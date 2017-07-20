Received: from eggs.gnu.org ([2001:4830:134:3::10]:54191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HT-0003k4-2n
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HR-00039a-66
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 20 Jul 2017 09:53:40 +0200
Message-Id: <1500537221-20556-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1500537221-20556-1-git-send-email-armbru@redhat.com>
References: <1500537221-20556-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/10] migration: Unshare
 MigrationParameters struct for now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

Commit de63ab6 "migrate: Share common MigrationParameters struct"
reused MigrationParameters for the arguments of
migrate-set-parameters, with the following rationale:

    It is rather verbose, and slightly error-prone, to repeat
    the same set of parameters for input (migrate-set-parameters)
    as for output (query-migrate-parameters), where the only
    difference is whether the members are optional.  We can just
    document that the optional members will always be present
    on output, and then share a common struct between both
    commands.  The next patch can then reduce the amount of
    code needed on input.

I need to unshare them to correct a design flaw in a stupid, but
minimally invasive way, in the next commit.  We can restore the
sharing when we redo that patch in a less stupid way.  Add a suitable
TODO comment.

Note that I revert only the sharing part of commit de63ab6, not the
part that made the members of query-migrate-parameters' result
optional.  The schema (and thus introspection) remains inaccurate for
query-migrate-parameters.  If we decide not to restore the sharing, we
should revert that part, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hmp.c                 |  4 +--
 migration/migration.c | 66 ++++++++++++++++++++++++++++++++++++---
 qapi-schema.json      | 85 ++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 140 insertions(+), 15 deletions(-)

diff --git a/hmp.c b/hmp.c
index d7b4727..4b6b114 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1556,7 +1556,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
-    MigrationParameters *p = g_new0(MigrationParameters, 1);
+    MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
     uint64_t valuebw = 0;
     Error *err = NULL;
     int i, ret;
@@ -1634,7 +1634,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     }
 
  cleanup:
-    qapi_free_MigrationParameters(p);
+    qapi_free_MigrateSetParameters(p);
     visit_free(v);
     if (err) {
         error_report_err(err);
diff --git a/migration/migration.c b/migration/migration.c
index 6b4d17f..205b801 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -742,7 +742,59 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_apply(MigrationParameters *params)
+static void migrate_params_test_apply(MigrateSetParameters *params,
+                                      MigrationParameters *dest)
+{
+    *dest = migrate_get_current()->parameters;
+
+    /* TODO use QAPI_CLONE() instead of duplicating it inline */
+
+    if (params->has_compress_level) {
+        dest->compress_level = params->compress_level;
+    }
+
+    if (params->has_compress_threads) {
+        dest->compress_threads = params->compress_threads;
+    }
+
+    if (params->has_decompress_threads) {
+        dest->decompress_threads = params->decompress_threads;
+    }
+
+    if (params->has_cpu_throttle_initial) {
+        dest->cpu_throttle_initial = params->cpu_throttle_initial;
+    }
+
+    if (params->has_cpu_throttle_increment) {
+        dest->cpu_throttle_increment = params->cpu_throttle_increment;
+    }
+
+    if (params->has_tls_creds) {
+        dest->tls_creds = g_strdup(params->tls_creds);
+    }
+
+    if (params->has_tls_hostname) {
+        dest->tls_hostname = g_strdup(params->tls_hostname);
+    }
+
+    if (params->has_max_bandwidth) {
+        dest->max_bandwidth = params->max_bandwidth;
+    }
+
+    if (params->has_downtime_limit) {
+        dest->downtime_limit = params->downtime_limit;
+    }
+
+    if (params->has_x_checkpoint_delay) {
+        dest->x_checkpoint_delay = params->x_checkpoint_delay;
+    }
+
+    if (params->has_block_incremental) {
+        dest->block_incremental = params->block_incremental;
+    }
+}
+
+static void migrate_params_apply(MigrateSetParameters *params)
 {
     MigrationState *s = migrate_get_current();
 
@@ -802,9 +854,13 @@ static void migrate_params_apply(MigrationParameters *params)
     }
 }
 
-void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
+void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
-    if (!migrate_params_check(params, errp)) {
+    MigrationParameters tmp;
+
+    migrate_params_test_apply(params, &tmp);
+
+    if (!migrate_params_check(&tmp, errp)) {
         /* Invalid parameter */
         return;
     }
@@ -1240,7 +1296,7 @@ int64_t qmp_query_migrate_cache_size(Error **errp)
 
 void qmp_migrate_set_speed(int64_t value, Error **errp)
 {
-    MigrationParameters p = {
+    MigrateSetParameters p = {
         .has_max_bandwidth = true,
         .max_bandwidth = value,
     };
@@ -1260,7 +1316,7 @@ void qmp_migrate_set_downtime(double value, Error **errp)
     value *= 1000; /* Convert to milliseconds */
     value = MAX(0, MIN(INT64_MAX, value));
 
-    MigrationParameters p = {
+    MigrateSetParameters p = {
         .has_downtime_limit = true,
         .downtime_limit = value,
     };
diff --git a/qapi-schema.json b/qapi-schema.json
index 62e7d07..9ea45d2 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1035,6 +1035,77 @@
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental' ] }
 
 ##
+# @MigrateSetParameters:
+#
+# @compress-level: compression level
+#
+# @compress-threads: compression thread count
+#
+# @decompress-threads: decompression thread count
+#
+# @cpu-throttle-initial: Initial percentage of time guest cpus are
+#                        throttled when migration auto-converge is activated.
+#                        The default value is 20. (Since 2.7)
+#
+# @cpu-throttle-increment: throttle percentage increase each time
+#                          auto-converge detects that migration is not making
+#                          progress. The default value is 10. (Since 2.7)
+#
+# @tls-creds: ID of the 'tls-creds' object that provides credentials
+#             for establishing a TLS connection over the migration data
+#             channel. On the outgoing side of the migration, the credentials
+#             must be for a 'client' endpoint, while for the incoming side the
+#             credentials must be for a 'server' endpoint. Setting this
+#             to a non-empty string enables TLS for all migrations.
+#             An empty string means that QEMU will use plain text mode for
+#             migration, rather than TLS (Since 2.9)
+#             Previously (since 2.7), this was reported by omitting
+#             tls-creds instead.
+#
+# @tls-hostname: hostname of the target host for the migration. This
+#                is required when using x509 based TLS credentials and the
+#                migration URI does not already include a hostname. For
+#                example if using fd: or exec: based migration, the
+#                hostname must be provided so that the server's x509
+#                certificate identity can be validated. (Since 2.7)
+#                An empty string means that QEMU will use the hostname
+#                associated with the migration URI, if any. (Since 2.9)
+#                Previously (since 2.7), this was reported by omitting
+#                tls-hostname instead.
+#
+# @max-bandwidth: to set maximum speed for migration. maximum speed in
+#                 bytes per second. (Since 2.8)
+#
+# @downtime-limit: set maximum tolerated downtime for migration. maximum
+#                  downtime in milliseconds (Since 2.8)
+#
+# @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
+#
+# @block-incremental: Affects how much storage is migrated when the
+# 	block migration capability is enabled.  When false, the entire
+# 	storage backing chain is migrated into a flattened image at
+# 	the destination; when true, only the active qcow2 layer is
+# 	migrated and the destination must already have access to the
+# 	same backing chain as was used on the source.  (since 2.10)
+#
+# Since: 2.4
+##
+# TODO either fuse back into MigrationParameters, or make
+# MigrationParameters members mandatory
+{ 'struct': 'MigrateSetParameters',
+  'data': { '*compress-level': 'int',
+            '*compress-threads': 'int',
+            '*decompress-threads': 'int',
+            '*cpu-throttle-initial': 'int',
+            '*cpu-throttle-increment': 'int',
+            '*tls-creds': 'str',
+            '*tls-hostname': 'str',
+            '*max-bandwidth': 'int',
+            '*downtime-limit': 'int',
+            '*x-checkpoint-delay': 'int',
+            '*block-incremental': 'bool' } }
+
+##
 # @migrate-set-parameters:
 #
 # Set various migration parameters.
@@ -1048,13 +1119,12 @@
 #
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
-  'data': 'MigrationParameters' }
+  'data': 'MigrateSetParameters' }
 
 ##
 # @MigrationParameters:
 #
-# Optional members can be omitted on input ('migrate-set-parameters')
-# but members will always be present on output.
+# The optional members aren't actually optional.
 #
 # @compress-level: compression level
 #
@@ -1063,19 +1133,18 @@
 # @decompress-threads: decompression thread count
 #
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
-#                        throttledwhen migration auto-converge is activated.
-#                        The default value is 20. (Since 2.7)
+#                        throttled when migration auto-converge is activated.
+#                        (Since 2.7)
 #
 # @cpu-throttle-increment: throttle percentage increase each time
 #                          auto-converge detects that migration is not making
-#                          progress. The default value is 10. (Since 2.7)
+#                          progress. (Since 2.7)
 #
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #             for establishing a TLS connection over the migration data
 #             channel. On the outgoing side of the migration, the credentials
 #             must be for a 'client' endpoint, while for the incoming side the
-#             credentials must be for a 'server' endpoint. Setting this
-#             to a non-empty string enables TLS for all migrations.
+#             credentials must be for a 'server' endpoint.
 #             An empty string means that QEMU will use plain text mode for
 #             migration, rather than TLS (Since 2.7)
 #             Note: 2.8 reports this by omitting tls-creds instead.
-- 
2.7.5
