Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E62C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0140520679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="IFtiLPEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0140520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfIs0-0000Bu-Av
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pizhenwei@bytedance.com>) id 1hfInc-0004dF-TL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1hfIna-0003Hl-0Q
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:49:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1hfInX-00035t-Rf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:49:52 -0400
Received: by mail-pl1-x642.google.com with SMTP id g4so6301971plb.5
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h8g/nC6vUT95D9nx3c9BGLOpS2Xrlhhb+4JSssXi+BA=;
 b=IFtiLPEbF3y2XTvShN4yk9BIFbZWnS9SjMG5Pd1YD3wACDtubaRGgQ4ZR/WhZVHr5d
 b8y7kdeydwwJ64+c8YHOF+JQbgzT982Nm64ctTgSNHtTvLg/2BmRteA5LegtaOplOml7
 W9LDTNYyZBZiLz4OEscdiiL5G/Rjdo9/SdWkqdF+jApf7R/EmGjggm5B007TYqK/iS6d
 Ppr7FyNIcMfZfscKnl1w6y+v+a+dbv73HJ0c4uNPX0eFpDmlo0jk0ProoELvARwEhMbx
 8uRJ0sNnKbIEqtcRHowWQX9/yCM3jiWdhNnkL/7ZXcRmqVyZQ7mx8C+Cm9Mk80HK5UHL
 qT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=h8g/nC6vUT95D9nx3c9BGLOpS2Xrlhhb+4JSssXi+BA=;
 b=pA9dg3VN6ZPmMPknCblVYfG3D7Qu/xexbD4dPAVlmRhZ3K7nnklQ7RALijHnTRoWDV
 4ZUUwdcyIATNKnZuc1UzIBxL27HEN+kDyi5jsEUE17fTZ4SwaEA8SRL3i1RYuJheJbzj
 ld/alcq4S+LqPO52fcp5qGsi0jdiY3owQdJXYiu28EVP9teJ+78v0vcgMuxFtiZphhc/
 BvCmsJd+sNkSjICYwhogZ/agEShwAXoy2N+emd/Tg0hy7Ehdq8EA2SdkW5ko97CuQZb4
 B4GuxRzM+0JerdR34ATOVmRvbpru+CrXhH/gJC+xug933Fd7y2yoIvI1IXYhSzwG+qMt
 GQTg==
X-Gm-Message-State: APjAAAXmV1kOJbQ78i24rRS6akqcCMAbjOMB5GMxuqjLBVO5sMjcjkAa
 ENy+/dzxVSTP7yqLjp2Axa3BnQ==
X-Google-Smtp-Source: APXvYqwpCmcMvTfnVXBoxY1paM6DWUYbBjd6EZTR+7lZ2h55ByO/PJsnEatwV85Nzq5uwxSlWXYnOQ==
X-Received: by 2002:a17:902:2ae7:: with SMTP id
 j94mr62003836plb.270.1561358988845; 
 Sun, 23 Jun 2019 23:49:48 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id n17sm17734259pfq.182.2019.06.23.23.49.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 23 Jun 2019 23:49:48 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kwolf@redhat.com,
	mreitz@redhat.com,
	eblake@redhat.com
Date: Mon, 24 Jun 2019 14:49:35 +0800
Message-Id: <1561358976-5183-3-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561358976-5183-1-git-send-email-pizhenwei@bytedance.com>
References: <1561358976-5183-1-git-send-email-pizhenwei@bytedance.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH V2 2/3] block/accounting: introduce block size
 histogram
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

Introduce block size histogram statics for block devices.

For read/write/flush operation type, the block size region
[0, +inf) is divided into subregions by several points.
It works like block latency histogram.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/accounting.c         | 18 ++++++++++++++++++
 include/block/accounting.h |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/block/accounting.c b/block/accounting.c
index d210a73fe9..3a1e41a971 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -192,6 +192,22 @@ void block_latency_histograms_clear(BlockAcctStats *stats)
     }
 }
 
+int block_size_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
+                             uint64List *boundaries)
+{
+    BlockHistogram *hist = &stats->size_histogram[type];
+
+    return block_histogram_set(hist, boundaries);
+}
+
+void block_size_histograms_clear(BlockAcctStats *stats)
+{
+    int i;
+
+    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
+        block_histogram_clear(&stats->size_histogram[i]);
+    }
+}
 static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
                                  bool failed)
 {
@@ -216,6 +232,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
 
     block_histogram_account(&stats->latency_histogram[cookie->type],
                             latency_ns);
+    block_histogram_account(&stats->size_histogram[cookie->type],
+                            cookie->bytes);
 
     if (!failed || stats->account_failed) {
         stats->total_time_ns[cookie->type] += latency_ns;
diff --git a/include/block/accounting.h b/include/block/accounting.h
index 270fddb69c..0fbba64408 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -89,6 +89,7 @@ struct BlockAcctStats {
     bool account_invalid;
     bool account_failed;
     BlockHistogram latency_histogram[BLOCK_MAX_IOTYPE];
+    BlockHistogram size_histogram[BLOCK_MAX_IOTYPE];
 };
 
 typedef struct BlockAcctCookie {
@@ -117,5 +118,7 @@ double block_acct_queue_depth(BlockAcctTimedStats *stats,
 int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
                                 uint64List *boundaries);
 void block_latency_histograms_clear(BlockAcctStats *stats);
-
+int block_size_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
+                             uint64List *boundaries);
+void block_size_histograms_clear(BlockAcctStats *stats);
 #endif
-- 
2.11.0


