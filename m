Received: from eggs.gnu.org ([2001:4830:134:3::10]:36220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYWWs-0006sQ-Qi
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYWWp-0008N4-NC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:23:18 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:30493 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cYWWp-0008Kk-Bb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:23:15 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jan 2017 14:23:08 +0300
Message-Id: <20170131112308.54189-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block: bdrv_invalidate_cache: invalidate
 children first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Current implementation invalidates firstly parent bds and then its
children. This leads to the following bug:

after incoming migration, in bdrv_invalidate_cache_all:
1. invalidate parent bds - reopen it with BDRV_O_INACTIVE cleared
2. child is not yet invalidated
3. parent check that its BDRV_O_INACTIVE is cleared
4. parent writes to child
5. assert in bdrv_co_pwritev, as BDRV_O_INACTIVE is set for child

This patch fixes it by just changing invalidate sequence: invalidate
children first.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: I've missed that bdrv_invalidate_cache is already recursive, so we
can change sequence here. Also v1 doesn't cover the case when
bdrv_invalidate_cache is called not from bdrv_invalidate_cache_all.

 block.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index a0346c80c6..dce1dc02af 100644
--- a/block.c
+++ b/block.c
@@ -3235,19 +3235,18 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
     if (!(bs->open_flags & BDRV_O_INACTIVE)) {
         return;
     }
-    bs->open_flags &= ~BDRV_O_INACTIVE;
 
-    if (bs->drv->bdrv_invalidate_cache) {
-        bs->drv->bdrv_invalidate_cache(bs, &local_err);
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_invalidate_cache(child->bs, &local_err);
         if (local_err) {
-            bs->open_flags |= BDRV_O_INACTIVE;
             error_propagate(errp, local_err);
             return;
         }
     }
 
-    QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_invalidate_cache(child->bs, &local_err);
+    bs->open_flags &= ~BDRV_O_INACTIVE;
+    if (bs->drv->bdrv_invalidate_cache) {
+        bs->drv->bdrv_invalidate_cache(bs, &local_err);
         if (local_err) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_propagate(errp, local_err);
-- 
2.11.0
