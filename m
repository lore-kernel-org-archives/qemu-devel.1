Received: from eggs.gnu.org ([2001:4830:134:3::10]:43364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuy-0000ks-Cd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBux-00088o-Em
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:52 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:30 +0100
Message-Id: <1487689130-30373-35-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 34/54] block: Add BdrvChildRole.stay_at_node
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
index a8a2fa7..c7c0a8b 100644
--- a/block.c
+++ b/block.c
@@ -2832,6 +2832,9 @@ static void change_parent_backing_link(BlockDriverState *from,
     BdrvChild *c, *next, *to_c;
 
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
+        if (c->role->stay_at_node) {
+            continue;
+        }
         if (c->role == &child_backing) {
             /* @from is generally not allowed to be a backing file, except for
              * when @to is the overlay. In that case, @from may not be replaced
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3177b9f..a0d9328 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -441,6 +441,10 @@ typedef struct BdrvAioNotifier {
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
