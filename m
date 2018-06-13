Received: from eggs.gnu.org ([2001:4830:134:3::10]:56751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAMB-0003Ib-Tl
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAM9-0005Rs-DS
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:18:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Jun 2018 20:18:15 +0200
Message-Id: <20180613181823.13618-7-mreitz@redhat.com>
In-Reply-To: <20180613181823.13618-1-mreitz@redhat.com>
References: <20180613181823.13618-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 06/14] block: Generalize
 should_update_child() rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

Currently, bdrv_replace_node() refuses to create loops from one BDS to
itself if the BDS to be replaced is the backing node of the BDS to
replace it: Say there is a node A and a node B.  Replacing B by A means
making all references to B point to A.  If B is a child of A (i.e. A has
a reference to B), that would mean we would have to make this reference
point to A itself -- so we'd create a loop.

bdrv_replace_node() (through should_update_child()) refuses to do so if
B is the backing node of A.  There is no reason why we should create
loops if B is not the backing node of A, though.  The BDS graph should
never contain loops, so we should always refuse to create them.

If B is a child of A and B is to be replaced by A, we should simply
leave B in place there because it is the most sensible choice.

A more specific argument would be: Putting filter drivers into the BDS
graph is basically the same as appending an overlay to a backing chain.
But the main child BDS of a filter driver is not "backing" but "file",
so restricting the no-loop rule to backing nodes would fail here.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 50887087f3..df6dce6a73 100644
--- a/block.c
+++ b/block.c
@@ -3394,16 +3394,39 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
         return false;
     }
 
-    if (c->role == &child_backing) {
-        /* If @from is a backing file of @to, ignore the child to avoid
-         * creating a loop. We only want to change the pointer of other
-         * parents. */
-        QLIST_FOREACH(to_c, &to->children, next) {
-            if (to_c == c) {
-                break;
-            }
-        }
-        if (to_c) {
+    /* If the child @c belongs to the BDS @to, replacing the current
+     * c->bs by @to would mean to create a loop.
+     *
+     * Such a case occurs when appending a BDS to a backing chain.
+     * For instance, imagine the following chain:
+     *
+     *   guest device -> node A -> further backing chain...
+     *
+     * Now we create a new BDS B which we want to put on top of this
+     * chain, so we first attach A as its backing node:
+     *
+     *                   node B
+     *                     |
+     *                     v
+     *   guest device -> node A -> further backing chain...
+     *
+     * Finally we want to replace A by B.  When doing that, we want to
+     * replace all pointers to A by pointers to B -- except for the
+     * pointer from B because (1) that would create a loop, and (2)
+     * that pointer should simply stay intact:
+     *
+     *   guest device -> node B
+     *                     |
+     *                     v
+     *                   node A -> further backing chain...
+     *
+     * In general, when replacing a node A (c->bs) by a node B (@to),
+     * if A is a child of B, that means we cannot replace A by B there
+     * because that would create a loop.  Silently detaching A from B
+     * is also not really an option.  So overall just leaving A in
+     * place there is the most sensible choice. */
+    QLIST_FOREACH(to_c, &to->children, next) {
+        if (to_c == c) {
             return false;
         }
     }
@@ -3429,6 +3452,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
 
     /* Put all parents into @list and calculate their cumulative permissions */
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
+        assert(c->bs == from);
         if (!should_update_child(c, to)) {
             continue;
         }
-- 
2.17.1
