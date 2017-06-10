Received: from eggs.gnu.org ([2001:4830:134:3::10]:37360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1dJcHY-0004MN-QE
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 05:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1dJcHY-0007yJ-6R
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 05:02:08 -0400
From: Zhengui Li <lizhengui@huawei.com>
Date: Sat, 10 Jun 2017 15:04:10 +0800
Message-ID: <1497078250-19505-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] bdrv_inc_in_flight and bdrv_dec_in_flight:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, lizhengui@huawei.com

Avoid empty pointer access if the bs is NULL.

Signed-off-by: Zhengui Li <lizhengui@huawei.com>
---
 block/io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index ed31810..b12d7cf 100644
--- a/block/io.c
+++ b/block/io.c
@@ -492,7 +492,9 @@ static bool tracked_request_overlaps(BdrvTrackedRequest *req,
 
 void bdrv_inc_in_flight(BlockDriverState *bs)
 {
-    atomic_inc(&bs->in_flight);
+    if (bs) {
+        atomic_inc(&bs->in_flight);
+    }
 }
 
 static void dummy_bh_cb(void *opaque)
@@ -508,8 +510,10 @@ void bdrv_wakeup(BlockDriverState *bs)
 
 void bdrv_dec_in_flight(BlockDriverState *bs)
 {
-    atomic_dec(&bs->in_flight);
-    bdrv_wakeup(bs);
+    if (bs) {
+        atomic_dec(&bs->in_flight);
+        bdrv_wakeup(bs);
+    }
 }
 
 static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
-- 
1.8.3.1
