Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3D0C606A7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A1320659
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Ymb0nKSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A1320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQ6M-0006Al-J0
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 05:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47909)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pizhenwei@bytedance.com>) id 1hkQ0y-0000sk-UP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1hkQ0w-00057H-Rd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:52 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1hkQ0w-00050G-Jq
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:50 -0400
Received: by mail-pl1-x643.google.com with SMTP id b3so4637544plr.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h8g/nC6vUT95D9nx3c9BGLOpS2Xrlhhb+4JSssXi+BA=;
 b=Ymb0nKSANQB+l2iVjf+ggRc4wX5NWTZtSviJM1li7jgKHFtkP+VV2kZ7zuybOZXvoR
 IuIyKrfGaKh1pKRcV7LlpKWHdl1+YyEsGw4CukkgTSSOAU37mGz8KL8FD1aIZAFxOdqE
 969OONJDcS3OKTySs9/Pd9SyaDSIzx1+btuPD196BU7IoQRN0Of5nT/OieCURju7nzOS
 clmHEmTeXDYmett9PrWqvDfrnUBS23AOQVtmUMIKHeOwSEOjELWbJrPcGrs//JYqxqx2
 ZKrFH3Mcx7qWyWJ7MdaaZedWyk2fIQFr4LEwf0+FQ53Y0vf7M2vAVQPghURFISfYrv8I
 KTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=h8g/nC6vUT95D9nx3c9BGLOpS2Xrlhhb+4JSssXi+BA=;
 b=N7AWDzlwRRJlsGrQxsq3sZXJ7FYQ6PMAg+5vzDYIa4S1hmUsr8ig4c83LFa0+Vkayh
 q10nf09ezWlk7tRxEV3yy3fmBaCCrpfg8P+irBFgAkzu5h8e3J1PvXNkuhVzfFw5piEa
 LhauMO63E3QWwu1siBMLfVIqi9ZhTKVj5Vhos/k4OUM5UWQyhTFEoAPPmbU3oJxRrkI3
 NPTuBoOX/jSq53LJ5uepIPPVgKu3kf5VX3vj/edJyZHpSwHWPP0sFMsHxx04j65HrQ+q
 NHi2Lqs7X0nkhoLhZLK/6CWCKAaoRoc98rHDGM3YxXffqgRwUteR6TSyPwNeUuYoC9J9
 KYbQ==
X-Gm-Message-State: APjAAAWgubex5AZHW1DG5ByzMvBawxPUsQ/n+U8P9+MUdxnfgu413/x/
 C1mE1LtxTMXvySevogMudcmFtg==
X-Google-Smtp-Source: APXvYqzrPkjCDllcxlq+LB2PEsfz+0879g2ZHxeeFs7QGXDcN2BbRHUbpq4L/JxTl9xV5xjU/m6Trw==
X-Received: by 2002:a17:902:7087:: with SMTP id
 z7mr22887740plk.184.1562578360512; 
 Mon, 08 Jul 2019 02:32:40 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id q7sm236504pff.2.2019.07.08.02.32.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 08 Jul 2019 02:32:40 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kwolf@redhat.com,
	vsementsov@virtuozzo.com,
	eblake@redhat.com
Date: Mon,  8 Jul 2019 17:32:28 +0800
Message-Id: <1562578349-12333-3-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562578349-12333-1-git-send-email-pizhenwei@bytedance.com>
References: <1562578349-12333-1-git-send-email-pizhenwei@bytedance.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2 2/3] block/accounting: introduce block size
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pizhenwei@bytedance.com,
 mreitz@redhat.com
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


