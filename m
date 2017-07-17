Received: from eggs.gnu.org ([2001:4830:134:3::10]:32776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1NW-0007Sd-AM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1NS-0002Rp-BE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1NS-0002RS-3V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E53C4E4D9
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:27:37 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:10 +0800
Message-Id: <1500279971-13875-11-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-1-git-send-email-peterx@redhat.com>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/11] migration: provide migrate_cap_add()
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

Abstracted from migrate_set_block_enabled() to allocate
MigrationCapabilityStatusList properly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 52db5e7..300f84d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -833,14 +833,27 @@ void migrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
-void migrate_set_block_enabled(bool value, Error **errp)
+static MigrationCapabilityStatusList *migrate_cap_add(
+    MigrationCapabilityStatusList *head,
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
+    cap->next = head;
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
2.7.4
