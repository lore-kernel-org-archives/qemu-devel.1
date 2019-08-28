Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C4C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B22C217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpyDqQQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B22C217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i37II-0003dO-OH
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BZ-0004IU-QO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BY-0008Hz-R4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:41132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i37BY-0008Hp-Ll
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:04 -0400
Received: by mail-pf1-x42a.google.com with SMTP id 196so735836pfz.8
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 16:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JQUPutWQvF8Cc5oeNW7RTy29F84wJ8I1Hnzwo9VUtUk=;
 b=zpyDqQQTi4XvJgPrR7M/XbhQyAuuDVR95eHWkhVnKf0Gm4EaXYZTmXCWkLk8kAQjom
 TrPjQdli2V5LD+lnFioB/iO3N199HEMY+FZ9/Fy/qLonyqP9v9YAw/zgtAQk3uZhd0+w
 gOzRSGQqoDX141zTJl+x7p+6z7Gbz2S/TJrMGJlAvVBTMXnPw1ynwbzButLqYEvhQcus
 +gt7pTaYtcHw2tMXPeAOAcPSwCC2gpryuZI2h5AQz2MUQHuoA2tsJqPd6xUj9EWUUZvC
 QrEZwwRyzSpmpZ17yzN4o9Hk7pc6Uhc7/zrHIMvqiU2WuiWBLMcM1yj472oTeDigyHXC
 +B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JQUPutWQvF8Cc5oeNW7RTy29F84wJ8I1Hnzwo9VUtUk=;
 b=cFMzAVTHJTmHPwBdvhIXCB1O3Gy/YH7M2n84LlkHdQ3tUHuW1WVajaLbM1JzByBNBF
 DC28u6xRFyA/5lzQJt4m6ytbsayecSn/qsoxtsy34N726+VvMIEe36f3YphFD5EJSaMs
 8NMlQSBTlsZ+pO4auAu78QXkdYkJ+nUMWMJy/HxMBT76ocVVP75wiwonfdIMUUg+59Rm
 lnngag1eiDEpPO6yr1v0w8ivUFklnfCyEKrwy9zqiL8JkRgpRe47S0seiMgWFFWmhHDd
 8i1AcbgAPSxCzCqOYKo6/aiC5VJCqQ4EGbRAQtuZ71SmoTsFXVVlxPo34sYSd2o9EVFH
 NQQQ==
X-Gm-Message-State: APjAAAXIMVj1OnMO0NYfBhEZqFhsYjx0F0B6DzBTLkyrs+egmZeGaJv9
 fvxyYnMP0G69vYVrRQjAr8s9W6pCUsk=
X-Google-Smtp-Source: APXvYqwQovGK4nirC8PtWAmoviAcggTqyVJUTSuNgJBez8cgunog25BRQJORx6l8TU33lbiNpN5j7A==
X-Received: by 2002:a63:1743:: with SMTP id 3mr5406212pgx.435.1567034223098;
 Wed, 28 Aug 2019 16:17:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s5sm485197pfm.97.2019.08.28.16.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 16:17:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 16:16:51 -0700
Message-Id: <20190828231651.17176-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828231651.17176-1-richard.henderson@linaro.org>
References: <20190828231651.17176-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: [Qemu-devel] [PATCH v2 8/8] tcg: Check for watchpoints in
 probe_write()
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let size > 0 indicate a promise to write to those bytes.
Check for write watchpoints in the probed range.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190823100741.9621-10-david@redhat.com>
[rth: Recompute index after tlb_fill; check TLB_WATCHPOINT.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 9a9a626938..010c4c6e3c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1086,13 +1086,24 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
 {
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    target_ulong tlb_addr = tlb_addr_write(entry);
 
-    if (!tlb_hit(tlb_addr_write(entry), addr)) {
-        /* TLB entry is for a different page */
+    if (unlikely(!tlb_hit(tlb_addr, addr))) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
                      mmu_idx, retaddr);
+            /* TLB resize via tlb_fill may have moved the entry. */
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
+        tlb_addr = tlb_addr_write(entry);
+    }
+
+    /* Handle watchpoints.  */
+    if ((tlb_addr & TLB_WATCHPOINT) && size > 0) {
+        cpu_check_watchpoint(env_cpu(env), addr, size,
+                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
+                             BP_MEM_WRITE, retaddr);
     }
 }
 
-- 
2.17.1


