Received: from eggs.gnu.org ([2001:4830:134:3::10]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Kw-0007Zm-B4
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Kv-0003bg-Ia
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3Kv-0003bC-Cd
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70B243680C
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:53:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:52:57 +0100
Message-Id: <20180115115309.23982-16-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 15/27] migration: assert colo instead of check
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

When reaching here if we are still "active" it means we must be in colo
state.  After a quick discussion offlist, we decided to use the safer
error_report().

Finally I want to use "switch" here rather than lots of complicated if
clauses.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7a77b193c1..f579752d21 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2348,7 +2348,15 @@ static void *migration_thread(void *opaque)
         }
         runstate_set(RUN_STATE_POSTMIGRATE);
     } else {
-        if (s->state == MIGRATION_STATUS_ACTIVE && enable_colo) {
+        if (s->state == MIGRATION_STATUS_ACTIVE) {
+            /*
+             * We should really assert here, but since it's during
+             * migration, let's try to reduce the usage of assertions.
+             */
+            if (!enable_colo) {
+                error_report("%s: critical error: calling COLO code without "
+                             "COLO enabled", __func__);
+            }
             migrate_start_colo_process(s);
             qemu_savevm_state_cleanup();
             /*
-- 
2.14.3
