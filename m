Received: from eggs.gnu.org ([2001:4830:134:3::10]:56459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLG-0004L7-1Q
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLD-0005sp-Nu
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLD-0005sI-F4
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:47 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 969CE7712
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:24 +0100
Message-Id: <20170313124434.1043-7-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/16] migration: Create x-multifd-threads
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
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Indicates the number of threads that we would create.  By default we
create 2 threads.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Catch inconsistent defaults.
Thanks Eric

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                         |  8 ++++++++
 include/migration/migration.h |  2 ++
 migration/migration.c         | 23 +++++++++++++++++++++++
 qapi-schema.json              | 13 +++++++++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 261843f..7d6db63 100644
--- a/hmp.c
+++ b/hmp.c
@@ -323,6 +323,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, " %s: %" PRId64,
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_DELAY],
             params->x_checkpoint_delay);
+        monitor_printf(mon, " %s: %" PRId64,
+            MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_THREADS],
+            params->x_multifd_threads);
         monitor_printf(mon, "\n");
     }
 
@@ -1400,6 +1403,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.has_x_checkpoint_delay = true;
                 use_int_value = true;
                 break;
+            case MIGRATION_PARAMETER_X_MULTIFD_THREADS:
+                p.has_x_multifd_threads = true;
+                use_int_value = true;
+                break;
             }
 
             if (use_int_value) {
@@ -1417,6 +1424,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.cpu_throttle_increment = valueint;
                 p.downtime_limit = valueint;
                 p.x_checkpoint_delay = valueint;
+                p.x_multifd_threads = valueint;
             }
 
             qmp_migrate_set_parameters(&p, &err);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index d48934b..2950270 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -265,6 +265,8 @@ bool migration_in_postcopy(MigrationState *);
 bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);
 
+int migrate_multifd_threads(void);
+
 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
 void migrate_decompress_threads_create(void);
diff --git a/migration/migration.c b/migration/migration.c
index 0e5b0bf..cc9440b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -71,6 +71,7 @@
  * Note: Please change this default value to 10000 when we support hybrid mode.
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
+#define DEFAULT_MIGRATE_MULTIFD_THREADS 2
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -105,6 +106,7 @@ MigrationState *migrate_get_current(void)
             .max_bandwidth = MAX_THROTTLE,
             .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
             .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
+            .x_multifd_threads = DEFAULT_MIGRATE_MULTIFD_THREADS,
         },
     };
 
@@ -596,6 +598,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
+    params->has_x_multifd_threads = true;
+    params->x_multifd_threads = s->parameters.x_multifd_threads;
 
     return params;
 }
@@ -860,6 +864,13 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
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
@@ -901,6 +912,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
             colo_checkpoint_notify(s);
         }
     }
+    if (params->has_x_multifd_threads) {
+        s->parameters.x_multifd_threads = params->x_multifd_threads;
+    }
 }
 
 
@@ -1418,6 +1432,15 @@ bool migrate_use_multifd(void)
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
diff --git a/qapi-schema.json b/qapi-schema.json
index d21934b..b7cb26d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -985,13 +985,17 @@
 # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
 #          periodic mode. (Since 2.8)
 #
+# @x-multifd-threads: Number of threads used to migrate data in parallel
+#                     The default value is 2 (since 2.9)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
   'data': ['compress-level', 'compress-threads', 'decompress-threads',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
-           'downtime-limit', 'x-checkpoint-delay' ] }
+           'downtime-limit', 'x-checkpoint-delay',
+           'x-multifd-threads'] }
 
 ##
 # @migrate-set-parameters:
@@ -1054,6 +1058,10 @@
 #
 # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
 #
+#
+# @x-multifd-threads: Number of threads used to migrate data in parallel
+#                     The default value is 2 (since 2.9)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1066,7 +1074,8 @@
             '*tls-hostname': 'str',
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
-            '*x-checkpoint-delay': 'int'} }
+            '*x-checkpoint-delay': 'int',
+            '*x-multifd-threads': 'int'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.9.3
