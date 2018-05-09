Received: from eggs.gnu.org ([2001:4830:134:3::10]:58828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDX-00050o-Td
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDS-0001kJ-2z
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53782 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDR-0001jI-UY
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98022818F6EB
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:25:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:56 +0200
Message-Id: <20180509112406.6183-32-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 31/41] migration: final handshake for the resume
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

Finish the last step to do the final handshake for the recovery.

First source sends one MIG_CMD_RESUME to dst, telling that source is
ready to resume.

Then, dest replies with MIG_RP_MSG_RESUME_ACK to source, telling that
dest is ready to resume (after switch to postcopy-active state).

When source received the RESUME_ACK, it switches its state to
postcopy-active, and finally the recovery is completed.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-19-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 19ef8b05b1..240960d951 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1924,7 +1924,8 @@ static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
     migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
-    /* TODO: notify send thread that time to continue send pages */
+    /* Notify send thread that time to continue send pages */
+    qemu_sem_post(&s->rp_state.rp_sem);
 
     return 0;
 }
@@ -2451,6 +2452,21 @@ typedef enum MigThrError {
     MIG_THR_ERR_FATAL = 2,
 } MigThrError;
 
+static int postcopy_resume_handshake(MigrationState *s)
+{
+    qemu_savevm_send_postcopy_resume(s->to_dst_file);
+
+    while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
+        qemu_sem_wait(&s->rp_state.rp_sem);
+    }
+
+    if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return 0;
+    }
+
+    return -1;
+}
+
 /* Return zero if success, or <0 for error */
 static int postcopy_do_resume(MigrationState *s)
 {
@@ -2468,10 +2484,14 @@ static int postcopy_do_resume(MigrationState *s)
     }
 
     /*
-     * TODO: handshake with dest using MIG_CMD_RESUME,
-     * MIG_RP_MSG_RESUME_ACK, then switch source state to
-     * "postcopy-active"
+     * Last handshake with destination on the resume (destination will
+     * switch to postcopy-active afterwards)
      */
+    ret = postcopy_resume_handshake(s);
+    if (ret) {
+        error_report("%s: handshake failed: %d", __func__, ret);
+        return ret;
+    }
 
     return 0;
 }
-- 
2.17.0
