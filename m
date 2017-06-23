Received: from eggs.gnu.org ([2001:4830:134:3::10]:60056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0p-0001aI-1k
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0n-0004SE-50
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:35 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:46:58 +0300
Message-Id: <20170623124700.1389-7-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 6/8] block: add options parameter to
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

Allow passing a QDict *options parameter to bdrv_new_open_driver() so
that it can be used if a driver needs it upon creation. The previous
behaviour (empty bs->options and bs->explicit_options) remains when
options is NULL.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c               | 13 +++++++++----
 block/commit.c        |  4 ++--
 block/mirror.c        |  2 +-
 block/vvfat.c         |  2 +-
 include/block/block.h |  2 +-
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index 694396281b..c7d9f8959a 100644
--- a/block.c
+++ b/block.c
@@ -1150,20 +1150,25 @@ free_and_fail:
 }
 
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
-                                       int flags, Error **errp)
+                                       int flags, QDict *options, Error **errp)
 {
     BlockDriverState *bs;
     int ret;
 
     bs = bdrv_new();
     bs->open_flags = flags;
-    bs->explicit_options = qdict_new();
-    bs->options = qdict_new();
+    if (options) {
+        bs->explicit_options = qdict_clone_shallow(options);
+        bs->options = qdict_clone_shallow(options);
+    } else {
+        bs->explicit_options = qdict_new();
+        bs->options = qdict_new();
+    }
     bs->opaque = NULL;
 
     update_options_from_flags(bs->options, flags);
 
-    ret = bdrv_open_driver(bs, drv, node_name, bs->options, flags, errp);
+    ret = bdrv_open_driver(bs, drv, node_name, options, flags, errp);
     if (ret < 0) {
         QDECREF(bs->explicit_options);
         QDECREF(bs->options);
diff --git a/block/commit.c b/block/commit.c
index af6fa68cf3..e855f20d7f 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -338,7 +338,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     /* Insert commit_top block node above top, so we can block consistent read
      * on the backing chain below it */
     commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, filter_node_name, 0,
-                                         errp);
+                                         NULL, errp);
     if (commit_top_bs == NULL) {
         goto fail;
     }
@@ -486,7 +486,7 @@ int bdrv_commit(BlockDriverState *bs)
     backing_file_bs = backing_bs(bs);
 
     commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_O_RDWR,
-                                         &local_err);
+                                         NULL, &local_err);
     if (commit_top_bs == NULL) {
         error_report_err(local_err);
         goto ro_cleanup;
diff --git a/block/mirror.c b/block/mirror.c
index 19afcc6f1a..3ebe953f18 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1155,7 +1155,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
      * reads on the top, while disabling it in the intermediate nodes, and make
      * the backing chain writable. */
     mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
-                                         BDRV_O_RDWR, errp);
+                                         BDRV_O_RDWR, NULL, errp);
     if (mirror_top_bs == NULL) {
         return;
     }
diff --git a/block/vvfat.c b/block/vvfat.c
index 8ab647c0c6..c8e8944947 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3064,7 +3064,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
 #endif
 
     backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
-                                   &error_abort);
+                                   NULL, &error_abort);
     *(void**) backing->opaque = s;
 
     bdrv_set_backing_hd(s->bs, backing, &error_abort);
diff --git a/include/block/block.h b/include/block/block.h
index a4f09df95a..e7db67c059 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -261,7 +261,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 BlockDriverState *bdrv_open(const char *filename, const char *reference,
                             QDict *options, int flags, Error **errp);
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
-                                       int flags, Error **errp);
+                                       int flags, QDict *options, Error **errp);
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, int flags);
-- 
2.11.0
