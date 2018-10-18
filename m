Received: from eggs.gnu.org ([2001:4830:134:3::10]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gD49c-00010q-0Z
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gD49Z-0008H2-84
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:59:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 18 Oct 2018 11:59:03 +0300
Message-Id: <bae94852a61089d9ff4171bbec13671a52778e2f.1539852875.git.berto@igalia.com>
In-Reply-To: <cover.1539852875.git.berto@igalia.com>
References: <cover.1539852875.git.berto@igalia.com>
In-Reply-To: <cover.1539852875.git.berto@igalia.com>
References: <cover.1539852875.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/2] quorum: Forbid adding children in
 blkverify mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The blkverify mode of Quorum only works when the number of children is
exactly two, so any attempt to add a new one must return an error.

quorum_del_child() on the other hand doesn't need any additional check
because decreasing the number of children would make it go under the
vote threshold.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Kevin Wolf <kwolf@redhat.com>
---
 block/quorum.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index 6188ff6666..16b3c8067c 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -992,6 +992,11 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
     char indexstr[32];
     int ret;
 
+    if (s->is_blkverify) {
+        error_setg(errp, "Cannot add a child to a quorum in blkverify mode");
+        return;
+    }
+
     assert(s->num_children <= INT_MAX / sizeof(BdrvChild *));
     if (s->num_children == INT_MAX / sizeof(BdrvChild *) ||
         s->next_child_index == UINT_MAX) {
@@ -1046,6 +1051,9 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
         return;
     }
 
+    /* We know now that num_children > threshold, so blkverify must be false */
+    assert(!s->is_blkverify);
+
     bdrv_drained_begin(bs);
 
     /* We can safely remove this child now */
-- 
2.11.0
