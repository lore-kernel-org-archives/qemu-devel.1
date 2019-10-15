Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F9DC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006CF20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006CF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKRTK-0008D0-3x
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 14:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKRR7-0005rL-HT
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKRR5-0001Tf-Id
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:20:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:35010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKRR5-0001RF-B4; Tue, 15 Oct 2019 14:20:43 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKRQy-0003ry-Im; Tue, 15 Oct 2019 21:20:36 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v3 1/5] qcow2: Allow writing compressed data of multiple
 clusters
Date: Tue, 15 Oct 2019 21:20:21 +0300
Message-Id: <1571163625-642312-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571163625-642312-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1571163625-642312-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
 andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU currently supports writing compressed data of the size equal to
one cluster. This patch allows writing QCOW2 compressed data that
exceed one cluster. Now, we split buffered data into separate clusters
and write them compressed using the existing functionality.
To inform the block layer about writing all the data compressed, we
introduce the 'compress' command line option. Based on that option, the
written data will be aligned by the cluster size at the generic layer.

Suggested-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block.c                   |  12 +++++-
 block/io.c                |   2 +-
 block/qcow2.c             | 106 ++++++++++++++++++++++++++++++++++------------
 block/qcow2.h             |   1 +
 blockdev.c                |   4 ++
 include/block/block.h     |   1 +
 include/block/block_int.h |   2 +
 qapi/block-core.json      |   6 ++-
 qemu-options.hx           |   6 ++-
 9 files changed, 108 insertions(+), 32 deletions(-)

diff --git a/block.c b/block.c
index 5944124..4cfbea2 100644
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
@@ -2983,6 +2988,11 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
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
@@ -3208,7 +3218,7 @@ static int bdrv_reset_options_allowed(BlockDriverState *bs,
      * in bdrv_reopen_prepare() so they can be left out of @new_opts */
     const char *const common_options[] = {
         "node-name", "discard", "cache.direct", "cache.no-flush",
-        "read-only", "auto-read-only", "detect-zeroes", NULL
+        "read-only", "auto-read-only", "detect-zeroes", "compress", NULL
     };
 
     for (e = qdict_first(bs->options); e; e = qdict_next(bs->options, e)) {
diff --git a/block/io.c b/block/io.c
index f8c3596..6a5509c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1922,7 +1922,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     } else if (flags & BDRV_REQ_ZERO_WRITE) {
         bdrv_debug_event(bs, BLKDBG_PWRITEV_ZERO);
         ret = bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags);
-    } else if (flags & BDRV_REQ_WRITE_COMPRESSED) {
+    } else if (flags & BDRV_REQ_WRITE_COMPRESSED || bs->all_write_compressed) {
         ret = bdrv_driver_pwritev_compressed(bs, offset, bytes,
                                              qiov, qiov_offset);
     } else if (bytes <= max_transfer) {
diff --git a/block/qcow2.c b/block/qcow2.c
index 7961c05..9a85d73 100644
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
@@ -4152,10 +4156,8 @@ fail:
     return ret;
 }
 
-/* XXX: put compressed sectors first, then all the cluster aligned
-   tables to avoid losing bytes in alignment */
 static coroutine_fn int
-qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
+qcow2_co_pwritev_compressed_task(BlockDriverState *bs,
                                  uint64_t offset, uint64_t bytes,
                                  QEMUIOVector *qiov, size_t qiov_offset)
 {
@@ -4165,32 +4167,11 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
     uint8_t *buf, *out_buf;
     uint64_t cluster_offset;
 
-    if (has_data_file(bs)) {
-        return -ENOTSUP;
-    }
-
-    if (bytes == 0) {
-        /* align end of file to a sector boundary to ease reading with
-           sector based I/Os */
-        int64_t len = bdrv_getlength(bs->file->bs);
-        if (len < 0) {
-            return len;
-        }
-        return bdrv_co_truncate(bs->file, len, PREALLOC_MODE_OFF, NULL);
-    }
-
-    if (offset_into_cluster(s, offset)) {
-        return -EINVAL;
-    }
+    assert(bytes == s->cluster_size || (bytes < s->cluster_size &&
+           (offset + bytes == bs->total_sectors << BDRV_SECTOR_BITS)));
 
     buf = qemu_blockalign(bs, s->cluster_size);
-    if (bytes != s->cluster_size) {
-        if (bytes > s->cluster_size ||
-            offset + bytes != bs->total_sectors << BDRV_SECTOR_BITS)
-        {
-            qemu_vfree(buf);
-            return -EINVAL;
-        }
+    if (bytes < s->cluster_size) {
         /* Zero-pad last write if image size is not cluster aligned */
         memset(buf + bytes, 0, s->cluster_size - bytes);
     }
@@ -4239,6 +4220,77 @@ fail:
     return ret;
 }
 
+static coroutine_fn int qcow2_co_pwritev_compressed_task_entry(AioTask *task)
+{
+    Qcow2AioTask *t = container_of(task, Qcow2AioTask, task);
+
+    assert(!t->cluster_type && !t->l2meta);
+
+    return qcow2_co_pwritev_compressed_task(t->bs, t->offset, t->bytes, t->qiov,
+                                            t->qiov_offset);
+}
+
+/*
+ * XXX: put compressed sectors first, then all the cluster aligned
+   tables to avoid losing bytes in alignment
+ */
+static coroutine_fn int
+qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
+                                 uint64_t offset, uint64_t bytes,
+                                 QEMUIOVector *qiov, size_t qiov_offset)
+{
+    BDRVQcow2State *s = bs->opaque;
+    AioTaskPool *aio = NULL;
+    int ret;
+
+    if (has_data_file(bs)) {
+        return -ENOTSUP;
+    }
+
+    if (bytes == 0) {
+        /*
+         * align end of file to a sector boundary to ease reading with
+         * sector based I/Os
+         */
+        int64_t len = bdrv_getlength(bs->file->bs);
+        if (len < 0) {
+            return len;
+        }
+        return bdrv_co_truncate(bs->file, len, PREALLOC_MODE_OFF, NULL);
+    }
+
+    if (offset_into_cluster(s, offset)) {
+        return -EINVAL;
+    }
+
+    while (bytes && aio_task_pool_status(aio) == 0) {
+        uint32_t chunk_size = MIN(bytes, s->cluster_size);
+
+        if (!aio && chunk_size != bytes) {
+            aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
+        }
+
+        ret = qcow2_add_task(bs, aio, qcow2_co_pwritev_compressed_task_entry,
+                             0, 0, offset, chunk_size, qiov, qiov_offset, NULL);
+        if (ret < 0) {
+            break;
+        }
+        qiov_offset += chunk_size;
+        offset += chunk_size;
+        bytes -= chunk_size;
+    }
+
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret == 0) {
+            ret = aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+
+    return ret;
+}
+
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
                            uint64_t file_cluster_offset,
diff --git a/block/qcow2.h b/block/qcow2.h
index f51f478..2d264c6 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -120,6 +120,7 @@
 #define QCOW2_OPT_L2_CACHE_ENTRY_SIZE "l2-cache-entry-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
 #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
+#define QCOW2_OPT_COMPRESS "compress"
 
 typedef struct QCowHeader {
     uint32_t magic;
diff --git a/blockdev.c b/blockdev.c
index fbef684..2103730 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4682,6 +4682,10 @@ QemuOptsList qemu_common_drive_opts = {
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
index 37c9de7..2980293 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -139,6 +139,7 @@ typedef struct HDGeometry {
 #define BDRV_OPT_AUTO_READ_ONLY "auto-read-only"
 #define BDRV_OPT_DISCARD        "discard"
 #define BDRV_OPT_FORCE_SHARE    "force-share"
+#define BDRV_OPT_COMPRESS       "compress"
 
 
 #define BDRV_SECTOR_BITS   9
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acd..6cb6604 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -922,6 +922,8 @@ struct BlockDriverState {
 
     /* BdrvChild links to this node may never be frozen */
     bool never_freeze;
+    /* Compress all writes to the image */
+    bool all_write_compressed;
 };
 
 struct BlockBackendRootState {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6edd64..14d8ce2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3949,6 +3949,9 @@
 # @force-share:   force share all permission on added nodes.
 #                 Requires read-only=true. (Since 2.10)
 #
+# @compress:      compress all writes to the image (Since 4.2)
+#                 (default: false)
+#
 # Remaining options are determined by the block driver.
 #
 # Since: 2.9
@@ -3961,7 +3964,8 @@
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
index 2a04ca6..0b0bfb9 100644
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


