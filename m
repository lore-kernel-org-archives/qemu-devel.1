Received: from eggs.gnu.org ([2001:4830:134:3::10]:60420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7Mb-0002xB-Pt
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7MY-0008C6-HN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df7MY-0008BR-9T
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:28:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 540BB72D96
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 16:28:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  8 Aug 2017 18:26:18 +0200
Message-Id: <20170808162629.32493-9-quintela@redhat.com>
In-Reply-To: <20170808162629.32493-1-quintela@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 08/19] migration: Create x-multifd-group
 parameter
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

Indicates how many pages we are going to send in each batch to a multifd
thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Be consistent with defaults and documentation
Use new DEFINE_PROP_*
---
 hmp.c                 |  7 +++++++
 migration/migration.c | 26 ++++++++++++++++++++++++++
 migration/migration.h |  1 +
 qapi-schema.json      | 17 ++++++++++++++---
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 7899813..a52035a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -340,6 +340,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_THREADS],
             params->x_multifd_threads);
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_GROUP],
+            params->x_multifd_group);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1629,6 +1632,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p->has_x_multifd_threads = true;
                 visit_type_int(v, param, &p->x_multifd_threads, &err);
                 break;
+            case MIGRATION_PARAMETER_X_MULTIFD_GROUP:
+                p->has_x_multifd_group = true;
+                visit_type_int(v, param, &p->x_multifd_group, &err);
+                break;
             }
 
             if (err) {
diff --git a/migration/migration.c b/migration/migration.c
index 6ed9600..6c4eb4b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -79,6 +79,7 @@
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
 #define DEFAULT_MIGRATE_MULTIFD_THREADS 2
+#define DEFAULT_MIGRATE_MULTIFD_GROUP 16
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -486,6 +487,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->block_incremental = s->parameters.block_incremental;
     params->has_x_multifd_threads = true;
     params->x_multifd_threads = s->parameters.x_multifd_threads;
+    params->has_x_multifd_group = true;
+    params->x_multifd_group = s->parameters.x_multifd_group;
 
     return params;
 }
@@ -774,6 +777,13 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
                    "is invalid, it should be in the range of 1 to 255");
         return false;
     }
+    if (params->has_x_multifd_group &&
+            (params->x_multifd_group < 1 || params->x_multifd_group > 10000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "multifd_group",
+                   "is invalid, it should be in the range of 1 to 10000");
+        return false;
+    }
 
     return true;
 }
@@ -895,6 +905,9 @@ static void migrate_params_apply(MigrateSetParameters *params)
     if (params->has_x_multifd_threads) {
         s->parameters.x_multifd_threads = params->x_multifd_threads;
     }
+    if (params->has_x_multifd_group) {
+        s->parameters.x_multifd_group = params->x_multifd_group;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1481,6 +1494,15 @@ int migrate_multifd_threads(void)
     return s->parameters.x_multifd_threads;
 }
 
+int migrate_multifd_group(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->parameters.x_multifd_group;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -2249,6 +2271,9 @@ static Property migration_properties[] = {
     DEFINE_PROP_INT64("x-multifd-threads", MigrationState,
                       parameters.x_multifd_threads,
                       DEFAULT_MIGRATE_MULTIFD_THREADS),
+    DEFINE_PROP_INT64("x-multifd-group", MigrationState,
+                      parameters.x_multifd_group,
+                      DEFAULT_MIGRATE_MULTIFD_GROUP),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -2307,6 +2332,7 @@ static void migration_instance_init(Object *obj)
     params->has_x_checkpoint_delay = true;
     params->has_block_incremental = true;
     params->has_x_multifd_threads = true;
+    params->has_x_multifd_group = true;
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index 8e4803d..ddf8c89 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -176,6 +176,7 @@ bool migrate_zero_blocks(void);
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
 int migrate_multifd_threads(void);
+int migrate_multifd_group(void);
 
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/qapi-schema.json b/qapi-schema.json
index 3fe1a64..2d4dbd3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1049,6 +1049,9 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.11)
 #
+# @x-multifd-group: Number of pages sent together to a thread
+#                   The default value is 16 (since 2.11)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -1056,7 +1059,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
-           'x-multifd-threads'] }
+           'x-multifd-threads', 'x-multifd-group'] }
 
 ##
 # @MigrateSetParameters:
@@ -1117,6 +1120,9 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.11)
 #
+# @x-multifd-group: Number of pages sent together to a thread
+#                   The default value is 16 (since 2.11)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -1133,7 +1139,8 @@
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool',
-            '*x-multifd-threads': 'int' } }
+            '*x-multifd-threads': 'int',
+            '*x-multifd-group': 'int' } }
 
 ##
 # @migrate-set-parameters:
@@ -1209,6 +1216,9 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.11)
 #
+# @x-multifd-group: Number of pages sent together to a thread
+#                   The default value is 16 (since 2.11)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1223,7 +1233,8 @@
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool',
-            '*x-multifd-threads': 'int'} }
+            '*x-multifd-threads': 'int',
+            '*x-multifd-group': 'int'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.9.4
