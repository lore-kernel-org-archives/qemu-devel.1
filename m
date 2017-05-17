Received: from eggs.gnu.org ([2001:4830:134:3::10]:36680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwuC-0002Mx-S6
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwuB-0002FB-J0
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAwuB-0002Ei-9i
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5268FC0B39C4
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 11:14:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 13:13:46 +0200
Message-Id: <20170517111346.21450-8-quintela@redhat.com>
In-Reply-To: <20170517111346.21450-1-quintela@redhat.com>
References: <20170517111346.21450-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] migration: Move check_migratable() into
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c                | 20 ++++++++++++++++----
 include/migration/migration.h |  6 ------
 include/migration/vmstate.h   |  2 ++
 include/sysemu/sysemu.h       |  2 +-
 migration/migration.c         | 15 ---------------
 migration/savevm.c            | 10 ++++++++++
 stubs/vmstate.c               |  5 ++---
 7 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 02b632f..6f1b070 100644
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
@@ -861,6 +861,20 @@ static bool device_get_realized(Object *obj, Error **errp)
     return dev->realized;
 }
 
+static bool check_only_migratable(Object *obj, Error **err)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(obj);
+
+    if (!vmstate_check_only_migratable(dc->vmsd)) {
+        error_setg(err, "Device %s is not migratable, but "
+                   "--only-migratable was specified",
+                   object_get_typename(obj));
+        return false;
+    }
+
+    return true;
+}
+
 static void device_set_realized(Object *obj, bool value, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -870,7 +884,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     Error *local_err = NULL;
     bool unattached_parent = false;
     static int unattached_count;
-    int ret;
 
     if (dev->hotplugged && !dc->hotpluggable) {
         error_setg(errp, QERR_DEVICE_NO_HOTPLUG, object_get_typename(obj));
@@ -878,8 +891,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     }
 
     if (value && !dev->realized) {
-        ret = check_migratable(obj, &local_err);
-        if (ret < 0) {
+        if (!check_only_migratable(obj, &local_err)) {
             goto fail;
         }
 
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 97e78ba..49ec501 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -22,7 +22,6 @@
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
-#include "qom/object.h"
 
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
@@ -39,9 +38,6 @@
 #define QEMU_VM_COMMAND              0x08
 #define QEMU_VM_SECTION_FOOTER       0x7e
 
-/* for vl.c */
-extern int only_migratable;
-
 struct MigrationParams {
     bool blk;
     bool shared;
@@ -253,8 +249,6 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
 int ram_postcopy_incoming_init(MigrationIncomingState *mis);
 void ram_postcopy_migrated_memory_release(MigrationState *ms);
 
-int check_migratable(Object *obj, Error **err);
-
 bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f4bf3f1..8489659 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1067,4 +1067,6 @@ int64_t self_announce_delay(int round)
 
 void dump_vmstate_json_to_file(FILE *out_fp);
 
+bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
+
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 282f6bc..83c1ceb 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -15,7 +15,7 @@
 /* vl.c */
 
 extern const char *bios_name;
-
+extern int only_migratable;
 extern const char *qemu_name;
 extern QemuUUID qemu_uuid;
 extern bool qemu_uuid_set;
diff --git a/migration/migration.c b/migration/migration.c
index ed11c1f..0304c01 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1143,21 +1143,6 @@ void migrate_del_blocker(Error *reason)
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
index b4f736f..f5e8194 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2317,3 +2317,13 @@ void vmstate_register_ram_global(MemoryRegion *mr)
 {
     vmstate_register_ram(mr, NULL);
 }
+
+bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
+{
+    /* check needed if --only-migratable is specified */
+    if (!only_migratable) {
+        return true;
+    }
+
+    return !(vmsd && vmsd->unmigratable);
+}
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 6d52f29..6399474 100644
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
+bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
-    return 0;
+    return true;
 }
-- 
2.9.3
