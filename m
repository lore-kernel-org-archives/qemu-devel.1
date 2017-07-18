Received: from eggs.gnu.org ([2001:4830:134:3::10]:54233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXJMV-0001GY-HG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXJMU-0008R9-L6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXJMU-0008Qe-4s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EC572F86E3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:39:49 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 18 Jul 2017 11:39:06 +0800
Message-Id: <1500349150-13240-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1500349150-13240-1-git-send-email-peterx@redhat.com>
References: <1500349150-13240-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/10] migration: check global params for
 validity
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

Adding validity check for the migration parameters passed in via global
properties.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8c65054..a4a8ed8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -102,14 +102,22 @@ enum mig_rp_message_type {
 
 static MigrationState *current_migration;
 
+static bool migration_object_check(MigrationState *ms, Error **errp);
+
 void migration_object_init(void)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
+    Error *err = NULL;
 
     /* This can only be called once. */
     assert(!current_migration);
     current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
 
+    if (!migration_object_check(current_migration, &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+
     /*
      * We cannot really do this in migration_instance_init() since at
      * that time global properties are not yet applied, then this
@@ -2101,12 +2109,38 @@ static void migration_class_init(ObjectClass *klass, void *data)
 static void migration_instance_init(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
+    MigrationParameters *params = &ms->parameters;
 
     ms->state = MIGRATION_STATUS_NONE;
     ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
     ms->mbps = -1;
-    ms->parameters.tls_creds = g_strdup("");
-    ms->parameters.tls_hostname = g_strdup("");
+
+    params->tls_hostname = g_strdup("");
+    params->tls_creds = g_strdup("");
+
+    /* Set has_* up only for parameter checks */
+    params->has_compress_level = true;
+    params->has_compress_threads = true;
+    params->has_decompress_threads = true;
+    params->has_cpu_throttle_initial = true;
+    params->has_cpu_throttle_increment = true;
+    params->has_max_bandwidth = true;
+    params->has_downtime_limit = true;
+    params->has_x_checkpoint_delay = true;
+    params->has_block_incremental = true;
+}
+
+/*
+ * Return true if check pass, false otherwise. Error will be put
+ * inside errp if provided.
+ */
+static bool migration_object_check(MigrationState *ms, Error **errp)
+{
+    if (!migrate_params_check(&ms->parameters, errp)) {
+        return false;
+    }
+
+    return true;
 }
 
 static const TypeInfo migration_type = {
-- 
2.7.4
