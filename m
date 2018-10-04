Received: from eggs.gnu.org ([2001:4830:134:3::10]:34623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81ss-00040d-Im
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iU-0003Xp-Gn
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:54 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iU-0003XU-A2
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:50 -0400
Received: by mail-wr1-f47.google.com with SMTP id z4-v6so9494304wrb.1
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:50 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:34 +0200
Message-Id: <54f53859b73142e6264c948ff8a8e70616baf268.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <cover.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 07/11] qga: report disk serial number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

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
 qga/Makefile.objs    |  1 +
 qga/commands-posix.c | 27 +++++++++++++++++++++++++++
 qga/commands-win32.c | 24 ++++++++++++++++++++++++
 qga/qapi-schema.json |  4 +++-
 4 files changed, 55 insertions(+), 1 deletion(-)

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
index 37e8a2d791..4d324178f2 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -48,6 +48,10 @@ extern char **environ;
 #include <net/if.h>
 #include <sys/statvfs.h>
 
+#ifdef CONFIG_LIBUDEV
+#include <libudev.h>
+#endif
+
 #ifdef FIFREEZE
 #define CONFIG_FSFREEZE
 #endif
@@ -872,6 +876,10 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     GuestDiskAddressList *list = NULL;
     bool has_ata = false, has_host = false, has_tgt = false;
     char *p, *q, *driver = NULL;
+#ifdef CONFIG_LIBUDEV
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+#endif
 
     p = strstr(syspath, "/devices/pci");
     if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
@@ -936,6 +944,21 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
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
@@ -1003,6 +1026,10 @@ cleanup:
         qapi_free_GuestDiskAddressList(list);
     }
     g_free(driver);
+#ifdef CONFIG_LIBUDEV
+    udev_unref(udev);
+    udev_device_unref(udevice);
+#endif
 }
 
 static void build_guest_fsinfo_for_device(char const *devpath,
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d7864fc65a..376ca1e288 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -603,6 +603,30 @@ static void get_disk_properties(HANDLE vol_h, GuestDiskAddress *disk,
     }
     disk->bus_type = find_bus_type(dev_desc->BusType);
     g_debug("bus type %d", disk->bus_type);
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
+    }
+out_free:
     g_free(dev_desc);
 
     return;
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
2.19.0
