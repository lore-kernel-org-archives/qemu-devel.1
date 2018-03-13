Received: from eggs.gnu.org ([2001:4830:134:3::10]:47308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUv-0007OA-K7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUu-0000xM-OX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:41 -0500
Message-Id: <20180313171345.659672-14-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 13/17] block/nbd-client: save first fatal error
 in nbd_iter_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It is ok, that fatal error hides previous not fatal, but hiding
first fatal error is a bad feature.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180312152126.286890-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 7b68499b76a..0d9f73a137f 100644
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
2.14.3
