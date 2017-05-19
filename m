Received: from eggs.gnu.org ([2001:4830:134:3::10]:36774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdt-0000iB-6p
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbds-0004EN-3o
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBbdr-0004Dn-RN
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3F547F4A2
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:44:02 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 14:43:31 +0800
Message-Id: <1495176212-14446-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1495176212-14446-1-git-send-email-peterx@redhat.com>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 5/6] migration: let MigrationState be an
 QObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Let the old man "MigrationState" join the object family. Direct benefit
is that we can start to use all the property features derived from
current QObject, like: HW_COMPAT_* bits, command line setup for
migration parameters (so will never need to set them up each time using
HMP/QMP, this is really, really attractive for test writters), etc.

I see no reason to disallow this happen yet. So let's start from this
one, to see whether it would be anything good.

No functional change at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/migration.h | 24 +++++++++++++++---
 include/qemu/typedefs.h       |  1 -
 migration/migration.c         | 57 +++++++++++++++++++++++++++++--------------
 3 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 49ec501..70710de 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -22,6 +22,7 @@
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
+#include "hw/qdev.h"
 
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
@@ -102,8 +103,25 @@ struct MigrationIncomingState {
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
 
-struct MigrationState
-{
+#define TYPE_MIGRATION "migration"
+
+#define MIGRATION_CLASS(klass) \
+    OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
+#define MIGRATION_OBJ(obj) \
+    OBJECT_CHECK(MigrationState, (obj), TYPE_MIGRATION)
+#define MIGRATION_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
+
+typedef struct MigrationClass {
+    /*< private >*/
+    DeviceClass parent_class;
+} MigrationClass;
+
+typedef struct MigrationState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
     size_t bytes_xfer;
     size_t xfer_limit;
     QemuThread thread;
@@ -153,7 +171,7 @@ struct MigrationState
 
     /* The last error that occurred */
     Error *error;
-};
+} MigrationState ;
 
 void migrate_set_state(int *state, int old_state, int new_state);
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 7d85057..95a382e 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -50,7 +50,6 @@ typedef struct MemoryRegionCache MemoryRegionCache;
 typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationParams MigrationParams;
-typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
 typedef struct MonitorDef MonitorDef;
 typedef struct MouseTransformInfo MouseTransformInfo;
diff --git a/migration/migration.c b/migration/migration.c
index a4006b4..6df3483 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -86,28 +86,14 @@ static bool deferred_incoming;
 MigrationState *migrate_get_current(void)
 {
     static bool once;
-    static MigrationState current_migration = {
-        .state = MIGRATION_STATUS_NONE,
-        .xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE,
-        .mbps = -1,
-        .parameters = {
-            .compress_level = DEFAULT_MIGRATE_COMPRESS_LEVEL,
-            .compress_threads = DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT,
-            .decompress_threads = DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT,
-            .cpu_throttle_initial = DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL,
-            .cpu_throttle_increment = DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT,
-            .max_bandwidth = MAX_THROTTLE,
-            .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
-            .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
-        },
-    };
+    static MigrationState *current_migration;
 
     if (!once) {
-        current_migration.parameters.tls_creds = g_strdup("");
-        current_migration.parameters.tls_hostname = g_strdup("");
+        current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
         once = true;
     }
-    return &current_migration;
+
+    return current_migration;
 }
 
 MigrationIncomingState *migration_incoming_get_current(void)
@@ -2107,3 +2093,38 @@ void migrate_fd_connect(MigrationState *s)
     s->migration_thread_running = true;
 }
 
+static void migration_instance_init(Object *obj)
+{
+    MigrationState *ms = MIGRATION_OBJ(obj);
+
+    ms->state = MIGRATION_STATUS_NONE;
+    ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
+    ms->mbps = -1;
+    ms->parameters = (MigrationParameters) {
+        .compress_level = DEFAULT_MIGRATE_COMPRESS_LEVEL,
+        .compress_threads = DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT,
+        .decompress_threads = DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT,
+        .cpu_throttle_initial = DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL,
+        .cpu_throttle_increment = DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT,
+        .max_bandwidth = MAX_THROTTLE,
+        .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
+        .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
+    };
+    ms->parameters.tls_creds = g_strdup("");
+    ms->parameters.tls_hostname = g_strdup("");
+}
+
+static const TypeInfo migration_type = {
+    .name = TYPE_MIGRATION,
+    .parent = TYPE_DEVICE,
+    .class_size = sizeof(MigrationClass),
+    .instance_size = sizeof(MigrationState),
+    .instance_init = migration_instance_init,
+};
+
+static void register_migration_types(void)
+{
+    type_register_static(&migration_type);
+}
+
+type_init(register_migration_types);
-- 
2.7.4
