Received: from eggs.gnu.org ([209.51.188.92]:33353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gpjpm-0005sW-2h
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gpjpj-0007ic-SQ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:11:01 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  1 Feb 2019 20:10:48 -0500
Message-Id: <20190202011048.12343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2] block/dirty-bitmap: Documentation and
 Comment fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>

The meaning of the states has changed subtly over time,
this should bring the understanding more in-line with the
current, actual usages.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>

---
V2: Amended some wordings, though this is a little chatty now.
    Hopefully it's clearer, though.
---
 block/dirty-bitmap.c | 20 ++++++++++++++------
 qapi/block-core.json | 32 ++++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 00ea36f554..b1b9b03939 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -29,12 +29,20 @@
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
+ * (3) Frozen:   successor is not NULL.
+ *               A frozen bitmap cannot be renamed, deleted, cleared, set,
+ *               enabled, merged to, etc. A frozen bitmap can only abdicate()
+ *               or reclaim().
+ *               In this state, the anonymous successor bitmap may be either
+ *               Active and recording writes from the guest (e.g. backup jobs),
+ *               but it can be Disabled and not recording writes.
+ * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
+ *               in any way from the monitor.
  */
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5f17d67d71..a775af04cf 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -417,17 +417,27 @@
 #
 # An enumeration of possible states that a dirty bitmap can report to the user.
 #
-# @frozen: The bitmap is currently in-use by a backup operation or block job,
-#          and is immutable.
+# @frozen: The bitmap is currently in-use by some operation and is immutable.
+#          If the bitmap was @active prior to the operation, new writes by the
+#          guest are being recorded in a temporary buffer, and will not be lost.
+#          Generally, bitmaps are cleared on successful use in an operation and
+#          the temporary buffer is committed into the bitmap. On failure, the
+#          temporary buffer is merged back into the bitmap without first
+#          clearing it.
+#          Please refer to the documentation for each bitmap-using operation,
+#          See also @blockdev-backup, @drive-backup.
 #
-# @disabled: The bitmap is currently in-use by an internal operation and is
-#            read-only. It can still be deleted.
+# @disabled: The bitmap is not currently recording new writes by the guest.
+#            This is requested explicitly via @block-dirty-bitmap-disable.
+#            It can still be cleared, deleted, or used for backup operations.
 #
 # @active: The bitmap is actively monitoring for new writes, and can be cleared,
 #          deleted, or used for backup operations.
 #
-# @locked: The bitmap is currently in-use by some operation and can not be
-#          cleared, deleted, or used for backup operations. (Since 2.12)
+# @locked: The bitmap is currently in-use by some operation and is immutable.
+#          If the bitmap was @active prior to the operation, it is still
+#          recording new writes. If the bitmap was @disabled, it is not
+#          recording new writes. (Since 2.12)
 #
 # Since: 2.4
 ##
@@ -2052,9 +2062,15 @@
 # @block-dirty-bitmap-merge:
 #
 # Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
-# The @bitmaps dirty bitmaps are unchanged.
+# Dirty bitmaps in @bitmaps will be unchanged, except if it also appears
+# as the @target bitmap. Any bits already set in @target will still be
+# set after the merge, i.e., this operation does not clear the target.
 # On error, @target is unchanged.
 #
+# The resulting bitmap will count as dirty any clusters that were dirty in any
+# of the source bitmaps. This can be used to achieve backup checkpoints, or in
+# simpler usages, to copy bitmaps.
+#
 # Returns: nothing on success
 #          If @node is not a valid block device, DeviceNotFound
 #          If any bitmap in @bitmaps or @target is not found, GenericError
@@ -2089,7 +2105,7 @@
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
