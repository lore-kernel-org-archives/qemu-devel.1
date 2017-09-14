Received: from eggs.gnu.org ([2001:4830:134:3::10]:52194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dsRZi-0006pz-15
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dsRZd-0001xp-OK
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:50 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dsRZd-0001wd-DV
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:45 -0400
Received: by mail-wr0-x244.google.com with SMTP id u48so1465652wrf.4
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 03:40:45 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 14 Sep 2017 06:40:07 -0400
Message-Id: <1505385610-35529-4-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v11 3/6] qmp: factor out throttle code to reuse
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This patch reuses the code to set throttle limits.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 blockdev.c | 53 +++--------------------------------------------------
 1 file changed, 3 insertions(+), 50 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 9d33c25..2bd8ebd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2569,6 +2569,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    ThrottleLimits *tlimit;
 
     blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -2586,56 +2587,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
         goto out;
     }
 
-    throttle_config_init(&cfg);
-    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
-    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
-    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
-
-    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
-    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
-    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
-
-    if (arg->has_bps_max) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
-    }
-    if (arg->has_bps_rd_max) {
-        cfg.buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
-    }
-    if (arg->has_bps_wr_max) {
-        cfg.buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
-    }
-    if (arg->has_iops_max) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
-    }
-    if (arg->has_iops_rd_max) {
-        cfg.buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
-    }
-    if (arg->has_iops_wr_max) {
-        cfg.buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
-    }
-
-    if (arg->has_bps_max_length) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
-    }
-    if (arg->has_bps_rd_max_length) {
-        cfg.buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
-    }
-    if (arg->has_bps_wr_max_length) {
-        cfg.buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
-    }
-    if (arg->has_iops_max_length) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
-    }
-    if (arg->has_iops_rd_max_length) {
-        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
-    }
-    if (arg->has_iops_wr_max_length) {
-        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
-    }
-
-    if (arg->has_iops_size) {
-        cfg.op_size = arg->iops_size;
-    }
+    tlimit = qapi_BlockIOThrottle_base(arg);
+    throttle_config_to_limits(&cfg, tlimit);
 
     if (!throttle_is_valid(&cfg, errp)) {
         goto out;
-- 
1.8.3.1
