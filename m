Received: from eggs.gnu.org ([2001:4830:134:3::10]:46961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7U-0002Wg-56
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7R-00026L-BV
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:11 +0200
Message-Id: <20180913125217.23173-12-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/17] block-backend: Decrease in_flight
 only after callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

Request callbacks can do pretty much anything, including operations that
will yield from the coroutine (such as draining the backend). In that
case, a decreased in_flight would be visible to other code and could
lead to a drain completing while the callback hasn't actually completed
yet.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 1b2d7a6ff5..2efaf0c968 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1338,8 +1338,16 @@ static const AIOCBInfo blk_aio_em_aiocb_info = {
 static void blk_aio_complete(BlkAioEmAIOCB *acb)
 {
     if (acb->has_returned) {
-        blk_dec_in_flight(acb->rwco.blk);
+        if (qemu_get_current_aio_context() == qemu_get_aio_context()) {
+            /* If we are in the main thread, the callback is allowed to unref
+             * the BlockBackend, so we have to hold an additional reference */
+            blk_ref(acb->rwco.blk);
+        }
         acb->common.cb(acb->common.opaque, acb->rwco.ret);
+        blk_dec_in_flight(acb->rwco.blk);
+        if (qemu_get_current_aio_context() == qemu_get_aio_context()) {
+            blk_unref(acb->rwco.blk);
+        }
         qemu_aio_unref(acb);
     }
 }
-- 
2.13.6
