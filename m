Received: from eggs.gnu.org ([2001:4830:134:3::10]:40136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQHAu-00035Y-Kx
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQHAt-0005RA-GD
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:59:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  5 Jun 2018 14:59:05 -0400
Message-Id: <20180605185905.4583-6-jsnow@redhat.com>
In-Reply-To: <20180605185905.4583-1-jsnow@redhat.com>
References: <20180605185905.4583-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] qapi: add disabled parameter to
 block-dirty-bitmap-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is needed, for example, to create a new bitmap and merge several
disabled bitmaps into a new one. Without this flag we will have to
put block-dirty-bitmap-add and block-dirty-bitmap-disable into one
transaction.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 10 ++++++++++
 qapi/block-core.json |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index b00908fdfd..03e7cbeea1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2073,6 +2073,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
                                action->has_granularity, action->granularity,
                                action->has_persistent, action->persistent,
                                action->has_autoload, action->autoload,
+                               action->has_x_disabled, action->x_disabled,
                                &local_err);
 
     if (!local_err) {
@@ -2880,6 +2881,7 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
                                 bool has_persistent, bool persistent,
                                 bool has_autoload, bool autoload,
+                                bool has_disabled, bool disabled,
                                 Error **errp)
 {
     BlockDriverState *bs;
@@ -2914,6 +2916,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         warn_report("Autoload option is deprecated and its value is ignored");
     }
 
+    if (!has_disabled) {
+        disabled = false;
+    }
+
     if (persistent &&
         !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
     {
@@ -2925,6 +2931,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         return;
     }
 
+    if (disabled) {
+        bdrv_disable_dirty_bitmap(bitmap);
+    }
+
     bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3999175c23..f06a43bfb2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1734,11 +1734,15 @@
 #            Currently, all dirty tracking bitmaps are loaded from Qcow2 on
 #            open.
 #
+# @x-disabled: the bitmap is created in the disabled state, which means that
+#              it will not track drive changes. The bitmap may be enabled with
+#              x-block-dirty-bitmap-enable. Default is false. (Since: 3.0)
+#
 # Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
-            '*persistent': 'bool', '*autoload': 'bool' } }
+            '*persistent': 'bool', '*autoload': 'bool', '*x-disabled': 'bool' } }
 
 ##
 # @BlockDirtyBitmapMerge:
-- 
2.14.3
