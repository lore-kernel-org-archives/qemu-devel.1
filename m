Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D67C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978E22067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978E22067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOWf-0006un-SM
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maozhongyi@cmss.chinamobile.com>)
 id 1jgOTD-0000Yc-Fz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:09:55 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:55316)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jgOT9-0000EI-QI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:09:55 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by
 rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75ed75ab7836-8b299;
 Wed, 03 Jun 2020 16:09:27 +0800 (CST)
X-RM-TRANSID: 2ee75ed75ab7836-8b299
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85ed75aae43e-6102a;
 Wed, 03 Jun 2020 16:09:27 +0800 (CST)
X-RM-TRANSID: 2ee85ed75aae43e-6102a
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 9/9] migration/ram: calculate un/encoded_size only when needed.
Date: Wed,  3 Jun 2020 16:09:04 +0800
Message-Id: <20200603080904.997083-10-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
Received-SPF: pass client-ip=221.176.66.80;
 envelope-from=maozhongyi@cmss.chinamobile.com; helo=cmccmta2.chinamobile.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:09:39
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 41cc530d9d..ca20030b64 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -910,14 +910,15 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
         xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
             rs->xbzrle_cache_miss_prev) / page_count;
         rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
-        unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
-                         TARGET_PAGE_SIZE;
-        encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
         if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
             xbzrle_counters.encoding_rate = 0;
-        } else if (!encoded_size) {
+        } else if (xbzrle_counters.bytes == rs->xbzrle_bytes_prev) {
             xbzrle_counters.encoding_rate = UINT64_MAX;
         } else {
+            unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
+                             TARGET_PAGE_SIZE;
+            encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
+
             xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
         }
         rs->xbzrle_pages_prev = xbzrle_counters.pages;
-- 
2.17.1




