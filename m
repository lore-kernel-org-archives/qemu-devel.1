Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31091FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F3A21835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F3A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmDj-00056E-Mn
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKmAg-0002XI-0J
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKmAe-00083t-CJ
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:29:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:51302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKmAe-00081P-3p; Wed, 16 Oct 2019 12:29:08 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKmAZ-0002B1-2M; Wed, 16 Oct 2019 19:29:03 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v4 1/4] block: support compressed write at generic layer
Date: Wed, 16 Oct 2019 19:28:50 +0300
Message-Id: <1571243333-882302-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To inform the block layer about writing all the data compressed, we
introduce the 'compress' command line option. Based on that option, the
written data will be aligned by the cluster size at the generic layer.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block.c                   | 20 +++++++++++++++++++-
 block/io.c                | 14 ++++++++++----
 block/qcow2.c             |  4 ++++
 blockdev.c                |  9 ++++++++-
 include/block/block.h     |  1 +
 include/block/block_int.h |  2 ++
 qapi/block-core.json      |  6 +++++-
 qemu-options.hx           |  6 ++++--
 8 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index 1946fc6..a674920 100644
--- a/block.c
+++ b/block.c
@@ -1418,6 +1418,11 @@ QemuOptsList bdrv_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "always accept other writers (default: off)",
         },
+        {
+            .name = BDRV_OPT_COMPRESS,
+            .type = QEMU_OPT_BOOL,
+            .help = "compress all writes to the image (default: off)",
+        },
         { /* end of list */ }
     },
 };
@@ -1545,6 +1550,14 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     }
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename), bs->filename);
 
+    if (bs->all_write_compressed && !drv->bdrv_co_pwritev_compressed_part) {
+        error_setg(errp, "Compression is not supported for the driver '%s'",
+                   drv->format_name);
+        bs->all_write_compressed = false;
+        ret = -ENOTSUP;
+        goto fail_opts;
+    }
+
     /* Open the image, either directly or using a protocol */
     open_flags = bdrv_open_flags(bs, bs->open_flags);
     node_name = qemu_opt_get(opts, "node-name");
@@ -2983,6 +2996,11 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         flags &= ~BDRV_O_RDWR;
     }
 
+    if (!g_strcmp0(qdict_get_try_str(options, BDRV_OPT_COMPRESS), "on") ||
+        qdict_get_try_bool(options, BDRV_OPT_COMPRESS, false)) {
+        bs->all_write_compressed = true;
+    }
+
     if (flags & BDRV_O_SNAPSHOT) {
         snapshot_options = qdict_new();
         bdrv_temp_snapshot_options(&snapshot_flags, snapshot_options,
@@ -3208,7 +3226,7 @@ static int bdrv_reset_options_allowed(BlockDriverState *bs,
      * in bdrv_reopen_prepare() so they can be left out of @new_opts */
     const char *const common_options[] = {
         "node-name", "discard", "cache.direct", "cache.no-flush",
-        "read-only", "auto-read-only", "detect-zeroes", NULL
+        "read-only", "auto-read-only", "detect-zeroes", "compress", NULL
     };
 
     for (e = qdict_first(bs->options); e; e = qdict_next(bs->options, e)) {
diff --git a/block/io.c b/block/io.c
index f0b86c1..3743a13 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1360,9 +1360,15 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
                 /* This does not change the data on the disk, it is not
                  * necessary to flush even in cache=writethrough mode.
                  */
-                ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
-                                          &local_qiov, 0,
-                                          BDRV_REQ_WRITE_UNCHANGED);
+                if (bs->all_write_compressed) {
+                    ret = bdrv_driver_pwritev_compressed(bs, cluster_offset,
+                                                         pnum, &local_qiov,
+                                                         qiov_offset);
+                } else {
+                    ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
+                                              &local_qiov, 0,
+                                              BDRV_REQ_WRITE_UNCHANGED);
+                }
             }
 
             if (ret < 0) {
@@ -1954,7 +1960,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     } else if (flags & BDRV_REQ_ZERO_WRITE) {
         bdrv_debug_event(bs, BLKDBG_PWRITEV_ZERO);
         ret = bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags);
-    } else if (flags & BDRV_REQ_WRITE_COMPRESSED) {
+    } else if (flags & BDRV_REQ_WRITE_COMPRESSED || bs->all_write_compressed) {
         ret = bdrv_driver_pwritev_compressed(bs, offset, bytes,
                                              qiov, qiov_offset);
     } else if (bytes <= max_transfer) {
diff --git a/block/qcow2.c b/block/qcow2.c
index 7961c05..6b29e16 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1787,6 +1787,10 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
         /* Encryption works on a sector granularity */
         bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
+    if (bs->all_write_compressed) {
+        bs->bl.request_alignment = MAX(bs->bl.request_alignment,
+                                       s->cluster_size);
+    }
     bs->bl.pwrite_zeroes_alignment = s->cluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
 }
diff --git a/blockdev.c b/blockdev.c
index f89e48f..0c0b398 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -471,7 +471,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     int bdrv_flags = 0;
     int on_read_error, on_write_error;
     bool account_invalid, account_failed;
-    bool writethrough, read_only;
+    bool writethrough, read_only, compress;
     BlockBackend *blk;
     BlockDriverState *bs;
     ThrottleConfig cfg;
@@ -570,6 +570,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     }
 
     read_only = qemu_opt_get_bool(opts, BDRV_OPT_READ_ONLY, false);
+    compress = qemu_opt_get_bool(opts, BDRV_OPT_COMPRESS, false);
 
     /* init */
     if ((!file || !*file) && !qdict_size(bs_opts)) {
@@ -595,6 +596,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         qdict_set_default_str(bs_opts, BDRV_OPT_READ_ONLY,
                               read_only ? "on" : "off");
         qdict_set_default_str(bs_opts, BDRV_OPT_AUTO_READ_ONLY, "on");
+        qdict_set_default_str(bs_opts, BDRV_OPT_COMPRESS,
+                              compress ? "on" : "off");
         assert((bdrv_flags & BDRV_O_CACHE_MASK) == 0);
 
         if (runstate_check(RUN_STATE_INMIGRATE)) {
@@ -4683,6 +4686,10 @@ QemuOptsList qemu_common_drive_opts = {
             .name = BDRV_OPT_READ_ONLY,
             .type = QEMU_OPT_BOOL,
             .help = "open drive file as read-only",
+        },{
+            .name = BDRV_OPT_COMPRESS,
+            .type = QEMU_OPT_BOOL,
+            .help = "compress all writes to image",
         },
 
         THROTTLE_OPTS,
diff --git a/include/block/block.h b/include/block/block.h
index 792bb82..7e0a927 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -139,6 +139,7 @@ typedef struct HDGeometry {
 #define BDRV_OPT_AUTO_READ_ONLY "auto-read-only"
 #define BDRV_OPT_DISCARD        "discard"
 #define BDRV_OPT_FORCE_SHARE    "force-share"
+#define BDRV_OPT_COMPRESS       "compress"
 
 
 #define BDRV_SECTOR_BITS   9
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 05056b3..3fe8923 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -923,6 +923,8 @@ struct BlockDriverState {
 
     /* BdrvChild links to this node may never be frozen */
     bool never_freeze;
+    /* Compress all writes to the image */
+    bool all_write_compressed;
 };
 
 struct BlockBackendRootState {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f66553a..6c1684f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4014,6 +4014,9 @@
 # @force-share:   force share all permission on added nodes.
 #                 Requires read-only=true. (Since 2.10)
 #
+# @compress:      compress all writes to the image (Since 4.2)
+#                 (default: false)
+#
 # Remaining options are determined by the block driver.
 #
 # Since: 2.9
@@ -4026,7 +4029,8 @@
             '*read-only': 'bool',
             '*auto-read-only': 'bool',
             '*force-share': 'bool',
-            '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
+            '*detect-zeroes': 'BlockdevDetectZeroesOptions',
+            '*compress': 'bool' },
   'discriminator': 'driver',
   'data': {
       'blkdebug':   'BlockdevOptionsBlkdebug',
diff --git a/qemu-options.hx b/qemu-options.hx
index 793d70f..1bfbf1a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -850,7 +850,7 @@ DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
     "-blockdev [driver=]driver[,node-name=N][,discard=ignore|unmap]\n"
     "          [,cache.direct=on|off][,cache.no-flush=on|off]\n"
     "          [,read-only=on|off][,detect-zeroes=on|off|unmap]\n"
-    "          [,driver specific parameters...]\n"
+    "          [,compress=on|off][,driver specific parameters...]\n"
     "                configure a block backend\n", QEMU_ARCH_ALL)
 STEXI
 @item -blockdev @var{option}[,@var{option}[,@var{option}[,...]]]
@@ -905,6 +905,8 @@ discard requests.
 conversion of plain zero writes by the OS to driver specific optimized
 zero write commands. You may even choose "unmap" if @var{discard} is set
 to "unmap" to allow a zero write to be converted to an @code{unmap} operation.
+@item compress
+Compress all writes to the image.
 @end table
 
 @item Driver-specific options for @code{file}
@@ -1026,7 +1028,7 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
     "       [,snapshot=on|off][,rerror=ignore|stop|report]\n"
     "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
-    "       [,readonly=on|off][,copy-on-read=on|off]\n"
+    "       [,readonly=on|off][,copy-on-read=on|off][,compress=on|off]\n"
     "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
     "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
     "       [[,iops=i]|[[,iops_rd=r][,iops_wr=w]]]\n"
-- 
1.8.3.1


