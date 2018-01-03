Received: from eggs.gnu.org ([2001:4830:134:3::10]:47704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbnJ-0002ug-VD
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbnI-0000pU-BD
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:40:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWbnI-0000ok-5V
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:40:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5904CC057FA1
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 05:40:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 13:40:33 +0800
Message-Id: <20180103054043.25719-2-peterx@redhat.com>
In-Reply-To: <20180103054043.25719-1-peterx@redhat.com>
References: <20180103054043.25719-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 01/11] migration: assert colo instead of check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

When reaching here if we are still "active" it means we must be in colo
state.  Assert it instead of check it in if condition.

Finally I want to use "switch" here rather than lots of complicated if
clauses.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4de3b551fe..0ee4b4c27c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2309,7 +2309,8 @@ static void *migration_thread(void *opaque)
         }
         runstate_set(RUN_STATE_POSTMIGRATE);
     } else {
-        if (s->state == MIGRATION_STATUS_ACTIVE && enable_colo) {
+        if (s->state == MIGRATION_STATUS_ACTIVE) {
+            assert(enable_colo);
             migrate_start_colo_process(s);
             qemu_savevm_state_cleanup();
             /*
-- 
2.14.3
