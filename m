Received: from eggs.gnu.org ([2001:4830:134:3::10]:43786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvN-0001IN-EM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvM-0008Ry-2V
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:42 +0100
Message-Id: <1487689130-30373-47-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 46/54] hmp: Request permissions in qemu-io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The HMP command 'qemu-io' is a bit tricky because it wants to work on
the original BlockBackend, but additional permissions could be required.
The details are explained in a comment in the code, but in summary, just
request whatever permissions the current qemu-io command needs.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c          |  6 ++++++
 hmp.c                          | 26 +++++++++++++++++++++++++-
 include/qemu-io.h              |  1 +
 include/sysemu/block-backend.h |  1 +
 qemu-io-cmds.c                 | 28 ++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 38a3858..daa7908 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -584,6 +584,12 @@ int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
     return 0;
 }
 
+void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
+{
+    *perm = blk->perm;
+    *shared_perm = blk->shared_perm;
+}
+
 static int blk_do_attach_dev(BlockBackend *blk, void *dev)
 {
     if (blk->dev) {
diff --git a/hmp.c b/hmp.c
index 801fddb..fde5016 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2045,7 +2045,6 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
     if (!blk) {
         BlockDriverState *bs = bdrv_lookup_bs(NULL, device, &err);
         if (bs) {
-            /* FIXME Use real permissions */
             blk = local_blk = blk_new(0, BLK_PERM_ALL);
             ret = blk_insert_bs(blk, bs, &err);
             if (ret < 0) {
@@ -2059,6 +2058,31 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
     aio_context = blk_get_aio_context(blk);
     aio_context_acquire(aio_context);
 
+    /*
+     * Notably absent: Proper permission management. This is sad, but it seems
+     * almost impossible to achieve without changing the semantics and thereby
+     * limiting the use cases of the qemu-io HMP command.
+     *
+     * In an ideal world we would unconditionally create a new BlockBackend for
+     * qemuio_command(), but we have commands like 'reopen' and want them to
+     * take effect on the exact BlockBackend whose name the user passed instead
+     * of just on a temporary copy of it.
+     *
+     * Another problem is that deleting the temporary BlockBackend involves
+     * draining all requests on it first, but some qemu-iotests cases want to
+     * issue multiple aio_read/write requests and expect them to complete in
+     * the background while the monitor has already returned.
+     *
+     * This is also what prevents us from saving the original permissions and
+     * restoring them later: We can't revoke permissions until all requests
+     * have completed, and we don't know when that is nor can we really let
+     * anything else run before we have revoken them to avoid race conditions.
+     *
+     * What happens now is that command() in qemu-io-cmds.c can extend the
+     * permissions if necessary for the qemu-io command. And they simply stay
+     * extended, possibly resulting in a read-only guest device keeping write
+     * permissions. Ugly, but it appears to be the lesser evil.
+     */
     qemuio_command(blk, command);
 
     aio_context_release(aio_context);
diff --git a/include/qemu-io.h b/include/qemu-io.h
index 4d402b9..196fde0 100644
--- a/include/qemu-io.h
+++ b/include/qemu-io.h
@@ -36,6 +36,7 @@ typedef struct cmdinfo {
     const char  *args;
     const char  *oneline;
     helpfunc_t  help;
+    uint64_t    perm;
 } cmdinfo_t;
 
 extern bool qemuio_misalign;
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index b23f683..096c17f 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -107,6 +107,7 @@ bool bdrv_has_blk(BlockDriverState *bs);
 bool bdrv_is_root_node(BlockDriverState *bs);
 int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
                  Error **errp);
+void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm);
 
 void blk_set_allow_write_beyond_eof(BlockBackend *blk, bool allow);
 void blk_iostatus_enable(BlockBackend *blk);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index e415b03..035cb96 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -83,6 +83,29 @@ static int command(BlockBackend *blk, const cmdinfo_t *ct, int argc,
         }
         return 0;
     }
+
+    /* Request additional permissions if necessary for this command. The caller
+     * is responsible for restoring the original permissions afterwards if this
+     * is what it wants. */
+    if (ct->perm && blk_is_available(blk)) {
+        uint64_t orig_perm, orig_shared_perm;
+        blk_get_perm(blk, &orig_perm, &orig_shared_perm);
+
+        if (ct->perm & ~orig_perm) {
+            uint64_t new_perm;
+            Error *local_err = NULL;
+            int ret;
+
+            new_perm = orig_perm | ct->perm;
+
+            ret = blk_set_perm(blk, new_perm, orig_shared_perm, &local_err);
+            if (ret < 0) {
+                error_report_err(local_err);
+                return 0;
+            }
+        }
+    }
+
     optind = 0;
     return ct->cfunc(blk, argc, argv);
 }
@@ -916,6 +939,7 @@ static const cmdinfo_t write_cmd = {
     .name       = "write",
     .altname    = "w",
     .cfunc      = write_f,
+    .perm       = BLK_PERM_WRITE,
     .argmin     = 2,
     .argmax     = -1,
     .args       = "[-bcCfquz] [-P pattern] off len",
@@ -1091,6 +1115,7 @@ static int writev_f(BlockBackend *blk, int argc, char **argv);
 static const cmdinfo_t writev_cmd = {
     .name       = "writev",
     .cfunc      = writev_f,
+    .perm       = BLK_PERM_WRITE,
     .argmin     = 2,
     .argmax     = -1,
     .args       = "[-Cfq] [-P pattern] off len [len..]",
@@ -1390,6 +1415,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv);
 static const cmdinfo_t aio_write_cmd = {
     .name       = "aio_write",
     .cfunc      = aio_write_f,
+    .perm       = BLK_PERM_WRITE,
     .argmin     = 2,
     .argmax     = -1,
     .args       = "[-Cfiquz] [-P pattern] off len [len..]",
@@ -1554,6 +1580,7 @@ static const cmdinfo_t truncate_cmd = {
     .name       = "truncate",
     .altname    = "t",
     .cfunc      = truncate_f,
+    .perm       = BLK_PERM_WRITE | BLK_PERM_RESIZE,
     .argmin     = 1,
     .argmax     = 1,
     .args       = "off",
@@ -1651,6 +1678,7 @@ static const cmdinfo_t discard_cmd = {
     .name       = "discard",
     .altname    = "d",
     .cfunc      = discard_f,
+    .perm       = BLK_PERM_WRITE,
     .argmin     = 2,
     .argmax     = -1,
     .args       = "[-Cq] off len",
-- 
1.8.3.1
