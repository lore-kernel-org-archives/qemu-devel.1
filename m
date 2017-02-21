Received: from eggs.gnu.org ([2001:4830:134:3::10]:47317)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cg9a2-0003Rm-07
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cg9Zx-0006Uy-UH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:30:05 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:41359 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cg9Zx-0006Uf-Io
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:30:01 -0500
From: Peter Lieven <pl@kamp.de>
Date: Tue, 21 Feb 2017 13:29:51 +0100
Message-Id: <1487680191-13096-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com, Peter Lieven <pl@kamp.de>

the convert process is currently completely implemented with sync operations.
That means it reads one buffer and then writes it. No parallelism and each sync
request takes as long as it takes until it is completed.

This can be a big performance hit when the convert process reads and writes
to devices which do not benefit from kernel readahead or pagecache.
In our environment we heavily have the following two use cases when using
qemu-img convert.

a) reading from NFS and writing to iSCSI for deploying templates
b) reading from iSCSI and writing to NFS for backups

In both processes we use libiscsi and libnfs so we have no kernel cache.

This patch changes the convert process to work with parallel running coroutines
which can significantly improve performance for network storage devices:

qemu-img (master)
 nfs -> iscsi 22.8 secs
 nfs -> ram   11.7 secs
 ram -> iscsi 12.3 secs

qemu-img-async (8 coroutines, in-order write disabled)
 nfs -> iscsi 11.0 secs
 nfs -> ram   10.4 secs
 ram -> iscsi  9.0 secs

This patches introduces 2 new cmdline parameters. The -m parameter to specify
the number of coroutines running in parallel (defaults to 8). And the -W paremeter to
allow qemu-img to write to the target out of order rather than sequential. This improves
performance as the writes do not have to wait for each other to complete.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
   RFC->V1: - add documentation
            - add missing coroutine_fn annotation [Stefan]
            - add a comment why it is safe to call coroutine_enter [Stefan]
            - check -m paramater for values < 1 [Stefan]
            - disallow -W parameter with compression [Stefan]

RFC V3->V4: - avoid to prepare a request queue upfront [Kevin]
            - do not ignore the BLK_BACKING_FILE status [Kevin]
            - redesign the interface to the read and write routines [Kevin]
    
RFC V2->V3: - updated stats in the commit msg from a host with a better network card
            - only wake up the coroutine that is acutally waiting for a write to complete.
              this was not only overhead, but also breaking at least linux AIO.
            - fix coding style complaints
            - rename some variables and structs
    
RFC V1->V2: - using coroutine as worker "threads". [Max]
            - keeping the request queue as otherwise it happens
              that we wait on BLK_ZERO chunks while keeping the write order.
              it also avoids redundant calls to get_block_status and helps
              to skip some conditions for fully allocated imaged (!s->min_sparse)

 qemu-img-cmds.hx |   4 +-
 qemu-img.c       | 276 ++++++++++++++++++++++++++++++++++++++++---------------
 qemu-img.texi    |  16 +++-
 3 files changed, 220 insertions(+), 76 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index f054599..9c9702c 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -40,9 +40,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("dd", img_dd,
diff --git a/qemu-img.c b/qemu-img.c
index cff22e3..00609f4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -156,6 +156,11 @@ static void QEMU_NORETURN help(void)
            "       kinds of errors, with a higher risk of choosing the wrong fix or\n"
            "       hiding corruption that has already occurred.\n"
            "\n"
+           "Parameters to convert subcommand:\n"
+           "  '-m' specifies how many coroutines work in parallel during the convert\n"
+           "       process (defaults to 8)\n"
+           "  '-W' allow to write to the target out of order rather than sequential\n"
+           "\n"
            "Parameters to snapshot subcommand:\n"
            "  'snapshot' is the name of the snapshot to create, apply or delete\n"
            "  '-a' applies a snapshot (revert disk to saved state)\n"
@@ -1448,6 +1453,8 @@ enum ImgConvertBlockStatus {
     BLK_BACKING_FILE,
 };
 
+#define MAX_COROUTINES 16
+
 typedef struct ImgConvertState {
     BlockBackend **src;
     int64_t *src_sectors;
@@ -1455,15 +1462,25 @@ typedef struct ImgConvertState {
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
@@ -1544,11 +1561,12 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     return n;
 }
 
-static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
-                        uint8_t *buf)
+static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
+                                        int nb_sectors, uint8_t *buf)
 {
-    int n;
-    int ret;
+    int n, ret;
+    QEMUIOVector qiov;
+    struct iovec iov;
 
     assert(nb_sectors <= s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1563,9 +1581,13 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
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
@@ -1578,15 +1600,18 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
     return 0;
 }
 
-static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
-                         const uint8_t *buf)
+
+static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
+                                         int nb_sectors, uint8_t *buf,
+                                         enum ImgConvertBlockStatus status)
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
@@ -1607,9 +1632,13 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
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
@@ -1622,8 +1651,12 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
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
@@ -1635,8 +1668,9 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
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
@@ -1651,12 +1685,122 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
     return 0;
 }
 
-static int convert_do_copy(ImgConvertState *s)
+static void coroutine_fn convert_co_do_copy(void *opaque)
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
+                    /*
+                     * A -> B -> A cannot occur because A has
+                     * s->wait_sector_num[i] == -1 during A -> B. Therefore
+                     * B will never enter A during this time window.
+                     */
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
@@ -1677,21 +1821,15 @@ static int convert_do_copy(ImgConvertState *s)
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
@@ -1704,58 +1842,28 @@ static int convert_do_copy(ImgConvertState *s)
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
@@ -1783,6 +1891,8 @@ static int img_convert(int argc, char **argv)
     QemuOpts *sn_opts = NULL;
     ImgConvertState state;
     bool image_opts = false;
+    bool wr_in_order = true;
+    int num_coroutines = 8;
 
     fmt = NULL;
     out_fmt = "raw";
@@ -1798,7 +1908,7 @@ static int img_convert(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qn",
+        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -1890,6 +2000,18 @@ static int img_convert(int argc, char **argv)
         case 'n':
             skip_create = 1;
             break;
+        case 'm':
+            num_coroutines = atoi(optarg);
+            if (num_coroutines < 1 || num_coroutines > MAX_COROUTINES) {
+                error_report("Allowed number of coroutines is between 1 and %d",
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
@@ -1909,6 +2031,12 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }
 
+    if (!wr_in_order && compress) {
+        error_report("Out of order write and compress are mutually exclusive");
+        ret = -1;
+        goto fail_getopt;
+    }
+
     /* Initialize before goto out */
     if (quiet) {
         progress = 0;
@@ -2149,6 +2277,8 @@ static int img_convert(int argc, char **argv)
         .min_sparse         = min_sparse,
         .cluster_sectors    = cluster_sectors,
         .buf_sectors        = bufsectors,
+        .wr_in_order        = wr_in_order,
+        .num_coroutines     = num_coroutines,
     };
     ret = convert_do_copy(&state);
 
diff --git a/qemu-img.texi b/qemu-img.texi
index 174aae3..6715ff3 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -137,6 +137,12 @@ Parameters to convert subcommand:
 
 @item -n
 Skip the creation of the target volume
+@item -m
+Number of parallel coroutines for the convert process
+@item -W
+Allow to write out of order to the destination. This is option improves performance,
+but is only recommened for preallocated devices like host devices or other
+raw block devices.
 @end table
 
 Parameters to dd subcommand:
@@ -296,7 +302,7 @@ Error on reading data
 
 @end table
 
-@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-m @var{num_coroutines}] [-W] {[-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
 
 Convert the disk image @var{filename} or a snapshot @var{snapshot_param}(@var{snapshot_id_or_name} is deprecated)
 to disk image @var{output_filename} using format @var{output_fmt}. It can be optionally compressed (@code{-c}
@@ -326,6 +332,14 @@ skipped. This is useful for formats such as @code{rbd} if the target
 volume has already been created with site specific options that cannot
 be supplied through qemu-img.
 
+With option @code{-W} specified, it is allowed to write out of order to the target.
+This is option improves performance, but is only recommened for preallocated devices
+like host devices or other raw block devices. Out of order write does not work
+in combination with creating compressed images.
+
+@var{num_coroutines} specifies how many coroutines work in parallel during
+the convert process (defaults to 8).
+
 @item dd [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 
 Dd copies from @var{input} file to @var{output} file converting it from
-- 
1.9.1
