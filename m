Received: from eggs.gnu.org ([2001:4830:134:3::10]:48037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRy-0004KQ-1N
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRv-0000kf-2S
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTqRu-0000kW-T8
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:38 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Jun 2018 16:15:15 +0100
Message-Id: <20180615151518.83637-8-dgilbert@redhat.com>
In-Reply-To: <20180615151518.83637-1-dgilbert@redhat.com>
References: <20180615151518.83637-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] migration/postcopy: Add
 max-postcopy-bandwidth parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, vsementsov@virtuozzo.com, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Limit the background transfer bandwidth during the postcopy
phase to the value set on this new parameter.  The default, 0,
corresponds to the existing behaviour which is unlimited bandwidth.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180613102642.23995-2-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c                 |  7 +++++++
 migration/migration.c | 35 ++++++++++++++++++++++++++++++++++-
 qapi/migration.json   | 19 ++++++++++++++++---
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index ef93f4878b..f40d8279cf 100644
--- a/hmp.c
+++ b/hmp.c
@@ -370,6 +370,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
+            params->max_postcopy_bandwidth);
     }
 
     qapi_free_MigrationParameters(params);
@@ -1676,6 +1679,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         }
         p->xbzrle_cache_size = cache_size;
         break;
+    case MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH:
+        p->has_max_postcopy_bandwidth = true;
+        visit_type_size(v, param, &p->max_postcopy_bandwidth, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/migration.c b/migration/migration.c
index 1e99ec9b7e..3a50d4c35c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -82,6 +82,11 @@
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
 #define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 16
 
+/* Background transfer rate for postcopy, 0 means unlimited, note
+ * that page requests can still exceed this limit.
+ */
+#define DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH 0
+
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
 
@@ -659,6 +664,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_multifd_page_count = s->parameters.x_multifd_page_count;
     params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
+    params->has_max_postcopy_bandwidth = true;
+    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
 
     return params;
 }
@@ -1066,6 +1073,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
+    if (params->has_max_postcopy_bandwidth) {
+        dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1138,6 +1148,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
     }
+    if (params->has_max_postcopy_bandwidth) {
+        s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1887,6 +1900,16 @@ int64_t migrate_xbzrle_cache_size(void)
     return s->parameters.xbzrle_cache_size;
 }
 
+static int64_t migrate_max_postcopy_bandwidth(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->parameters.max_postcopy_bandwidth;
+}
+
+
 bool migrate_use_block(void)
 {
     MigrationState *s;
@@ -2226,6 +2249,7 @@ static int postcopy_start(MigrationState *ms)
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
     int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    int64_t bandwidth = migrate_max_postcopy_bandwidth();
     bool restart_block = false;
     int cur_state = MIGRATION_STATUS_ACTIVE;
     if (!migrate_pause_before_switchover()) {
@@ -2280,7 +2304,12 @@ static int postcopy_start(MigrationState *ms)
      * will notice we're in POSTCOPY_ACTIVE and not actually
      * wrap their state up here
      */
-    qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
+    /* 0 max-postcopy-bandwidth means unlimited */
+    if (!bandwidth) {
+        qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
+    } else {
+        qemu_file_set_rate_limit(ms->to_dst_file, bandwidth / XFER_LIMIT_RATIO);
+    }
     if (migrate_postcopy_ram()) {
         /* Ping just for debugging, helps line traces up */
         qemu_savevm_send_ping(ms->to_dst_file, 2);
@@ -3042,6 +3071,9 @@ static Property migration_properties[] = {
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
+    DEFINE_PROP_SIZE("max-postcopy-bandwidth", MigrationState,
+                      parameters.max_postcopy_bandwidth,
+                      DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -3110,6 +3142,7 @@ static void migration_instance_init(Object *obj)
     params->has_x_multifd_channels = true;
     params->has_x_multifd_page_count = true;
     params->has_xbzrle_cache_size = true;
+    params->has_max_postcopy_bandwidth = true;
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
diff --git a/qapi/migration.json b/qapi/migration.json
index f7e10ee90f..1b4c1db670 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -517,6 +517,9 @@
 #                     and a power of 2
 #                     (Since 2.11)
 #
+# @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
+#                     Defaults to 0 (unlimited).  In bytes per second.
+#                     (Since 3.0)
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -525,7 +528,7 @@
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
-           'xbzrle-cache-size' ] }
+           'xbzrle-cache-size', 'max-postcopy-bandwidth' ] }
 
 ##
 # @MigrateSetParameters:
@@ -593,6 +596,10 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
+#                     Defaults to 0 (unlimited).  In bytes per second.
+#                     (Since 3.0)
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -611,7 +618,8 @@
             '*block-incremental': 'bool',
             '*x-multifd-channels': 'int',
             '*x-multifd-page-count': 'int',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size',
+            '*max-postcopy-bandwidth': 'size' } }
 
 ##
 # @migrate-set-parameters:
@@ -694,6 +702,10 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
+#                     Defaults to 0 (unlimited).  In bytes per second.
+#                     (Since 3.0)
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -710,7 +722,8 @@
             '*block-incremental': 'bool' ,
             '*x-multifd-channels': 'uint8',
             '*x-multifd-page-count': 'uint32',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size',
+            '*max-postcopy-bandwidth': 'size'  } }
 
 ##
 # @query-migrate-parameters:
-- 
2.17.1
