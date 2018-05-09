Received: from eggs.gnu.org ([2001:4830:134:3::10]:56961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGQZ7-0008SX-J7
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGQZ6-0007wj-2N
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:59:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  9 May 2018 22:58:15 +0800
Message-Id: <20180509145815.3330-10-famz@redhat.com>
In-Reply-To: <20180509145815.3330-1-famz@redhat.com>
References: <20180509145815.3330-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 9/9] qemu-img: Convert with copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The new blk_co_copy_range interface offers a more efficient way in the
case of network based storage. Make use of it to allow faster convert
operation.

Since copy offloading cannot do zero detection ('-S') and compression
(-c), only try it when these options are not used.

Update 178.out.qcow2 as we are now a little more efficient on the actual
file size.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c                       | 50 ++++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/178.out.qcow2 |  8 +++----
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ea62d2d61e..9c3678ebf0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1544,6 +1544,7 @@ typedef struct ImgConvertState {
     bool compressed;
     bool target_has_backing;
     bool wr_in_order;
+    bool copy_range;
     int min_sparse;
     size_t cluster_sectors;
     size_t buf_sectors;
@@ -1737,6 +1738,37 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
     return 0;
 }
 
+static int coroutine_fn convert_co_copy_range(ImgConvertState *s, int64_t sector_num,
+                                              int nb_sectors)
+{
+    int n, ret;
+
+    while (nb_sectors > 0) {
+        BlockBackend *blk;
+        int src_cur;
+        int64_t bs_sectors, src_cur_offset;
+        int64_t offset;
+
+        convert_select_part(s, sector_num, &src_cur, &src_cur_offset);
+        offset = (sector_num - src_cur_offset) << BDRV_SECTOR_BITS;
+        blk = s->src[src_cur];
+        bs_sectors = s->src_sectors[src_cur];
+
+        n = MIN(nb_sectors, bs_sectors - (sector_num - src_cur_offset));
+
+        ret = blk_co_copy_range(blk, offset, s->target,
+                                sector_num << BDRV_SECTOR_BITS,
+                                n << BDRV_SECTOR_BITS, 0);
+        if (ret < 0) {
+            return ret;
+        }
+
+        sector_num += n;
+        nb_sectors -= n;
+    }
+    return 0;
+}
+
 static void coroutine_fn convert_co_do_copy(void *opaque)
 {
     ImgConvertState *s = opaque;
@@ -1759,6 +1791,7 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
         int n;
         int64_t sector_num;
         enum ImgConvertBlockStatus status;
+        bool copy_range;
 
         qemu_co_mutex_lock(&s->lock);
         if (s->ret != -EINPROGRESS || s->sector_num >= s->total_sectors) {
@@ -1788,7 +1821,9 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
                                         s->allocated_sectors, 0);
         }
 
-        if (status == BLK_DATA) {
+retry:
+        copy_range = s->copy_range && s->status == BLK_DATA;
+        if (status == BLK_DATA && !copy_range) {
             ret = convert_co_read(s, sector_num, n, buf);
             if (ret < 0) {
                 error_report("error while reading sector %" PRId64
@@ -1810,7 +1845,15 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
         }
 
         if (s->ret == -EINPROGRESS) {
-            ret = convert_co_write(s, sector_num, n, buf, status);
+            if (copy_range) {
+                ret = convert_co_copy_range(s, sector_num, n);
+                if (ret) {
+                    s->copy_range = false;
+                    goto retry;
+                }
+            } else {
+                ret = convert_co_write(s, sector_num, n, buf, status);
+            }
             if (ret < 0) {
                 error_report("error while writing sector %" PRId64
                              ": %s", sector_num, strerror(-ret));
@@ -1933,6 +1976,7 @@ static int img_convert(int argc, char **argv)
     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
         .min_sparse         = 8,
+        .copy_range         = true,
         .buf_sectors        = IO_BUF_SIZE / BDRV_SECTOR_SIZE,
         .wr_in_order        = true,
         .num_coroutines     = 8,
@@ -1973,6 +2017,7 @@ static int img_convert(int argc, char **argv)
             break;
         case 'c':
             s.compressed = true;
+            s.copy_range = false;
             break;
         case 'o':
             if (!is_valid_option_list(optarg)) {
@@ -2014,6 +2059,7 @@ static int img_convert(int argc, char **argv)
             }
 
             s.min_sparse = sval / BDRV_SECTOR_SIZE;
+            s.copy_range = false;
             break;
         }
         case 'p':
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
index d42d4a4597..3e72893451 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -54,7 +54,7 @@ wrote 64512/64512 bytes at offset 134217728
 required size: 589824
 fully allocated size: 1074135040
 
-converted image file size in bytes: 524288
+converted image file size in bytes: 523264
 
 == qcow2 input image with internal snapshot (human) ==
 
@@ -107,7 +107,7 @@ wrote 64512/64512 bytes at offset 134217728
 required size: 589824
 fully allocated size: 1074135040
 
-converted image file size in bytes: 524288
+converted image file size in bytes: 523264
 
 == raw input image and a backing file (human) ==
 
@@ -187,7 +187,7 @@ wrote 64512/64512 bytes at offset 134217728
     "fully-allocated": 1074135040
 }
 
-converted image file size in bytes: 524288
+converted image file size in bytes: 523264
 
 == qcow2 input image with internal snapshot (json) ==
 
@@ -254,7 +254,7 @@ wrote 64512/64512 bytes at offset 134217728
     "fully-allocated": 1074135040
 }
 
-converted image file size in bytes: 524288
+converted image file size in bytes: 523264
 
 == raw input image and a backing file (json) ==
 
-- 
2.14.3
