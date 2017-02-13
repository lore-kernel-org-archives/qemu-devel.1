Received: from eggs.gnu.org ([2001:4830:134:3::10]:57757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIJ-0007vv-1W
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIH-0004ri-9z
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIH-0004qs-0z
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:05 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39B4681236
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:40 +0100
Message-Id: <1487006388-7966-5-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/12] migration: Create x-multifd-threads
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
---
 hmp.c                         |  8 ++++++++
 include/migration/migration.h |  2 ++
 migration/migration.c         | 23 +++++++++++++++++++++++
 qapi-schema.json              | 13 +++++++++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 2bc4f06..71e3d8c 100644
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

@@ -1395,6 +1398,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.has_x_checkpoint_delay = true;
                 use_int_value = true;
                 break;
+            case MIGRATION_PARAMETER_X_MULTIFD_THREADS:
+                p.has_x_multifd_threads = true;
+                use_int_value = true;
+                break;
             }

             if (use_int_value) {
@@ -1412,6 +1419,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.cpu_throttle_increment = valueint;
                 p.downtime_limit = valueint;
                 p.x_checkpoint_delay = valueint;
+                p.x_multifd_threads = valueint;
             }

             qmp_migrate_set_parameters(&p, &err);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index e8bba55..de987da 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -254,6 +254,8 @@ bool migration_in_postcopy(MigrationState *);
 bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);

+int migrate_multifd_threads(void);
+
 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
 void migrate_decompress_threads_create(void);
diff --git a/migration/migration.c b/migration/migration.c
index 37af7a4..141eac6 100644
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
+        (params->x_multifd_threads < 1 || params->x_multifd_threads > 255)) {
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


@@ -1378,6 +1392,15 @@ bool migrate_use_multifd(void)
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
index ff7579e..5c18d54 100644
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
+#                     The default value is 2 (since 2.9)
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
2.7.4
