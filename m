Received: from eggs.gnu.org ([2001:4830:134:3::10]:33885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkqjv-0003IJ-Nl
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkqjr-0001Es-FM
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:00:31 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fkqjr-0001ES-2k
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:00:27 -0400
Received: by mail-pl0-x241.google.com with SMTP id w8-v6so8774206ply.8
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 06:00:26 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed,  1 Aug 2018 06:00:20 -0700
Message-Id: <1533128420-2745-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] migrate/cpu-throttle: Add max-cpu-throttle
 migration parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com, Li Qiang <liq3ea@gmail.com>

Currently, the default maximum CPU throttle for migration is
99(CPU_THROTTLE_PCT_MAX). This is too big and can make a remarkable
performance effect for the guest. We see a lot of packets latency
exceed 500ms when the CPU_THROTTLE_PCT_MAX reached. This patch set
adds a new max-cpu-throttle parameter to limit the CPU throttle.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hmp.c                 |  8 ++++++++
 migration/migration.c | 23 ++++++++++++++++++++++-
 migration/migration.h |  1 +
 migration/ram.c       |  4 +++-
 qapi/migration.json   | 21 ++++++++++++++++++---
 5 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/hmp.c b/hmp.c
index 2aafb50e8e..c38e8b1f78 100644
--- a/hmp.c
+++ b/hmp.c
@@ -339,6 +339,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT),
             params->cpu_throttle_increment);
+        assert(params->has_max_cpu_throttle);
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
+            params->max_cpu_throttle);
         assert(params->has_tls_creds);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
@@ -1635,6 +1639,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_cpu_throttle_increment = true;
         visit_type_int(v, param, &p->cpu_throttle_increment, &err);
         break;
+    case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
+        p->has_max_cpu_throttle = true;
+        visit_type_int(v, param, &p->max_cpu_throttle, &err);
+        break;
     case MIGRATION_PARAMETER_TLS_CREDS:
         p->has_tls_creds = true;
         p->tls_creds = g_new0(StrOrNull, 1);
diff --git a/migration/migration.c b/migration/migration.c
index b7d9854bda..570da6c0e7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -71,6 +71,7 @@
 /* Define default autoconverge cpu throttle migration parameters */
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT 10
+#define DEFAULT_MIGRATE_MAX_CPU_THROTTLE 99
 
 /* Migration XBZRLE default cache size */
 #define DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE (64 * 1024 * 1024)
@@ -697,6 +698,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth = true;
     params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
+    params->has_max_cpu_throttle = true;
+    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
 
     return params;
 }
@@ -1043,6 +1046,15 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_max_cpu_throttle &&
+        (params->max_cpu_throttle < params->cpu_throttle_initial ||
+         params->max_cpu_throttle > 99)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "max_cpu_throttle",
+                   "an integer in the range of cpu_throttle_initial to 99");
+        return false;
+    }
+
     return true;
 }
 
@@ -1110,6 +1122,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_max_postcopy_bandwidth) {
         dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
     }
+    if (params->has_max_cpu_throttle) {
+        dest->max_cpu_throttle = params->max_cpu_throttle;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1185,6 +1200,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_max_postcopy_bandwidth) {
         s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
     }
+    if (params->has_max_cpu_throttle) {
+        s->parameters.max_cpu_throttle = params->max_cpu_throttle;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1962,7 +1980,6 @@ static int64_t migrate_max_postcopy_bandwidth(void)
     return s->parameters.max_postcopy_bandwidth;
 }
 
-
 bool migrate_use_block(void)
 {
     MigrationState *s;
@@ -3160,6 +3177,9 @@ static Property migration_properties[] = {
     DEFINE_PROP_SIZE("max-postcopy-bandwidth", MigrationState,
                       parameters.max_postcopy_bandwidth,
                       DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH),
+    DEFINE_PROP_UINT8("max-cpu-throttle", MigrationState,
+                      parameters.max_cpu_throttle,
+                      DEFAULT_MIGRATE_MAX_CPU_THROTTLE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -3230,6 +3250,7 @@ static void migration_instance_init(Object *obj)
     params->has_x_multifd_page_count = true;
     params->has_xbzrle_cache_size = true;
     params->has_max_postcopy_bandwidth = true;
+    params->has_max_cpu_throttle = true;
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
diff --git a/migration/migration.h b/migration/migration.h
index 64a7b33735..eb0c04a7b4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -266,6 +266,7 @@ bool migrate_colo_enabled(void);
 
 bool migrate_use_block(void);
 bool migrate_use_block_incremental(void);
+int migrate_max_cpu_throttle(void);
 bool migrate_use_return_path(void);
 
 bool migrate_use_compression(void);
diff --git a/migration/ram.c b/migration/ram.c
index 24dea2730c..cdd4349177 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1390,13 +1390,15 @@ static void mig_throttle_guest_down(void)
     MigrationState *s = migrate_get_current();
     uint64_t pct_initial = s->parameters.cpu_throttle_initial;
     uint64_t pct_icrement = s->parameters.cpu_throttle_increment;
+    int pct_max = s->parameters.max_cpu_throttle;
 
     /* We have not started throttling yet. Let's start it. */
     if (!cpu_throttle_active()) {
         cpu_throttle_set(pct_initial);
     } else {
         /* Throttling already on, just increase the rate */
-        cpu_throttle_set(cpu_throttle_get_percentage() + pct_icrement);
+        cpu_throttle_set(MIN(cpu_throttle_get_percentage() + pct_icrement,
+                         pct_max));
     }
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 186e8a7303..865064e18c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -523,6 +523,9 @@
 # @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
 #                     Defaults to 0 (unlimited).  In bytes per second.
 #                     (Since 3.0)
+#
+# @max-cpu-throttle: maximum cpu throttle percentage.
+#                    Defaults to 99. (Since 3.1)
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -531,7 +534,8 @@
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
-           'xbzrle-cache-size', 'max-postcopy-bandwidth' ] }
+           'xbzrle-cache-size', 'max-postcopy-bandwidth',
+           'max-cpu-throttle' ] }
 
 ##
 # @MigrateSetParameters:
@@ -603,6 +607,10 @@
 # @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
 #                     Defaults to 0 (unlimited).  In bytes per second.
 #                     (Since 3.0)
+#
+# @max-cpu-throttle: maximum cpu throttle percentage.
+#                    The default value is 99. (Since 3.1)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -622,7 +630,8 @@
             '*x-multifd-channels': 'int',
             '*x-multifd-page-count': 'int',
             '*xbzrle-cache-size': 'size',
-            '*max-postcopy-bandwidth': 'size' } }
+            '*max-postcopy-bandwidth': 'size',
+	    '*max-cpu-throttle': 'int' } }
 
 ##
 # @migrate-set-parameters:
@@ -709,6 +718,11 @@
 # @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
 #                     Defaults to 0 (unlimited).  In bytes per second.
 #                     (Since 3.0)
+#
+# @max-cpu-throttle: maximum cpu throttle percentage.
+#                    Defaults to 99.
+#                     (Since 3.1)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -726,7 +740,8 @@
             '*x-multifd-channels': 'uint8',
             '*x-multifd-page-count': 'uint32',
             '*xbzrle-cache-size': 'size',
-            '*max-postcopy-bandwidth': 'size'  } }
+	    '*max-postcopy-bandwidth': 'size',
+            '*max-cpu-throttle':'uint8'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.11.0
