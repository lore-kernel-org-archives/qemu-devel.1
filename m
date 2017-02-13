Received: from eggs.gnu.org ([2001:4830:134:3::10]:59762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMP-0003ot-N6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMO-0006Nn-O2
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:55 +0100
Message-Id: <1487006583-24350-34-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 33/41] block: Allow backing file links in
 change_parent_backing_link()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Now that the backing file child role implements .attach/.detach
callbacks, nothing prevents us from modifying the graph even if that
involves changing backing file links.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index ff328f1..8224dde 100644
--- a/block.c
+++ b/block.c
@@ -2788,9 +2788,9 @@ static void change_parent_backing_link(BlockDriverState *from,
             continue;
         }
         if (c->role == &child_backing) {
-            /* @from is generally not allowed to be a backing file, except for
-             * when @to is the overlay. In that case, @from may not be replaced
-             * by @to as @to's backing node. */
+            /* If @from is a backing file of @to, ignore the child to avoid
+             * creating a loop. We only want to change the pointer of other
+             * parents. */
             QLIST_FOREACH(to_c, &to->children, next) {
                 if (to_c == c) {
                     break;
@@ -2801,7 +2801,6 @@ static void change_parent_backing_link(BlockDriverState *from,
             }
         }
 
-        assert(c->role != &child_backing);
         bdrv_ref(to);
         bdrv_replace_child(c, to);
         bdrv_unref(from);
-- 
1.8.3.1
