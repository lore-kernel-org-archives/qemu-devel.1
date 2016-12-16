Received: from eggs.gnu.org ([2001:4830:134:3::10]:51404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHpDo-00062K-9m
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHpDk-0003Hr-CY
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:54:36 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cHpDk-0003HP-7g
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:54:32 -0500
Received: by mail-pg0-x241.google.com with SMTP id p66so9259370pga.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 01:54:32 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Fri, 16 Dec 2016 15:23:42 +0530
Message-Id: <1481882024-10016-3-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1481882024-10016-1-git-send-email-ashijeetacharya@gmail.com>
References: <1481882024-10016-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/4] migration: Allow "device add" options
 to only add migratable devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Introduce checks for the unmigratable flag in the VMStateDescription
structs of respective devices when user attempts to add them. If the
"--only-migratable" was specified, all unmigratable devices will
rightly fail to add. This feature is made compatible for both "-device"
and "-usbdevice" command line options and covers their hmp and qmp
counterparts as well.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 hw/usb/bus.c   | 18 ++++++++++++++++++
 qdev-monitor.c |  9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 25913ad..3d26103 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -8,6 +8,7 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include "qemu/cutils.h"
+#include "migration/migration.h"
 
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
 
@@ -686,6 +687,8 @@ USBDevice *usbdevice_create(const char *cmdline)
     const char *params;
     int len;
     USBDevice *dev;
+    ObjectClass *klass;
+    DeviceClass *dc;
 
     params = strchr(cmdline,':');
     if (params) {
@@ -720,6 +723,21 @@ USBDevice *usbdevice_create(const char *cmdline)
         return NULL;
     }
 
+    klass = object_class_by_name(f->name);
+    if (klass == NULL) {
+        return NULL;
+    }
+
+    dc = DEVICE_CLASS(klass);
+
+    if (only_migratable) {
+        if (dc->vmsd->unmigratable) {
+            error_report("Device %s is not migratable, but --only-migratable "
+                         "was specified", f->name);
+            return NULL;
+        }
+    }
+
     if (f->usbdevice_init) {
         dev = f->usbdevice_init(bus, params);
     } else {
diff --git a/qdev-monitor.c b/qdev-monitor.c
index c73410c..81d01df 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "sysemu/block-backend.h"
+#include "migration/migration.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -577,6 +578,14 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
+    if (only_migratable) {
+        if (dc->vmsd->unmigratable) {
+            error_setg(errp, "Device %s is not migratable, but "
+                       "--only-migratable was specified", driver);
+            return NULL;
+        }
+    }
+
     /* find bus */
     path = qemu_opt_get(opts, "bus");
     if (path != NULL) {
-- 
2.6.2
