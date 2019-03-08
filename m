Received: from eggs.gnu.org ([209.51.188.92]:44856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0000rZ-G8
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7G-0006ur-RL
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7F-0006pw-As
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:14 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:53 -0500
Message-Id: <20190308202858.26636-13-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 12/17] block/dirty-bitmap: add inconsistent
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Even though the status field is deprecated, we still have to support
it for a few more releases. Since this is a very new kind of bitmap
state, it makes sense for it to have its own status field.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190301191545.8728-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 7 ++++++-
 block/dirty-bitmap.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e639ef6d1c..ae55cd0704 100644
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
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c611bfb971..987ea7ca29 100644
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
-- 
2.17.2
