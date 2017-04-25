Received: from eggs.gnu.org ([2001:4830:134:3::10]:45884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xXr-00004x-DF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xXq-0006iA-1D
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2xXp-0006i3-Ny
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:18:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6A017CFA8
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:18:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 25 Apr 2017 12:17:57 +0200
Message-Id: <20170425101758.3944-2-quintela@redhat.com>
In-Reply-To: <20170425101758.3944-1-quintela@redhat.com>
References: <20170425101758.3944-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: Move check_migratable() into
 qdev.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

The function is only used once, and nothing else in migration knows
about objects.  Create the function vmstate_device_is_migratable() in
savem.c that really do the bit that is related with migration.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/core/qdev.c                | 15 ++++++++++++++-
 include/migration/migration.h |  3 ---
 include/migration/vmstate.h   |  2 ++
 migration/migration.c         | 15 ---------------
 migration/savevm.c            | 10 ++++++++++
 stubs/vmstate.c               |  5 ++---
 6 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 02b632f..17ff638 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -37,7 +37,7 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "qapi-event.h"
-#include "migration/migration.h"
+#include "migration/vmstate.h"
 
 bool qdev_hotplug = false;
 static bool qdev_hot_added = false;
@@ -861,6 +861,19 @@ static bool device_get_realized(Object *obj, Error **errp)
     return dev->realized;
 }
 
+static int check_migratable(Object *obj, Error **err)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(obj);
+    if (!vmstate_device_is_migratable(dc->vmsd)) {
+        error_setg(err, "Device %s is not migratable, but "
+                   "--only-migratable was specified",
+                   object_get_typename(obj));
+        return -1;
+    }
+
+    return 0;
+}
+
 static void device_set_realized(Object *obj, bool value, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index ba1a16c..dfeca38 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -22,7 +22,6 @@
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
-#include "qom/object.h"
 
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
@@ -292,8 +291,6 @@ int migrate_add_blocker(Error *reason, Error **errp);
  */
 void migrate_del_blocker(Error *reason);
 
-int check_migratable(Object *obj, Error **err);
-
 bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index dad3984..9452dec 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1049,4 +1049,6 @@ int64_t self_announce_delay(int round)
 
 void dump_vmstate_json_to_file(FILE *out_fp);
 
+bool vmstate_device_is_migratable(const VMStateDescription *vmsd);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 353f272..5447cab 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1158,21 +1158,6 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-int check_migratable(Object *obj, Error **err)
-{
-    DeviceClass *dc = DEVICE_GET_CLASS(obj);
-    if (only_migratable && dc->vmsd) {
-        if (dc->vmsd->unmigratable) {
-            error_setg(err, "Device %s is not migratable, but "
-                       "--only-migratable was specified",
-                       object_get_typename(obj));
-            return -1;
-        }
-    }
-
-    return 0;
-}
-
 void qmp_migrate_incoming(const char *uri, Error **errp)
 {
     Error *local_err = NULL;
diff --git a/migration/savevm.c b/migration/savevm.c
index 03ae1bd..7421a67 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2480,3 +2480,13 @@ void vmstate_register_ram_global(MemoryRegion *mr)
 {
     vmstate_register_ram(mr, NULL);
 }
+
+bool vmstate_device_is_migratable(const VMStateDescription *vmsd)
+{
+    if (only_migratable && vmsd) {
+        if (vmsd->unmigratable) {
+            return false;
+        }
+    }
+    return true;
+}
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 6d52f29..5af824b 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "migration/vmstate.h"
-#include "migration/migration.h"
 
 const VMStateDescription vmstate_dummy = {};
 
@@ -21,7 +20,7 @@ void vmstate_unregister(DeviceState *dev,
 {
 }
 
-int check_migratable(Object *obj, Error **err)
+bool vmstate_device_is_migratable(const VMStateDescription *vmsd)
 {
-    return 0;
+    return true;
 }
-- 
2.9.3
