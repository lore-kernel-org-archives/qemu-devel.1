Received: from eggs.gnu.org ([2001:4830:134:3::10]:49828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLmGC-0005cI-B7
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLmG2-0000J5-R9
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:10:12 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:46538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fLmG2-0000I5-G0
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:10:02 -0400
Received: from player791.ha.ovh.net (unknown [10.109.120.34])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 62F7D16BBF
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 11:09:59 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 24 May 2018 11:09:47 +0200
Message-ID: <152715298769.397287.11782572103987618822.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org

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
changes while we have in-flight requests. This patch hence adds
a drained section to bdrv_detach_child(), so that we're sure
all requests have been drained when blk->root is freed.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - drain I/O requests when detaching the BDS (Stefan, Paolo)
---
 block.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block.c b/block.c
index 676e57f5623a..fc9379439883 100644
--- a/block.c
+++ b/block.c
@@ -2127,12 +2127,16 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
 static void bdrv_detach_child(BdrvChild *child)
 {
+    BlockDriverState *child_bs = child->bs;
+
     if (child->next.le_prev) {
         QLIST_REMOVE(child, next);
         child->next.le_prev = NULL;
     }
 
+    bdrv_drained_begin(child_bs);
     bdrv_replace_child(child, NULL);
+    bdrv_drained_end(child_bs);
 
     g_free(child->name);
     g_free(child);
