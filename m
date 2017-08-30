Received: from eggs.gnu.org ([2001:4830:134:3::10]:34847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmySS-0008JJ-Vi
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmySN-0003se-Ui
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmySN-0003r5-M5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:39 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:32:18 +0800
Message-Id: <1504081950-2528-22-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 21/33] migration: new cmd
 MIG_CMD_POSTCOPY_RESUME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Introducing this new command to be sent when the source VM is ready to
resume the paused migration.  What the destination does here is
basically release the fault thread to continue service page faults.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c     | 33 +++++++++++++++++++++++++++++++++
 migration/savevm.h     |  1 +
 migration/trace-events |  1 +
 3 files changed, 35 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7f77a31..e914346 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -77,6 +77,7 @@ enum qemu_vm_cmd {
     MIG_CMD_POSTCOPY_RAM_DISCARD,  /* A list of pages to discard that
                                       were previously sent during
                                       precopy but are dirty. */
+    MIG_CMD_POSTCOPY_RESUME,       /* resume postcopy on dest */
     MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
     MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
     MIG_CMD_MAX
@@ -95,6 +96,7 @@ static struct mig_cmd_args {
     [MIG_CMD_POSTCOPY_RUN]     = { .len =  0, .name = "POSTCOPY_RUN" },
     [MIG_CMD_POSTCOPY_RAM_DISCARD] = {
                                    .len = -1, .name = "POSTCOPY_RAM_DISCARD" },
+    [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
     [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
     [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
@@ -931,6 +933,12 @@ void qemu_savevm_send_postcopy_run(QEMUFile *f)
     qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_RUN, 0, NULL);
 }
 
+void qemu_savevm_send_postcopy_resume(QEMUFile *f)
+{
+    trace_savevm_send_postcopy_resume();
+    qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_RESUME, 0, NULL);
+}
+
 void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
 {
     size_t len;
@@ -1682,6 +1690,28 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
     return LOADVM_QUIT;
 }
 
+static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
+{
+    if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
+        error_report("%s: illegal resume received", __func__);
+        /* Don't fail the load, only for this. */
+        return 0;
+    }
+
+    /*
+     * This means source VM is ready to resume the postcopy migration.
+     * It's time to switch state and release the fault thread to
+     * continue service page faults.
+     */
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    qemu_sem_post(&mis->postcopy_pause_sem_fault);
+
+    /* TODO: Tell source that "we are ready" */
+
+    return 0;
+}
+
 /**
  * Immediately following this command is a blob of data containing an embedded
  * chunk of migration stream; read it and load it.
@@ -1847,6 +1877,9 @@ static int loadvm_process_command(QEMUFile *f)
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         return loadvm_postcopy_ram_handle_discard(mis, len);
 
+    case MIG_CMD_POSTCOPY_RESUME:
+        return loadvm_postcopy_handle_resume(mis);
+
     case MIG_CMD_RECV_BITMAP:
         return loadvm_handle_recv_bitmap(mis, len);
     }
diff --git a/migration/savevm.h b/migration/savevm.h
index 8126b1c..a5f3879 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -46,6 +46,7 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
 void qemu_savevm_send_postcopy_advise(QEMUFile *f);
 void qemu_savevm_send_postcopy_listen(QEMUFile *f);
 void qemu_savevm_send_postcopy_run(QEMUFile *f);
+void qemu_savevm_send_postcopy_resume(QEMUFile *f);
 void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
 
 void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
diff --git a/migration/trace-events b/migration/trace-events
index 9960cd8..0a1c302 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -35,6 +35,7 @@ savevm_send_open_return_path(void) ""
 savevm_send_ping(uint32_t val) "0x%x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
+savevm_send_postcopy_resume(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
 savevm_state_setup(void) ""
 savevm_state_header(void) ""
-- 
2.7.4
