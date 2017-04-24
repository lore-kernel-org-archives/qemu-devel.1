Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d2jWx-0001WO-2M
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d2jWv-0002fa-Rp
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:20:15 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 24 Apr 2017 15:19:54 -0400
Message-Id: <20170424192002.18622-5-jcody@redhat.com>
In-Reply-To: <20170424192002.18622-1-jcody@redhat.com>
References: <20170424192002.18622-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/12] block: add bdrv_set_read_only() helper
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

We have a helper wrapper for checking for the BDS read_only flag,
add a helper wrapper to set the read_only flag as well.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 9b18972d05f5fa2ac16c014f0af98d680553048d.1491597120.git.jcody@redhat.com
---
 block.c               | 5 +++++
 block/bochs.c         | 2 +-
 block/cloop.c         | 2 +-
 block/dmg.c           | 2 +-
 block/rbd.c           | 2 +-
 block/vvfat.c         | 4 ++--
 include/block/block.h | 1 +
 7 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 7eda9a4..6f21145 100644
--- a/block.c
+++ b/block.c
@@ -192,6 +192,11 @@ void path_combine(char *dest, int dest_size,
     }
 }
 
+void bdrv_set_read_only(BlockDriverState *bs, bool read_only)
+{
+    bs->read_only = read_only;
+}
+
 void bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                   const char *backing,
                                                   char *dest, size_t sz,
diff --git a/block/bochs.c b/block/bochs.c
index 516da56..bdc2831 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -110,7 +110,7 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    bs->read_only = true; /* no write support yet */
+    bdrv_set_read_only(bs, true); /* no write support yet */
 
     ret = bdrv_pread(bs->file, 0, &bochs, sizeof(bochs));
     if (ret < 0) {
diff --git a/block/cloop.c b/block/cloop.c
index a6c7b9d..11f17c8 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -72,7 +72,7 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    bs->read_only = true;
+    bdrv_set_read_only(bs, true);
 
     /* read header */
     ret = bdrv_pread(bs->file, 128, &s->block_size, 4);
diff --git a/block/dmg.c b/block/dmg.c
index a7d25fc..27ce4a6 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -420,7 +420,7 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     block_module_load_one("dmg-bz2");
-    bs->read_only = true;
+    bdrv_set_read_only(bs, true);
 
     s->n_chunks = 0;
     s->offsets = s->lengths = s->sectors = s->sectorcounts = NULL;
diff --git a/block/rbd.c b/block/rbd.c
index 1ceeeb5..6ad2904 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -641,7 +641,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_open;
     }
 
-    bs->read_only = (s->snap != NULL);
+    bdrv_set_read_only(bs, (s->snap != NULL));
 
     qemu_opts_del(opts);
     return 0;
diff --git a/block/vvfat.c b/block/vvfat.c
index af5153d..d4ce6d7 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1157,7 +1157,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     s->current_cluster=0xffffffff;
 
     /* read only is the default for safety */
-    bs->read_only = true;
+    bdrv_set_read_only(bs, true);
     s->qcow = NULL;
     s->qcow_filename = NULL;
     s->fat2 = NULL;
@@ -1173,7 +1173,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         if (ret < 0) {
             goto fail;
         }
-        bs->read_only = false;
+        bdrv_set_read_only(bs, false);
     }
 
     bs->total_sectors = cyls * heads * secs;
diff --git a/include/block/block.h b/include/block/block.h
index 466de49..99d49f2 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -434,6 +434,7 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t sector_num, int nb_sectors, int *pnum);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
+void bdrv_set_read_only(BlockDriverState *bs, bool read_only);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
 int bdrv_media_changed(BlockDriverState *bs);
-- 
2.9.3
