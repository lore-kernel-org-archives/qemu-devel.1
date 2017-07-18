Received: from eggs.gnu.org ([2001:4830:134:3::10]:54449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXJMq-0001cv-2E
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXJMo-0000GB-1e
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:40:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXJMn-0000FP-Rs
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF79385376
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:40:08 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 18 Jul 2017 11:39:10 +0800
Message-Id: <1500349150-13240-11-git-send-email-peterx@redhat.com>
In-Reply-To: <1500349150-13240-1-git-send-email-peterx@redhat.com>
References: <1500349150-13240-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/10] migration: check global caps for
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
line.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index db869c4..cdcf989 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2165,11 +2165,27 @@ static void migration_instance_init(Object *obj)
  */
 static bool migration_object_check(MigrationState *ms, Error **errp)
 {
+    MigrationCapabilityStatusList *head = NULL;
+    /* Assuming all off */
+    bool cap_list[MIGRATION_CAPABILITY__MAX] = { 0 }, ret;
+    int i;
+
     if (!migrate_params_check(&ms->parameters, errp)) {
         return false;
     }
 
-    return true;
+    for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        if (ms->enabled_capabilities[i]) {
+            head = migrate_cap_add(head, i, true);
+        }
+    }
+
+    ret = migrate_caps_check(cap_list, head, errp);
+
+    /* It works with head == NULL */
+    qapi_free_MigrationCapabilityStatusList(head);
+
+    return ret;
 }
 
 static const TypeInfo migration_type = {
-- 
2.7.4
