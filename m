Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D467C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CCF20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CCF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwpn-0007t6-Ln
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jtwnx-0005MO-CR; Fri, 10 Jul 2020 13:27:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:57036 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jtwnu-0006dU-HA; Fri, 10 Jul 2020 13:27:21 -0400
Received: from [192.168.15.187] (helo=iris.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jtwnk-0008U2-DE; Fri, 10 Jul 2020 20:27:08 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] block: add logging facility for long standing IO requests
Date: Fri, 10 Jul 2020 20:27:11 +0300
Message-Id: <20200710172711.8059-3-den@openvz.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710172711.8059-1-den@openvz.org>
References: <20200710172711.8059-1-den@openvz.org>
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 13:27:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are severe delays with IO requests processing if QEMU is running in
virtual machine or over software defined storage. Such delays potentially
results in unpredictable guest behavior. For example, guests over IDE or
SATA drive could remount filesystem read-only if write is performed
longer than 10 seconds.

Such reports are very complex to process. Some good starting point for this
seems quite reasonable. This patch provides one. It adds logging of such
potentially dangerous long IO operations.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 block/accounting.c         | 59 +++++++++++++++++++++++++++++++++++++-
 blockdev.c                 |  7 ++++-
 include/block/accounting.h |  5 +++-
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index 8d41c8a83a..3002444fa5 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -27,7 +27,9 @@
 #include "block/accounting.h"
 #include "block/block_int.h"
 #include "qemu/timer.h"
+#include "qemu/log.h"
 #include "sysemu/qtest.h"
+#include "sysemu/block-backend.h"
 
 static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
 static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
@@ -41,10 +43,11 @@ void block_acct_init(BlockAcctStats *stats)
 }
 
 void block_acct_setup(BlockAcctStats *stats, bool account_invalid,
-                      bool account_failed)
+                      bool account_failed, unsigned latency_log_threshold_ms)
 {
     stats->account_invalid = account_invalid;
     stats->account_failed = account_failed;
+    stats->latency_log_threshold_ms = latency_log_threshold_ms;
 }
 
 void block_acct_cleanup(BlockAcctStats *stats)
@@ -182,6 +185,58 @@ void block_latency_histograms_clear(BlockAcctStats *stats)
     }
 }
 
+static const char *block_account_type(enum BlockAcctType type)
+{
+    switch (type) {
+    case BLOCK_ACCT_READ:
+        return "READ";
+    case BLOCK_ACCT_WRITE:
+        return "WRITE";
+    case BLOCK_ACCT_FLUSH:
+        return "DISCARD";
+    case BLOCK_ACCT_UNMAP:
+        return "TRUNCATE";
+    case BLOCK_ACCT_NONE:
+        return "NONE";
+    case BLOCK_MAX_IOTYPE:
+        break;
+    }
+    return "UNKNOWN";
+}
+
+static void block_acct_report_long(BlockAcctStats *stats,
+                                   BlockAcctCookie *cookie, int64_t latency_ns)
+{
+    unsigned latency_ms = latency_ns / 1000000;
+    int64_t start_time_host_s;
+    char buf[64];
+    struct tm t;
+    BlockDriverState *bs;
+
+    if (cookie->type == BLOCK_ACCT_NONE) {
+        return;
+    }
+    if (stats->latency_log_threshold_ms == 0) {
+        return;
+    }
+    if (latency_ms < stats->latency_log_threshold_ms) {
+        return;
+    }
+
+    start_time_host_s = cookie->start_time_ns / 1000000000ull;
+    strftime(buf, sizeof(buf), "%m-%d %H:%M:%S",
+             localtime_r(&start_time_host_s, &t));
+
+    bs = blk_bs(blk_stats2blk(stats));
+    qemu_log("long %s[%ld] IO request: %d.03%d since %s.%03d bs: %s(%s, %s)\n",
+             block_account_type(cookie->type), cookie->bytes,
+             (int)(latency_ms / 1000), (int)(latency_ms % 1000), buf,
+             (int)((cookie->start_time_ns / 1000000) % 1000),
+             bs == NULL ? "unknown" : bdrv_get_node_name(bs),
+             bs == NULL ? "unknown" : bdrv_get_format_name(bs),
+             bs == NULL ? "unknown" : bs->filename);
+}
+
 static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
                                  bool failed)
 {
@@ -222,6 +277,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
 
     qemu_mutex_unlock(&stats->lock);
 
+    block_acct_report_long(stats, cookie, latency_ns);
+
     cookie->type = BLOCK_ACCT_NONE;
 }
 
diff --git a/blockdev.c b/blockdev.c
index 31d5eaf6bf..d87260958c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -625,7 +625,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
 
         bs->detect_zeroes = detect_zeroes;
 
-        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed);
+        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
+                qemu_opt_get_number(opts, "latency-log-threshold", 0));
 
         if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
             blk_unref(blk);
@@ -3740,6 +3741,10 @@ QemuOptsList qemu_common_drive_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "whether to account for failed I/O operations "
                     "in the statistics",
+        },{
+            .name = "latency-log-threshold",
+            .type = QEMU_OPT_STRING,
+            .help = "threshold for long I/O report (disabled if <=0), in ms",
         },
         { /* end of list */ }
     },
diff --git a/include/block/accounting.h b/include/block/accounting.h
index 878b4c3581..c3ea25f9aa 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -91,6 +91,9 @@ struct BlockAcctStats {
     bool account_invalid;
     bool account_failed;
     BlockLatencyHistogram latency_histogram[BLOCK_MAX_IOTYPE];
+
+    /* Threshold for long I/O detection, ms */
+    unsigned latency_log_threshold_ms;
 };
 
 typedef struct BlockAcctCookie {
@@ -101,7 +104,7 @@ typedef struct BlockAcctCookie {
 
 void block_acct_init(BlockAcctStats *stats);
 void block_acct_setup(BlockAcctStats *stats, bool account_invalid,
-                     bool account_failed);
+                      bool account_failed, unsigned latency_log_threshold_ms);
 void block_acct_cleanup(BlockAcctStats *stats);
 void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
 BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
-- 
2.17.1


