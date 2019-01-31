Received: from eggs.gnu.org ([209.51.188.92]:38132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gp0jn-00012J-Rn
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gp0jm-00018F-MQ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:01:51 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 30 Jan 2019 20:01:36 -0500
Message-Id: <20190131010136.12007-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] block/dirty-bitmap: Documentation and Comment
 fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>

The meaning of the states has changed subtly over time,
this should bring the understanding more in-line with the
current, actual usages.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 19 +++++++++++++------
 qapi/block-core.json | 17 ++++++++++++-----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 00ea36f554..e2adf54dd3 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -29,12 +29,19 @@
 #include "block/blockjob.h"
 
 /**
- * A BdrvDirtyBitmap can be in three possible states:
- * (1) successor is NULL and disabled is false: full r/w mode
- * (2) successor is NULL and disabled is true: read only mode ("disabled")
- * (3) successor is set: frozen mode.
- *     A frozen bitmap cannot be renamed, deleted, anonymized, cleared, set,
- *     or enabled. A frozen bitmap can only abdicate() or reclaim().
+ * A BdrvDirtyBitmap can be in four possible user-visible states:
+ * (1) Active:   successor is NULL, and disabled is false: full r/w mode
+ * (2) Disabled: successor is NULL, and disabled is true: qualified r/w mode,
+ *               guest writes are dropped, but monitor writes are possible,
+ *               through commands like merge and clear.
+ * (3) Frozen:   successor is not null.
+ *               A frozen bitmap cannot be renamed, deleted, cleared, set,
+ *               enabled, merged to, etc. A frozen bitmap can only abdicate()
+ *               or reclaim().
+ *               In this state, the successor bitmap is Active and will
+ *               generally be recording writes from the guest for us.
+ * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
+ *               in any way from the monitor.
  */
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91685be6c2..eba126c76e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -418,10 +418,12 @@
 # An enumeration of possible states that a dirty bitmap can report to the user.
 #
 # @frozen: The bitmap is currently in-use by a backup operation or block job,
-#          and is immutable.
+#          and is immutable. New writes by the guest are being recorded in a
+#          cache, and are not lost.
 #
-# @disabled: The bitmap is currently in-use by an internal operation and is
-#            read-only. It can still be deleted.
+# @disabled: The bitmap is not currently recording new writes by the guest.
+#            This is requested explicitly via @block-dirty-bitmap-disable.
+#            It can still be cleared, deleted, or used for backup operations.
 #
 # @active: The bitmap is actively monitoring for new writes, and can be cleared,
 #          deleted, or used for backup operations.
@@ -1944,9 +1946,14 @@
 # @block-dirty-bitmap-merge:
 #
 # Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
-# The @bitmaps dirty bitmaps are unchanged.
+# Dirty bitmaps in @bitmaps will be unchanged.
+# Any bits already set in @target will still be set after the merge.
 # On error, @target is unchanged.
 #
+# The resulting bitmap will count as dirty any clusters that were dirty in any
+# of the source bitmaps. This can be used to achieve backup checkpoints, or in
+# simpler usages, to copy bitmaps.
+#
 # Returns: nothing on success
 #          If @node is not a valid block device, DeviceNotFound
 #          If any bitmap in @bitmaps or @target is not found, GenericError
@@ -1981,7 +1988,7 @@
 ##
 # @x-debug-block-dirty-bitmap-sha256:
 #
-# Get bitmap SHA256
+# Get bitmap SHA256.
 #
 # Returns: BlockDirtyBitmapSha256 on success
 #          If @node is not a valid block device, DeviceNotFound
-- 
2.17.2
