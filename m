Received: from eggs.gnu.org ([2001:4830:134:3::10]:39247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxut4-0004LL-Bw
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxut1-00043d-MR
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxut1-00042J-GY
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:07 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:31 +0800
Message-Id: <20170411122632.14050-11-famz@redhat.com>
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 10/11] block: Fix bdrv_co_flush early return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

bdrv_inc_in_flight and bdrv_dec_in_flight are mandatory for
BDRV_POLL_WHILE to work, even for the shortcut case where flush is
unnecessary. Move the if block to below bdrv_dec_in_flight, and BTW fix
the variable declaration position.

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index 00e45ca..bae6947 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2278,16 +2278,17 @@ static void coroutine_fn bdrv_flush_co_entry(void *opaque)
 
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
-    int ret;
-
-    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
-        bdrv_is_sg(bs)) {
-        return 0;
-    }
+    int current_gen;
+    int ret = 0;
 
     bdrv_inc_in_flight(bs);
 
-    int current_gen = bs->write_gen;
+    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
+        bdrv_is_sg(bs)) {
+        goto early_exit;
+    }
+
+    current_gen = bs->write_gen;
 
     /* Wait until any previous flushes are completed */
     while (bs->active_flush_req) {
@@ -2370,6 +2371,7 @@ out:
     /* Return value is ignored - it's ok if wait queue is empty */
     qemu_co_queue_next(&bs->flush_queue);
 
+early_exit:
     bdrv_dec_in_flight(bs);
     return ret;
 }
-- 
2.9.3
