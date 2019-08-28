Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606F3217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STphK/P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606F3217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i37Go-0001Ua-7V
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BW-0004EM-6C
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BU-0008Ga-My
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:01 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i37BU-0008GK-HL
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:00 -0400
Received: by mail-pg1-x542.google.com with SMTP id n9so527977pgc.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=g2Ys6FT3dAIWRm2+sxUDBYBh9aclrTTCcmC9pqtLRPs=;
 b=STphK/P731J0GmYktFaMQOTVo3Pflb9IUOw8II6nZn6jbPbD6UKAZ3OWJrb4oo3Ve+
 y/bZALj+aPVbczYOkNHDntHtdUhLS6HHb9Pdblrtdzb4wXtffLaFW/E2moJ/fm99xIZ6
 LeGeT1xZm31FxGtaWJNZ5yaVT5wuux56zhdBmAR4XuWUcj2j5imCTvmgX4hVWrhZ1RsE
 d9ekp8cvrKOMhnHR5L9kvtIogAeU3Fe2+NSNKbXjXPF1nv1SOmS0mo7psfCa5XVDEjZ9
 fnB57d2H0nLUrfsGU6TR2wuQiX52JJxQNlK1PlWbTl1bs9wus/4tHfB0jO+ctPHY3Eud
 rZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=g2Ys6FT3dAIWRm2+sxUDBYBh9aclrTTCcmC9pqtLRPs=;
 b=DXUjKYw+GskDLpbb4saDFCIwuEJ5xWezQSp06WHP2oCGIIu+sHMoCe3ac58ACnPTw3
 efbh8sr+KPLjAHDkl1X4YTJS/SLS3fwwWBy/3L5fQQwE9otPTD7pSRmcKsCoLpUEMOCQ
 Lq7bZ9RWHbnn3xqHXxrC/XrogL7hEG8Pe6F8a4EROI6LZsfoEwjxEE7T6Q1OTJO0vZAO
 5qkh41/16K48BT149FoN8WT/8bx6MBYWOeVdHqPhODhlZeVEZcO0Q44UgDJEUAYPI3QN
 efe/cIStMzGmjrlWsoEYxSkoou7M/0VVc38yYeJIJTrQP204K/ngbGCwMOh5Ie737YSc
 /99w==
X-Gm-Message-State: APjAAAVdqwN27r4f+p1h9seTeLMOEGJIZy69RbGdLFwl3jRi7LHOC+sB
 aXTS7aLoZVnFMa29yvNHq+yB0IM0esY=
X-Google-Smtp-Source: APXvYqyhZQiiEP5ypT+SjIzunCjNc5KtTSdQQGWBRcctQByz8zmDXd/UGqNRhqwufrf2akmJsoonQw==
X-Received: by 2002:a17:90a:f011:: with SMTP id
 bt17mr6700083pjb.21.1567034219275; 
 Wed, 28 Aug 2019 16:16:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s5sm485197pfm.97.2019.08.28.16.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 16:16:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 16:16:48 -0700
Message-Id: <20190828231651.17176-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828231651.17176-1-richard.henderson@linaro.org>
References: <20190828231651.17176-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 5/8] cputlb: Fix size operand for tlb_fill
 on unaligned store
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

We are currently passing the size of the full write to
the tlb_fill for the second page.  Instead pass the real
size of the write to that page.

This argument is unused within all tlb_fill, except to be
logged via tracing, so in practice this makes no difference.

But in a moment we'll need the value of size2 for watchpoints,
and if we've computed the value we might as well use it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c9576bebcf..7fb67d2f05 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1504,6 +1504,8 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         uintptr_t index2;
         CPUTLBEntry *entry2;
         target_ulong page2, tlb_addr2;
+        size_t size2;
+
     do_unaligned_access:
         /*
          * Ensure the second page is in the TLB.  Note that the first page
@@ -1511,13 +1513,14 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
          * cannot evict the first.
          */
         page2 = (addr + size) & TARGET_PAGE_MASK;
+        size2 = (addr + size) & ~TARGET_PAGE_MASK;
         index2 = tlb_index(env, mmu_idx, page2);
         entry2 = tlb_entry(env, mmu_idx, page2);
         tlb_addr2 = tlb_addr_write(entry2);
         if (!tlb_hit_page(tlb_addr2, page2)
             && !victim_tlb_hit(env, mmu_idx, index2, tlb_off,
                                page2 & TARGET_PAGE_MASK)) {
-            tlb_fill(env_cpu(env), page2, size, MMU_DATA_STORE,
+            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
 
-- 
2.17.1


