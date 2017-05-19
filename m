Received: from eggs.gnu.org ([2001:4830:134:3::10]:48322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJi-0006rX-0g
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJe-0006ot-4N
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:26 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com
	([104.47.2.116]:14269
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJd-0006oZ-Q1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:22 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:37 +0300
Message-ID: <1495186480-114192-11-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 10/13] qcow2-cluster: slightly refactor
 handle_dependencies()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

  - assert the alignment on return if the allocation has to stop
    (at the start of a running allocation)
  - make use of const specifiers for local variables

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/qcow2-cluster.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 4204db9..03d6f7e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -900,15 +900,15 @@ out:
  * Check if there already is an AIO write request in flight which allocates
  * the same cluster. In this case we need to wait until the previous
  * request has completed and updated the L2 table accordingly.
- *
  * Returns:
  *   0       if there was no dependency. *cur_bytes indicates the number of
  *           bytes from guest_offset that can be read before the next
- *           dependency must be processed (or the request is complete)
+ *           dependency must be processed (or the request is complete).
+ *           *m is not modified
  *
- *   -EAGAIN if we had to wait for another request, previously gathered
- *           information on cluster allocation may be invalid now. The caller
- *           must start over anyway, so consider *cur_bytes undefined.
+ *   -EAGAIN if we had to wait for another request. The caller
+ *           must start over, so consider *cur_bytes undefined.
+ *           *m is not modified
  */
 static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t *cur_bytes, QCowL2Meta **m)
@@ -919,10 +919,10 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
 
     QLIST_FOREACH(old_alloc, &s->cluster_allocs, next_in_flight) {
 
-        uint64_t start = guest_offset;
-        uint64_t end = start + bytes;
-        uint64_t old_start = l2meta_cow_start(old_alloc);
-        uint64_t old_end = l2meta_cow_end(old_alloc);
+        const uint64_t start = guest_offset;
+        const uint64_t end = start + bytes;
+        const uint64_t old_start = l2meta_cow_start(old_alloc);
+        const uint64_t old_end = l2meta_cow_end(old_alloc);
 
         if (end <= old_start || start >= old_end) {
             /* No intersection */
@@ -939,6 +939,8 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
              * and deal with requests depending on them before starting to
              * gather new ones. Not worth the trouble. */
             if (bytes == 0 && *m) {
+                /* start must be cluster aligned at this point */
+                assert(start == start_of_cluster(s, start));
                 *cur_bytes = 0;
                 return 0;
             }
-- 
2.7.4
