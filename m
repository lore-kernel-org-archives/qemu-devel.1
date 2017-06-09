Received: from eggs.gnu.org ([2001:4830:134:3::10]:33246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvI-0002VA-Nk
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvH-0007Vm-QJ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJAvH-0007UY-HJ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B0CB5AFC9
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 03:49:18 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 11:48:58 +0800
Message-Id: <1496980142-8986-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1496980142-8986-1-git-send-email-peterx@redhat.com>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] migration: let MigrationState be a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Let the old man "MigrationState" join the object family. Direct benefit
is that we can start to use all the property features derived from
current QDev, like: HW_COMPAT_* bits, command line setup for migration
parameters (so will never need to set them up each time using HMP/QMP,
this is really, really attractive for test writters), etc.

I see no reason to disallow this happen yet. So let's start from this
one, to see whether it would be anything good.

No functional change at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/migration.h | 19 ++++++++++++++
 migration/migration.c         | 61 ++++++++++++++++++++++++++++---------------
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 79b5484..bd0186c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -21,6 +21,7 @@
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
+#include "hw/qdev.h"
 
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
@@ -49,6 +50,8 @@ enum mig_rp_message_type {
     MIG_RP_MSG_MAX
 };
 
+#define TYPE_MIGRATION "migration"
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -91,8 +94,24 @@ struct MigrationIncomingState {
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
 
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
 struct MigrationState
 {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
     size_t bytes_xfer;
     size_t xfer_limit;
     QemuThread thread;
diff --git a/migration/migration.c b/migration/migration.c
index 48c94c9..98b77e2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -93,29 +93,13 @@ static bool deferred_incoming;
 /* For outgoing */
 MigrationState *migrate_get_current(void)
 {
-    static bool once;
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
 
-    if (!once) {
-        current_migration.parameters.tls_creds = g_strdup("");
-        current_migration.parameters.tls_hostname = g_strdup("");
-        once = true;
+    if (!current_migration) {
+        current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
     }
-    return &current_migration;
+
+    return current_migration;
 }
 
 MigrationIncomingState *migration_incoming_get_current(void)
@@ -2123,3 +2107,38 @@ void migrate_fd_connect(MigrationState *s)
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
