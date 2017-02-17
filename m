Received: from eggs.gnu.org ([2001:4830:134:3::10]:45894)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cekxW-0002Kj-1W
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cekxS-0008MZ-M8
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:00:34 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:53177 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cekxS-0008Kd-9s
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:00:30 -0500
From: Peter Lieven <pl@kamp.de>
Date: Fri, 17 Feb 2017 17:00:24 +0100
Message-Id: <1487347224-8667-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [RFC PATCH V4] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com, Peter Lieven <pl@kamp.de>

this is something I have been thinking about for almost 2 years now.
we heavily have the following two use cases when using qemu-img convert.

a) reading from NFS and writing to iSCSI for deploying templates
b) reading from iSCSI and writing to NFS for backups

In both processes we use libiscsi and libnfs so we have no kernel pagecache.
As qemu-img convert is implemented with sync operations that means we
read one buffer and then write it. No parallelism and each sync request
takes as long as it takes until it is completed.

This is version 4 of the approach using coroutine worker "threads".

So far I have the following runtimes when reading an uncompressed QCOW2 from
NFS and writing it to iSCSI (raw):

qemu-img (master)
 nfs -> iscsi 22.8 secs
 nfs -> ram   11.7 secs
 ram -> iscsi 12.3 secs

qemu-img-async (8 coroutines, in-order write disabled)
 nfs -> iscsi 11.0 secs
 nfs -> ram   10.4 secs
 ram -> iscsi  9.0 secs

The following are the runtimes found with different settings between V3 and V4.
This is always the best runtime out of 10 runs when converting from nfs to iscsi.
Please note that in V4 in-order write scenarios show a very high jitter. I think
this is because the get_block_status on the NFS share is delayed by concurrent read
requests.

                       in-order        out-of-order
V3  - 16 coroutines    12.4 seconds    11.1 seconds
    -  8 coroutines    12.2 seconds    11.3 seconds
    -  4 coroutines    12.5 seconds    11.1 seconds
    -  2 coroutines    14.8 seconds    14.9 seconds

V4  - 32 coroutines    15.9 seconds    11.5 seconds
    - 16 coroutines    12.5 seconds    11.0 seconds
    -  8 coroutines    12.9 seconds    11.0 seconds
    -  4 coroutines    14.1 seconds    11.5 seconds
    -  2 coroutines    16.9 seconds    13.2 seconds

Comments appreciated.

Thank you,
Peter

Signed-off-by: Peter Lieven <pl@kamp.de>
---
v3->v4: - avoid to prepare a request queue upfront [Kevin]
        - do not ignore the BLK_BACKING_FILE status [Kevin]
        - redesign the interface to the read and write routines [Kevin]

v2->v3: - updated stats in the commit msg from a host with a better network card
        - only wake up the coroutine that is acutally waiting for a write to complete.
          this was not only overhead, but also breaking at least linux AIO.
        - fix coding style complaints
        - rename some variables and structs

v1->v2: - using coroutine as worker "threads". [Max]
        - keeping the request queue as otherwise it happens
          that we wait on BLK_ZERO chunks while keeping the write order.
          it also avoids redundant calls to get_block_status and helps
          to skip some conditions for fully allocated imaged (!s->min_sparse)
---
 qemu-img.c | 260 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 187 insertions(+), 73 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index cff22e3..6bac980 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1448,6 +1448,8 @@ enum ImgConvertBlockStatus {
     BLK_BACKING_FILE,
 };
 
+#define MAX_COROUTINES 16
+
 typedef struct ImgConvertState {
     BlockBackend **src;
     int64_t *src_sectors;
@@ -1455,15 +1457,25 @@ typedef struct ImgConvertState {
     int64_t src_cur_offset;
     int64_t total_sectors;
     int64_t allocated_sectors;
+    int64_t allocated_done;
+    int64_t sector_num;
+    int64_t wr_offs;
     enum ImgConvertBlockStatus status;
     int64_t sector_next_status;
     BlockBackend *target;
     bool has_zero_init;
     bool compressed;
     bool target_has_backing;
+    bool wr_in_order;
     int min_sparse;
     size_t cluster_sectors;
     size_t buf_sectors;
+    int num_coroutines;
+    int running_coroutines;
+    Coroutine *co[MAX_COROUTINES];
+    int64_t wait_sector_num[MAX_COROUTINES];
+    CoMutex lock;
+    int ret;
 } ImgConvertState;
 
 static void convert_select_part(ImgConvertState *s, int64_t sector_num)
@@ -1544,11 +1556,12 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     return n;
 }
 
-static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
-                        uint8_t *buf)
+static int convert_co_read(ImgConvertState *s, int64_t sector_num,
+                           int nb_sectors, uint8_t *buf)
 {
-    int n;
-    int ret;
+    int n, ret;
+    QEMUIOVector qiov;
+    struct iovec iov;
 
     assert(nb_sectors <= s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1563,9 +1576,13 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
         bs_sectors = s->src_sectors[s->src_cur];
 
         n = MIN(nb_sectors, bs_sectors - (sector_num - s->src_cur_offset));
-        ret = blk_pread(blk,
-                        (sector_num - s->src_cur_offset) << BDRV_SECTOR_BITS,
-                        buf, n << BDRV_SECTOR_BITS);
+        iov.iov_base = buf;
+        iov.iov_len = n << BDRV_SECTOR_BITS;
+        qemu_iovec_init_external(&qiov, &iov, 1);
+
+        ret = blk_co_preadv(
+                blk, (sector_num - s->src_cur_offset) << BDRV_SECTOR_BITS,
+                n << BDRV_SECTOR_BITS, &qiov, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1578,15 +1595,18 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
     return 0;
 }
 
-static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
-                         const uint8_t *buf)
+
+static int convert_co_write(ImgConvertState *s, int64_t sector_num,
+                            int nb_sectors, uint8_t *buf,
+                            enum ImgConvertBlockStatus status)
 {
     int ret;
+    QEMUIOVector qiov;
+    struct iovec iov;
 
     while (nb_sectors > 0) {
         int n = nb_sectors;
-
-        switch (s->status) {
+        switch (status) {
         case BLK_BACKING_FILE:
             /* If we have a backing file, leave clusters unallocated that are
              * unallocated in the source image, so that the backing file is
@@ -1607,9 +1627,13 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
                     break;
                 }
 
-                ret = blk_pwrite_compressed(s->target,
-                                            sector_num << BDRV_SECTOR_BITS,
-                                            buf, n << BDRV_SECTOR_BITS);
+                iov.iov_base = buf;
+                iov.iov_len = n << BDRV_SECTOR_BITS;
+                qemu_iovec_init_external(&qiov, &iov, 1);
+
+                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
+                                     n << BDRV_SECTOR_BITS, &qiov,
+                                     BDRV_REQ_WRITE_COMPRESSED);
                 if (ret < 0) {
                     return ret;
                 }
@@ -1622,8 +1646,12 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
             if (!s->min_sparse ||
                 is_allocated_sectors_min(buf, n, &n, s->min_sparse))
             {
-                ret = blk_pwrite(s->target, sector_num << BDRV_SECTOR_BITS,
-                                 buf, n << BDRV_SECTOR_BITS, 0);
+                iov.iov_base = buf;
+                iov.iov_len = n << BDRV_SECTOR_BITS;
+                qemu_iovec_init_external(&qiov, &iov, 1);
+
+                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
+                                     n << BDRV_SECTOR_BITS, &qiov, 0);
                 if (ret < 0) {
                     return ret;
                 }
@@ -1635,8 +1663,9 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
             if (s->has_zero_init) {
                 break;
             }
-            ret = blk_pwrite_zeroes(s->target, sector_num << BDRV_SECTOR_BITS,
-                                    n << BDRV_SECTOR_BITS, 0);
+            ret = blk_co_pwrite_zeroes(s->target,
+                                       sector_num << BDRV_SECTOR_BITS,
+                                       n << BDRV_SECTOR_BITS, 0);
             if (ret < 0) {
                 return ret;
             }
@@ -1651,12 +1680,117 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
     return 0;
 }
 
-static int convert_do_copy(ImgConvertState *s)
+static void convert_co_do_copy(void *opaque)
 {
+    ImgConvertState *s = opaque;
     uint8_t *buf = NULL;
-    int64_t sector_num, allocated_done;
-    int ret;
-    int n;
+    int ret, i;
+    int index = -1;
+
+    for (i = 0; i < s->num_coroutines; i++) {
+        if (s->co[i] == qemu_coroutine_self()) {
+            index = i;
+            break;
+        }
+    }
+    assert(index >= 0);
+
+    s->running_coroutines++;
+    buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
+
+    while (1) {
+        int n;
+        int64_t sector_num;
+        enum ImgConvertBlockStatus status;
+
+        qemu_co_mutex_lock(&s->lock);
+        if (s->ret != -EINPROGRESS || s->sector_num >= s->total_sectors) {
+            qemu_co_mutex_unlock(&s->lock);
+            goto out;
+        }
+        n = convert_iteration_sectors(s, s->sector_num);
+        if (n < 0) {
+            qemu_co_mutex_unlock(&s->lock);
+            s->ret = n;
+            goto out;
+        }
+        /* safe current sector and allocation status to local variables */
+        sector_num = s->sector_num;
+        status = s->status;
+        if (!s->min_sparse && s->status == BLK_ZERO) {
+            n = MIN(n, s->buf_sectors);
+        }
+        /* increment global sector counter so that other coroutines can
+         * already continue reading beyond this request */
+        s->sector_num += n;
+        qemu_co_mutex_unlock(&s->lock);
+
+        if (status == BLK_DATA || (!s->min_sparse && s->status == BLK_ZERO)) {
+            s->allocated_done += n;
+            qemu_progress_print(100.0 * s->allocated_done /
+                                        s->allocated_sectors, 0);
+        }
+
+        if (status == BLK_DATA) {
+            ret = convert_co_read(s, sector_num, n, buf);
+            if (ret < 0) {
+                error_report("error while reading sector %" PRId64
+                             ": %s", sector_num, strerror(-ret));
+                s->ret = ret;
+                goto out;
+            }
+        } else if (!s->min_sparse && s->status == BLK_ZERO) {
+            status = BLK_DATA;
+            memset(buf, 0x00, n * BDRV_SECTOR_SIZE);
+        }
+
+        if (s->wr_in_order) {
+            /* keep writes in order */
+            while (s->wr_offs != sector_num) {
+                if (s->ret != -EINPROGRESS) {
+                    goto out;
+                }
+                s->wait_sector_num[index] = sector_num;
+                qemu_coroutine_yield();
+            }
+            s->wait_sector_num[index] = -1;
+        }
+
+        ret = convert_co_write(s, sector_num, n, buf, status);
+        if (ret < 0) {
+            error_report("error while writing sector %" PRId64
+                         ": %s", sector_num, strerror(-ret));
+            s->ret = ret;
+            goto out;
+        }
+
+        if (s->wr_in_order) {
+            /* reenter the coroutine that might have waited
+             * for this write to complete */
+            s->wr_offs = sector_num + n;
+            for (i = 0; i < s->num_coroutines; i++) {
+                if (s->co[i] && s->wait_sector_num[i] == s->wr_offs) {
+                    qemu_coroutine_enter(s->co[i]);
+                    break;
+                }
+            }
+        }
+    }
+
+out:
+    qemu_vfree(buf);
+    s->co[index] = NULL;
+    s->running_coroutines--;
+    if (!s->running_coroutines && s->ret == -EINPROGRESS) {
+        /* the convert job finished successfully */
+        s->ret = 0;
+    }
+}
+
+static int convert_do_copy(ImgConvertState *s)
+{
+    int ret, i, n;
+    int64_t sector_num = 0;
 
     /* Check whether we have zero initialisation or can get it efficiently */
     s->has_zero_init = s->min_sparse && !s->target_has_backing
@@ -1677,21 +1811,15 @@ static int convert_do_copy(ImgConvertState *s)
     if (s->compressed) {
         if (s->cluster_sectors <= 0 || s->cluster_sectors > s->buf_sectors) {
             error_report("invalid cluster size");
-            ret = -EINVAL;
-            goto fail;
+            return -EINVAL;
         }
         s->buf_sectors = s->cluster_sectors;
     }
-    buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
 
-    /* Calculate allocated sectors for progress */
-    s->allocated_sectors = 0;
-    sector_num = 0;
     while (sector_num < s->total_sectors) {
         n = convert_iteration_sectors(s, sector_num);
         if (n < 0) {
-            ret = n;
-            goto fail;
+            return n;
         }
         if (s->status == BLK_DATA || (!s->min_sparse && s->status == BLK_ZERO))
         {
@@ -1704,58 +1832,28 @@ static int convert_do_copy(ImgConvertState *s)
     s->src_cur = 0;
     s->src_cur_offset = 0;
     s->sector_next_status = 0;
+    s->ret = -EINPROGRESS;
 
-    sector_num = 0;
-    allocated_done = 0;
-
-    while (sector_num < s->total_sectors) {
-        n = convert_iteration_sectors(s, sector_num);
-        if (n < 0) {
-            ret = n;
-            goto fail;
-        }
-        if (s->status == BLK_DATA || (!s->min_sparse && s->status == BLK_ZERO))
-        {
-            allocated_done += n;
-            qemu_progress_print(100.0 * allocated_done / s->allocated_sectors,
-                                0);
-        }
-
-        if (s->status == BLK_DATA) {
-            ret = convert_read(s, sector_num, n, buf);
-            if (ret < 0) {
-                error_report("error while reading sector %" PRId64
-                             ": %s", sector_num, strerror(-ret));
-                goto fail;
-            }
-        } else if (!s->min_sparse && s->status == BLK_ZERO) {
-            n = MIN(n, s->buf_sectors);
-            memset(buf, 0, n * BDRV_SECTOR_SIZE);
-            s->status = BLK_DATA;
-        }
-
-        ret = convert_write(s, sector_num, n, buf);
-        if (ret < 0) {
-            error_report("error while writing sector %" PRId64
-                         ": %s", sector_num, strerror(-ret));
-            goto fail;
-        }
+    qemu_co_mutex_init(&s->lock);
+    for (i = 0; i < s->num_coroutines; i++) {
+        s->co[i] = qemu_coroutine_create(convert_co_do_copy, s);
+        s->wait_sector_num[i] = -1;
+        qemu_coroutine_enter(s->co[i]);
+    }
 
-        sector_num += n;
+    while (s->ret == -EINPROGRESS) {
+        main_loop_wait(false);
     }
 
-    if (s->compressed) {
+    if (s->compressed && !s->ret) {
         /* signal EOF to align */
         ret = blk_pwrite_compressed(s->target, 0, NULL, 0);
         if (ret < 0) {
-            goto fail;
+            return ret;
         }
     }
 
-    ret = 0;
-fail:
-    qemu_vfree(buf);
-    return ret;
+    return s->ret;
 }
 
 static int img_convert(int argc, char **argv)
@@ -1783,6 +1881,8 @@ static int img_convert(int argc, char **argv)
     QemuOpts *sn_opts = NULL;
     ImgConvertState state;
     bool image_opts = false;
+    bool wr_in_order = true;
+    int num_coroutines = 8;
 
     fmt = NULL;
     out_fmt = "raw";
@@ -1798,7 +1898,7 @@ static int img_convert(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qn",
+        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -1890,6 +1990,18 @@ static int img_convert(int argc, char **argv)
         case 'n':
             skip_create = 1;
             break;
+        case 'm':
+            num_coroutines = atoi(optarg);
+            if (num_coroutines > MAX_COROUTINES) {
+                error_report("Maximum allowed number of coroutines is %d",
+                             MAX_COROUTINES);
+                ret = -1;
+                goto fail_getopt;
+            }
+            break;
+        case 'W':
+            wr_in_order = false;
+            break;
         case OPTION_OBJECT:
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
@@ -2149,6 +2261,8 @@ static int img_convert(int argc, char **argv)
         .min_sparse         = min_sparse,
         .cluster_sectors    = cluster_sectors,
         .buf_sectors        = bufsectors,
+        .wr_in_order        = wr_in_order,
+        .num_coroutines     = num_coroutines,
     };
     ret = convert_do_copy(&state);
 
-- 
1.9.1
