Received: from eggs.gnu.org ([2001:4830:134:3::10]:36710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9e-0000ts-On
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9a-0004AX-Jt
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:26 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fyF9a-00049q-99
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:22 -0400
Received: by mail-wm0-f44.google.com with SMTP id t25-v6so14296280wmi.3
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 04:42:22 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri,  7 Sep 2018 13:42:12 +0200
Message-Id: <b434fd2fe7740704c45ea045d7ec048767ea3678.1536320522.git.tgolembi@redhat.com>
In-Reply-To: <cover.1536320522.git.tgolembi@redhat.com>
References: <cover.1536320522.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/5] qga: report disk serial number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

The feature is implemented for Windows and Linux. Reporting of serial
number on Linux depends on libudev.

Example from Linux:

    {
      "name": "dm-2",
      "mountpoint": "/",
      ...
      "disk": [
        {
          "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
          ...
        }
      ],
    }

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 configure            | 22 ++++++++++++++
 qga/Makefile.objs    |  1 +
 qga/commands-posix.c | 22 ++++++++++++++
 qga/commands-win32.c | 71 ++++++++++++++++++++++++++++++++------------
 qga/qapi-schema.json |  4 ++-
 5 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index 0f168607e8..ac24cb3975 100755
--- a/configure
+++ b/configure
@@ -477,6 +477,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
+libudev="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -873,6 +874,7 @@ Linux)
   vhost_vsock="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
+  libudev="yes"
 ;;
 esac
 
@@ -5676,6 +5678,20 @@ if test "$libnfs" != "no" ; then
   fi
 fi
 
+##########################################
+# Do we have libudev
+if test "$libudev" != "no" ; then
+  if $pkg_config libudev; then
+    libudev="yes"
+    libudev_libs=$($pkg_config --libs libudev)
+  else
+    if test "$libudev" = "yes" ; then
+      feature_not_found "libudev" "Install systemd development files"
+    fi
+    libudev="no"
+  fi
+fi
+
 # Now we've finished running tests it's OK to add -Werror to the compiler flags
 if test "$werror" = "yes"; then
     QEMU_CFLAGS="-Werror $QEMU_CFLAGS"
@@ -6100,6 +6116,7 @@ echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
+echo "libudev           $libudev"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6944,6 +6961,11 @@ if test "$docker" != "no"; then
     echo "HAVE_USER_DOCKER=y" >> $config_host_mak
 fi
 
+if test "$libudev" != "no"; then
+    echo "CONFIG_LIBUDEV=y" >> $config_host_mak
+    echo "LIBUDEV_LIBS=$libudev_libs" >> $config_host_mak
+fi
+
 # use included Linux headers
 if test "$linux" = "yes" ; then
   mkdir -p linux-headers
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index ed08c5917c..80e6bb3c2e 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -1,3 +1,4 @@
+commands-posix.o-libs := $(LIBUDEV_LIBS)
 qga-obj-y = commands.o guest-agent-command-state.o main.o
 qga-obj-$(CONFIG_POSIX) += commands-posix.o channel-posix.o
 qga-obj-$(CONFIG_WIN32) += commands-win32.o channel-win32.o service-win32.o
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 37e8a2d791..37fedd123b 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -47,6 +47,7 @@ extern char **environ;
 #include <sys/socket.h>
 #include <net/if.h>
 #include <sys/statvfs.h>
+#include <libudev.h>
 
 #ifdef FIFREEZE
 #define CONFIG_FSFREEZE
@@ -872,6 +873,10 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     GuestDiskAddressList *list = NULL;
     bool has_ata = false, has_host = false, has_tgt = false;
     char *p, *q, *driver = NULL;
+#ifdef CONFIG_LIBUDEV
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+#endif
 
     p = strstr(syspath, "/devices/pci");
     if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
@@ -936,6 +941,21 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     list = g_malloc0(sizeof(*list));
     list->value = disk;
 
+#ifdef CONFIG_LIBUDEV
+    udev = udev_new();
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udev == NULL || udevice == NULL) {
+        g_debug("failed to query udev");
+    } else {
+        const char *serial;
+        serial = udev_device_get_property_value(udevice, "ID_SERIAL");
+        if (serial != NULL && *serial != 0) {
+            disk->serial = g_strdup(serial);
+            disk->has_serial = true;
+        }
+    }
+#endif
+
     if (strcmp(driver, "ata_piix") == 0) {
         /* a host per ide bus, target*:0:<unit>:0 */
         if (!has_host || !has_tgt) {
@@ -1003,6 +1023,8 @@ cleanup:
         qapi_free_GuestDiskAddressList(list);
     }
     g_free(driver);
+    udev_unref(udev);
+    udev_device_unref(udevice);
 }
 
 static void build_guest_fsinfo_for_device(char const *devpath,
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index e16c58275e..fa186154a8 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -583,25 +583,53 @@ out:
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
+        const char *serial = (char *)dev_desc + dev_desc->SerialNumberOffset;
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
@@ -613,8 +641,8 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     GuestDiskAddress *disk;
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
-    int bus;
     HANDLE vol_h;
+    Error *local_err = NULL;
 
     scsi_ad = &addr;
     char *name = g_strndup(guid, strlen(guid)-1);
@@ -624,22 +652,22 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
@@ -679,11 +707,16 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
index dfbc4a5e32..3bcda6257e 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -834,13 +834,15 @@
 # @bus: bus id
 # @target: target id
 # @unit: unit id
+# @serial: serial number (since: 3.1)
 #
 # Since: 2.2
 ##
 { 'struct': 'GuestDiskAddress',
   'data': {'pci-controller': 'GuestPCIAddress',
            'bus-type': 'GuestDiskBusType',
-           'bus': 'int', 'target': 'int', 'unit': 'int'} }
+           'bus': 'int', 'target': 'int', 'unit': 'int',
+           '*serial': 'str'} }
 
 ##
 # @GuestFilesystemInfo:
-- 
2.18.0
