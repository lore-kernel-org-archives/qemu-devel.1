Received: from eggs.gnu.org ([2001:4830:134:3::10]:40256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2o-0007Uj-4p
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2k-0006zZ-1j
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cst2j-0006zC-QA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB06E81235
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 15:28:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Mar 2017 16:27:40 +0100
Message-Id: <20170328152745.28186-2-dgilbert@redhat.com>
In-Reply-To: <20170328152745.28186-1-dgilbert@redhat.com>
References: <20170328152745.28186-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] migration/announce: Add parameters for
 self-announce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: kashyap@redhat.com, germano@redhat.com, armbru@redhat.com, jasowang@redhat.com, jdenemar@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the parameters and wire into the set/get routines.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json      | 34 +++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 54060f7..96c4ad6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -53,6 +53,14 @@
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
 #define MAX_MIGRATE_DOWNTIME (MAX_MIGRATE_DOWNTIME_SECONDS * 1000)
 
+/* Parameters for self_announce_delay giving a stream of RARP/ARP
+ * packets after migration.
+ */
+#define DEFAULT_MIGRATE_ANNOUNCE_INITIAL  50
+#define DEFAULT_MIGRATE_ANNOUNCE_MAX     550
+#define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
+#define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
+
 /* Default compression thread count */
 #define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
 /* Default decompression thread count, usually decompression is at
@@ -97,6 +105,10 @@ MigrationState *migrate_get_current(void)
         .xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE,
         .mbps = -1,
         .parameters = {
+            .announce_initial = DEFAULT_MIGRATE_ANNOUNCE_INITIAL,
+            .announce_max = DEFAULT_MIGRATE_ANNOUNCE_MAX,
+            .announce_rounds = DEFAULT_MIGRATE_ANNOUNCE_ROUNDS,
+            .announce_step = DEFAULT_MIGRATE_ANNOUNCE_STEP,
             .compress_level = DEFAULT_MIGRATE_COMPRESS_LEVEL,
             .compress_threads = DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT,
             .decompress_threads = DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT,
@@ -580,6 +592,14 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     MigrationState *s = migrate_get_current();
 
     params = g_malloc0(sizeof(*params));
+    params->has_announce_initial = true;
+    params->announce_initial = s->parameters.announce_initial;
+    params->has_announce_max = true;
+    params->announce_max = s->parameters.announce_max;
+    params->has_announce_rounds = true;
+    params->announce_rounds = s->parameters.announce_rounds;
+    params->has_announce_step = true;
+    params->announce_step = s->parameters.announce_step;
     params->has_compress_level = true;
     params->compress_level = s->parameters.compress_level;
     params->has_compress_threads = true;
@@ -809,6 +829,26 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
 
+    if (params->has_announce_initial &&
+        (params->announce_initial < 1 || params->announce_initial > 100000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "announce_initial",
+                   "is invalid, it should be in the range of 1 to 100000 ms");
+    }
+    if (params->has_announce_max &&
+        (params->announce_max < 1 || params->announce_max > 100000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "announce_max",
+                   "is invalid, it should be in the range of 1 to 100000 ms");
+    }
+    if (params->has_announce_rounds &&
+        (params->announce_rounds < 1 || params->announce_rounds > 1000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "announce_rounds",
+                   "is invalid, it should be in the range of 1 to 1000");
+    }
+    if (params->has_announce_step &&
+        (params->announce_step < 0 || params->announce_step > 10000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "announce_step",
+                   "is invalid, it should be in the range of 1 to 10000 ms");
+    }
     if (params->has_compress_level &&
         (params->compress_level < 0 || params->compress_level > 9)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
@@ -865,6 +905,18 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
                     "is invalid, it should be positive");
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
     if (params->has_compress_level) {
         s->parameters.compress_level = params->compress_level;
     }
diff --git a/qapi-schema.json b/qapi-schema.json
index 68a4327..ae66d2e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -960,6 +960,18 @@
 #
 # Migration parameters enumeration
 #
+# @announce-initial: The inital delay (in ms) before sending the first announce
+#          (Since 2.10)
+#
+# @announce-max: The maximum delay (in ms) between packets in the announcment
+#          (Since 2.10)
+#
+# @announce-rounds: The number of self-announce packets sent after migration
+#          (Since 2.10)
+#
+# @announce-step: The increase in delay (in ms) between subsequent packets in
+#          the announcement (Since 2.10)
+#
 # @compress-level: Set the compression level to be used in live migration,
 #          the compression level is an integer between 0 and 9, where 0 means
 #          no compression, 1 means the best compression speed, and 9 means best
@@ -1009,7 +1021,9 @@
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
-  'data': ['compress-level', 'compress-threads', 'decompress-threads',
+  'data': ['announce-initial', 'announce-max',
+           'announce-rounds', 'announce-step',
+           'compress-level', 'compress-threads', 'decompress-threads',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay' ] }
@@ -1038,6 +1052,18 @@
 # ('query-migrate-parameters'), with the exception of tls-creds and
 # tls-hostname.
 #
+# @announce-initial: The inital delay (in ms) before sending the first announce
+#          (Since 2.10)
+#
+# @announce-max: The maximum delay (in ms) between packets in the announcment
+#          (Since 2.10)
+#
+# @announce-rounds: The number of self-announce packets sent after migration
+#          (Since 2.10)
+#
+# @announce-step: The increase in delay (in ms) between subsequent packets in
+#          the announcement (Since 2.10)
+#
 # @compress-level: compression level
 #
 # @compress-threads: compression thread count
@@ -1082,7 +1108,11 @@
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
-  'data': { '*compress-level': 'int',
+  'data': { '*announce-initial': 'int',
+            '*announce-max': 'int',
+            '*announce-rounds': 'int',
+            '*announce-step': 'int',
+            '*compress-level': 'int',
             '*compress-threads': 'int',
             '*decompress-threads': 'int',
             '*cpu-throttle-initial': 'int',
-- 
2.9.3
