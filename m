Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D8C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7509320675
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7509320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHX7-0003gm-Nk
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:38:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRHRt-00081f-GZ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRHRr-0004K7-FL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:33:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:39694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRHRn-0004EI-N5; Thu, 16 May 2019 10:33:27 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRHRm-0007Lk-FQ; Thu, 16 May 2019 17:33:26 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Thu, 16 May 2019 17:33:14 +0300
Message-Id: <20190516143314.81302-10-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 9/9] qapi: query-blockstat: add driver
 specific file-posix stats
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
 block/file-posix.c        | 38 +++++++++++++++++++++++++++++++++++---
 block/qapi.c              |  5 +++++
 6 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 55194f84ce..368e09ae37 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -956,6 +956,41 @@
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
+# Since: 4.1
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
+# Since: 4.1
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
@@ -971,6 +1006,8 @@
 #
 # @stats:  A @BlockDeviceStats for the device.
 #
+# @driver-specific: Optional driver-specific stats. (Since 4.1)
+#
 # @parent: This describes the file block device if it has one.
 #          Contains recursively the statistics of the underlying
 #          protocol (e.g. the host file for a qcow2 image). If there is
@@ -984,6 +1021,7 @@
 { 'struct': 'BlockStats',
   'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
            'stats': 'BlockDeviceStats',
+           '*driver-specific': 'BlockStatsSpecific',
            '*parent': 'BlockStats',
            '*backing': 'BlockStats'} }
 
diff --git a/include/block/block.h b/include/block/block.h
index 5e2b98b0ee..b182f0c7ae 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -490,6 +490,7 @@ int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
                                           Error **errp);
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
 void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 94d45c9708..dc3bc97ea3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -358,6 +358,7 @@ struct BlockDriver {
     int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
     ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs,
                                                  Error **errp);
+    BlockStatsSpecific *(*bdrv_get_specific_stats)(BlockDriverState *bs);
 
     int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
                                           QEMUIOVector *qiov,
diff --git a/block.c b/block.c
index 6999aad446..f68fb5aaec 100644
--- a/block.c
+++ b/block.c
@@ -4942,6 +4942,15 @@ ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
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
index 76d54b3a85..a2f01cfe10 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -160,9 +160,9 @@ typedef struct BDRVRawState {
     bool drop_cache;
     bool check_cache_dropped;
     struct {
-        int64_t discard_nb_ok;
-        int64_t discard_nb_failed;
-        int64_t discard_bytes_ok;
+        uint64_t discard_nb_ok;
+        uint64_t discard_nb_failed;
+        uint64_t discard_bytes_ok;
     } stats;
 
     PRManager *pr_mgr;
@@ -2723,6 +2723,36 @@ static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
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
@@ -2922,6 +2952,7 @@ BlockDriver bdrv_file = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_specific_stats = raw_get_specific_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
@@ -3400,6 +3431,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_get_specific_stats = hdev_get_specific_stats,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
diff --git a/block/qapi.c b/block/qapi.c
index f9447a3297..3afcb9dc5c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -537,6 +537,11 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
 
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


