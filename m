Received: from eggs.gnu.org ([2001:4830:134:3::10]:47667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0K2-0001l0-NO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0K1-0001rD-PO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0K1-0001qi-GB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:33 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:37 +0800
Message-Id: <1501229198-30588-29-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 28/29] migration: final handshake for the resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Finish the last step to do the final handshake for the recovery.

First source sends one MIG_CMD_RESUME to dst, telling that source is
ready to resume.

Then, dest replies with MIG_RP_MSG_RESUME_ACK to source, telling that
dest is ready to resume (after switch to postcopy-active state).

When source received the RESUME_ACK, it switches its state to
postcopy-active, and finally the recovery is completed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 93fbc96..ecebe30 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1666,6 +1666,13 @@ static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
     return ram_dirty_bitmap_reload(s, block);
 }
 
+static void postcopy_resume_handshake_ack(MigrationState *s)
+{
+    qemu_mutex_lock(&s->resume_lock);
+    qemu_cond_signal(&s->resume_cond);
+    qemu_mutex_unlock(&s->resume_lock);
+}
+
 static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
 {
     trace_source_return_path_thread_resume_ack(value);
@@ -1680,7 +1687,8 @@ static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
     migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
-    /* TODO: notify send thread that time to continue send pages */
+    /* Notify send thread that time to continue send pages */
+    postcopy_resume_handshake_ack(s);
 
     return 0;
 }
@@ -2151,6 +2159,25 @@ static bool postcopy_should_start(MigrationState *s)
     return atomic_read(&s->start_postcopy) || s->start_postcopy_fast;
 }
 
+static int postcopy_resume_handshake(MigrationState *s)
+{
+    qemu_mutex_lock(&s->resume_lock);
+
+    qemu_savevm_send_postcopy_resume(s->to_dst_file);
+
+    while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
+        qemu_cond_wait(&s->resume_cond, &s->resume_lock);
+    }
+
+    qemu_mutex_unlock(&s->resume_lock);
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
@@ -2168,10 +2195,14 @@ static int postcopy_do_resume(MigrationState *s)
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
2.7.4
