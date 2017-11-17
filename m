Received: from eggs.gnu.org ([2001:4830:134:3::10]:42785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCO-0000ow-OO
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCN-0002D0-Dm
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:33 +0100
Message-Id: <20171117181653.20651-6-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/25] block: Deprecate bdrv_set_read_only() and
 users
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

bdrv_set_read_only() is used by some block drivers to override the
read-only option given by the user. This is not how read-only images
generally work in QEMU: Instead of second guessing what the user really
meant (which currently includes making an image read-only even if the
user didn't only use the default, but explicitly said read-only=off), we
should error out if we can't provide what the user requested.

This adds deprecation warnings to all callers of bdrv_set_read_only() so
that the behaviour can be corrected after the usual deprecation period.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  7 +++++--
 block.c              |  5 +++++
 block/bochs.c        | 13 ++++++++++---
 block/cloop.c        | 13 ++++++++++---
 block/dmg.c          | 12 +++++++++---
 block/rbd.c          | 14 ++++++++++----
 block/vvfat.c        |  6 +++++-
 7 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab96e348e6..76bf50f813 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3134,8 +3134,11 @@
 #                 This option is required on the top level of blockdev-add.
 # @discard:       discard-related options (default: ignore)
 # @cache:         cache-related options
-# @read-only:     whether the block device should be read-only
-#                 (default: false)
+# @read-only:     whether the block device should be read-only (default: false).
+#                 Note that some block drivers support only read-only access,
+#                 either generally or in certain configurations. In this case,
+#                 the default value does not work and the option must be
+#                 specified explicitly.
 # @detect-zeroes: detect and optimize zero writes (Since 2.1)
 #                 (default: off)
 # @force-share:   force share all permission on added nodes.
diff --git a/block.c b/block.c
index f6415547fe..0ed0c27140 100644
--- a/block.c
+++ b/block.c
@@ -261,6 +261,11 @@ int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
     return 0;
 }
 
+/* TODO Remove (deprecated since 2.11)
+ * Block drivers are not supposed to automatically change bs->read_only.
+ * Instead, they should just check whether they can provide what the user
+ * explicitly requested and error out if read-write is requested, but they can
+ * only provide read-only access. */
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
 {
     int ret = 0;
diff --git a/block/bochs.c b/block/bochs.c
index a759b6eff0..50c630047b 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -28,6 +28,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/bswap.h"
+#include "qemu/error-report.h"
 
 /**************************************************************/
 
@@ -110,9 +111,15 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    ret = bdrv_set_read_only(bs, true, errp); /* no write support yet */
-    if (ret < 0) {
-        return ret;
+    if (!bdrv_is_read_only(bs)) {
+        error_report("Opening bochs images without an explicit read-only=on "
+                     "option is deprecated. Future versions will refuse to "
+                     "open the image instead of automatically marking the "
+                     "image read-only.");
+        ret = bdrv_set_read_only(bs, true, errp); /* no write support yet */
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     ret = bdrv_pread(bs->file, 0, &bochs, sizeof(bochs));
diff --git a/block/cloop.c b/block/cloop.c
index d6597fcf78..2be68987bd 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -23,6 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
@@ -72,9 +73,15 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    ret = bdrv_set_read_only(bs, true, errp);
-    if (ret < 0) {
-        return ret;
+    if (!bdrv_is_read_only(bs)) {
+        error_report("Opening cloop images without an explicit read-only=on "
+                     "option is deprecated. Future versions will refuse to "
+                     "open the image instead of automatically marking the "
+                     "image read-only.");
+        ret = bdrv_set_read_only(bs, true, errp);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     /* read header */
diff --git a/block/dmg.c b/block/dmg.c
index 6c0711f563..c9b3c519c4 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -419,9 +419,15 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    ret = bdrv_set_read_only(bs, true, errp);
-    if (ret < 0) {
-        return ret;
+    if (!bdrv_is_read_only(bs)) {
+        error_report("Opening dmg images without an explicit read-only=on "
+                     "option is deprecated. Future versions will refuse to "
+                     "open the image instead of automatically marking the "
+                     "image read-only.");
+        ret = bdrv_set_read_only(bs, true, errp);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     block_module_load_one("dmg-bz2");
diff --git a/block/rbd.c b/block/rbd.c
index 144f350e1f..a76a5e8755 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -665,10 +665,16 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     /* If we are using an rbd snapshot, we must be r/o, otherwise
      * leave as-is */
     if (s->snap != NULL) {
-        r = bdrv_set_read_only(bs, true, &local_err);
-        if (r < 0) {
-            error_propagate(errp, local_err);
-            goto failed_open;
+        if (!bdrv_is_read_only(bs)) {
+            error_report("Opening rbd snapshots without an explicit "
+                         "read-only=on option is deprecated. Future versions "
+                         "will refuse to open the image instead of "
+                         "automatically marking the image read-only.");
+            r = bdrv_set_read_only(bs, true, &local_err);
+            if (r < 0) {
+                error_propagate(errp, local_err);
+                goto failed_open;
+            }
         }
     }
 
diff --git a/block/vvfat.c b/block/vvfat.c
index a0f2335894..0841cc42fc 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1259,7 +1259,11 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                        "Unable to set VVFAT to 'rw' when drive is read-only");
             goto fail;
         }
-    } else  {
+    } else  if (!bdrv_is_read_only(bs)) {
+        error_report("Opening non-rw vvfat images without an explicit "
+                     "read-only=on option is deprecated. Future versions "
+                     "will refuse to open the image instead of "
+                     "automatically marking the image read-only.");
         /* read only is the default for safety */
         ret = bdrv_set_read_only(bs, true, &local_err);
         if (ret < 0) {
-- 
2.13.6
