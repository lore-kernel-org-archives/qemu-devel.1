Received: from eggs.gnu.org ([2001:4830:134:3::10]:54153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HR-0003iJ-MK
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HP-00036b-Q0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:53 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 20 Jul 2017 09:53:37 +0200
Message-Id: <1500537221-20556-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1500537221-20556-1-git-send-email-armbru@redhat.com>
References: <1500537221-20556-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/10] hmp: Clean up and simplify
 hmp_migrate_set_parameter()
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

The bulk of hmp_migrate_set_parameter()'s code sets one member of
MigrationParameters according to the command's arguments.  It uses a
string visitor for integer and boolean members, but not for string and
size members.  It calls visit_type_bool() right away, but delays
visit_type_int() some.  The delaying requires a flag variable and a
bit of trickery: we set all integer members instead of just the one we
want, and rely on the has_FOOs to mask the unwanted ones.

Clean this up as follows.  Don't delay calling visit_type_int().  Use
the string visitor for strings, too.  This involves extra allocations
and cleanup, but doing them is simpler and cleaner than avoiding them.

Sadly, using the string visitor for sizes isn't possible, because it
defaults to Bytes rather than Mebibytes.  Add a comment explaining
that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hmp.c | 78 ++++++++++++++++++++++++++++---------------------------------------
 1 file changed, 32 insertions(+), 46 deletions(-)

diff --git a/hmp.c b/hmp.c
index bf1de74..dae4604 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1554,90 +1554,75 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
+    MigrationParameters *p = g_new0(MigrationParameters, 1);
     uint64_t valuebw = 0;
-    int64_t valueint = 0;
-    bool valuebool = false;
     Error *err = NULL;
-    bool use_int_value = false;
     int i, ret;
 
     for (i = 0; i < MIGRATION_PARAMETER__MAX; i++) {
         if (strcmp(param, MigrationParameter_lookup[i]) == 0) {
-            MigrationParameters p = { 0 };
             switch (i) {
             case MIGRATION_PARAMETER_COMPRESS_LEVEL:
-                p.has_compress_level = true;
-                use_int_value = true;
+                p->has_compress_level = true;
+                visit_type_int(v, param, &p->compress_level, &err);
                 break;
             case MIGRATION_PARAMETER_COMPRESS_THREADS:
-                p.has_compress_threads = true;
-                use_int_value = true;
+                p->has_compress_threads = true;
+                visit_type_int(v, param, &p->compress_threads, &err);
                 break;
             case MIGRATION_PARAMETER_DECOMPRESS_THREADS:
-                p.has_decompress_threads = true;
-                use_int_value = true;
+                p->has_decompress_threads = true;
+                visit_type_int(v, param, &p->decompress_threads, &err);
                 break;
             case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
-                p.has_cpu_throttle_initial = true;
-                use_int_value = true;
+                p->has_cpu_throttle_initial = true;
+                visit_type_int(v, param, &p->cpu_throttle_initial, &err);
                 break;
             case MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT:
-                p.has_cpu_throttle_increment = true;
-                use_int_value = true;
+                p->has_cpu_throttle_increment = true;
+                visit_type_int(v, param, &p->cpu_throttle_increment, &err);
                 break;
             case MIGRATION_PARAMETER_TLS_CREDS:
-                p.has_tls_creds = true;
-                p.tls_creds = (char *) valuestr;
+                p->has_tls_creds = true;
+                visit_type_str(v, param, &p->tls_creds, &err);
                 break;
             case MIGRATION_PARAMETER_TLS_HOSTNAME:
-                p.has_tls_hostname = true;
-                p.tls_hostname = (char *) valuestr;
+                p->has_tls_hostname = true;
+                visit_type_str(v, param, &p->tls_hostname, &err);
                 break;
             case MIGRATION_PARAMETER_MAX_BANDWIDTH:
-                p.has_max_bandwidth = true;
+                p->has_max_bandwidth = true;
+                /*
+                 * Can't use visit_type_size() here, because it
+                 * defaults to Bytes rather than Mebibytes.
+                 */
                 ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
                 if (ret < 0 || valuebw > INT64_MAX
                     || (size_t)valuebw != valuebw) {
                     error_setg(&err, "Invalid size %s", valuestr);
-                    goto cleanup;
+                    break;
                 }
-                p.max_bandwidth = valuebw;
+                p->max_bandwidth = valuebw;
                 break;
             case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
-                p.has_downtime_limit = true;
-                use_int_value = true;
+                p->has_downtime_limit = true;
+                visit_type_int(v, param, &p->downtime_limit, &err);
                 break;
             case MIGRATION_PARAMETER_X_CHECKPOINT_DELAY:
-                p.has_x_checkpoint_delay = true;
-                use_int_value = true;
+                p->has_x_checkpoint_delay = true;
+                visit_type_int(v, param, &p->x_checkpoint_delay, &err);
                 break;
             case MIGRATION_PARAMETER_BLOCK_INCREMENTAL:
-                p.has_block_incremental = true;
-                visit_type_bool(v, param, &valuebool, &err);
-                if (err) {
-                    goto cleanup;
-                }
-                p.block_incremental = valuebool;
+                p->has_block_incremental = true;
+                visit_type_bool(v, param, &p->block_incremental, &err);
                 break;
             }
 
-            if (use_int_value) {
-                visit_type_int(v, param, &valueint, &err);
-                if (err) {
-                    goto cleanup;
-                }
-                /* Set all integers; only one has_FOO will be set, and
-                 * the code ignores the remaining values */
-                p.compress_level = valueint;
-                p.compress_threads = valueint;
-                p.decompress_threads = valueint;
-                p.cpu_throttle_initial = valueint;
-                p.cpu_throttle_increment = valueint;
-                p.downtime_limit = valueint;
-                p.x_checkpoint_delay = valueint;
+            if (err) {
+                goto cleanup;
             }
 
-            qmp_migrate_set_parameters(&p, &err);
+            qmp_migrate_set_parameters(p, &err);
             break;
         }
     }
@@ -1647,6 +1632,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     }
 
  cleanup:
+    qapi_free_MigrationParameters(p);
     visit_free(v);
     if (err) {
         error_report_err(err);
-- 
2.7.5
