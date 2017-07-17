Received: from eggs.gnu.org ([2001:4830:134:3::10]:60560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1Mt-0006tN-Lh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1Mo-00023L-FS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1Mo-00022w-64
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 087CF81241
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:26:57 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:05 +0800
Message-Id: <1500279971-13875-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-1-git-send-email-peterx@redhat.com>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/11] migration: introduce
 migrate_params_check()
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

Helper to check the parameters. Abstracted from
qmp_migrate_set_parameters().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3208162..2821f8a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -643,64 +643,86 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     }
 }
 
-void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
+/*
+ * Check whether the parameters are valid. Error will be put into errp
+ * (if provided). Return true if valid, otherwise false.
+ */
+static bool migrate_params_check(MigrationParameters *params, Error **errp)
 {
-    MigrationState *s = migrate_get_current();
-
     if (params->has_compress_level &&
         (params->compress_level < 0 || params->compress_level > 9)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
                    "is invalid, it should be in the range of 0 to 9");
-        return;
+        return false;
     }
+
     if (params->has_compress_threads &&
         (params->compress_threads < 1 || params->compress_threads > 255)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "compress_threads",
                    "is invalid, it should be in the range of 1 to 255");
-        return;
+        return false;
     }
+
     if (params->has_decompress_threads &&
         (params->decompress_threads < 1 || params->decompress_threads > 255)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "decompress_threads",
                    "is invalid, it should be in the range of 1 to 255");
-        return;
+        return false;
     }
+
     if (params->has_cpu_throttle_initial &&
         (params->cpu_throttle_initial < 1 ||
          params->cpu_throttle_initial > 99)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "cpu_throttle_initial",
                    "an integer in the range of 1 to 99");
-        return;
+        return false;
     }
+
     if (params->has_cpu_throttle_increment &&
         (params->cpu_throttle_increment < 1 ||
          params->cpu_throttle_increment > 99)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "cpu_throttle_increment",
                    "an integer in the range of 1 to 99");
-        return;
+        return false;
     }
+
     if (params->has_max_bandwidth &&
         (params->max_bandwidth < 0 || params->max_bandwidth > SIZE_MAX)) {
         error_setg(errp, "Parameter 'max_bandwidth' expects an integer in the"
                          " range of 0 to %zu bytes/second", SIZE_MAX);
-        return;
+        return false;
     }
+
     if (params->has_downtime_limit &&
         (params->downtime_limit < 0 ||
          params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
         error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
                          "the range of 0 to %d milliseconds",
                          MAX_MIGRATE_DOWNTIME);
-        return;
+        return false;
     }
+
     if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                     "x_checkpoint_delay",
                     "is invalid, it should be positive");
+        return false;
+    }
+
+    return true;
+}
+
+void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+
+    if (!migrate_params_check(params, errp)) {
+        /* Invalid parameter */
+        return;
     }
 
     if (params->has_compress_level) {
-- 
2.7.4
