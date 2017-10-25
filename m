Received: from eggs.gnu.org ([2001:4830:134:3::10]:35635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7EYl-0000wb-2Q
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7EYi-0004Wh-V7
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e7EYi-0004VJ-M2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9435579704
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:48:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Oct 2017 07:48:42 +0200
Message-Id: <20171025054842.24883-6-quintela@redhat.com>
In-Reply-To: <20171025054842.24883-1-quintela@redhat.com>
References: <20171025054842.24883-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/5] migration: [RFC] Use proper types in
 json
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

We use int for everything (int64_t), and then we check that value is
between 0 and 255.  Change it to the valid types.

For qmp, the only real change is that now max_bandwidth allows to use
the k/M/G suffixes.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                 | 22 +++++++++++-----------
 migration/migration.c | 49 ++++++++++++++++++++-----------------------------
 qapi/migration.json   | 20 ++++++++++----------
 3 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/hmp.c b/hmp.c
index a01be50daa..7670f102c3 100644
--- a/hmp.c
+++ b/hmp.c
@@ -293,23 +293,23 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 
     if (params) {
         assert(params->has_compress_level);
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
             params->compress_level);
         assert(params->has_compress_threads);
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_THREADS),
             params->compress_threads);
         assert(params->has_decompress_threads);
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREADS),
             params->decompress_threads);
         assert(params->has_cpu_throttle_initial);
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
             params->cpu_throttle_initial);
         assert(params->has_cpu_throttle_increment);
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT),
             params->cpu_throttle_increment);
         assert(params->has_tls_creds);
@@ -321,28 +321,28 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
             params->tls_hostname);
         assert(params->has_max_bandwidth);
-        monitor_printf(mon, "%s: %" PRId64 " bytes/second\n",
+        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
             params->max_bandwidth);
         assert(params->has_downtime_limit);
-        monitor_printf(mon, "%s: %" PRId64 " milliseconds\n",
+        monitor_printf(mon, "%s: %" PRIu64 " milliseconds\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
             params->downtime_limit);
         assert(params->has_x_checkpoint_delay);
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
         assert(params->has_block_incremental);
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
             params->block_incremental ? "on" : "off");
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_CHANNELS),
             params->x_multifd_channels);
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_PAGE_COUNT),
             params->x_multifd_page_count);
-        monitor_printf(mon, "%s: %" PRId64 "\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
     }
diff --git a/migration/migration.c b/migration/migration.c
index 4de3b551fe..8d2372394c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -741,22 +741,20 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
 static bool migrate_params_check(MigrationParameters *params, Error **errp)
 {
     if (params->has_compress_level &&
-        (params->compress_level < 0 || params->compress_level > 9)) {
+        (params->compress_level > 9)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
                    "is invalid, it should be in the range of 0 to 9");
         return false;
     }
 
-    if (params->has_compress_threads &&
-        (params->compress_threads < 1 || params->compress_threads > 255)) {
+    if (params->has_compress_threads && (params->compress_threads < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "compress_threads",
                    "is invalid, it should be in the range of 1 to 255");
         return false;
     }
 
-    if (params->has_decompress_threads &&
-        (params->decompress_threads < 1 || params->decompress_threads > 255)) {
+    if (params->has_decompress_threads && (params->decompress_threads < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "decompress_threads",
                    "is invalid, it should be in the range of 1 to 255");
@@ -781,38 +779,31 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_max_bandwidth &&
-        (params->max_bandwidth < 0 || params->max_bandwidth > SIZE_MAX)) {
+    if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX)) {
         error_setg(errp, "Parameter 'max_bandwidth' expects an integer in the"
                          " range of 0 to %zu bytes/second", SIZE_MAX);
         return false;
     }
 
     if (params->has_downtime_limit &&
-        (params->downtime_limit < 0 ||
-         params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
+        (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
         error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
                          "the range of 0 to %d milliseconds",
                          MAX_MIGRATE_DOWNTIME);
         return false;
     }
 
-    if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                    "x_checkpoint_delay",
-                    "is invalid, it should be positive");
-        return false;
-    }
-    if (params->has_x_multifd_channels &&
-        (params->x_multifd_channels < 1 || params->x_multifd_channels > 255)) {
+    /* x_checkpoint_delay is now always positive */
+
+    if (params->has_x_multifd_channels && (params->x_multifd_channels < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
                    "is invalid, it should be in the range of 1 to 255");
         return false;
     }
     if (params->has_x_multifd_page_count &&
-            (params->x_multifd_page_count < 1 ||
-             params->x_multifd_page_count > 10000)) {
+        (params->x_multifd_page_count < 1 ||
+         params->x_multifd_page_count > 10000)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_page_count",
                    "is invalid, it should be in the range of 1 to 10000");
@@ -2394,33 +2385,33 @@ static Property migration_properties[] = {
                      send_section_footer, true),
 
     /* Migration parameters */
-    DEFINE_PROP_INT64("x-compress-level", MigrationState,
+    DEFINE_PROP_UINT8("x-compress-level", MigrationState,
                       parameters.compress_level,
                       DEFAULT_MIGRATE_COMPRESS_LEVEL),
-    DEFINE_PROP_INT64("x-compress-threads", MigrationState,
+    DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
                       parameters.compress_threads,
                       DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
-    DEFINE_PROP_INT64("x-decompress-threads", MigrationState,
+    DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
                       parameters.decompress_threads,
                       DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
-    DEFINE_PROP_INT64("x-cpu-throttle-initial", MigrationState,
+    DEFINE_PROP_UINT8("x-cpu-throttle-initial", MigrationState,
                       parameters.cpu_throttle_initial,
                       DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
-    DEFINE_PROP_INT64("x-cpu-throttle-increment", MigrationState,
+    DEFINE_PROP_UINT8("x-cpu-throttle-increment", MigrationState,
                       parameters.cpu_throttle_increment,
                       DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
-    DEFINE_PROP_INT64("x-max-bandwidth", MigrationState,
+    DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
-    DEFINE_PROP_INT64("x-downtime-limit", MigrationState,
+    DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
                       parameters.downtime_limit,
                       DEFAULT_MIGRATE_SET_DOWNTIME),
-    DEFINE_PROP_INT64("x-checkpoint-delay", MigrationState,
+    DEFINE_PROP_UINT32("x-checkpoint-delay", MigrationState,
                       parameters.x_checkpoint_delay,
                       DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
-    DEFINE_PROP_INT64("x-multifd-channels", MigrationState,
+    DEFINE_PROP_UINT8("x-multifd-channels", MigrationState,
                       parameters.x_multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
-    DEFINE_PROP_INT64("x-multifd-page-count", MigrationState,
+    DEFINE_PROP_UINT32("x-multifd-page-count", MigrationState,
                       parameters.x_multifd_page_count,
                       DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
diff --git a/qapi/migration.json b/qapi/migration.json
index bbc4671ded..ca4563dbd7 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -668,19 +668,19 @@
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
-  'data': { '*compress-level': 'int',
-            '*compress-threads': 'int',
-            '*decompress-threads': 'int',
-            '*cpu-throttle-initial': 'int',
-            '*cpu-throttle-increment': 'int',
+  'data': { '*compress-level': 'uint8',
+            '*compress-threads': 'uint8',
+            '*decompress-threads': 'uint8',
+            '*cpu-throttle-initial': 'uint8',
+            '*cpu-throttle-increment': 'uint8',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
-            '*max-bandwidth': 'int',
-            '*downtime-limit': 'int',
-            '*x-checkpoint-delay': 'int',
+            '*max-bandwidth': 'size',
+            '*downtime-limit': 'uint64',
+            '*x-checkpoint-delay': 'uint32',
             '*block-incremental': 'bool' ,
-            '*x-multifd-channels': 'int',
-            '*x-multifd-page-count': 'int',
+            '*x-multifd-channels': 'uint8',
+            '*x-multifd-page-count': 'uint32',
             '*xbzrle-cache-size': 'size' } }
 
 ##
-- 
2.13.6
