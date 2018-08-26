Received: from eggs.gnu.org ([2001:4830:134:3::10]:60105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082l-FW
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006yM-3T
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:40 +0300
Message-Id: <c3e00bed732f1a08edff79aee79669f3572352b8.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 9/9] block: Allow changing 'force-share' on
 reopen
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

'force-share' is one of the basic BlockdevOptions available for all
drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
the user cannot change it and doesn't get an error explaining that it
can't be changed.

One example of how this option is being ignored is that on a
read-write image this should produce an error:

   (qemu) qemu-io virtio0 "reopen -o force-share=on"
   force-share=on can only be used with read-only images

Since there's no reason why we shouldn't allow changing it and the
implementation is simple let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 30 ++++++++++++++++++++++++------
 include/block/block.h |  1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 9aed5c19f4..b6e495b716 100644
--- a/block.c
+++ b/block.c
@@ -788,6 +788,18 @@ static BlockdevDetectZeroesOptions bdrv_parse_detect_zeroes(QemuOpts *opts,
     return detect_zeroes;
 }
 
+static bool bdrv_parse_force_share(QemuOpts *opts, int flags, Error **errp)
+{
+    bool value = qemu_opt_get_bool(opts, BDRV_OPT_FORCE_SHARE, false);
+
+    if (value && (flags & BDRV_O_RDWR)) {
+        error_setg(errp, BDRV_OPT_FORCE_SHARE
+                   "=on can only be used with read-only images");
+    }
+
+    return value;
+}
+
 /**
  * Set open flags for a given discard mode
  *
@@ -1373,12 +1385,9 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     drv = bdrv_find_format(driver_name);
     assert(drv != NULL);
 
-    bs->force_share = qemu_opt_get_bool(opts, BDRV_OPT_FORCE_SHARE, false);
-
-    if (bs->force_share && (bs->open_flags & BDRV_O_RDWR)) {
-        error_setg(errp,
-                   BDRV_OPT_FORCE_SHARE
-                   "=on can only be used with read-only images");
+    bs->force_share = bdrv_parse_force_share(opts, bs->open_flags, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail_opts;
     }
@@ -3201,6 +3210,14 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         goto error;
     }
 
+    reopen_state->force_share =
+        bdrv_parse_force_share(opts, reopen_state->flags, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* node-name and driver must be unchanged. Put them back into the QDict, so
      * that they are checked at the end of this function. */
     value = qemu_opt_get(opts, "node-name");
@@ -3359,6 +3376,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->open_flags         = reopen_state->flags;
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
     bs->detect_zeroes      = reopen_state->detect_zeroes;
+    bs->force_share        = reopen_state->force_share;
 
     /* Remove child references from bs->options and bs->explicit_options */
     QLIST_FOREACH(child, &bs->children, next) {
diff --git a/include/block/block.h b/include/block/block.h
index f71fa5a1c4..a49a027c54 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -185,6 +185,7 @@ typedef struct BDRVReopenState {
     BlockDriverState *bs;
     int flags;
     BlockdevDetectZeroesOptions detect_zeroes;
+    bool force_share;
     uint64_t perm, shared_perm;
     QDict *options;
     QDict *explicit_options;
-- 
2.11.0
