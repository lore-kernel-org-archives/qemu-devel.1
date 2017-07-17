Received: from eggs.gnu.org ([2001:4830:134:3::10]:46055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6It-00043W-Cw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6In-0005Om-Cw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6In-0005OY-3k
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1132F4A6EA
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:43:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:27 +0200
Message-Id: <20170717134238.1966-7-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 06/17] migration: Create x-multifd-group
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

Indicates how many pages we are going to send in each batch to a multifd
thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Be consistent with defaults and documentation
---
 hmp.c                 |  8 ++++++++
 migration/migration.c | 23 +++++++++++++++++++++++
 migration/migration.h |  1 +
 qapi-schema.json      | 11 +++++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 92f9456..b01605a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_THREADS],
             params->x_multifd_threads);
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_GROUP],
+            params->x_multifd_group);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1580,6 +1583,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.has_x_multifd_threads = true;
                 use_int_value = true;
                 break;
+            case MIGRATION_PARAMETER_X_MULTIFD_GROUP:
+                p.has_x_multifd_group = true;
+                use_int_value = true;
+                break;
             }
 
             if (use_int_value) {
@@ -1597,6 +1604,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.downtime_limit = valueint;
                 p.x_checkpoint_delay = valueint;
                 p.x_multifd_threads = valueint;
+                p.x_multifd_group = valueint;
             }
 
             qmp_migrate_set_parameters(&p, &err);
diff --git a/migration/migration.c b/migration/migration.c
index 148edc1..ff3fc9d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -79,6 +79,7 @@
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
 #define DEFAULT_MIGRATE_MULTIFD_THREADS 2
+#define DEFAULT_MIGRATE_MULTIFD_GROUP 16
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -463,6 +464,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->block_incremental = s->parameters.block_incremental;
     params->has_x_multifd_threads = true;
     params->x_multifd_threads = s->parameters.x_multifd_threads;
+    params->has_x_multifd_group = true;
+    params->x_multifd_group = s->parameters.x_multifd_group;
 
     return params;
 }
@@ -722,6 +725,13 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
                    "is invalid, it should be in the range of 1 to 255");
         return;
     }
+    if (params->has_x_multifd_group &&
+            (params->x_multifd_group < 1 || params->x_multifd_group > 10000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "multifd_group",
+                   "is invalid, it should be in the range of 1 to 10000");
+        return;
+    }
 
     if (params->has_compress_level) {
         s->parameters.compress_level = params->compress_level;
@@ -769,6 +779,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     if (params->has_x_multifd_threads) {
         s->parameters.x_multifd_threads = params->x_multifd_threads;
     }
+    if (params->has_x_multifd_group) {
+        s->parameters.x_multifd_group = params->x_multifd_group;
+    }
 }
 
 
@@ -1313,6 +1326,15 @@ int migrate_multifd_threads(void)
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
@@ -2078,6 +2100,7 @@ static void migration_instance_init(Object *obj)
         .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
         .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
         .x_multifd_threads = DEFAULT_MIGRATE_MULTIFD_THREADS,
+        .x_multifd_group = DEFAULT_MIGRATE_MULTIFD_GROUP,
     };
     ms->parameters.tls_creds = g_strdup("");
     ms->parameters.tls_hostname = g_strdup("");
diff --git a/migration/migration.h b/migration/migration.h
index 20ea30c..4aaaf9e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -174,6 +174,7 @@ bool migrate_zero_blocks(void);
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
 int migrate_multifd_threads(void);
+int migrate_multifd_group(void);
 
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/qapi-schema.json b/qapi-schema.json
index 444e8f0..5b3733e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1033,6 +1033,9 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.10)
 #
+# @x-multifd-group: Number of pages sent together to a thread
+#                   The default value is 16 (since 2.10)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -1040,7 +1043,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
-           'x-multifd-threads'] }
+           'x-multifd-threads', 'x-multifd-group'] }
 
 ##
 # @migrate-set-parameters:
@@ -1119,6 +1122,9 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.10)
 #
+# @x-multifd-group: Number of pages sent together to a thread
+#                   The default value is 16 (since 2.10)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1133,7 +1139,8 @@
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
