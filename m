Received: from eggs.gnu.org ([2001:4830:134:3::10]:59552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMA-0003V6-0s
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKM8-0006EG-Ml
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:46 +0100
Message-Id: <1487006583-24350-25-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 24/41] block: Add BdrvChildRole.stay_at_node
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

When the parents' child links are updated in bdrv_append() or
bdrv_replace_in_backing_chain(), this should affect all child links of
BlockBackends or other nodes, but not on child links held for other
purposes (like for setting permissions). This patch allows to control
the behaviour per BdrvChildRole.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   | 3 +++
 include/block/block_int.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/block.c b/block.c
index d743f50..842ac78 100644
--- a/block.c
+++ b/block.c
@@ -2713,6 +2713,9 @@ static void change_parent_backing_link(BlockDriverState *from,
     BdrvChild *c, *next, *to_c;
 
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
+        if (c->role->stay_at_node) {
+            continue;
+        }
         if (c->role == &child_backing) {
             /* @from is generally not allowed to be a backing file, except for
              * when @to is the overlay. In that case, @from may not be replaced
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a5557b1..b24fc49 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -427,6 +427,10 @@ typedef struct BdrvAioNotifier {
 } BdrvAioNotifier;
 
 struct BdrvChildRole {
+    /* If true, bdrv_replace_in_backing_chain() doesn't change the node this
+     * BdrvChild points to. */
+    bool stay_at_node;
+
     void (*inherit_options)(int *child_flags, QDict *child_options,
                             int parent_flags, QDict *parent_options);
 
-- 
1.8.3.1
