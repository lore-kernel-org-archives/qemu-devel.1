Received: from eggs.gnu.org ([2001:4830:134:3::10]:47204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj7x-00072S-3Z
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj7v-0007Jh-Ta
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:38:57 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:38:35 +0100
Message-Id: <20170212013844.6560-3-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 12/21] block: bdrv_invalidate_cache: invalidate
 children first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
Message-id: 20170131112308.54189-1-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index b8bc2a1c68..743c349100 100644
--- a/block.c
+++ b/block.c
@@ -3248,19 +3248,18 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
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
