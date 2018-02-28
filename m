Received: from eggs.gnu.org ([2001:4830:134:3::10]:41486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er66W-00044C-Sm
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er66V-00042p-P7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:05:24 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 28 Feb 2018 19:04:53 +0100
Message-Id: <20180228180507.3964-3-mreitz@redhat.com>
In-Reply-To: <20180228180507.3964-1-mreitz@redhat.com>
References: <20180228180507.3964-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/16] block: BDS deletion in
 bdrv_do_drained_begin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Draining a BDS (in the main loop) may cause it to go be deleted.  That
is rather suboptimal if we still plan to access it afterwards, so let us
enclose the main body of the function with a bdrv_ref()/bdrv_unref()
pair.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/block/io.c b/block/io.c
index ead12c4136..3b61e26114 100644
--- a/block/io.c
+++ b/block/io.c
@@ -294,12 +294,27 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
                            BdrvChild *parent)
 {
     BdrvChild *child, *next;
+    bool in_main_loop =
+        qemu_get_current_aio_context() == qemu_get_aio_context();
+    /* bdrv_close() invokes bdrv_drain() with bs->refcnt == 0; then,
+     * we may not invoke bdrv_ref()/bdrv_unref() because the latter
+     * would result in the refcount going back to 0, creating an
+     * infinite loop.
+     * Also, we have to be in the main loop because we may not call
+     * bdrv_unref() elsewhere.  But because of that, the BDS is not in
+     * danger of going away without the bdrv_ref()/bdrv_unref() pair
+     * elsewhere, so we are fine then. */
+    bool add_ref = in_main_loop && bs->refcnt > 0;
 
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, true, recursive, parent);
         return;
     }
 
+    if (add_ref) {
+        bdrv_ref(bs);
+    }
+
     /* Stop things in parent-to-child order */
     if (atomic_fetch_inc(&bs->quiesce_counter) == 0) {
         aio_disable_external(bdrv_get_aio_context(bs));
@@ -315,6 +330,10 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
             bdrv_do_drained_begin(child->bs, true, child);
         }
     }
+
+    if (add_ref) {
+        bdrv_unref(bs);
+    }
 }
 
 void bdrv_drained_begin(BlockDriverState *bs)
-- 
2.14.3
