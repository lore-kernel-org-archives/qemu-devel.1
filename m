Received: from eggs.gnu.org ([2001:4830:134:3::10]:36113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJRy-0000Hu-JO
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJRx-00070P-8x
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJRx-00070C-0n
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:57 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:17 +0800
Message-Id: <20171108060130.3772-20-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 19/32] migration: introduce
 SaveVMHandlers.resume_prepare
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

This is hook function to be called when a postcopy migration wants to
resume from a failure. For each module, it should provide its own
recovery logic before we switch to the postcopy-active state.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h |  2 ++
 migration/migration.c        | 20 +++++++++++++++++++-
 migration/savevm.c           | 25 +++++++++++++++++++++++++
 migration/savevm.h           |  1 +
 migration/trace-events       |  1 +
 5 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index f4f7bdc177..128124f008 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -42,6 +42,8 @@ typedef struct SaveVMHandlers {
     LoadStateHandler *load_state;
     int (*load_setup)(QEMUFile *f, void *opaque);
     int (*load_cleanup)(void *opaque);
+    /* Called when postcopy migration wants to resume from failure */
+    int (*resume_prepare)(MigrationState *s, void *opaque);
 } SaveVMHandlers;
 
 int register_savevm_live(DeviceState *dev,
diff --git a/migration/migration.c b/migration/migration.c
index 308adae4d3..4dc34ed8ce 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2392,7 +2392,25 @@ typedef enum MigThrError {
 /* Return zero if success, or <0 for error */
 static int postcopy_do_resume(MigrationState *s)
 {
-    /* TODO: do the resume logic */
+    int ret;
+
+    /*
+     * Call all the resume_prepare() hooks, so that modules can be
+     * ready for the migration resume.
+     */
+    ret = qemu_savevm_state_resume_prepare(s);
+    if (ret) {
+        error_report("%s: resume_prepare() failure detected: %d",
+                     __func__, ret);
+        return ret;
+    }
+
+    /*
+     * TODO: handshake with dest using MIG_CMD_RESUME,
+     * MIG_RP_MSG_RESUME_ACK, then switch source state to
+     * "postcopy-active"
+     */
+
     return 0;
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 611b3f1a09..bc87b0e5b1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1028,6 +1028,31 @@ void qemu_savevm_state_setup(QEMUFile *f)
     }
 }
 
+int qemu_savevm_state_resume_prepare(MigrationState *s)
+{
+    SaveStateEntry *se;
+    int ret;
+
+    trace_savevm_state_resume_prepare();
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->resume_prepare) {
+            continue;
+        }
+        if (se->ops && se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+        ret = se->ops->resume_prepare(s, se->opaque);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 /*
  * this function has three return values:
  *   negative: there was one error, and we have -errno.
diff --git a/migration/savevm.h b/migration/savevm.h
index a5f3879191..3193f04cca 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -31,6 +31,7 @@
 
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_state_setup(QEMUFile *f);
+int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
diff --git a/migration/trace-events b/migration/trace-events
index 2bf8301293..eadabf03e8 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -39,6 +39,7 @@ savevm_send_postcopy_run(void) ""
 savevm_send_postcopy_resume(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
 savevm_state_setup(void) ""
+savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
 savevm_state_cleanup(void) ""
-- 
2.13.6
