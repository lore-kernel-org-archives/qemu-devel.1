Received: from eggs.gnu.org ([2001:4830:134:3::10]:54199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXJMR-0001Cx-D9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXJMQ-0008PC-KL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXJMQ-0008Ok-BL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 524057A162
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:39:45 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 18 Jul 2017 11:39:05 +0800
Message-Id: <1500349150-13240-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1500349150-13240-1-git-send-email-peterx@redhat.com>
References: <1500349150-13240-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/10] migration: provide
 migrate_params_apply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Abstracted from qmp_migrate_set_parameters().

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2821f8a..8c65054 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -716,38 +716,40 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
+static void migrate_params_apply(MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
 
-    if (!migrate_params_check(params, errp)) {
-        /* Invalid parameter */
-        return;
-    }
-
     if (params->has_compress_level) {
         s->parameters.compress_level = params->compress_level;
     }
+
     if (params->has_compress_threads) {
         s->parameters.compress_threads = params->compress_threads;
     }
+
     if (params->has_decompress_threads) {
         s->parameters.decompress_threads = params->decompress_threads;
     }
+
     if (params->has_cpu_throttle_initial) {
         s->parameters.cpu_throttle_initial = params->cpu_throttle_initial;
     }
+
     if (params->has_cpu_throttle_increment) {
         s->parameters.cpu_throttle_increment = params->cpu_throttle_increment;
     }
+
     if (params->has_tls_creds) {
         g_free(s->parameters.tls_creds);
         s->parameters.tls_creds = g_strdup(params->tls_creds);
     }
+
     if (params->has_tls_hostname) {
         g_free(s->parameters.tls_hostname);
         s->parameters.tls_hostname = g_strdup(params->tls_hostname);
     }
+
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
         if (s->to_dst_file) {
@@ -755,6 +757,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
                                 s->parameters.max_bandwidth / XFER_LIMIT_RATIO);
         }
     }
+
     if (params->has_downtime_limit) {
         s->parameters.downtime_limit = params->downtime_limit;
     }
@@ -765,11 +768,22 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
             colo_checkpoint_notify(s);
         }
     }
+
     if (params->has_block_incremental) {
         s->parameters.block_incremental = params->block_incremental;
     }
 }
 
+void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
+{
+    if (!migrate_params_check(params, errp)) {
+        /* Invalid parameter */
+        return;
+    }
+
+    migrate_params_apply(params);
+}
+
 
 void qmp_migrate_start_postcopy(Error **errp)
 {
-- 
2.7.4
