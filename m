Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C1C606A7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4E620651
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="N9cPepx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4E620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQ20-0001ss-Ck
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 05:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pizhenwei@bytedance.com>) id 1hkQ0y-0000so-Vf
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1hkQ0w-00056i-O0
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:52 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1hkQ0u-0004zF-OT
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:50 -0400
Received: by mail-pf1-x441.google.com with SMTP id r1so7283631pfq.12
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KK+YGEA0uSCnrX+5Jr/a/tEimY4fAc66vitG4iWRbas=;
 b=N9cPepx5lucgL54X7VFcnhf4ZIB1DTXIsvsUmogTHCvZ0nqjL53pL9IcJm9kNwU95t
 DNTqQG9pdm8RJhaCAwJBlvKE7Lnz8oHSiiXOB/H7RFIkcKSb6ct89vWSCRPvQG9Jn5O4
 VHz9ojYSItRZdQZjIUnpXAW29YmzDJ/X2zLNYurf+dYZ8uYpZbWd1XYG1J3rijL6UjQJ
 ZxA50pYLuic4t8UkZmVEHSKdAXaUPvONk0nKxbpLuYuVVgzy42YHNEqbeTPW4oW4Vx6G
 AOqKogMfDSaVkDPnFAMbMf1TA6I4uKE2I/0vdkfF0vBs+PGZ/P6HidgB3SNs4Aple8s6
 OLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KK+YGEA0uSCnrX+5Jr/a/tEimY4fAc66vitG4iWRbas=;
 b=uGwAqHHaah89Rn3IJnD++LPy1T+7oiwyxXSXPwfBS//7PsncSmBPXGsrDw9Ma566or
 U/t8XS/R9u0T4QE0elUJ7ObMutAIM5h+VjUUw+mftE+PLchGgVmRjrTxu97TO1kOwWua
 R74TXjJjrjk/2JDX+9B7nbXSBJF4KEt1gXu06WRGmAYSkEavQunh9EKm4dz7mN9TtOCJ
 rOAKnK1HleQ05lXJxCOavw7XEwvfc0mSzWBAqisKfD/RVLJt2BiTaXiKWtiCJ0emeoE7
 vrsKIHv7TVHye3rGz3ioyPjKkTlM/5+Uj7MBZiSwyMUMw3JrYCKPVhBT/H/b0oH5tv1y
 A1gg==
X-Gm-Message-State: APjAAAV+uniRr081iRH9zWwjxewhFXXcgsdYEJkaCavhYHL+q/nBz6h0
 ax+X/fv5mlJwsY/sGKYj2X8fwQ==
X-Google-Smtp-Source: APXvYqzhCC+trjTr9MSTCg3rKN6uqQEbr8x44acp9RL7Y2CyTPpir6S33Jryp23n3jHBRTi4Uc/nyw==
X-Received: by 2002:a63:e5a:: with SMTP id 26mr21306749pgo.3.1562578357839;
 Mon, 08 Jul 2019 02:32:37 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id q7sm236504pff.2.2019.07.08.02.32.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 08 Jul 2019 02:32:37 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kwolf@redhat.com,
	vsementsov@virtuozzo.com,
	eblake@redhat.com
Date: Mon,  8 Jul 2019 17:32:27 +0800
Message-Id: <1562578349-12333-2-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562578349-12333-1-git-send-email-pizhenwei@bytedance.com>
References: <1562578349-12333-1-git-send-email-pizhenwei@bytedance.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 1/3] block/accounting: rename struct
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pizhenwei@bytedance.com,
 mreitz@redhat.com
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


