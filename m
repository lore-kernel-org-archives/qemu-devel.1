Received: from eggs.gnu.org ([2001:4830:134:3::10]:38325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbQ-0006hl-5E
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbO-0003Q3-Lf
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:48 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 25 Aug 2017 16:23:27 +0300
Message-Id: <20170825132332.6734-3-el13635@mail.ntua.gr>
In-Reply-To: <20170825132332.6734-1-el13635@mail.ntua.gr>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 2/7] block: add options parameter to
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
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Allow passing a QDict *options parameter to bdrv_new_open_driver() so
that it can be used if a driver needs it upon creation. The previous
behaviour (empty bs->options and bs->explicit_options) remains when
options is NULL.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 include/block/block.h |  2 +-
 block.c               | 16 +++++++++++++---
 block/commit.c        |  4 ++--
 block/mirror.c        |  2 +-
 block/vvfat.c         |  2 +-
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index ab80195378..d1f03cb48b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -263,7 +263,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 BlockDriverState *bdrv_open(const char *filename, const char *reference,
                             QDict *options, int flags, Error **errp);
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
-                                       int flags, Error **errp);
+                                       int flags, QDict *options, Error **errp);
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, int flags);
diff --git a/block.c b/block.c
index e35d546c08..2de1c29eb3 100644
--- a/block.c
+++ b/block.c
@@ -1153,16 +1153,26 @@ open_failed:
     return ret;
 }
 
+/*
+ * If options is not NULL, its ownership is transferred to the block layer. The
+ * caller must use QINCREF() if they wish to keep ownership.
+ */
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
+        QDECREF(options);
+    } else {
+        bs->explicit_options = qdict_new();
+        bs->options = qdict_new();
+    }
     bs->opaque = NULL;
 
     update_options_from_flags(bs->options, flags);
diff --git a/block/commit.c b/block/commit.c
index c7857c3321..539e23c3f8 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -342,7 +342,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     /* Insert commit_top block node above top, so we can block consistent read
      * on the backing chain below it */
     commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, filter_node_name, 0,
-                                         errp);
+                                         NULL, errp);
     if (commit_top_bs == NULL) {
         goto fail;
     }
@@ -494,7 +494,7 @@ int bdrv_commit(BlockDriverState *bs)
     backing_file_bs = backing_bs(bs);
 
     commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_O_RDWR,
-                                         &local_err);
+                                         NULL, &local_err);
     if (commit_top_bs == NULL) {
         error_report_err(local_err);
         goto ro_cleanup;
diff --git a/block/mirror.c b/block/mirror.c
index c9a6a3ca86..e1a160e6ea 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1164,7 +1164,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
      * reads on the top, while disabling it in the intermediate nodes, and make
      * the backing chain writable. */
     mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
-                                         BDRV_O_RDWR, errp);
+                                         BDRV_O_RDWR, NULL, errp);
     if (mirror_top_bs == NULL) {
         return;
     }
diff --git a/block/vvfat.c b/block/vvfat.c
index a9e207f7f0..6c59473baf 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3194,7 +3194,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
 #endif
 
     backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
-                                   &error_abort);
+                                   NULL, &error_abort);
     *(void**) backing->opaque = s;
 
     bdrv_set_backing_hd(s->bs, backing, &error_abort);
-- 
2.11.0
