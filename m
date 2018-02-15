Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxU-0001q3-K0
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxQ-0000yg-1q
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:20 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 15 Feb 2018 16:51:42 +0300
Message-Id: <1518702707-7077-5-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/9] block/nbd-client: save first fatal error
 in nbd_iter_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

It is ok, that fatal error hides previous not fatal, but hiding
first fatal error is a bad feature.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9206652e45..b1cbe95b13 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -481,6 +481,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
 
 typedef struct NBDReplyChunkIter {
     int ret;
+    bool fatal;
     Error *err;
     bool done, only_structured;
 } NBDReplyChunkIter;
@@ -490,11 +491,12 @@ static void nbd_iter_error(NBDReplyChunkIter *iter, bool fatal,
 {
     assert(ret < 0);
 
-    if (fatal || iter->ret == 0) {
+    if ((fatal && !iter->fatal) || iter->ret == 0) {
         if (iter->ret != 0) {
             error_free(iter->err);
             iter->err = NULL;
         }
+        iter->fatal = fatal;
         iter->ret = ret;
         error_propagate(&iter->err, *local_err);
     } else {
-- 
2.11.1
