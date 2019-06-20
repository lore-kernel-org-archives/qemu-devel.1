Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4FC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9EE2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Hqi915xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9EE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdt6F-0001zh-3H
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pizhenwei@bytedance.com>) id 1hdsqT-0006Tl-OT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1hdsqQ-0006bG-3s
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:55:01 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1hdsqP-0006Rx-IO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:54:57 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so1125043plo.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cJCSKKTdv36gQrhbcBLvJk3JSqEM/emgmnMnXZozayA=;
 b=Hqi915xy8KXEeOk4cdmf0eqP6dV7aCQRI+ZsyZ3JdA8kfV/ZNan1lUUSo/L261OFVS
 fIZNEHVtbooqSCGixGiuL/6KuRrvoj+WP4g+fL45YvZlWY5POoQB0mhBMPXsHjB+/5tY
 Kc6YrGgPeRSKcADx1pS47p0C5RP8B1VdYcajvrydKqGCfSXdLBkivia50sXqcYNAwXpT
 9P2xUPBcDQT+sI+yB/46Ik1qqcpN7oif8dLL0J0Nf8PpxTnZX7QUVzwSwaMdJum4fps3
 zhnQF2YZMYcEjl2wBdzUiVZVWkP/Vy+k2lhdV3Qa5//qIoA2ygBOwheOBhO0HCNnu+ac
 A7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cJCSKKTdv36gQrhbcBLvJk3JSqEM/emgmnMnXZozayA=;
 b=ld3bF131kkFvLwazqZfUHg3T3qayCQv7AmFHntEKDcheYVz9wAo3yV2zl1B8QuIgvv
 XODtbwPaF6SGnMyqIDwOrrs3PE7ucYUTwHi60gG+dMVkD0HwV/qWY6yFZxndFKNOvNX1
 a1D7t3ng+3puZXcUQTsaHAMP1k9boUwGpLXk9PJBBmXBPZIVaQMo9aKbmFaxIC11znBM
 ODKk0k5iWTgyG4dTC1rjVldb3cCA7MpiN854gtWz+uMjALTiVFY9RjQEznfi2IwOJm8e
 jY5mlr6x5w/ta+XcIFUOUgox2sGrh4BRxAdd92dGHygK7ASkMBZhvd15UBGUNlt5Qb2j
 w6Eg==
X-Gm-Message-State: APjAAAXxTfhVJi0KMtLwN7SuES0n8u7kdeI3Ufa3E6jvI/bhVKi8yzjS
 j0+07iDf42B5Gps7KSPjlCAY+A==
X-Google-Smtp-Source: APXvYqxPUQarjZRECDRpVMn8zyMg+9NOJHPCd0iUNqGGSMV5lDrbzYVQZhOvay2msvKhbS34wtXh4g==
X-Received: by 2002:a17:902:30a3:: with SMTP id
 v32mr125234768plb.6.1561020887182; 
 Thu, 20 Jun 2019 01:54:47 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id c11sm19240635pgg.2.2019.06.20.01.54.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 20 Jun 2019 01:54:46 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kwolf@redhat.com,
	mreitz@redhat.com
Date: Thu, 20 Jun 2019 16:54:32 +0800
Message-Id: <1561020872-6214-4-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561020872-6214-1-git-send-email-pizhenwei@bytedance.com>
References: <1561020872-6214-1-git-send-email-pizhenwei@bytedance.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 3/3] qapi: add block size histogram interface
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
Cc: fam@euphon.net, qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, pizhenwei@bytedance.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set/Clear block size histograms through new command
x-block-size-histogram-set and show new statistics in
query-blockstats results.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/qapi.c         |  24 ++++++++++++
 blockdev.c           |  56 +++++++++++++++++++++++++++
 qapi/block-core.json | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/block/qapi.c b/block/qapi.c
index f3a84f776e..04edbd5243 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -428,6 +428,20 @@ static void bdrv_latency_histogram_stats(BlockHistogram *hist,
     }
 }
 
+static void bdrv_size_histogram_stats(BlockHistogram *hist,
+                                         bool *not_null,
+                                         BlockSizeHistogramInfo **info)
+{
+    *not_null = hist->bins != NULL;
+    if (*not_null) {
+        *info = g_new0(BlockSizeHistogramInfo, 1);
+
+        (*info)->boundaries = uint64_list(hist->boundaries, hist->nbins - 1);
+        (*info)->bins = uint64_list(hist->bins, hist->nbins);
+    }
+}
+
+
 static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 {
     BlockAcctStats *stats = blk_get_stats(blk);
@@ -503,6 +517,16 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
     bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_FLUSH],
                                  &ds->has_flush_latency_histogram,
                                  &ds->flush_latency_histogram);
+
+    bdrv_size_histogram_stats(&stats->size_histogram[BLOCK_ACCT_READ],
+                                 &ds->has_x_rd_size_histogram,
+                                 &ds->x_rd_size_histogram);
+    bdrv_size_histogram_stats(&stats->size_histogram[BLOCK_ACCT_WRITE],
+                                 &ds->has_x_wr_size_histogram,
+                                 &ds->x_wr_size_histogram);
+    bdrv_size_histogram_stats(&stats->size_histogram[BLOCK_ACCT_FLUSH],
+                                 &ds->has_x_flush_size_histogram,
+                                 &ds->x_flush_size_histogram);
 }
 
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
diff --git a/blockdev.c b/blockdev.c
index 5d6a13dea9..c3f893891d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4563,6 +4563,62 @@ void qmp_block_latency_histogram_set(
     }
 }
 
+void qmp_x_block_size_histogram_set(
+    const char *id,
+    bool has_boundaries, uint64List *boundaries,
+    bool has_boundaries_read, uint64List *boundaries_read,
+    bool has_boundaries_write, uint64List *boundaries_write,
+    bool has_boundaries_flush, uint64List *boundaries_flush,
+    Error **errp)
+{
+    BlockBackend *blk = qmp_get_blk(NULL, id, errp);
+    BlockAcctStats *stats;
+    int ret;
+
+    if (!blk) {
+        return;
+    }
+
+    stats = blk_get_stats(blk);
+
+    if (!has_boundaries && !has_boundaries_read && !has_boundaries_write &&
+        !has_boundaries_flush)
+    {
+        block_size_histograms_clear(stats);
+        return;
+    }
+
+    if (has_boundaries || has_boundaries_read) {
+        ret = block_size_histogram_set(
+            stats, BLOCK_ACCT_READ,
+            has_boundaries_read ? boundaries_read : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set read boundaries fail", id);
+            return;
+        }
+    }
+
+    if (has_boundaries || has_boundaries_write) {
+        ret = block_size_histogram_set(
+            stats, BLOCK_ACCT_WRITE,
+            has_boundaries_write ? boundaries_write : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set write boundaries fail", id);
+            return;
+        }
+    }
+
+    if (has_boundaries || has_boundaries_flush) {
+        ret = block_size_histogram_set(
+            stats, BLOCK_ACCT_FLUSH,
+            has_boundaries_flush ? boundaries_flush : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set flush boundaries fail", id);
+            return;
+        }
+    }
+}
+
 QemuOptsList qemu_common_drive_opts = {
     .name = "drive",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..cae45c9db5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -633,6 +633,100 @@
            '*boundaries-flush': ['uint64'] } }
 
 ##
+# @BlockSizeHistogramInfo:
+#
+# Block size histogram.
+#
+# @boundaries: list of interval boundary values in nanoseconds, all greater
+#              than zero and in ascending order.
+#              For example, the list [8193, 32769, 131073] produces the
+#              following histogram intervals:
+#              [0, 8193), [8193, 32769), [32769, 131073), [131073, +inf).
+#
+# @bins: list of io request counts corresponding to histogram intervals.
+#        len(@bins) = len(@boundaries) + 1
+#        For the example above, @bins may be something like [6, 3, 7, 9],
+#        and corresponding histogram looks like:
+#
+# Since: 4.0
+##
+{ 'struct': 'BlockSizeHistogramInfo',
+  'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
+
+##
+# @x-block-size-histogram-set:
+#
+# Manage read, write and flush size histograms for the device.
+#
+# If only @id parameter is specified, remove all present size histograms
+# for the device. Otherwise, add/reset some of (or all) size histograms.
+#
+# @id: The name or QOM path of the guest device.
+#
+# @boundaries: list of interval boundary values (see description in
+#              BlockSizeHistogramInfo definition). If specified, all
+#              size histograms are removed, and empty ones created for all
+#              io types with intervals corresponding to @boundaries (except for
+#              io types, for which specific boundaries are set through the
+#              following parameters).
+#
+# @boundaries-read: list of interval boundary values for read size
+#                   histogram. If specified, old read size histogram is
+#                   removed, and empty one created with intervals
+#                   corresponding to @boundaries-read. The parameter has higher
+#                   priority then @boundaries.
+#
+# @boundaries-write: list of interval boundary values for write size
+#                    histogram.
+#
+# @boundaries-flush: list of interval boundary values for flush size
+#                    histogram.
+#
+# Returns: error if device is not found or any boundary arrays are invalid.
+#
+# Since: 4.0
+#
+# Example: set new histograms for all io types with intervals
+# [0, 8193), [8193, 32769), [32769, 131073), [131073, +inf):
+#
+# -> { "execute": "x-block-size-histogram-set",
+#      "arguments": { "id": "drive0",
+#                     "boundaries": [8193, 32769, 131073] } }
+# <- { "return": {} }
+#
+# Example: set new histogram only for write, other histograms will remain
+# not changed (or not created):
+#
+# -> { "execute": "x-block-size-histogram-set",
+#      "arguments": { "id": "drive0",
+#                     "boundaries-write": [8193, 32769, 131073] } }
+# <- { "return": {} }
+#
+# Example: set new histograms with the following intervals:
+#   read, flush: [0, 8193), [8193, 32769), [32769, 131073), [131073, +inf)
+#   write: [0, 4097), [4097, 8193), [8193, 32769), [32769, +inf)
+#
+# -> { "execute": "x-block-size-histogram-set",
+#      "arguments": { "id": "drive0",
+#                     "boundaries": [8193, 32769, 131073],
+#                     "boundaries-write": [4097, 8193, 32769] } }
+# <- { "return": {} }
+#
+# Example: remove all size histograms:
+#
+# -> { "execute": "x-block-size-histogram-set",
+#      "arguments": { "id": "drive0" } }
+# <- { "return": {} }
+##
+{ 'command': 'x-block-size-histogram-set',
+  'data': {'id': 'str',
+           '*boundaries': ['uint64'],
+           '*boundaries-read': ['uint64'],
+           '*boundaries-write': ['uint64'],
+           '*boundaries-flush': ['uint64'] } }
+
+
+##
 # @BlockInfo:
 #
 # Block device information.  This structure describes a virtual device and
@@ -918,6 +1012,12 @@
 #
 # @flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 4.0)
 #
+# @x_rd_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)
+#
+# @x_wr_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)
+#
+# @x_flush_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
@@ -933,7 +1033,10 @@
            'timed_stats': ['BlockDeviceTimedStats'],
            '*rd_latency_histogram': 'BlockLatencyHistogramInfo',
            '*wr_latency_histogram': 'BlockLatencyHistogramInfo',
-           '*flush_latency_histogram': 'BlockLatencyHistogramInfo' } }
+           '*flush_latency_histogram': 'BlockLatencyHistogramInfo',
+           '*x_rd_size_histogram': 'BlockSizeHistogramInfo',
+           '*x_wr_size_histogram': 'BlockSizeHistogramInfo',
+           '*x_flush_size_histogram': 'BlockSizeHistogramInfo' } }
 
 ##
 # @BlockStats:
-- 
2.11.0


