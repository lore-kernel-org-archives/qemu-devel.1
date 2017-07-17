Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6Ik-0003wR-C4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6Ij-0005Nx-5q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6Ii-0005Ng-Sk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC75C7D0DB
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:43:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:26 +0200
Message-Id: <20170717134238.1966-6-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/17] migration: Create x-multifd-threads
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

Indicates the number of threads that we would create.  By default we
create 2 threads.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Catch inconsistent defaults (eric).
Improve comment stating that number of threads is the same than number
of sockets
---
 hmp.c                 |  7 +++++++
 migration/migration.c | 23 +++++++++++++++++++++++
 migration/migration.h |  1 +
 qapi-schema.json      | 18 ++++++++++++++++--
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index d970ea9..92f9456 100644
--- a/hmp.c
+++ b/hmp.c
@@ -335,6 +335,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_BLOCK_INCREMENTAL],
                        params->block_incremental ? "on" : "off");
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_THREADS],
+            params->x_multifd_threads);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1573,6 +1576,9 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                     goto cleanup;
                 }
                 p.block_incremental = valuebool;
+            case MIGRATION_PARAMETER_X_MULTIFD_THREADS:
+                p.has_x_multifd_threads = true;
+                use_int_value = true;
                 break;
             }
 
@@ -1590,6 +1596,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.cpu_throttle_increment = valueint;
                 p.downtime_limit = valueint;
                 p.x_checkpoint_delay = valueint;
+                p.x_multifd_threads = valueint;
             }
 
             qmp_migrate_set_parameters(&p, &err);
diff --git a/migration/migration.c b/migration/migration.c
index af2630b..148edc1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -78,6 +78,7 @@
  * Note: Please change this default value to 10000 when we support hybrid mode.
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
+#define DEFAULT_MIGRATE_MULTIFD_THREADS 2
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -460,6 +461,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
     params->has_block_incremental = true;
     params->block_incremental = s->parameters.block_incremental;
+    params->has_x_multifd_threads = true;
+    params->x_multifd_threads = s->parameters.x_multifd_threads;
 
     return params;
 }
@@ -712,6 +715,13 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
                     "x_checkpoint_delay",
                     "is invalid, it should be positive");
     }
+    if (params->has_x_multifd_threads &&
+        (params->x_multifd_threads < 1 || params->x_multifd_threads > 255)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "multifd_threads",
+                   "is invalid, it should be in the range of 1 to 255");
+        return;
+    }
 
     if (params->has_compress_level) {
         s->parameters.compress_level = params->compress_level;
@@ -756,6 +766,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     if (params->has_block_incremental) {
         s->parameters.block_incremental = params->block_incremental;
     }
+    if (params->has_x_multifd_threads) {
+        s->parameters.x_multifd_threads = params->x_multifd_threads;
+    }
 }
 
 
@@ -1291,6 +1304,15 @@ bool migrate_use_multifd(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
 }
 
+int migrate_multifd_threads(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->parameters.x_multifd_threads;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -2055,6 +2077,7 @@ static void migration_instance_init(Object *obj)
         .max_bandwidth = MAX_THROTTLE,
         .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
         .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
+        .x_multifd_threads = DEFAULT_MIGRATE_MULTIFD_THREADS,
     };
     ms->parameters.tls_creds = g_strdup("");
     ms->parameters.tls_hostname = g_strdup("");
diff --git a/migration/migration.h b/migration/migration.h
index 9da9b4e..20ea30c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -173,6 +173,7 @@ bool migrate_zero_blocks(void);
 
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
+int migrate_multifd_threads(void);
 
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/qapi-schema.json b/qapi-schema.json
index 2457fb0..444e8f0 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -902,6 +902,7 @@
 #
 # @return-path: If enabled, migration will use the return path even
 #               for precopy. (since 2.10)
+#
 # @x-multifd: Use more than one fd for migration (since 2.10)
 #
 # Since: 1.2
@@ -910,6 +911,7 @@
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
            'block', 'return-path', 'x-multifd'] }
+
 ##
 # @MigrationCapabilityStatus:
 #
@@ -1026,13 +1028,19 @@
 # 	migrated and the destination must already have access to the
 # 	same backing chain as was used on the source.  (since 2.10)
 #
+# @x-multifd-threads: Number of threads used to migrate data in
+#                     parallel. This is the same number that the
+#                     number of sockets used for migration.
+#                     The default value is 2 (since 2.10)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
   'data': ['compress-level', 'compress-threads', 'decompress-threads',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
-           'downtime-limit', 'x-checkpoint-delay', 'block-incremental' ] }
+           'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
+           'x-multifd-threads'] }
 
 ##
 # @migrate-set-parameters:
@@ -1106,6 +1114,11 @@
 # 	migrated and the destination must already have access to the
 # 	same backing chain as was used on the source.  (since 2.10)
 #
+# @x-multifd-threads: Number of threads used to migrate data in
+#                     parallel. This is the same number that the
+#                     number of sockets used for migration.
+#                     The default value is 2 (since 2.10)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1119,7 +1132,8 @@
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
-            '*block-incremental': 'bool' } }
+            '*block-incremental': 'bool',
+            '*x-multifd-threads': 'int'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.9.4
