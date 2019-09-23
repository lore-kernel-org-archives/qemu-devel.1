Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94463C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2167A207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2167A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNTa-0007gT-Dj
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iCNIF-0006to-Ts
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iCNIE-0001nq-4y
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:18:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:59160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1iCNI7-0001iP-Kz; Mon, 23 Sep 2019 08:18:08 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1iCNI6-0007xx-3k; Mon, 23 Sep 2019 15:18:06 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v10 9/9] qapi: query-blockstat: add driver specific file-posix
 stats
Date: Mon, 23 Sep 2019 15:17:37 +0300
Message-Id: <20190923121737.83281-10-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
References: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A block driver can provide a callback to report driver-specific
statistics.

file-posix driver now reports discard statistics

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json      | 38 ++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  1 +
 include/block/block_int.h |  1 +
 block.c                   |  9 +++++++++
 block/file-posix.c        | 32 ++++++++++++++++++++++++++++++++
 block/qapi.c              |  5 +++++
 6 files changed, 86 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7d3e05891c..859acea014 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -960,6 +960,41 @@
            '*wr_latency_histogram': 'BlockLatencyHistogramInfo',
            '*flush_latency_histogram': 'BlockLatencyHistogramInfo' } }
 
+##
+# @BlockStatsSpecificFile:
+#
+# File driver statistics
+#
+# @discard-nb-ok: The number of successful discard operations performed by
+#                 the driver.
+#
+# @discard-nb-failed: The number of failed discard operations performed by
+#                     the driver.
+#
+# @discard-bytes-ok: The number of bytes discarded by the driver.
+#
+# Since: 4.2
+##
+{ 'struct': 'BlockStatsSpecificFile',
+  'data': {
+      'discard-nb-ok': 'uint64',
+      'discard-nb-failed': 'uint64',
+      'discard-bytes-ok': 'uint64' } }
+
+##
+# @BlockStatsSpecific:
+#
+# Block driver specific statistics
+#
+# Since: 4.2
+##
+{ 'union': 'BlockStatsSpecific',
+  'base': { 'driver': 'BlockdevDriver' },
+  'discriminator': 'driver',
+  'data': {
+      'file': 'BlockStatsSpecificFile',
+      'host_device': 'BlockStatsSpecificFile' } }
+
 ##
 # @BlockStats:
 #
@@ -975,6 +1010,8 @@
 #
 # @stats:  A @BlockDeviceStats for the device.
 #
+# @driver-specific: Optional driver-specific stats. (Since 4.2)
+#
 # @parent: This describes the file block device if it has one.
 #          Contains recursively the statistics of the underlying
 #          protocol (e.g. the host file for a qcow2 image). If there is
@@ -988,6 +1025,7 @@
 { 'struct': 'BlockStats',
   'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
            'stats': 'BlockDeviceStats',
+           '*driver-specific': 'BlockStatsSpecific',
            '*parent': 'BlockStats',
            '*backing': 'BlockStats'} }
 
diff --git a/include/block/block.h b/include/block/block.h
index 37c9de7446..792bb826db 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -501,6 +501,7 @@ int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
                                           Error **errp);
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
 void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acdf1c..2b113eb3c7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -366,6 +366,7 @@ struct BlockDriver {
     int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
     ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs,
                                                  Error **errp);
+    BlockStatsSpecific *(*bdrv_get_specific_stats)(BlockDriverState *bs);
 
     int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
                                           QEMUIOVector *qiov,
diff --git a/block.c b/block.c
index 5944124845..5d3a5a6b95 100644
--- a/block.c
+++ b/block.c
@@ -5155,6 +5155,15 @@ ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
     return NULL;
 }
 
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs)
+{
+    BlockDriver *drv = bs->drv;
+    if (!drv || !drv->bdrv_get_specific_stats) {
+        return NULL;
+    }
+    return drv->bdrv_get_specific_stats(bs);
+}
+
 void bdrv_debug_event(BlockDriverState *bs, BlkdebugEvent event)
 {
     if (!bs || !bs->drv || !bs->drv->bdrv_debug_event) {
diff --git a/block/file-posix.c b/block/file-posix.c
index f3934c4e10..695fcf740d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2753,6 +2753,36 @@ static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
+static BlockStatsSpecificFile get_blockstats_specific_file(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+    return (BlockStatsSpecificFile) {
+        .discard_nb_ok = s->stats.discard_nb_ok,
+        .discard_nb_failed = s->stats.discard_nb_failed,
+        .discard_bytes_ok = s->stats.discard_bytes_ok,
+    };
+}
+
+static BlockStatsSpecific *raw_get_specific_stats(BlockDriverState *bs)
+{
+    BlockStatsSpecific *stats = g_new(BlockStatsSpecific, 1);
+
+    stats->driver = BLOCKDEV_DRIVER_FILE;
+    stats->u.file = get_blockstats_specific_file(bs);
+
+    return stats;
+}
+
+static BlockStatsSpecific *hdev_get_specific_stats(BlockDriverState *bs)
+{
+    BlockStatsSpecific *stats = g_new(BlockStatsSpecific, 1);
+
+    stats->driver = BLOCKDEV_DRIVER_HOST_DEVICE;
+    stats->u.host_device = get_blockstats_specific_file(bs);
+
+    return stats;
+}
+
 static QemuOptsList raw_create_opts = {
     .name = "raw-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(raw_create_opts.head),
@@ -2960,6 +2990,7 @@ BlockDriver bdrv_file = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_specific_stats = raw_get_specific_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
@@ -3438,6 +3469,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_specific_stats = hdev_get_specific_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
diff --git a/block/qapi.c b/block/qapi.c
index 69c35c4196..9a5d0c9b27 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -543,6 +543,11 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
 
     s->stats->wr_highest_offset = stat64_get(&bs->wr_highest_offset);
 
+    s->driver_specific = bdrv_get_specific_stats(bs);
+    if (s->driver_specific) {
+        s->has_driver_specific = true;
+    }
+
     if (bs->file) {
         s->has_parent = true;
         s->parent = bdrv_query_bds_stats(bs->file->bs, blk_level);
-- 
2.17.1


