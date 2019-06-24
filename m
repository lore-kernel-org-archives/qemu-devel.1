Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438C6C48BE8
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152E620674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="IfDy3cys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152E620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfIpK-00063A-8Q
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pizhenwei@bytedance.com>) id 1hfIna-0004cA-2n
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1hfInX-0003Cq-Aw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:49:53 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1hfInU-000301-Cd
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:49:49 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so6561444pgj.7
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KK+YGEA0uSCnrX+5Jr/a/tEimY4fAc66vitG4iWRbas=;
 b=IfDy3cysG+tq1Ob4DJ7brxU8iHWSBgVk2XYJ2WPZLQKtOraT6xJqxCw/udiT5Ohau1
 sTUUcMwmZocDs72CZ5Vy9FoLTBF7bMfoZS6VeY6sFa0Jz15dk6Pz2kz7DWlLDx0uUs/r
 HHgpoPXtwC6BMt2iLyvAKKpBMY70i7zFUX8l3xYVn//moEqT5oG+tZtBNnpIK4Cu6wAF
 db52lFEDtEgxLlqSJ0Whr+kgUF93oaU4OSAw9eUx1k6qg3uVMIm5hVN8PZ/j3RUf1n5+
 a4u5pYhjyMuuXRSuFow6nQ0IFB2ewS7E11fL87BIcBvSw12UYA83L+ob4f80LDQWr5V7
 sIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KK+YGEA0uSCnrX+5Jr/a/tEimY4fAc66vitG4iWRbas=;
 b=ghcHcMSAIMxC+VguNU1BpFwmBRBuqaN4E8EhluWro7ocrQmtrPvAuQ73u0O+4+gyV6
 YWjP7fHyc10WryDgYakK1VIZFat5B6M5sD2e11mQ2pmJp9tWzmOlpNSSjFfJXUT4OZzH
 jUXWhnowiV7uXSf352Df2KoVQw0Ge8XhDT6FPaXBop1DU1+TMFGMNIGTAohSTLawDcfu
 BJkck8F6ePunNnIaI2Lgmyh2wiJPfrGl5sUztqIME4wrNm7muAMGlDk7RCLCVYT5k6KT
 EG6ZgB5HZa/j7qESPX5kgkR3UcU4SGy+mlW2jaU8g5jv+syaj/oYNdk4AMg+zu0JNJhM
 +NTQ==
X-Gm-Message-State: APjAAAVfjZZMIGBFim4PxpkwGx/YLlg/utXasX/2DqfQkiHGHU7qYIF4
 kmzAkFWIAtKfFS39vN6GR8UCYg==
X-Google-Smtp-Source: APXvYqx2FpgsyMhBTG1p/95UuwZbslrZlNum1M4oVHZcS5LyxNlepvtrJUj6wxDe6N7sbSCjTH+hwA==
X-Received: by 2002:a63:f146:: with SMTP id o6mr30655438pgk.179.1561358985979; 
 Sun, 23 Jun 2019 23:49:45 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id n17sm17734259pfq.182.2019.06.23.23.49.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 23 Jun 2019 23:49:45 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kwolf@redhat.com,
	mreitz@redhat.com,
	eblake@redhat.com
Date: Mon, 24 Jun 2019 14:49:34 +0800
Message-Id: <1561358976-5183-2-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561358976-5183-1-git-send-email-pizhenwei@bytedance.com>
References: <1561358976-5183-1-git-send-email-pizhenwei@bytedance.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH V2 1/3] block/accounting: rename struct
 BlockLatencyHistogram
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

Rename struct BlockLatencyHistogram to BlockHistogram, and rename
related functions.
Make this struct and functions be common, they can be used widely.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/accounting.c         | 44 +++++++++++++++++++++++++++-----------------
 block/qapi.c               | 23 +++++++++++------------
 include/block/accounting.h |  8 ++++----
 3 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index 70a3d9a426..d210a73fe9 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -94,13 +94,14 @@ void block_acct_start(BlockAcctStats *stats, BlockAcctCookie *cookie,
     cookie->type = type;
 }
 
-/* block_latency_histogram_compare_func:
+/**
+ * block_histogram_compare_func:
  * Compare @key with interval [@it[0], @it[1]).
  * Return: -1 if @key < @it[0]
  *          0 if @key in [@it[0], @it[1])
  *         +1 if @key >= @it[1]
  */
-static int block_latency_histogram_compare_func(const void *key, const void *it)
+static int block_histogram_compare_func(const void *key, const void *it)
 {
     uint64_t k = *(uint64_t *)key;
     uint64_t a = ((uint64_t *)it)[0];
@@ -109,8 +110,7 @@ static int block_latency_histogram_compare_func(const void *key, const void *it)
     return k < a ? -1 : (k < b ? 0 : 1);
 }
 
-static void block_latency_histogram_account(BlockLatencyHistogram *hist,
-                                            int64_t latency_ns)
+static void block_histogram_account(BlockHistogram *hist, int64_t val)
 {
     uint64_t *pos;
 
@@ -120,28 +120,26 @@ static void block_latency_histogram_account(BlockLatencyHistogram *hist,
     }
 
 
-    if (latency_ns < hist->boundaries[0]) {
+    if (val < hist->boundaries[0]) {
         hist->bins[0]++;
         return;
     }
 
-    if (latency_ns >= hist->boundaries[hist->nbins - 2]) {
+    if (val >= hist->boundaries[hist->nbins - 2]) {
         hist->bins[hist->nbins - 1]++;
         return;
     }
 
-    pos = bsearch(&latency_ns, hist->boundaries, hist->nbins - 2,
+    pos = bsearch(&val, hist->boundaries, hist->nbins - 2,
                   sizeof(hist->boundaries[0]),
-                  block_latency_histogram_compare_func);
+                  block_histogram_compare_func);
     assert(pos != NULL);
 
     hist->bins[pos - hist->boundaries + 1]++;
 }
 
-int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
-                                uint64List *boundaries)
+static int block_histogram_set(BlockHistogram *hist, uint64List *boundaries)
 {
-    BlockLatencyHistogram *hist = &stats->latency_histogram[type];
     uint64List *entry;
     uint64_t *ptr;
     uint64_t prev = 0;
@@ -170,15 +168,27 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
     return 0;
 }
 
+static void block_histogram_clear(BlockHistogram *hist)
+{
+    g_free(hist->bins);
+    g_free(hist->boundaries);
+    memset(hist, 0, sizeof(*hist));
+}
+
+int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
+                                uint64List *boundaries)
+{
+    BlockHistogram *hist = &stats->latency_histogram[type];
+
+    return block_histogram_set(hist, boundaries);
+}
+
 void block_latency_histograms_clear(BlockAcctStats *stats)
 {
     int i;
 
     for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
-        BlockLatencyHistogram *hist = &stats->latency_histogram[i];
-        g_free(hist->bins);
-        g_free(hist->boundaries);
-        memset(hist, 0, sizeof(*hist));
+        block_histogram_clear(&stats->latency_histogram[i]);
     }
 }
 
@@ -204,8 +214,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
         stats->nr_ops[cookie->type]++;
     }
 
-    block_latency_histogram_account(&stats->latency_histogram[cookie->type],
-                                    latency_ns);
+    block_histogram_account(&stats->latency_histogram[cookie->type],
+                            latency_ns);
 
     if (!failed || stats->account_failed) {
         stats->total_time_ns[cookie->type] += latency_ns;
diff --git a/block/qapi.c b/block/qapi.c
index 917435f022..9d9b2f1927 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -415,9 +415,8 @@ static uint64List *uint64_list(uint64_t *list, int size)
     return out_list;
 }
 
-static void bdrv_latency_histogram_stats(BlockLatencyHistogram *hist,
-                                         bool *not_null,
-                                         BlockLatencyHistogramInfo **info)
+static void bdrv_histogram_stats(BlockHistogram *hist, bool *not_null,
+                                 BlockLatencyHistogramInfo **info)
 {
     *not_null = hist->bins != NULL;
     if (*not_null) {
@@ -494,15 +493,15 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
             block_acct_queue_depth(ts, BLOCK_ACCT_WRITE);
     }
 
-    bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_READ],
-                                 &ds->has_rd_latency_histogram,
-                                 &ds->rd_latency_histogram);
-    bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_WRITE],
-                                 &ds->has_wr_latency_histogram,
-                                 &ds->wr_latency_histogram);
-    bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_FLUSH],
-                                 &ds->has_flush_latency_histogram,
-                                 &ds->flush_latency_histogram);
+    bdrv_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_READ],
+                         &ds->has_rd_latency_histogram,
+                         &ds->rd_latency_histogram);
+    bdrv_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_WRITE],
+                         &ds->has_wr_latency_histogram,
+                         &ds->wr_latency_histogram);
+    bdrv_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_FLUSH],
+                         &ds->has_flush_latency_histogram,
+                         &ds->flush_latency_histogram);
 }
 
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
diff --git a/include/block/accounting.h b/include/block/accounting.h
index d1f67b10dd..270fddb69c 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -46,7 +46,7 @@ struct BlockAcctTimedStats {
     QSLIST_ENTRY(BlockAcctTimedStats) entries;
 };
 
-typedef struct BlockLatencyHistogram {
+typedef struct BlockHistogram {
     /* The following histogram is represented like this:
      *
      * 5|           *
@@ -57,7 +57,7 @@ typedef struct BlockLatencyHistogram {
      *  +------------------
      *      10   50   100
      *
-     * BlockLatencyHistogram histogram = {
+     * BlockHistogram histogram = {
      *     .nbins = 4,
      *     .boundaries = {10, 50, 100},
      *     .bins = {3, 1, 5, 2},
@@ -74,7 +74,7 @@ typedef struct BlockLatencyHistogram {
     uint64_t *boundaries; /* @nbins-1 numbers here
                              (all boundaries, except 0 and +inf) */
     uint64_t *bins;
-} BlockLatencyHistogram;
+} BlockHistogram;
 
 struct BlockAcctStats {
     QemuMutex lock;
@@ -88,7 +88,7 @@ struct BlockAcctStats {
     QSLIST_HEAD(, BlockAcctTimedStats) intervals;
     bool account_invalid;
     bool account_failed;
-    BlockLatencyHistogram latency_histogram[BLOCK_MAX_IOTYPE];
+    BlockHistogram latency_histogram[BLOCK_MAX_IOTYPE];
 };
 
 typedef struct BlockAcctCookie {
-- 
2.11.0


