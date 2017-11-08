Received: from eggs.gnu.org ([2001:4830:134:3::10]:36202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJS9-0000QS-3x
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJS5-00074L-OF
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJS5-000745-Ih
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:05 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:20 +0800
Message-Id: <20171108060130.3772-23-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 22/32] migration: final handshake for the
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
index 5b1fbe5b98..189d5d2d42 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1858,7 +1858,8 @@ static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
     migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
-    /* TODO: notify send thread that time to continue send pages */
+    /* Notify send thread that time to continue send pages */
+    qemu_sem_post(&s->rp_state.rp_sem);
 
     return 0;
 }
@@ -2389,6 +2390,21 @@ typedef enum MigThrError {
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
@@ -2406,10 +2422,14 @@ static int postcopy_do_resume(MigrationState *s)
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
2.13.6
