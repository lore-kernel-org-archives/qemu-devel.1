Received: from eggs.gnu.org ([2001:4830:134:3::10]:44603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioW6-0005WE-7r
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioW5-0007ZH-Aw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:02 +0100
Message-Id: <1488314205-16264-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/46] block: Add op blocker permission constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This patch defines the permission categories that will be used by the
new op blocker system.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
---
 include/block/block.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index bde5ebd..f62f38e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -187,6 +187,42 @@ typedef enum BlockOpType {
     BLOCK_OP_TYPE_MAX,
 } BlockOpType;
 
+/* Block node permission constants */
+enum {
+    /**
+     * A user that has the "permission" of consistent reads is guaranteed that
+     * their view of the contents of the block device is complete and
+     * self-consistent, representing the contents of a disk at a specific
+     * point.
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
+     * the visible disk content doesn't change.
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
 /* disk I/O throttling */
 void bdrv_init(void);
 void bdrv_init_with_whitelist(void);
-- 
1.8.3.1
