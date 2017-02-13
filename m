Received: from eggs.gnu.org ([2001:4830:134:3::10]:58798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLT-0002gG-PF
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLR-0005l4-LY
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:24 +0100
Message-Id: <1487006583-24350-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 02/41] block: Add op blocker permission
 constants
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

This patch defines the permission categories that will be used by the
new op blocker system.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 2d92d7e..6a37b06 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -414,6 +414,40 @@ struct BdrvChildRole {
 extern const BdrvChildRole child_file;
 extern const BdrvChildRole child_format;
 
+enum {
+    /**
+     * A user that has the "permission" of consistent reads is guaranteed that
+     * their view of the contents of the block device is complete and
+     * self-consistent, repesenting the contents of a disk at a specific point.
+     *
+     * For most block devices (including their backing files) this is true, but
+     * the property cannot be maintained in a few situations like for
+     * intermediate nodes of a commit block job.
+     */
+    BLK_PERM_CONSISTENT_READ    = 0x01,
+
+    /** This permission is required to change the visible disk contents. */
+    BLK_PERM_WRITE              = 0x02,
+
+    /**
+     * This permission (which is weaker than BLK_PERM_WRITE) is both enough and
+     * required for writes to the block node when the caller promises that
+     * this visible disk contents doesn't change.
+     */
+    BLK_PERM_WRITE_UNCHANGED    = 0x04,
+
+    /** This permission is required to change the size of a block node. */
+    BLK_PERM_RESIZE             = 0x08,
+
+    /**
+     * This permission is required to change the node that this BdrvChild
+     * points to.
+     */
+    BLK_PERM_GRAPH_MOD          = 0x10,
+
+    BLK_PERM_ALL                = 0x1f,
+};
+
 struct BdrvChild {
     BlockDriverState *bs;
     char *name;
-- 
1.8.3.1
