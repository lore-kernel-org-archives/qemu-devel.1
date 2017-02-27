Received: from eggs.gnu.org ([2001:4830:134:3::10]:52108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci9Rs-0003nB-Le
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 19:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci9Rr-0005r6-BY
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 19:45:56 -0500
Date: Mon, 27 Feb 2017 01:45:45 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170227004545.hzpr266jzturlxdh@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] blk: Add discard=sparse mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

By default, on discard requests, the posix block backend punches holes but
re-fallocates them to keep the allocated size intact. In some situations
it is however convenient, when using sparse disk images, to see disk image
sizes shrink on discard requests.

This commit adds a discard=sparse mode which does this, by disabling the
fallocate call.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/block.c b/block.c
index b663204f3f..e9cd83210a 100644
--- a/block.c
+++ b/block.c
@@ -665,12 +665,14 @@ static void bdrv_join_options(BlockDriverState *bs, QDict *options,
  */
 int bdrv_parse_discard_flags(const char *mode, int *flags)
 {
-    *flags &= ~BDRV_O_UNMAP;
+    *flags &= ~(BDRV_O_UNMAP | BDRV_O_SPARSE);
 
     if (!strcmp(mode, "off") || !strcmp(mode, "ignore")) {
         /* do nothing */
     } else if (!strcmp(mode, "on") || !strcmp(mode, "unmap")) {
         *flags |= BDRV_O_UNMAP;
+    } else if (!strcmp(mode, "sparse")) {
+        *flags |= BDRV_O_UNMAP | BDRV_O_SPARSE;
     } else {
         return -1;
     }
diff --git a/block/file-posix.c b/block/file-posix.c
index 4de1abd023..f9efadc5be 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1057,6 +1057,10 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
     BDRVRawState *s = aiocb->bs->opaque;
 #endif
 
+#if defined(CONFIG_FALLOCATE_PUNCH_HOLE) || defined(CONFIG_FALLOCATE)
+    int open_flags = aiocb->bs->open_flags;
+#endif
+
     if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
         return handle_aiocb_write_zeroes_block(aiocb);
     }
@@ -1079,7 +1083,7 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
 #endif
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
-    if (s->has_discard && s->has_fallocate) {
+    if (s->has_discard && (s->has_fallocate || open_flags & BDRV_O_SPARSE)) {
         int ret = do_fallocate(s->fd,
                                FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                                aiocb->aio_offset, aiocb->aio_nbytes);
@@ -1098,7 +1102,8 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
 #endif
 
 #ifdef CONFIG_FALLOCATE
-    if (s->has_fallocate && aiocb->aio_offset >= bdrv_getlength(aiocb->bs)) {
+    if (s->has_fallocate && !(open_flags & BDRV_O_SPARSE)
+            && aiocb->aio_offset >= bdrv_getlength(aiocb->bs)) {
         int ret = do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->aio_nbytes);
         if (ret == 0 || ret != -ENOTSUP) {
             return ret;
diff --git a/include/block/block.h b/include/block/block.h
index bde5ebda18..103313bee0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -97,6 +97,8 @@ typedef struct HDGeometry {
                                       select an appropriate protocol driver,
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
+#define BDRV_O_SPARSE      0x20000 /* make guest UNMAP/TRIM operations make image
+                                      possibly sparse */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 9a84e81eed..8df4f58ddc 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -63,8 +63,8 @@ and @samp{native} (Linux only).
 @item --discard=@var{discard}
 Control whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap})
 requests are ignored or passed to the filesystem.  @var{discard} is one of
-@samp{ignore} (or @samp{off}), @samp{unmap} (or @samp{on}).  The default is
-@samp{ignore}.
+@samp{ignore} (or @samp{off}), @samp{unmap} (or @samp{on}), or @samp{sparse}.
+The default is @samp{ignore}.
 @item --detect-zeroes=@var{detect-zeroes}
 Control the automatic conversion of plain zero writes by the OS to
 driver-specific optimized zero write commands.  @var{detect-zeroes} is one of
diff --git a/qemu-options.hx b/qemu-options.hx
index bf458f83c3..f5c7455fd1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -539,7 +539,7 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "       [,serial=s][,addr=A][,rerror=ignore|stop|report]\n"
     "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
     "       [,readonly=on|off][,copy-on-read=on|off]\n"
-    "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
+    "       [,discard=ignore|unmap|sparse][,detect-zeroes=on|off|unmap]\n"
     "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
     "       [[,iops=i]|[[,iops_rd=r][,iops_wr=w]]]\n"
     "       [[,bps_max=bm]|[[,bps_rd_max=rm][,bps_wr_max=wm]]]\n"
@@ -582,7 +582,7 @@ These options have the same definition as they have in @option{-hdachs}.
 @item aio=@var{aio}
 @var{aio} is "threads", or "native" and selects between pthread based disk I/O and native Linux AIO.
 @item discard=@var{discard}
-@var{discard} is one of "ignore" (or "off") or "unmap" (or "on") and controls whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap}) requests are ignored or passed to the filesystem.  Some machine types may not support discard requests.
+@var{discard} is one of "ignore" (or "off") or "unmap" (or "on") or "sparse" and controls whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap}) requests are ignored or passed to the filesystem.  Some machine types may not support discard requests.
 @item format=@var{format}
 Specify which disk @var{format} will be used rather than detecting
 the format.  Can be used to specify format=raw to avoid interpreting
