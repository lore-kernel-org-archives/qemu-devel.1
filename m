Received: from eggs.gnu.org ([2001:4830:134:3::10]:58359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYx-0003N9-L2
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYu-0001w4-W3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjYu-0001vh-QV
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60DB840203F4
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:40:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:40:04 +0200
Message-Id: <20180515234017.2277-28-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 27/40] migration: introduce
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

This is hook function to be called when a postcopy migration wants to
resume from a failure. For each module, it should provide its own
recovery logic before we switch to the postcopy-active state.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-16-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/register.h |  2 ++
 migration/migration.c        | 20 +++++++++++++++++++-
 migration/savevm.c           | 25 +++++++++++++++++++++++++
 migration/savevm.h           |  1 +
 migration/trace-events       |  1 +
 5 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index f6f12f9b1a..d287f4c317 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -64,6 +64,8 @@ typedef struct SaveVMHandlers {
     LoadStateHandler *load_state;
     int (*load_setup)(QEMUFile *f, void *opaque);
     int (*load_cleanup)(void *opaque);
+    /* Called when postcopy migration wants to resume from failure */
+    int (*resume_prepare)(MigrationState *s, void *opaque);
 } SaveVMHandlers;
 
 int register_savevm_live(DeviceState *dev,
diff --git a/migration/migration.c b/migration/migration.c
index 4f2c6d22d1..b0217c4823 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2454,7 +2454,25 @@ typedef enum MigThrError {
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
index 6a2d77cbf3..8e7653badc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1031,6 +1031,31 @@ void qemu_savevm_state_setup(QEMUFile *f)
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
index b24ff073ad..a5e65b8ae3 100644
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
index 40a7217829..be36fbccfe 100644
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
2.17.0
