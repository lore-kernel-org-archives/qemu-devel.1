Received: from eggs.gnu.org ([2001:4830:134:3::10]:33765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEC-0002EQ-Aj
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE9-00035c-BB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmE9-000347-2q
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:37 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 463BD7FB75
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:11 +0100
Message-Id: <1485207141-1941-8-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 07/17] migration: Create x-multifd-group
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
---
 hmp.c                         |  8 ++++++++
 include/migration/migration.h |  1 +
 migration/migration.c         | 23 +++++++++++++++++++++++
 qapi-schema.json              | 11 +++++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 8c7e302..e579766 100644
--- a/hmp.c
+++ b/hmp.c
@@ -325,6 +325,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, " %s: %" PRId64,
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_THREADS],
             params->x_multifd_threads);
+        monitor_printf(mon, " %s: %" PRId64,
+            MigrationParameter_lookup[MIGRATION_PARAMETER_X_MULTIFD_GROUP],
+            params->x_multifd_group);
         monitor_printf(mon, "\n");
     }

@@ -1401,6 +1404,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.has_x_multifd_threads = true;
                 use_int_value = true;
                 break;
+            case MIGRATION_PARAMETER_X_MULTIFD_GROUP:
+                p.has_x_multifd_group = true;
+                use_int_value = true;
+                break;
             }

             if (use_int_value) {
@@ -1419,6 +1426,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 p.downtime_limit = valueint;
                 p.x_checkpoint_delay = valueint;
                 p.x_multifd_threads = valueint;
+                p.x_multifd_group = valueint;
             }

             qmp_migrate_set_parameters(&p, &err);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index b35044c..515569d 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -248,6 +248,7 @@ bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);

 int migrate_multifd_threads(void);
+int migrate_multifd_group(void);

 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
diff --git a/migration/migration.c b/migration/migration.c
index 2fe03d8..9bde01b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -68,6 +68,7 @@
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
 #define DEFAULT_MIGRATE_MULTIFD_THREADS 2
+#define DEFAULT_MIGRATE_MULTIFD_GROUP 16

 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -103,6 +104,7 @@ MigrationState *migrate_get_current(void)
             .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
             .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
             .x_multifd_threads = DEFAULT_MIGRATE_MULTIFD_THREADS,
+            .x_multifd_group = DEFAULT_MIGRATE_MULTIFD_GROUP,
         },
     };

@@ -595,6 +597,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
     params->has_x_multifd_threads = true;
     params->x_multifd_threads = s->parameters.x_multifd_threads;
+    params->has_x_multifd_group = true;
+    params->x_multifd_group = s->parameters.x_multifd_group;

     return params;
 }
@@ -865,6 +869,13 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
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
@@ -906,6 +917,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     if (params->has_x_multifd_threads) {
         s->parameters.x_multifd_threads = params->x_multifd_threads;
     }
+    if (params->has_x_multifd_group) {
+        s->parameters.x_multifd_group = params->x_multifd_group;
+    }
 }


@@ -1351,6 +1365,15 @@ int migrate_multifd_threads(void)
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
index 2273864..54232ee 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -984,6 +984,9 @@
 # @x-multifd-threads: Number of threads used to migrate data in parallel
 #                     The default value is 2 (since 2.9)
 #
+# @x-multifd-group: Number of pages sent together to a thread
+#                     The default value is 32 (since 2.9)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -991,7 +994,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay',
-           'x-multifd-threads'] }
+           'x-multifd-threads', 'x-multifd-group'] }

 ##
 # @migrate-set-parameters:
@@ -1058,6 +1061,9 @@
 # @x-multifd-threads: Number of threads used to migrate data in parallel
 #                     The default value is 1 (since 2.9)
 #
+# @x-multifd-group: Number of pages sent together in a bunch
+#                     The default value is 32 (since 2.9)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1071,7 +1077,8 @@
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
