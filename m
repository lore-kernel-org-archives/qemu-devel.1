Received: from eggs.gnu.org ([2001:4830:134:3::10]:42464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLK6B-0002PT-8M
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLK6A-0004je-80
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:05:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 23 May 2018 11:04:36 +0800
Message-Id: <20180523030436.29097-11-famz@redhat.com>
In-Reply-To: <20180523030436.29097-1-famz@redhat.com>
References: <20180523030436.29097-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/10] qemu-img: Convert with copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

The new blk_co_copy_range interface offers a more efficient way in the
case of network based storage. Make use of it to allow faster convert
operation.

Since copy offloading cannot do zero detection ('-S') and compression
(-c), only try it when these options are not used.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-img.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2b5a5706b6..67f3631a81 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1543,6 +1543,7 @@ typedef struct ImgConvertState {
     bool compressed;
     bool target_has_backing;
     bool wr_in_order;
+    bool copy_range;
     int min_sparse;
     size_t cluster_sectors;
     size_t buf_sectors;
@@ -1736,6 +1737,37 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
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
@@ -1758,6 +1790,7 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
         int n;
         int64_t sector_num;
         enum ImgConvertBlockStatus status;
+        bool copy_range;
 
         qemu_co_mutex_lock(&s->lock);
         if (s->ret != -EINPROGRESS || s->sector_num >= s->total_sectors) {
@@ -1787,7 +1820,9 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
                                         s->allocated_sectors, 0);
         }
 
-        if (status == BLK_DATA) {
+retry:
+        copy_range = s->copy_range && s->status == BLK_DATA;
+        if (status == BLK_DATA && !copy_range) {
             ret = convert_co_read(s, sector_num, n, buf);
             if (ret < 0) {
                 error_report("error while reading sector %" PRId64
@@ -1809,7 +1844,15 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
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
@@ -1932,6 +1975,7 @@ static int img_convert(int argc, char **argv)
     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
         .min_sparse         = 8,
+        .copy_range         = true,
         .buf_sectors        = IO_BUF_SIZE / BDRV_SECTOR_SIZE,
         .wr_in_order        = true,
         .num_coroutines     = 8,
@@ -1972,6 +2016,7 @@ static int img_convert(int argc, char **argv)
             break;
         case 'c':
             s.compressed = true;
+            s.copy_range = false;
             break;
         case 'o':
             if (!is_valid_option_list(optarg)) {
@@ -2013,6 +2058,7 @@ static int img_convert(int argc, char **argv)
             }
 
             s.min_sparse = sval / BDRV_SECTOR_SIZE;
+            s.copy_range = false;
             break;
         }
         case 'p':
-- 
2.14.3
