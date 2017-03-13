Received: from eggs.gnu.org ([2001:4830:134:3::10]:56461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLG-0004LR-B0
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLF-0005tb-AF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLF-0005tB-1m
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:49 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20CEDC05AA40
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:25 +0100
Message-Id: <20170313124434.1043-8-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 07/16] migration: Create x-multifd-group
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

Indicates how many pages we are going to send in each bach to a multifd
thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Be consistent with defaults and documentation

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                         |  8 ++++++++
 include/migration/migration.h |  1 +
 migration/migration.c         | 23 +++++++++++++++++++++++
 qapi-schema.json              | 11 +++++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 7d6db63..ab02773 100644
--- a/hmp.c
+++ b/hmp.c
@@ -326,6 +326,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, " %s: %" PRId64,
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_THREADS],
             params->x_multifd_threads);
+        monitor_printf(mon, " %s: %" PRId64,
+            MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_GROUP],
+            params->x_multifd_group);
         monitor_printf(mon, "\n");
     }
 
@@ -1407,6 +1410,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.has_x_multifd_threads = true;
                 use_int_value = true;
                 break;
+            case MIGRATION_PARAMETER_X_MULTIFD_GROUP:
+                p.has_x_multifd_group = true;
+                use_int_value = true;
+                break;
             }
 
             if (use_int_value) {
@@ -1425,6 +1432,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.downtime_limit = valueint;
                 p.x_checkpoint_delay = valueint;
                 p.x_multifd_threads = valueint;
+                p.x_multifd_group = valueint;
             }
 
             qmp_migrate_set_parameters(&p, &err);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 2950270..bacde15 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -266,6 +266,7 @@ bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);
 
 int migrate_multifd_threads(void);
+int migrate_multifd_group(void);
 
 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
diff --git a/migration/migration.c b/migration/migration.c
index cc9440b..4cc45a4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -72,6 +72,7 @@
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
 #define DEFAULT_MIGRATE_MULTIFD_THREADS 2
+#define DEFAULT_MIGRATE_MULTIFD_GROUP 16
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -107,6 +108,7 @@ MigrationState *migrate_get_current(void)
             .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
             .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
             .x_multifd_threads = DEFAULT_MIGRATE_MULTIFD_THREADS,
+            .x_multifd_group = DEFAULT_MIGRATE_MULTIFD_GROUP,
         },
     };
 
@@ -600,6 +602,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
     params->has_x_multifd_threads = true;
     params->x_multifd_threads = s->parameters.x_multifd_threads;
+    params->has_x_multifd_group = true;
+    params->x_multifd_group = s->parameters.x_multifd_group;
 
     return params;
 }
@@ -871,6 +875,13 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
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
@@ -915,6 +926,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     if (params->has_x_multifd_threads) {
         s->parameters.x_multifd_threads = params->x_multifd_threads;
     }
+    if (params->has_x_multifd_group) {
+        s->parameters.x_multifd_group = params->x_multifd_group;
+    }
 }
 
 
@@ -1441,6 +1455,15 @@ int migrate_multifd_threads(void)
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
diff --git a/qapi-schema.json b/qapi-schema.json
index b7cb26d..33a6267 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -988,6 +988,9 @@
 # @x-multifd-threads: Number of threads used to migrate data in parallel
 #                     The default value is 2 (since 2.9)
 #
+# @x-multifd-group: Number of pages sent together to a thread
+#                     The default value is 16 (since 2.9)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -995,7 +998,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay',
-           'x-multifd-threads'] }
+           'x-multifd-threads', 'x-multifd-group'] }
 
 ##
 # @migrate-set-parameters:
@@ -1062,6 +1065,9 @@
 # @x-multifd-threads: Number of threads used to migrate data in parallel
 #                     The default value is 2 (since 2.9)
 #
+# @x-multifd-group: Number of pages sent together in a bunch
+#                     The default value is 16 (since 2.9)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1075,7 +1081,8 @@
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
-            '*x-multifd-threads': 'int'} }
+            '*x-multifd-threads': 'int',
+            '*x-multifd-group': 'int'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.9.3
