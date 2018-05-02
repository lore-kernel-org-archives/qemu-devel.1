Received: from eggs.gnu.org ([2001:4830:134:3::10]:35049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJj-0006zE-51
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJi-00035v-0F
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpJh-00035f-Sc
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:57 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:34 +0800
Message-Id: <20180502104740.12123-19-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 18/24] migration: final handshake for the
 resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Finish the last step to do the final handshake for the recovery.

First source sends one MIG_CMD_RESUME to dst, telling that source is
ready to resume.

Then, dest replies with MIG_RP_MSG_RESUME_ACK to source, telling that
dest is ready to resume (after switch to postcopy-active state).

When source received the RESUME_ACK, it switches its state to
postcopy-active, and finally the recovery is completed.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 960827d3ea..eec84ccc3a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1919,7 +1919,8 @@ static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
     migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
-    /* TODO: notify send thread that time to continue send pages */
+    /* Notify send thread that time to continue send pages */
+    qemu_sem_post(&s->rp_state.rp_sem);
 
     return 0;
 }
@@ -2446,6 +2447,21 @@ typedef enum MigThrError {
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
@@ -2463,10 +2479,14 @@ static int postcopy_do_resume(MigrationState *s)
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
2.14.3
