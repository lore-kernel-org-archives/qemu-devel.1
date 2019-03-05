Received: from eggs.gnu.org ([209.51.188.92]:43412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fl-0002iz-TD
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fk-0000cN-Cn
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h14Fk-0000bs-2X
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:40 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Mar 2019 15:12:13 +0800
Message-Id: <1551769940-22739-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
References: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 06/13] migration: Add announce parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add migration parameters that control RARP/GARP announcement timeouts.

Based on earlier patches by myself and
  Vladislav Yasevich <vyasevic@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hmp.c                    |  28 +++++++++++++
 include/migration/misc.h |   2 +
 migration/migration.c    | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi/migration.json      |  53 +++++++++++++++++++++++--
 4 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 1e006ee..f3db0bf 100644
--- a/hmp.c
+++ b/hmp.c
@@ -334,6 +334,18 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
     params = qmp_query_migrate_parameters(NULL);
 
     if (params) {
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
+            params->announce_initial);
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
+            params->announce_max);
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
+            params->announce_rounds);
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
+            params->announce_step);
         assert(params->has_compress_level);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
@@ -1757,6 +1769,22 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_max_postcopy_bandwidth = true;
         visit_type_size(v, param, &p->max_postcopy_bandwidth, &err);
         break;
+    case MIGRATION_PARAMETER_ANNOUNCE_INITIAL:
+        p->has_announce_initial = true;
+        visit_type_size(v, param, &p->announce_initial, &err);
+        break;
+    case MIGRATION_PARAMETER_ANNOUNCE_MAX:
+        p->has_announce_max = true;
+        visit_type_size(v, param, &p->announce_max, &err);
+        break;
+    case MIGRATION_PARAMETER_ANNOUNCE_ROUNDS:
+        p->has_announce_rounds = true;
+        visit_type_size(v, param, &p->announce_rounds, &err);
+        break;
+    case MIGRATION_PARAMETER_ANNOUNCE_STEP:
+        p->has_announce_step = true;
+        visit_type_size(v, param, &p->announce_step, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4ebf24c..e837ab3 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -15,6 +15,7 @@
 #define MIGRATION_MISC_H
 
 #include "qemu/notify.h"
+#include "qapi/qapi-types-net.h"
 
 /* migration/ram.c */
 
@@ -38,6 +39,7 @@ int64_t self_announce_delay(int round)
     return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
 }
 
+AnnounceParameters *migrate_announce_params(void);
 /* migration/savevm.c */
 
 void dump_vmstate_json_to_file(FILE *out_fp);
diff --git a/migration/migration.c b/migration/migration.c
index a9c4c6f..ca9c35a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -87,6 +87,15 @@
  */
 #define DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH 0
 
+/*
+ * Parameters for self_announce_delay giving a stream of RARP/ARP
+ * packets after migration.
+ */
+#define DEFAULT_MIGRATE_ANNOUNCE_INITIAL  50
+#define DEFAULT_MIGRATE_ANNOUNCE_MAX     550
+#define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
+#define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
+
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
 
@@ -740,10 +749,32 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
     params->has_max_cpu_throttle = true;
     params->max_cpu_throttle = s->parameters.max_cpu_throttle;
+    params->has_announce_initial = true;
+    params->announce_initial = s->parameters.announce_initial;
+    params->has_announce_max = true;
+    params->announce_max = s->parameters.announce_max;
+    params->has_announce_rounds = true;
+    params->announce_rounds = s->parameters.announce_rounds;
+    params->has_announce_step = true;
+    params->announce_step = s->parameters.announce_step;
 
     return params;
 }
 
+AnnounceParameters *migrate_announce_params(void)
+{
+    static AnnounceParameters ap;
+
+    MigrationState *s = migrate_get_current();
+
+    ap.initial = s->parameters.announce_initial;
+    ap.max = s->parameters.announce_max;
+    ap.rounds = s->parameters.announce_rounds;
+    ap.step = s->parameters.announce_step;
+
+    return &ap;
+}
+
 /*
  * Return true if we're already in the middle of a migration
  * (i.e. any of the active or setup states)
@@ -1117,6 +1148,35 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_announce_initial &&
+        params->announce_initial > 100000) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "announce_initial",
+                   "is invalid, it must be less than 100000 ms");
+        return false;
+    }
+    if (params->has_announce_max &&
+        params->announce_max > 100000) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "announce_max",
+                   "is invalid, it must be less than 100000 ms");
+       return false;
+    }
+    if (params->has_announce_rounds &&
+        params->announce_rounds > 1000) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "announce_rounds",
+                   "is invalid, it must be in the range of 0 to 1000");
+       return false;
+    }
+    if (params->has_announce_step &&
+        (params->announce_step < 1 ||
+        params->announce_step > 10000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "announce_step",
+                   "is invalid, it must be in the range of 1 to 10000 ms");
+       return false;
+    }
     return true;
 }
 
@@ -1191,6 +1251,18 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_max_cpu_throttle) {
         dest->max_cpu_throttle = params->max_cpu_throttle;
     }
+    if (params->has_announce_initial) {
+        dest->announce_initial = params->announce_initial;
+    }
+    if (params->has_announce_max) {
+        dest->announce_max = params->announce_max;
+    }
+    if (params->has_announce_rounds) {
+        dest->announce_rounds = params->announce_rounds;
+    }
+    if (params->has_announce_step) {
+        dest->announce_step = params->announce_step;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1273,6 +1345,18 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_max_cpu_throttle) {
         s->parameters.max_cpu_throttle = params->max_cpu_throttle;
     }
+    if (params->has_announce_initial) {
+        s->parameters.announce_initial = params->announce_initial;
+    }
+    if (params->has_announce_max) {
+        s->parameters.announce_max = params->announce_max;
+    }
+    if (params->has_announce_rounds) {
+        s->parameters.announce_rounds = params->announce_rounds;
+    }
+    if (params->has_announce_step) {
+        s->parameters.announce_step = params->announce_step;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -3275,6 +3359,18 @@ static Property migration_properties[] = {
     DEFINE_PROP_UINT8("max-cpu-throttle", MigrationState,
                       parameters.max_cpu_throttle,
                       DEFAULT_MIGRATE_MAX_CPU_THROTTLE),
+    DEFINE_PROP_SIZE("announce-initial", MigrationState,
+                      parameters.announce_initial,
+                      DEFAULT_MIGRATE_ANNOUNCE_INITIAL),
+    DEFINE_PROP_SIZE("announce-max", MigrationState,
+                      parameters.announce_max,
+                      DEFAULT_MIGRATE_ANNOUNCE_MAX),
+    DEFINE_PROP_SIZE("announce-rounds", MigrationState,
+                      parameters.announce_rounds,
+                      DEFAULT_MIGRATE_ANNOUNCE_ROUNDS),
+    DEFINE_PROP_SIZE("announce-step", MigrationState,
+                      parameters.announce_step,
+                      DEFAULT_MIGRATE_ANNOUNCE_STEP),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -3347,6 +3443,10 @@ static void migration_instance_init(Object *obj)
     params->has_xbzrle_cache_size = true;
     params->has_max_postcopy_bandwidth = true;
     params->has_max_cpu_throttle = true;
+    params->has_announce_initial = true;
+    params->has_announce_max = true;
+    params->has_announce_rounds = true;
+    params->has_announce_step = true;
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
diff --git a/qapi/migration.json b/qapi/migration.json
index 7a795ec..1fd7bbe 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -480,6 +480,18 @@
 #
 # Migration parameters enumeration
 #
+# @announce-initial: Initial delay (in milliseconds) before sending the first
+#          announce (Since 4.0)
+#
+# @announce-max: Maximum delay (in milliseconds) between packets in the
+#          announcement (Since 4.0)
+#
+# @announce-rounds: Number of self-announce packets sent after migration
+#          (Since 4.0)
+#
+# @announce-step: Increase in delay (in milliseconds) between subsequent
+#          packets in the announcement (Since 4.0)
+#
 # @compress-level: Set the compression level to be used in live migration,
 #          the compression level is an integer between 0 and 9, where 0 means
 #          no compression, 1 means the best compression speed, and 9 means best
@@ -557,10 +569,13 @@
 #
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99. (Since 3.1)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
-  'data': ['compress-level', 'compress-threads', 'decompress-threads',
+  'data': ['announce-initial', 'announce-max',
+           'announce-rounds', 'announce-step',
+           'compress-level', 'compress-threads', 'decompress-threads',
            'compress-wait-thread',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
@@ -572,6 +587,18 @@
 ##
 # @MigrateSetParameters:
 #
+# @announce-initial: Initial delay (in milliseconds) before sending the first
+#          announce (Since 4.0)
+#
+# @announce-max: Maximum delay (in milliseconds) between packets in the
+#          announcement (Since 4.0)
+#
+# @announce-rounds: Number of self-announce packets sent after migration
+#          (Since 4.0)
+#
+# @announce-step: Increase in delay (in milliseconds) between subsequent
+#          packets in the announcement (Since 4.0)
+#
 # @compress-level: compression level
 #
 # @compress-threads: compression thread count
@@ -653,7 +680,11 @@
 # TODO either fuse back into MigrationParameters, or make
 # MigrationParameters members mandatory
 { 'struct': 'MigrateSetParameters',
-  'data': { '*compress-level': 'int',
+  'data': { '*announce-initial': 'size',
+            '*announce-max': 'size',
+            '*announce-rounds': 'size',
+            '*announce-step': 'size',
+            '*compress-level': 'int',
             '*compress-threads': 'int',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'int',
@@ -692,6 +723,18 @@
 #
 # The optional members aren't actually optional.
 #
+# @announce-initial: Initial delay (in milliseconds) before sending the
+#          first announce (Since 4.0)
+#
+# @announce-max: Maximum delay (in milliseconds) between packets in the
+#          announcement (Since 4.0)
+#
+# @announce-rounds: Number of self-announce packets sent after migration
+#          (Since 4.0)
+#
+# @announce-step: Increase in delay (in milliseconds) between subsequent
+#          packets in the announcement (Since 4.0)
+#
 # @compress-level: compression level
 #
 # @compress-threads: compression thread count
@@ -769,7 +812,11 @@
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
-  'data': { '*compress-level': 'uint8',
+  'data': { '*announce-initial': 'size',
+            '*announce-max': 'size',
+            '*announce-rounds': 'size',
+            '*announce-step': 'size',
+            '*compress-level': 'uint8',
             '*compress-threads': 'uint8',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
-- 
2.5.0
