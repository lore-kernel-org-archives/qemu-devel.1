Received: from eggs.gnu.org ([2001:4830:134:3::10]:42570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cdKza-0000GQ-TR
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cdKzW-000147-UN
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:04:50 -0500
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:36793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cdKzW-00013m-OJ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:04:46 -0500
Received: by mail-yb0-x241.google.com with SMTP id o65so4361557ybo.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 10:04:45 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon, 13 Feb 2017 23:34:48 +0530
Message-Id: <1487009088-23891-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v4] migrate: Introduce a 'dc->vmsd' check to
 avoid segfault for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: quintela@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Commit a3a3d8c7 introduced a segfault bug while checking for
'dc->vmsd->unmigratable' which caused QEMU to crash when trying to add
devices which do no set their 'dc->vmsd' yet while initialization.
Place a 'dc->vmsd' check prior to it so that we do not segfault for
such devices.

NOTE: This doesn't compromise the functioning of --only-migratable
option as all the unmigratable devices do set their 'dc->vmsd'.

Introduce a new function check_migratable() and move the
only_migratable check inside it, also use stubs to avoid user-mode qemu
build failures.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
Changes in v4:
- introduce new check_migratable() function and use stubs
Changes is v3:
- move only_migratable check inside device_set_realized() to avoid code
- duplication
- I have dropped Juan's R-b tag for this one
Changes in v2:
- place dc->vmsd check in hw/usb/bus.c as well
---
 hw/core/qdev.c                |  7 +++++++
 hw/usb/bus.c                  | 19 -------------------
 include/migration/migration.h |  3 +++
 migration/migration.c         | 15 +++++++++++++++
 qdev-monitor.c                |  9 ---------
 stubs/vmstate.c               |  6 ++++++
 6 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5783442..4f49cfe 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -37,6 +37,7 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "qapi-event.h"
+#include "migration/migration.h"
 
 int qdev_hotplug = 0;
 static bool qdev_hot_added = false;
@@ -889,6 +890,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     Error *local_err = NULL;
     bool unattached_parent = false;
     static int unattached_count;
+    int ret;
 
     if (dev->hotplugged && !dc->hotpluggable) {
         error_setg(errp, QERR_DEVICE_NO_HOTPLUG, object_get_typename(obj));
@@ -896,6 +898,11 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     }
 
     if (value && !dev->realized) {
+        ret = check_migratable(obj, &local_err);
+        if (ret < 0) {
+            goto fail;
+        }
+
         if (!obj->parent) {
             gchar *name = g_strdup_printf("device[%d]", unattached_count++);
 
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 1dcc35c..25913ad 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -8,7 +8,6 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include "qemu/cutils.h"
-#include "migration/migration.h"
 
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
 
@@ -687,8 +686,6 @@ USBDevice *usbdevice_create(const char *cmdline)
     const char *params;
     int len;
     USBDevice *dev;
-    ObjectClass *klass;
-    DeviceClass *dc;
 
     params = strchr(cmdline,':');
     if (params) {
@@ -723,22 +720,6 @@ USBDevice *usbdevice_create(const char *cmdline)
         return NULL;
     }
 
-    klass = object_class_by_name(f->name);
-    if (klass == NULL) {
-        error_report("Device '%s' not found", f->name);
-        return NULL;
-    }
-
-    dc = DEVICE_CLASS(klass);
-
-    if (only_migratable) {
-        if (dc->vmsd->unmigratable) {
-            error_report("Device %s is not migratable, but --only-migratable "
-                         "was specified", f->name);
-            return NULL;
-        }
-    }
-
     if (f->usbdevice_init) {
         dev = f->usbdevice_init(bus, params);
     } else {
diff --git a/include/migration/migration.h b/include/migration/migration.h
index af9135f..a6868cd 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -22,6 +22,7 @@
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
+#include "qom/object.h"
 
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
@@ -305,6 +306,8 @@ int migrate_add_blocker(Error *reason, Error **errp);
  */
 void migrate_del_blocker(Error *reason);
 
+int check_migratable(Object *obj, Error **err);
+
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 2766d2f..00b33f3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1146,6 +1146,21 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
+int check_migratable(Object *obj, Error **err)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(obj);
+    if (only_migratable && dc->vmsd) {
+        if (dc->vmsd->unmigratable) {
+            error_setg(err, "Device %s is not migratable, but "
+                       "--only-migratable was specified",
+                       object_get_typename(obj));
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 void qmp_migrate_incoming(const char *uri, Error **errp)
 {
     Error *local_err = NULL;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 549f45f..5f2fcdf 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -29,7 +29,6 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "sysemu/block-backend.h"
-#include "migration/migration.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -579,14 +578,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
-    if (only_migratable) {
-        if (dc->vmsd->unmigratable) {
-            error_setg(errp, "Device %s is not migratable, but "
-                       "--only-migratable was specified", driver);
-            return NULL;
-        }
-    }
-
     /* find bus */
     path = qemu_opt_get(opts, "bus");
     if (path != NULL) {
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 6590627..5a71770 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "migration/vmstate.h"
+#include "migration/migration.h"
 
 const VMStateDescription vmstate_dummy = {};
 
@@ -18,3 +19,8 @@ void vmstate_unregister(DeviceState *dev,
                         void *opaque)
 {
 }
+
+int check_migratable(Object *obj, Error **err)
+{
+    return 0;
+}
-- 
2.6.2
