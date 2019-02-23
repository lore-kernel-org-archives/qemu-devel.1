Received: from eggs.gnu.org ([209.51.188.92]:34773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxL5B-0000D1-QF
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxL5B-0004Qu-1P
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:22:21 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Feb 2019 19:22:07 -0500
Message-Id: <20190223002209.23084-3-jsnow@redhat.com>
In-Reply-To: <20190223002209.23084-1-jsnow@redhat.com>
References: <20190223002209.23084-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] block/dirty-bitmap: add inconsistent
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Even though the status field is deprecated, we still have to support
it for a few more releases. Since this is a very new kind of bitmap
state, it makes sense for it to have its own status field.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 7 ++++++-
 qapi/block-core.json | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 9042c04788..4e8f931659 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -209,10 +209,15 @@ bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
  *               or it can be Disabled and not recording writes.
  * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
  *               in any way from the monitor.
+ * (5) Inconsistent: This is a persistent bitmap whose "in use" bit is set, and
+ *                   is unusable by QEMU. It can be deleted to remove it from
+ *                   the qcow2.
  */
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 {
-    if (bdrv_dirty_bitmap_has_successor(bitmap)) {
+    if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        return DIRTY_BITMAP_STATUS_INCONSISTENT;
+    } else if (bdrv_dirty_bitmap_has_successor(bitmap)) {
         return DIRTY_BITMAP_STATUS_FROZEN;
     } else if (bdrv_dirty_bitmap_busy(bitmap)) {
         return DIRTY_BITMAP_STATUS_LOCKED;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a7209fce22..b25ca6a6c1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -442,10 +442,15 @@
 #          recording new writes. If the bitmap was @disabled, it is not
 #          recording new writes. (Since 2.12)
 #
+# @inconsistent: This is a persistent dirty bitmap that was marked in-use on
+#                disk, and is unusable by QEMU. It can only be deleted.
+#                Please rely on the inconsistent field in @BlockDirtyInfo
+#                instead, as the status field is deprecated. (Since 4.0)
+#
 # Since: 2.4
 ##
 { 'enum': 'DirtyBitmapStatus',
-  'data': ['active', 'disabled', 'frozen', 'locked'] }
+  'data': ['active', 'disabled', 'frozen', 'locked', 'inconsistent'] }
 
 ##
 # @BlockDirtyInfo:
-- 
2.17.2
