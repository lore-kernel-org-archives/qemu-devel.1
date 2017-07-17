Received: from eggs.gnu.org ([2001:4830:134:3::10]:60619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1My-0006yO-JD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1Mx-000288-NY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1Mx-00027d-Ea
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72E344E4D9
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:27:06 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:07 +0800
Message-Id: <1500279971-13875-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-1-git-send-email-peterx@redhat.com>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/11] migration: check global params for
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
 migration/migration.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 8c65054..5a7f22c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2109,6 +2109,39 @@ static void migration_instance_init(Object *obj)
     ms->parameters.tls_hostname = g_strdup("");
 }
 
+static void migration_instance_post_init(Object *obj)
+{
+    MigrationState *ms = (MigrationState *)obj;
+    Error *err = NULL;
+    MigrationParameters params = {
+        .has_compress_level = true,
+        .compress_level = ms->parameters.compress_level,
+        .has_compress_threads = true,
+        .compress_threads = ms->parameters.compress_threads,
+        .has_decompress_threads = true,
+        .decompress_threads = ms->parameters.decompress_threads,
+        .has_cpu_throttle_initial = true,
+        .cpu_throttle_initial = ms->parameters.cpu_throttle_initial,
+        .has_cpu_throttle_increment = true,
+        .cpu_throttle_increment = ms->parameters.cpu_throttle_increment,
+        .has_max_bandwidth = true,
+        .max_bandwidth = ms->parameters.max_bandwidth,
+        .has_downtime_limit = true,
+        .downtime_limit = ms->parameters.downtime_limit,
+        .has_x_checkpoint_delay = true,
+        .x_checkpoint_delay = ms->parameters.x_checkpoint_delay,
+        .has_block_incremental = true,
+        .block_incremental = ms->parameters.block_incremental,
+    };
+
+    /* We have applied all the migration properties... */
+
+    if (!migrate_params_check(&params, &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+}
+
 static const TypeInfo migration_type = {
     .name = TYPE_MIGRATION,
     /*
@@ -2124,6 +2157,7 @@ static const TypeInfo migration_type = {
     .class_size = sizeof(MigrationClass),
     .instance_size = sizeof(MigrationState),
     .instance_init = migration_instance_init,
+    .instance_post_init = migration_instance_post_init,
 };
 
 static void register_migration_types(void)
-- 
2.7.4
