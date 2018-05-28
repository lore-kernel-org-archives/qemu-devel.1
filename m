Received: from eggs.gnu.org ([2001:4830:134:3::10]:33471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNGsr-0002Xg-Fe
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNGso-000370-D4
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:04:17 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:41796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNGso-000369-7A
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:04:14 -0400
Received: from player755.ha.ovh.net (unknown [10.109.122.51])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 27E3AE3F65
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 14:04:11 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 28 May 2018 14:03:59 +0200
Message-ID: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4] block: fix QEMU crash with scsi-hd and
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

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
---
v4: - call blk_drain() in blk_remove_bs() (Kevin)

v3: - start drained section before modifying the graph (Stefan)

v2: - drain I/O requests when detaching the BDS (Stefan, Paolo)
---
 block/block-backend.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 89f47b00ea24..bee1f0e41461 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -768,6 +768,11 @@ void blk_remove_bs(BlockBackend *blk)
 
     blk_update_root_state(blk);
 
+    /* bdrv_root_unref_child() will cause blk->root to become stale and may
+     * switch to a completion coroutine later on. Let's drain all I/O here
+     * to avoid that and a potential QEMU crash.
+     */
+    blk_drain(blk);
     bdrv_root_unref_child(blk->root);
     blk->root = NULL;
 }
