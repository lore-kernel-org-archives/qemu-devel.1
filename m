Received: from eggs.gnu.org ([2001:4830:134:3::10]:53392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faypu-0001j0-P0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faypt-0001Oz-QL
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:37:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  5 Jul 2018 15:36:58 +0800
Message-Id: <20180705073701.10558-7-famz@redhat.com>
In-Reply-To: <20180705073701.10558-1-famz@redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/9] block: Use common req handling for
 discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Reuse the new bdrv_co_write_req_prepare/finish helpers. The variation
here is that discard requests don't affect bs->wr_highest_offset.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index f06978dda0..912fcb962a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1582,7 +1582,18 @@ bdrv_co_write_req_finish(BdrvChild *child, BdrvTrackedRequest *req, int ret)
         bdrv_parent_cb_resize(bs);
         bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
     }
-    bdrv_set_dirty(bs, req->offset, req->bytes);
+    if (req->bytes) {
+        switch (req->type) {
+        case BDRV_TRACKED_WRITE:
+            stat64_max(&bs->wr_highest_offset, req->offset + req->bytes);
+            /* fall through, to set dirty bits */
+        case BDRV_TRACKED_DISCARD:
+            bdrv_set_dirty(bs, req->offset, req->bytes);
+            break;
+        default:
+            break;
+        }
+    }
 }
 
 /*
@@ -2643,10 +2654,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
     ret = bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
         return ret;
-    } else if (bs->read_only) {
-        return -EPERM;
     }
-    assert(!(bs->open_flags & BDRV_O_INACTIVE));
 
     /* Do nothing if disabled.  */
     if (!(bs->open_flags & BDRV_O_UNMAP)) {
@@ -2670,7 +2678,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
     bdrv_inc_in_flight(bs);
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_DISCARD);
 
-    ret = notifier_with_return_list_notify(&bs->before_write_notifiers, &req);
+    ret = bdrv_co_write_req_prepare(child, &req, 0);
     if (ret < 0) {
         goto out;
     }
@@ -2736,8 +2744,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
     }
     ret = 0;
 out:
-    atomic_inc(&bs->write_gen);
-    bdrv_set_dirty(bs, req.offset, req.bytes);
+    bdrv_co_write_req_finish(child, &req, ret);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
     return ret;
-- 
2.17.1
