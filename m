Received: from eggs.gnu.org ([2001:4830:134:3::10]:60590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfVL-0000vN-QP
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfVI-0002aq-J5
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:41:07 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:33439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHfVI-0002Zw-C7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:41:04 -0400
Received: by mail-qt1-x82f.google.com with SMTP id i15-v6so16014231qtr.0
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:41:02 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 20:38:02 -0500
Message-Id: <20181031013821.24023-6-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
References: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 05/24] qga: linux: report disk serial number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tomáš Golembiovský <tgolembi@redhat.com>

Add reporting of disk serial number on Linux guests. The feature depends
on libudev.

Example:

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
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/Makefile.objs    |  1 +
 qga/commands-posix.c | 32 ++++++++++++++++++++++++++++++--
 qga/qapi-schema.json |  4 +++-
 3 files changed, 34 insertions(+), 3 deletions(-)

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
index 42d30f078e..41bd11b2b5 100644
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
@@ -995,14 +1018,19 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
 
     list->next = fs->disk;
     fs->disk = list;
-    g_free(driver);
-    return;
+    goto out;
 
 cleanup:
     if (list) {
         qapi_free_GuestDiskAddressList(list);
     }
+out:
     g_free(driver);
+#ifdef CONFIG_LIBUDEV
+    udev_unref(udev);
+    udev_device_unref(udevice);
+#endif
+    return;
 }
 
 static void build_guest_fsinfo_for_device(char const *devpath,
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
2.17.1
