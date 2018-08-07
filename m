Received: from eggs.gnu.org ([2001:4830:134:3::10]:39621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzai-000281-0W
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzac-0004K2-Vp
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:51:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fmzac-0004JK-L6
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:51:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so15292950wrv.12
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 03:51:46 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  7 Aug 2018 12:51:38 +0200
Message-Id: <23ca1636f8e238b2ffaded962519d2be1e3b5d3a.1533639095.git.tgolembi@redhat.com>
In-Reply-To: <cover.1533639095.git.tgolembi@redhat.com>
References: <cover.1533639095.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/4] qga: report serial ID and device node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

On Linux the functionality depends on libudev.

Example from Linux:

    {
      "name": "dm-2",
      "mountpoint": "/",
      ...
      "disk": [
        {
          "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
          "dev": "/dev/sda2",
          ...
        }
      ],
    }

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 configure            |  1 +
 qga/commands-posix.c | 23 ++++++++++++++
 qga/commands-win32.c | 73 ++++++++++++++++++++++++++++++++------------
 qga/qapi-schema.json |  4 ++-
 4 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index b31f37ed50..d73d929b6c 100755
--- a/configure
+++ b/configure
@@ -871,6 +871,7 @@ Linux)
   vhost_vsock="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
+  libs_qga="$($pkg_config --libs libudev) $libs_qga"
 ;;
 esac
 
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 233f78a406..4270f85aae 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -47,6 +47,7 @@ extern char **environ;
 #include <sys/socket.h>
 #include <net/if.h>
 #include <sys/statvfs.h>
+#include <libudev.h>
 
 #ifdef FIFREEZE
 #define CONFIG_FSFREEZE
@@ -872,6 +873,8 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     GuestDiskAddressList *list = NULL;
     bool has_ata = false, has_host = false, has_tgt = false;
     char *p, *q, *driver = NULL;
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
 
     p = strstr(syspath, "/devices/pci");
     if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
@@ -935,6 +938,24 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     list = g_malloc0(sizeof(*list));
     list->value = disk;
 
+    udev = udev_new();
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udev == NULL || udevice == NULL) {
+        g_debug("failed to query udev");
+    } else {
+        const char *devnode, *serial;
+        devnode = udev_device_get_devnode(udevice);
+        if (devnode != NULL) {
+            disk->dev = g_strdup(devnode);
+            disk->has_dev = true;
+        }
+        serial = udev_device_get_property_value(udevice, "ID_SERIAL");
+        if (serial != NULL && *serial != 0) {
+            disk->serial = g_strdup(serial);
+            disk->has_serial = true;
+        }
+    }
+
     if (strcmp(driver, "ata_piix") == 0) {
         /* a host per ide bus, target*:0:<unit>:0 */
         if (!has_host || !has_tgt) {
@@ -1002,6 +1023,8 @@ cleanup:
         qapi_free_GuestDiskAddressList(list);
     }
     g_free(driver);
+    udev_unref(udev);
+    udev_device_unref(udevice);
 }
 
 static void build_guest_fsinfo_for_device(char const *devpath,
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 995f62c2e4..666443dec2 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -577,25 +577,53 @@ out:
     return pci;
 }
 
-static int get_disk_bus_type(HANDLE vol_h, Error **errp)
+static void get_disk_properties(HANDLE vol_h, GuestDiskAddress *disk,
+    Error **errp)
 {
     STORAGE_PROPERTY_QUERY query;
     STORAGE_DEVICE_DESCRIPTOR *dev_desc, buf;
     DWORD received;
+    ULONG size = sizeof(buf);
 
     dev_desc = &buf;
-    dev_desc->Size = sizeof(buf);
     query.PropertyId = StorageDeviceProperty;
     query.QueryType = PropertyStandardQuery;
 
     if (!DeviceIoControl(vol_h, IOCTL_STORAGE_QUERY_PROPERTY, &query,
                          sizeof(STORAGE_PROPERTY_QUERY), dev_desc,
-                         dev_desc->Size, &received, NULL)) {
+                         size, &received, NULL)) {
         error_setg_win32(errp, GetLastError(), "failed to get bus type");
-        return -1;
+        return;
+    }
+    disk->bus_type = find_bus_type(dev_desc->BusType);
+    g_debug("bus type %d", disk->bus_type);
+
+    /* Query once more. Now with long enough buffer. */
+    size = dev_desc->Size;
+    dev_desc = g_malloc0(size);
+    if (!DeviceIoControl(vol_h, IOCTL_STORAGE_QUERY_PROPERTY, &query,
+                         sizeof(STORAGE_PROPERTY_QUERY), dev_desc,
+                         size, &received, NULL)) {
+        error_setg_win32(errp, GetLastError(), "failed to get serial number");
+        goto out_free;
+    }
+    if (dev_desc->SerialNumberOffset > 0) {
+        if (dev_desc->SerialNumberOffset >= received) {
+            error_setg(errp, "offset outside the buffer");
+            goto out_free;
+        }
+        const char *serial = (char*)dev_desc + dev_desc->SerialNumberOffset;
+        size_t len = received - dev_desc->SerialNumberOffset;
+        if (*serial != 0) {
+            disk->serial = g_strndup(serial, len);
+            disk->has_serial = true;
+            g_debug("serial number %s", disk->serial);
+        }
     }
+out_free:
+    g_free(dev_desc);
 
-    return dev_desc->BusType;
+    return;
 }
 
 /* VSS provider works with volumes, thus there is no difference if
@@ -607,8 +635,8 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     GuestDiskAddress *disk;
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
-    int bus;
     HANDLE vol_h;
+    Error *local_err = NULL;
 
     scsi_ad = &addr;
     char *name = g_strndup(guid, strlen(guid)-1);
@@ -618,22 +646,24 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
                        0, NULL);
     if (vol_h == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to open volume");
-        goto out_free;
+        goto err;
     }
 
-    g_debug("getting bus type");
-    bus = get_disk_bus_type(vol_h, errp);
-    if (bus < 0) {
-        goto out_close;
+    disk = g_malloc0(sizeof(*disk));
+    disk->dev = name;
+    disk->has_dev = true;
+    get_disk_properties(vol_h, disk, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto err_close;
     }
 
-    disk = g_malloc0(sizeof(*disk));
-    disk->bus_type = find_bus_type(bus);
-    g_debug("bus type %d", disk->bus_type);
-    if (bus == BusTypeScsi || bus == BusTypeAta || bus == BusTypeRAID
+    if (disk->bus_type == GUEST_DISK_BUS_TYPE_SCSI
+            || disk->bus_type == GUEST_DISK_BUS_TYPE_IDE
+            || disk->bus_type == GUEST_DISK_BUS_TYPE_RAID
 #if (_WIN32_WINNT >= 0x0600)
             /* This bus type is not supported before Windows Server 2003 SP1 */
-            || bus == BusTypeSas
+            || disk->bus_type == GUEST_DISK_BUS_TYPE_SAS
 #endif
         ) {
         /* We are able to use the same ioctls for different bus types
@@ -673,11 +703,16 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     list = g_malloc0(sizeof(*list));
     list->value = disk;
     list->next = NULL;
-out_close:
     CloseHandle(vol_h);
-out_free:
-    g_free(name);
     return list;
+
+err_close:
+    g_free(disk);
+    CloseHandle(vol_h);
+err:
+    g_free(name);
+
+    return NULL;
 }
 
 #else
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index dfbc4a5e32..dea995181e 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -834,13 +834,15 @@
 # @bus: bus id
 # @target: target id
 # @unit: unit id
+# @serial: serial number
 #
 # Since: 2.2
 ##
 { 'struct': 'GuestDiskAddress',
   'data': {'pci-controller': 'GuestPCIAddress',
            'bus-type': 'GuestDiskBusType',
-           'bus': 'int', 'target': 'int', 'unit': 'int'} }
+           'bus': 'int', 'target': 'int', 'unit': 'int',
+           '*serial': 'str', '*dev': 'str'} }
 
 ##
 # @GuestFilesystemInfo:
-- 
2.18.0
