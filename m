Received: from eggs.gnu.org ([2001:4830:134:3::10]:42228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5PG-0006Pq-Lz
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5PA-0006ic-CC
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds5PA-0006hf-4j
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C366883AC
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:00:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 13 Sep 2017 12:59:42 +0200
Message-Id: <20170913105953.13760-10-quintela@redhat.com>
In-Reply-To: <20170913105953.13760-1-quintela@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v8 09/20] migration: Create
 x-multifd-page-count parameter
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
Reviewed-by: Peter Xu <peterx@redhat.com>

--

Be consistent with defaults and documentation
Use new DEFINE_PROP_*
Rename x-multifd-group to x-multifd-page-count
---
 hmp.c                 |  7 +++++++
 migration/migration.c | 27 +++++++++++++++++++++++++++
 migration/migration.h |  1 +
 qapi/migration.json   | 17 ++++++++++++++---
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 1f9e39529f..203fe1d50e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -339,6 +339,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_CHANNELS),
             params->x_multifd_channels);
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_PAGE_COUNT),
+            params->x_multifd_page_count);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1628,6 +1631,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_multifd_channels = true;
         visit_type_int(v, param, &p->x_multifd_channels, &err);
         break;
+    case MIGRATION_PARAMETER_X_MULTIFD_PAGE_COUNT:
+        p->has_x_multifd_page_count = true;
+        visit_type_int(v, param, &p->x_multifd_page_count, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/migration.c b/migration/migration.c
index 021586f9f8..5be39fe6e2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -78,6 +78,7 @@
  */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
+#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 16
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -484,6 +485,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->block_incremental = s->parameters.block_incremental;
     params->has_x_multifd_channels = true;
     params->x_multifd_channels = s->parameters.x_multifd_channels;
+    params->has_x_multifd_page_count = true;
+    params->x_multifd_page_count = s->parameters.x_multifd_page_count;
 
     return params;
 }
@@ -772,6 +775,14 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
                    "is invalid, it should be in the range of 1 to 255");
         return false;
     }
+    if (params->has_x_multifd_page_count &&
+            (params->x_multifd_page_count < 1 ||
+             params->x_multifd_page_count > 10000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "multifd_page_count",
+                   "is invalid, it should be in the range of 1 to 10000");
+        return false;
+    }
 
     return true;
 }
@@ -893,6 +904,9 @@ static void migrate_params_apply(MigrateSetParameters *params)
     if (params->has_x_multifd_channels) {
         s->parameters.x_multifd_channels = params->x_multifd_channels;
     }
+    if (params->has_x_multifd_page_count) {
+        s->parameters.x_multifd_page_count = params->x_multifd_page_count;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1489,6 +1503,15 @@ int migrate_multifd_channels(void)
     return s->parameters.x_multifd_channels;
 }
 
+int migrate_multifd_page_count(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->parameters.x_multifd_page_count;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -2257,6 +2280,9 @@ static Property migration_properties[] = {
     DEFINE_PROP_INT64("x-multifd-channels", MigrationState,
                       parameters.x_multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
+    DEFINE_PROP_INT64("x-multifd-page-count", MigrationState,
+                      parameters.x_multifd_page_count,
+                      DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -2317,6 +2343,7 @@ static void migration_instance_init(Object *obj)
     params->has_x_checkpoint_delay = true;
     params->has_block_incremental = true;
     params->has_x_multifd_channels = true;
+    params->has_x_multifd_page_count = true;
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index a6a7c41823..da39d4c711 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -181,6 +181,7 @@ bool migrate_zero_blocks(void);
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
 int migrate_multifd_channels(void);
+int migrate_multifd_page_count(void);
 
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index c766fb1e52..f8b365e3f5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -471,6 +471,9 @@
 #                     number of sockets used for migration.  The
 #                     default value is 2 (since 2.11)
 #
+# @x-multifd-page-count: Number of pages sent together to a thread
+#                        The default value is 16 (since 2.11)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -478,7 +481,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
-           'x-multifd-channels'] }
+           'x-multifd-channels', 'x-multifd-page-count' ] }
 
 ##
 # @MigrateSetParameters:
@@ -539,6 +542,9 @@
 #                     number of sockets used for migration.  The
 #                     default value is 2 (since 2.11)
 #
+# @x-multifd-page-count: Number of pages sent together to a thread
+#                        The default value is 16 (since 2.11)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -555,7 +561,8 @@
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool',
-            '*x-multifd-channels': 'int' } }
+            '*x-multifd-channels': 'int',
+            '*x-multifd-page-count': 'int' } }
 
 ##
 # @migrate-set-parameters:
@@ -631,6 +638,9 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.11)
 #
+# @x-multifd-page-count: Number of pages sent together to a thread
+#                        The default value is 16 (since 2.11)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -645,7 +655,8 @@
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool' ,
-            '*x-multifd-channels': 'int' } }
+            '*x-multifd-channels': 'int',
+            '*x-multifd-page-count': 'int' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.13.5
