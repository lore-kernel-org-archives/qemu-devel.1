Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD4C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37C6206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37C6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXbK-0003FT-8c
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrT-0007BZ-EV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrS-0008Md-46
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrO-0008LP-JR; Thu, 10 Oct 2019 07:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CBA3310CC1EC;
 Thu, 10 Oct 2019 11:43:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46A575DAAC;
 Thu, 10 Oct 2019 11:43:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 25/36] qapi: query-blockstat: add driver specific file-posix
 stats
Date: Thu, 10 Oct 2019 13:42:49 +0200
Message-Id: <20191010114300.7746-26-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 10 Oct 2019 11:43:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

A block driver can provide a callback to report driver-specific
statistics.

file-posix driver now reports discard statistics

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20190923121737.83281-10-anton.nefedov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
=20
+##
+# @BlockStatsSpecificFile:
+#
+# File driver statistics
+#
+# @discard-nb-ok: The number of successful discard operations performed =
by
+#                 the driver.
+#
+# @discard-nb-failed: The number of failed discard operations performed =
by
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
=20
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
+    BlockStatsSpecific *(*bdrv_get_specific_stats)(BlockDriverState *bs)=
;
=20
     int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
                                           QEMUIOVector *qiov,
diff --git a/block.c b/block.c
index 1c7c199849..1946fc6f57 100644
--- a/block.c
+++ b/block.c
@@ -5155,6 +5155,15 @@ ImageInfoSpecific *bdrv_get_specific_info(BlockDri=
verState *bs,
     return NULL;
 }
=20
+BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs)
+{
+    BlockDriver *drv =3D bs->drv;
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
@@ -2753,6 +2753,36 @@ static int raw_get_info(BlockDriverState *bs, Bloc=
kDriverInfo *bdi)
     return 0;
 }
=20
+static BlockStatsSpecificFile get_blockstats_specific_file(BlockDriverSt=
ate *bs)
+{
+    BDRVRawState *s =3D bs->opaque;
+    return (BlockStatsSpecificFile) {
+        .discard_nb_ok =3D s->stats.discard_nb_ok,
+        .discard_nb_failed =3D s->stats.discard_nb_failed,
+        .discard_bytes_ok =3D s->stats.discard_bytes_ok,
+    };
+}
+
+static BlockStatsSpecific *raw_get_specific_stats(BlockDriverState *bs)
+{
+    BlockStatsSpecific *stats =3D g_new(BlockStatsSpecific, 1);
+
+    stats->driver =3D BLOCKDEV_DRIVER_FILE;
+    stats->u.file =3D get_blockstats_specific_file(bs);
+
+    return stats;
+}
+
+static BlockStatsSpecific *hdev_get_specific_stats(BlockDriverState *bs)
+{
+    BlockStatsSpecific *stats =3D g_new(BlockStatsSpecific, 1);
+
+    stats->driver =3D BLOCKDEV_DRIVER_HOST_DEVICE;
+    stats->u.host_device =3D get_blockstats_specific_file(bs);
+
+    return stats;
+}
+
 static QemuOptsList raw_create_opts =3D {
     .name =3D "raw-create-opts",
     .head =3D QTAILQ_HEAD_INITIALIZER(raw_create_opts.head),
@@ -2960,6 +2990,7 @@ BlockDriver bdrv_file =3D {
     .bdrv_get_info =3D raw_get_info,
     .bdrv_get_allocated_file_size
                         =3D raw_get_allocated_file_size,
+    .bdrv_get_specific_stats =3D raw_get_specific_stats,
     .bdrv_check_perm =3D raw_check_perm,
     .bdrv_set_perm   =3D raw_set_perm,
     .bdrv_abort_perm_update =3D raw_abort_perm_update,
@@ -3438,6 +3469,7 @@ static BlockDriver bdrv_host_device =3D {
     .bdrv_get_info =3D raw_get_info,
     .bdrv_get_allocated_file_size
                         =3D raw_get_allocated_file_size,
+    .bdrv_get_specific_stats =3D hdev_get_specific_stats,
     .bdrv_check_perm =3D raw_check_perm,
     .bdrv_set_perm   =3D raw_set_perm,
     .bdrv_abort_perm_update =3D raw_abort_perm_update,
diff --git a/block/qapi.c b/block/qapi.c
index 69c35c4196..9a5d0c9b27 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -543,6 +543,11 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverS=
tate *bs,
=20
     s->stats->wr_highest_offset =3D stat64_get(&bs->wr_highest_offset);
=20
+    s->driver_specific =3D bdrv_get_specific_stats(bs);
+    if (s->driver_specific) {
+        s->has_driver_specific =3D true;
+    }
+
     if (bs->file) {
         s->has_parent =3D true;
         s->parent =3D bdrv_query_bds_stats(bs->file->bs, blk_level);
--=20
2.21.0


