Received: from eggs.gnu.org ([2001:4830:134:3::10]:43492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNhFf-0004CJ-Tm
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNhFW-0006MN-Lp
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:45:49 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 16 Nov 2018 17:45:24 +0100
Message-Id: <20181116164526.31487-2-mreitz@redhat.com>
In-Reply-To: <20181116164526.31487-1-mreitz@redhat.com>
References: <20181116164526.31487-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1? v2 1/3] block: Always abort reopen
 after prepare succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

bdrv_reopen_multiple() does not invoke bdrv_reopen_abort() for the
element of the reopen queue for which bdrv_reopen_prepare() failed,
because it assumes that the prepare function will have rolled back all
changes already.

However, bdrv_reopen_prepare() does not do this in every case: It may
notice an error after BlockDriver.bdrv_reopen_prepare() succeeded, and
it will not invoke BlockDriver.bdrv_reopen_abort() then; and neither
will bdrv_reopen_multiple(), as explained above.

This is wrong because we must always call .bdrv_reopen_commit() or
.bdrv_reopen_abort() after .bdrv_reopen_prepare() has succeeded.
Otherwise, the block driver has no chance to undo what it has done in
its implementation of .bdrv_reopen_prepare().

To fix this, bdrv_reopen_prepare() has to call .bdrv_reopen_abort() if
it wants to return an error after .bdrv_reopen_prepare() has succeeded.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block.c b/block.c
index fd67e14dfa..3feac08535 100644
--- a/block.c
+++ b/block.c
@@ -3201,6 +3201,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     QDict *orig_reopen_opts;
     char *discard = NULL;
     bool read_only;
+    bool drv_prepared = false;
 
     assert(reopen_state != NULL);
     assert(reopen_state->bs->drv != NULL);
@@ -3285,6 +3286,8 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         goto error;
     }
 
+    drv_prepared = true;
+
     /* Options that are not handled are only okay if they are unchanged
      * compared to the old state. It is expected that some options are only
      * used for the initial open, but not reopen (e.g. filename) */
@@ -3350,6 +3353,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     reopen_state->options = qobject_ref(orig_reopen_opts);
 
 error:
+    if (ret < 0 && drv_prepared) {
+        /* drv->bdrv_reopen_prepare() has succeeded, so we need to
+         * call drv->bdrv_reopen_abort() before signaling an error
+         * (bdrv_reopen_multiple() will not call bdrv_reopen_abort()
+         * when the respective bdrv_reopen_prepare() has failed) */
+        if (drv->bdrv_reopen_abort) {
+            drv->bdrv_reopen_abort(reopen_state);
+        }
+    }
     qemu_opts_del(opts);
     qobject_unref(orig_reopen_opts);
     g_free(discard);
-- 
2.17.2
