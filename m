Received: from eggs.gnu.org ([2001:4830:134:3::10]:35589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7EYi-0000uJ-GF
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7EYh-0004UX-5Y
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e7EYg-0004U3-SM
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:48:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3654CD276
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:48:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Oct 2017 07:48:41 +0200
Message-Id: <20171025054842.24883-5-quintela@redhat.com>
In-Reply-To: <20171025054842.24883-1-quintela@redhat.com>
References: <20171025054842.24883-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/5] migration: Make xbzrle_cache_size a
 migration parameter
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

Right now it is a variable in MigrationState instead of a
MigrationParameter.  The change allows to set it as the rest of the
Migration parameters, from the command line, with
query_migration_paramters, set_migrate_parameters, etc.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c                 | 14 ++++++++++++++
 migration/migration.c | 43 ++++++++++++++++++++++++++++++++-----------
 migration/migration.h |  1 -
 migration/ram.c       |  7 -------
 qapi/migration.json   | 26 +++++++++++++++++++++++---
 5 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/hmp.c b/hmp.c
index 41fcce6f5a..a01be50daa 100644
--- a/hmp.c
+++ b/hmp.c
@@ -342,6 +342,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_PAGE_COUNT),
             params->x_multifd_page_count);
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
+            params->xbzrle_cache_size);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1578,6 +1581,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     Visitor *v = string_input_visitor_new(valuestr);
     MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
     uint64_t valuebw = 0;
+    uint64_t cache_size;
     Error *err = NULL;
     int val, ret;
 
@@ -1653,6 +1657,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_multifd_page_count = true;
         visit_type_int(v, param, &p->x_multifd_page_count, &err);
         break;
+    case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
+        p->has_xbzrle_cache_size = true;
+        visit_type_size(v, param, &cache_size, &err);
+        if (err || cache_size > INT64_MAX
+            || (size_t)cache_size != cache_size) {
+            error_setg(&err, "Invalid size %s", valuestr);
+            break;
+        }
+        p->xbzrle_cache_size = cache_size;
+        break;
     default:
         assert(0);
     }
diff --git a/migration/migration.c b/migration/migration.c
index 6bbd4715d3..4de3b551fe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -71,7 +71,7 @@
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT 10
 
 /* Migration XBZRLE default cache size */
-#define DEFAULT_MIGRATE_CACHE_SIZE (64 * 1024 * 1024)
+#define DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE (64 * 1024 * 1024)
 
 /* The delay time (in ms) between two COLO checkpoints
  * Note: Please change this default value to 10000 when we support hybrid mode.
@@ -515,6 +515,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_multifd_channels = s->parameters.x_multifd_channels;
     params->has_x_multifd_page_count = true;
     params->x_multifd_page_count = s->parameters.x_multifd_page_count;
+    params->has_xbzrle_cache_size = true;
+    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
 
     return params;
 }
@@ -817,6 +819,16 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_xbzrle_cache_size &&
+        (params->xbzrle_cache_size < qemu_target_page_size() ||
+         !is_power_of_2(params->xbzrle_cache_size))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "xbzrle_cache_size",
+                   "is invalid, it should be bigger than target page size"
+                   " and a power of two");
+        return false;
+    }
+
     return true;
 }
 
@@ -878,9 +890,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_x_multifd_page_count) {
         dest->x_multifd_page_count = params->x_multifd_page_count;
     }
+    if (params->has_xbzrle_cache_size) {
+        dest->xbzrle_cache_size = params->xbzrle_cache_size;
+    }
 }
 
-static void migrate_params_apply(MigrateSetParameters *params)
+static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
 
@@ -946,6 +961,10 @@ static void migrate_params_apply(MigrateSetParameters *params)
     if (params->has_x_multifd_page_count) {
         s->parameters.x_multifd_page_count = params->x_multifd_page_count;
     }
+    if (params->has_xbzrle_cache_size) {
+        s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
+        xbzrle_cache_resize(params->xbzrle_cache_size, errp);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -974,7 +993,7 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
         return;
     }
 
-    migrate_params_apply(params);
+    migrate_params_apply(params, errp);
 }
 
 
@@ -1405,13 +1424,12 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
 
 void qmp_migrate_set_cache_size(int64_t value, Error **errp)
 {
-    MigrationState *s = migrate_get_current();
+    MigrateSetParameters p = {
+        .has_xbzrle_cache_size = true,
+        .xbzrle_cache_size = value,
+    };
 
-    if (xbzrle_cache_resize(value, errp) < 0) {
-        return;
-    }
-
-    s->xbzrle_cache_size = value;
+    qmp_migrate_set_parameters(&p, errp);
 }
 
 int64_t qmp_query_migrate_cache_size(Error **errp)
@@ -1587,7 +1605,7 @@ int64_t migrate_xbzrle_cache_size(void)
 
     s = migrate_get_current();
 
-    return s->xbzrle_cache_size;
+    return s->parameters.xbzrle_cache_size;
 }
 
 bool migrate_use_block(void)
@@ -2405,6 +2423,9 @@ static Property migration_properties[] = {
     DEFINE_PROP_INT64("x-multifd-page-count", MigrationState,
                       parameters.x_multifd_page_count,
                       DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT),
+    DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
+                      parameters.xbzrle_cache_size,
+                      DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -2448,7 +2469,6 @@ static void migration_instance_init(Object *obj)
     MigrationParameters *params = &ms->parameters;
 
     ms->state = MIGRATION_STATUS_NONE;
-    ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
     ms->mbps = -1;
     qemu_sem_init(&ms->pause_sem, 0);
     qemu_mutex_init(&ms->error_mutex);
@@ -2468,6 +2488,7 @@ static void migration_instance_init(Object *obj)
     params->has_block_incremental = true;
     params->has_x_multifd_channels = true;
     params->has_x_multifd_page_count = true;
+    params->has_xbzrle_cache_size = true;
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index 8ccdd7a577..663415fe48 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -107,7 +107,6 @@ struct MigrationState
     int64_t downtime;
     int64_t expected_downtime;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
-    int64_t xbzrle_cache_size;
     int64_t setup_time;
 
     /* Flag set once the migration has been asked to enter postcopy */
diff --git a/migration/ram.c b/migration/ram.c
index 997340c7c2..8620aa400a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -129,13 +129,6 @@ int xbzrle_cache_resize(int64_t new_size, Error **errp)
         return -1;
     }
 
-    /* Cache should not be larger than guest ram size */
-    if (new_size > ram_bytes_total()) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "exceeds guest ram size");
-        return -1;
-    }
-
     if (new_size == migrate_xbzrle_cache_size()) {
         /* nothing to do */
         return 0;
diff --git a/qapi/migration.json b/qapi/migration.json
index 6ae866e1aa..bbc4671ded 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -483,6 +483,11 @@
 # @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
+# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
+#                     needs to be a multiple of the target page size
+#                     and a power of 2
+#                     (Since 2.11)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -490,7 +495,8 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
-           'x-multifd-channels', 'x-multifd-page-count' ] }
+           'x-multifd-channels', 'x-multifd-page-count',
+           'xbzrle-cache-size' ] }
 
 ##
 # @MigrateSetParameters:
@@ -554,6 +560,10 @@
 # @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
+# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
+#                     needs to be a multiple of the target page size
+#                     and a power of 2
+#                     (Since 2.11)
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -571,7 +581,8 @@
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool',
             '*x-multifd-channels': 'int',
-            '*x-multifd-page-count': 'int' } }
+            '*x-multifd-page-count': 'int',
+            '*xbzrle-cache-size': 'size' } }
 
 ##
 # @migrate-set-parameters:
@@ -650,6 +661,10 @@
 # @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
+# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
+#                     needs to be a multiple of the target page size
+#                     and a power of 2
+#                     (Since 2.11)
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -665,7 +680,8 @@
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool' ,
             '*x-multifd-channels': 'int',
-            '*x-multifd-page-count': 'int' } }
+            '*x-multifd-page-count': 'int',
+            '*xbzrle-cache-size': 'size' } }
 
 ##
 # @query-migrate-parameters:
@@ -947,6 +963,8 @@
 #
 # Returns: nothing on success
 #
+# Notes: This command is deprecated in favor of 'migrate-set-parameters'
+#
 # Since: 1.2
 #
 # Example:
@@ -965,6 +983,8 @@
 #
 # Returns: XBZRLE cache size in bytes
 #
+# Notes: This command is deprecated in favor of 'query-migrate-parameters'
+#
 # Since: 1.2
 #
 # Example:
-- 
2.13.6
