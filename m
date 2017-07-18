Received: from eggs.gnu.org ([2001:4830:134:3::10]:59679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUdh-0000NA-QX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUdd-0006Mg-VM
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXUdd-0006L0-O0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86A902F86EE
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:42:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 18 Jul 2017 17:41:26 +0200
Message-Id: <20170718154127.6459-16-quintela@redhat.com>
In-Reply-To: <20170718154127.6459-1-quintela@redhat.com>
References: <20170718154127.6459-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 15/16] migration: provide migrate_cap_add()
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

Abstracted from migrate_set_block_enabled() to allocate
MigrationCapabilityStatusList properly.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1500349150-13240-10-git-send-email-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 74099b3..0ebdde1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -842,14 +842,27 @@ void migrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
-void migrate_set_block_enabled(bool value, Error **errp)
+static MigrationCapabilityStatusList *migrate_cap_add(
+    MigrationCapabilityStatusList *list,
+    MigrationCapability index,
+    bool state)
 {
     MigrationCapabilityStatusList *cap;
 
     cap = g_new0(MigrationCapabilityStatusList, 1);
     cap->value = g_new0(MigrationCapabilityStatus, 1);
-    cap->value->capability = MIGRATION_CAPABILITY_BLOCK;
-    cap->value->state = value;
+    cap->value->capability = index;
+    cap->value->state = state;
+    cap->next = list;
+
+    return cap;
+}
+
+void migrate_set_block_enabled(bool value, Error **errp)
+{
+    MigrationCapabilityStatusList *cap;
+
+    cap = migrate_cap_add(NULL, MIGRATION_CAPABILITY_BLOCK, value);
     qmp_migrate_set_capabilities(cap, errp);
     qapi_free_MigrationCapabilityStatusList(cap);
 }
-- 
2.9.4
