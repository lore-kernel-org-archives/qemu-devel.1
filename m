Received: from eggs.gnu.org ([2001:4830:134:3::10]:60324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5r-0001ia-6D
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5q-0008Oq-2g
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:35 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  9 Mar 2018 16:09:07 +0800
Message-Id: <20180309080910.7274-2-famz@redhat.com>
In-Reply-To: <20180309080910.7274-1-famz@redhat.com>
References: <20180309080910.7274-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] block: Pass "current_flags" in
 BdrvChildRole.inherit_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

So that the current flags can influence the returned flags in the coming
patches.

For now, 0 is passed everywhere and the parameter is not used.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                   | 20 +++++++++++++-------
 block/block-backend.c     |  3 ++-
 block/vvfat.c             |  3 ++-
 include/block/block_int.h |  3 ++-
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 4f76714f6b..bedbe208e6 100644
--- a/block.c
+++ b/block.c
@@ -869,7 +869,8 @@ static void bdrv_temp_snapshot_options(int *child_flags, QDict *child_options,
  * is expected, based on the given options and flags for the parent BDS
  */
 static void bdrv_inherited_options(int *child_flags, QDict *child_options,
-                                   int parent_flags, QDict *parent_options)
+                                   int parent_flags, QDict *parent_options,
+                                   int current_flags)
 {
     int flags = parent_flags;
 
@@ -913,10 +914,12 @@ const BdrvChildRole child_file = {
  * flags for the parent BDS
  */
 static void bdrv_inherited_fmt_options(int *child_flags, QDict *child_options,
-                                       int parent_flags, QDict *parent_options)
+                                       int parent_flags, QDict *parent_options,
+                                       int current_flags)
 {
     child_file.inherit_options(child_flags, child_options,
-                               parent_flags, parent_options);
+                               parent_flags, parent_options,
+                               current_flags);
 
     *child_flags &= ~(BDRV_O_PROTOCOL | BDRV_O_NO_IO);
 }
@@ -991,7 +994,8 @@ static void bdrv_backing_detach(BdrvChild *c)
  * given options and flags for the parent BDS
  */
 static void bdrv_backing_options(int *child_flags, QDict *child_options,
-                                 int parent_flags, QDict *parent_options)
+                                 int parent_flags, QDict *parent_options,
+                                 int current_flags)
 {
     int flags = parent_flags;
 
@@ -2548,7 +2552,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     if (child_role) {
         bs->inherits_from = parent;
         child_role->inherit_options(&flags, options,
-                                    parent->open_flags, parent->options);
+                                    parent->open_flags, parent->options,
+                                    0);
     }
 
     ret = bdrv_fill_options(&options, filename, &flags, &local_err);
@@ -2576,7 +2581,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                    flags, options);
         /* Let bdrv_backing_options() override "read-only" */
         qdict_del(options, BDRV_OPT_READ_ONLY);
-        bdrv_backing_options(&flags, options, flags, options);
+        bdrv_backing_options(&flags, options, flags, options, 0);
     }
 
     bs->open_flags = flags;
@@ -2837,7 +2842,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     /* Inherit from parent node */
     if (parent_options) {
         assert(!flags);
-        role->inherit_options(&flags, options, parent_flags, parent_options);
+        role->inherit_options(&flags, options, parent_flags, parent_options,
+                              0);
     }
 
     /* Old values are used for options that aren't set yet */
diff --git a/block/block-backend.c b/block/block-backend.c
index b3c790e2bd..a9a72f5aa8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -107,7 +107,8 @@ static QTAILQ_HEAD(, BlockBackend) monitor_block_backends =
     QTAILQ_HEAD_INITIALIZER(monitor_block_backends);
 
 static void blk_root_inherit_options(int *child_flags, QDict *child_options,
-                                     int parent_flags, QDict *parent_options)
+                                     int parent_flags, QDict *parent_options,
+                                     int current_flags)
 {
     /* We're not supposed to call this function for root nodes */
     abort();
diff --git a/block/vvfat.c b/block/vvfat.c
index 4a17a49e12..ae90aa0af0 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3126,7 +3126,8 @@ static BlockDriver vvfat_write_target = {
 };
 
 static void vvfat_qcow_options(int *child_flags, QDict *child_options,
-                               int parent_flags, QDict *parent_options)
+                               int parent_flags, QDict *parent_options,
+                               int current_flags)
 {
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "off");
     *child_flags = BDRV_O_NO_FLUSH;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 64a5700f2b..fcda7220a2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -535,7 +535,8 @@ struct BdrvChildRole {
     bool stay_at_node;
 
     void (*inherit_options)(int *child_flags, QDict *child_options,
-                            int parent_flags, QDict *parent_options);
+                            int parent_flags, QDict *parent_options,
+                            int current_flags);
 
     void (*change_media)(BdrvChild *child, bool load);
     void (*resize)(BdrvChild *child);
-- 
2.14.3
