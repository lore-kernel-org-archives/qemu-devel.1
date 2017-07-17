Received: from eggs.gnu.org ([2001:4830:134:3::10]:32782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1NW-0007T6-Rt
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1NW-0002Tp-2J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1NV-0002T4-Se
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D90417CB80
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:27:40 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:11 +0800
Message-Id: <1500279971-13875-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-1-git-send-email-peterx@redhat.com>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/11] migration: check global caps for
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

Checks validity for all the capabilities that we enabled with command
line.  Stop the VM if detected anything wrong.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 300f84d..b2667d0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2142,6 +2142,9 @@ static void migration_instance_post_init(Object *obj)
 {
     MigrationState *ms = (MigrationState *)obj;
     Error *err = NULL;
+    MigrationCapabilityStatusList *head = NULL;
+    /* Assuming all off */
+    bool cap_list[MIGRATION_CAPABILITY__MAX] = { 0 };
     MigrationParameters params = {
         .has_compress_level = true,
         .compress_level = ms->parameters.compress_level,
@@ -2162,13 +2165,35 @@ static void migration_instance_post_init(Object *obj)
         .has_block_incremental = true,
         .block_incremental = ms->parameters.block_incremental,
     };
+    int i;
 
     /* We have applied all the migration properties... */
 
     if (!migrate_params_check(&params, &err)) {
+        goto error;
+    }
+
+    for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        if (ms->enabled_capabilities[i]) {
+            head = migrate_cap_add(head, i, true);
+        }
+    }
+
+    if (!migrate_caps_check(cap_list, head, &err)) {
+        goto error;
+    }
+
+    qapi_free_MigrationCapabilityStatusList(head);
+    return;
+
+error:
+    if (head) {
+        qapi_free_MigrationCapabilityStatusList(head);
+    }
+    if (err) {
         error_report_err(err);
-        exit(1);
     }
+    exit(1);
 }
 
 static const TypeInfo migration_type = {
-- 
2.7.4
