Received: from eggs.gnu.org ([2001:4830:134:3::10]:52099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHZ-00053s-L0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHY-0006O6-P6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:50 +0200
Message-Id: <20180618164504.24488-22-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/35] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Greg Kurz <groug@kaod.org>

Removing a drive with drive_del while it is being used to run an I/O
intensive workload can cause QEMU to crash.

An AIO flush can yield at some point:

blk_aio_flush_entry()
 blk_co_flush(blk)
  bdrv_co_flush(blk->root->bs)
   ...
    qemu_coroutine_yield()

and let the HMP command to run, free blk->root and give control
back to the AIO flush:

    hmp_drive_del()
     blk_remove_bs()
      bdrv_root_unref_child(blk->root)
       child_bs = blk->root->bs
       bdrv_detach_child(blk->root)
        bdrv_replace_child(blk->root, NULL)
         blk->root->bs = NULL
        g_free(blk->root) <============== blk->root becomes stale
       bdrv_unref(child_bs)
        bdrv_delete(child_bs)
         bdrv_close()
          bdrv_drained_begin()
           bdrv_do_drained_begin()
            bdrv_drain_recurse()
             aio_poll()
              ...
              qemu_coroutine_switch()

and the AIO flush completion ends up dereferencing blk->root:

  blk_aio_complete()
   scsi_aio_complete()
    blk_get_aio_context(blk)
     bs = blk_bs(blk)
 ie, bs = blk->root ? blk->root->bs : NULL
            ^^^^^
            stale

The problem is that we should avoid making block driver graph
changes while we have in-flight requests. Let's drain all I/O
for this BB before calling bdrv_root_unref_child().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 2d1a3463e8..6b75bca317 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -767,6 +767,11 @@ void blk_remove_bs(BlockBackend *blk)
 
     blk_update_root_state(blk);
 
+    /* bdrv_root_unref_child() will cause blk->root to become stale and may
+     * switch to a completion coroutine later on. Let's drain all I/O here
+     * to avoid that and a potential QEMU crash.
+     */
+    blk_drain(blk);
     bdrv_root_unref_child(blk->root);
     blk->root = NULL;
 }
-- 
2.13.6
