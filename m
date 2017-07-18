Received: from eggs.gnu.org ([2001:4830:134:3::10]:59681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUdh-0000NC-Rd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUdg-0006Rz-T0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXUdg-0006Qm-Mz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C7BB7CE1A
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:42:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 18 Jul 2017 17:41:27 +0200
Message-Id: <20170718154127.6459-17-quintela@redhat.com>
In-Reply-To: <20170718154127.6459-1-quintela@redhat.com>
References: <20170718154127.6459-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 16/16] migration: check global caps for validity
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

From: Peter Xu <peterx@redhat.com>

Checks validity for all the capabilities that we enabled with command
line.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1500349150-13240-11-git-send-email-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0ebdde1..7615391 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2166,11 +2166,27 @@ static void migration_instance_init(Object *obj)
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
2.9.4
