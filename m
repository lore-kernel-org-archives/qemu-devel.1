Received: from eggs.gnu.org ([2001:4830:134:3::10]:43746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJzYa-00070U-0p
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJzYU-000539-6z
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:25:32 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 29 Nov 2017 11:25:10 +0100
Message-Id: <20171129102513.9153-2-pbonzini@redhat.com>
In-Reply-To: <20171129102513.9153-1-pbonzini@redhat.com>
References: <20171129102513.9153-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] block: Expect graph changes in
 bdrv_parent_drained_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com

From: Kevin Wolf <kwolf@redhat.com>

The .drained_begin/end callbacks can (directly or indirectly via
aio_poll()) cause block nodes to be removed or the current BdrvChild to
point to a different child node.

Use QLIST_FOREACH_SAFE() to make sure we don't access invalid
BlockDriverStates or accidentally continue iterating the parents of the
new child node instead of the node we actually came from.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
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
2.14.3
