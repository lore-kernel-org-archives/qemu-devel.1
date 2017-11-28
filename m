Received: from eggs.gnu.org ([2001:4830:134:3::10]:34021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJi3v-0005E6-5C
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJi3r-0005dP-Ae
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:44:43 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Nov 2017 16:43:50 +0100
Message-Id: <20171128154350.21504-5-kwolf@redhat.com>
In-Reply-To: <20171128154350.21504-1-kwolf@redhat.com>
References: <20171128154350.21504-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 4/4] block: Expect graph changes in
 bdrv_parent_drained_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The .drained_begin/end callbacks can (directly or indirectly via
aio_poll()) cause block nodes to be removed or the current BdrvChild to
point to a different child node.

Use QLIST_FOREACH_SAFE() to make sure we don't access invalid
BlockDriverStates or accidentally continue iterating the parents of the
new child node instead of the node we actually came from.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4fdf93a014..6773926fc1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -42,9 +42,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
 
 void bdrv_parent_drained_begin(BlockDriverState *bs)
 {
-    BdrvChild *c;
+    BdrvChild *c, *next;
 
-    QLIST_FOREACH(c, &bs->parents, next_parent) {
+    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
         if (c->role->drained_begin) {
             c->role->drained_begin(c);
         }
@@ -53,9 +53,9 @@ void bdrv_parent_drained_begin(BlockDriverState *bs)
 
 void bdrv_parent_drained_end(BlockDriverState *bs)
 {
-    BdrvChild *c;
+    BdrvChild *c, *next;
 
-    QLIST_FOREACH(c, &bs->parents, next_parent) {
+    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
         if (c->role->drained_end) {
             c->role->drained_end(c);
         }
-- 
2.13.6
