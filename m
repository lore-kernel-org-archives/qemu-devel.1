Received: from eggs.gnu.org ([2001:4830:134:3::10]:35794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHI-0005gL-BP
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHH-0000BZ-9t
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHH-0000AV-47
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E54A6A7C9
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:50 +0200
Message-Id: <20171023160800.20540-12-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 11/21] migration: allow cancel to unpause
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

If a migration_cancel is issued during the new paused state,
kick the pause_sem to get to unpause so it can cancel.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 90bfdc3a7c..b523d8f215 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1114,6 +1114,10 @@ static void migrate_fd_cancel(MigrationState *s)
         if (!migration_is_setup_or_active(old_state)) {
             break;
         }
+        /* If the migration is paused, kick it out of the pause */
+        if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER) {
+            qemu_sem_post(&s->pause_sem);
+        }
         migrate_set_state(&s->state, old_state, MIGRATION_STATUS_CANCELLING);
     } while (s->state != MIGRATION_STATUS_CANCELLING);
 
-- 
2.13.6
