Received: from eggs.gnu.org ([2001:4830:134:3::10]:33137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elaG0-0007kS-8L
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elaFz-0006hy-54
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:04:24 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Feb 2018 14:03:55 +0100
Message-Id: <20180213130356.8885-7-mreitz@redhat.com>
In-Reply-To: <20180213130356.8885-1-mreitz@redhat.com>
References: <20180213130356.8885-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] sheepdog: Pass old and new size to
 sd_prealloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, sheepdog@lists.wpkg.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>

sd_prealloc() will now preallocate the area [old_size, new_size).  As
before, it rounds to buf_size and may thus overshoot and preallocate
areas that were not requested to be preallocated.  For image creation,
this is no change in behavior.  For truncation, this is in accordance
with the documentation for preallocated truncation.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/sheepdog.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index cc1d37b3da..d300fb69c0 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1826,14 +1826,14 @@ static int do_sd_create(BDRVSheepdogState *s, uint32_t *vdi_id, int snapshot,
     return 0;
 }
 
-static int sd_prealloc(BlockDriverState *bs, Error **errp)
+static int sd_prealloc(BlockDriverState *bs, int64_t old_size, int64_t new_size,
+                       Error **errp)
 {
     BlockBackend *blk = NULL;
     BDRVSheepdogState *base = bs->opaque;
     unsigned long buf_size;
     uint32_t idx, max_idx;
     uint32_t object_size;
-    int64_t vdi_size;
     void *buf = NULL;
     int ret;
 
@@ -1847,19 +1847,13 @@ static int sd_prealloc(BlockDriverState *bs, Error **errp)
 
     blk_set_allow_write_beyond_eof(blk, true);
 
-    vdi_size = blk_getlength(blk);
-    if (vdi_size < 0) {
-        ret = vdi_size;
-        goto out;
-    }
-
     object_size = (UINT32_C(1) << base->inode.block_size_shift);
     buf_size = MIN(object_size, SD_DATA_OBJ_SIZE);
     buf = g_malloc0(buf_size);
 
-    max_idx = DIV_ROUND_UP(vdi_size, buf_size);
+    max_idx = DIV_ROUND_UP(new_size, buf_size);
 
-    for (idx = 0; idx < max_idx; idx++) {
+    for (idx = old_size / buf_size; idx < max_idx; idx++) {
         /*
          * The created image can be a cloned image, so we need to read
          * a data from the source image.
@@ -2119,7 +2113,7 @@ static int sd_create(const char *filename, QemuOpts *opts,
             goto out;
         }
 
-        ret = sd_prealloc(bs, errp);
+        ret = sd_prealloc(bs, 0, s->inode.vdi_size, errp);
 
         bdrv_unref(bs);
     }
-- 
2.14.3
