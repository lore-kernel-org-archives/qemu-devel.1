Received: from eggs.gnu.org ([2001:4830:134:3::10]:33741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE9-0002B2-1o
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE7-00032G-Si
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmE7-00030Q-Jz
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3C397FE81
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:10 +0100
Message-Id: <1485207141-1941-7-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/17] migration: Create x-multifd-threads
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
---
 hmp.c                         |  8 ++++++++
 include/migration/migration.h |  2 ++
 migration/migration.c         | 23 +++++++++++++++++++++++
 qapi-schema.json              | 13 +++++++++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 8522efe..8c7e302 100644
--- a/hmp.c
+++ b/hmp.c
@@ -322,6 +322,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, " %s: %" PRId64,
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_DELAY],
             params->x_checkpoint_delay);
+        monitor_printf(mon, " %s: %" PRId64,
+            MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_THREADS],
+            params->x_multifd_threads);
         monitor_printf(mon, "\n");
     }

@@ -1394,6 +1397,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.has_x_checkpoint_delay = true;
                 use_int_value = true;
                 break;
+            case MIGRATION_PARAMETER_X_MULTIFD_THREADS:
+                p.has_x_multifd_threads = true;
+                use_int_value = true;
+                break;
             }

             if (use_int_value) {
@@ -1411,6 +1418,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.cpu_throttle_increment = valueint;
                 p.downtime_limit = valueint;
                 p.x_checkpoint_delay = valueint;
+                p.x_multifd_threads = valueint;
             }

             qmp_migrate_set_parameters(&p, &err);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 19245d6..b35044c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -247,6 +247,8 @@ bool migration_in_postcopy(MigrationState *);
 bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);

+int migrate_multifd_threads(void);
+
 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
 void migrate_decompress_threads_create(void);
diff --git a/migration/migration.c b/migration/migration.c
index 1669e41..2fe03d8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -67,6 +67,7 @@
  * Note: Please change this default value to 10000 when we support hybrid mode.
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
+#define DEFAULT_MIGRATE_MULTIFD_THREADS 2

 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -101,6 +102,7 @@ MigrationState *migrate_get_current(void)
             .max_bandwidth = MAX_THROTTLE,
             .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
             .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
+            .x_multifd_threads = DEFAULT_MIGRATE_MULTIFD_THREADS,
         },
     };

@@ -591,6 +593,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
+    params->has_x_multifd_threads = true;
+    params->x_multifd_threads = s->parameters.x_multifd_threads;

     return params;
 }
@@ -854,6 +858,13 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
                     "x_checkpoint_delay",
                     "is invalid, it should be positive");
     }
+    if (params->has_x_multifd_threads &&
+            (params->x_multifd_threads < 1 || params->x_multifd_threads > 255)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "multifd_threads",
+                   "is invalid, it should be in the range of 1 to 255");
+        return;
+    }

     if (params->has_compress_level) {
         s->parameters.compress_level = params->compress_level;
@@ -892,6 +903,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     if (params->has_x_checkpoint_delay) {
         s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
     }
+    if (params->has_x_multifd_threads) {
+        s->parameters.x_multifd_threads = params->x_multifd_threads;
+    }
 }


@@ -1328,6 +1342,15 @@ bool migrate_use_multifd(void)
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
index d34632e..2273864 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -981,13 +981,17 @@
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
@@ -1050,6 +1054,10 @@
 #
 # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
 #
+#
+# @x-multifd-threads: Number of threads used to migrate data in parallel
+#                     The default value is 1 (since 2.9)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1062,7 +1070,8 @@
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
