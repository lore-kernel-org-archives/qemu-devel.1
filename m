Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6F0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6837121881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivbX7TAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6837121881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BwQ-00013N-4V
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN7-0001WT-RR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN6-0003w4-QZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:33 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BN6-0003vd-Kr
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:32 -0400
Received: by mail-pf1-x441.google.com with SMTP id w16so11073115pfn.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v5bX0Qu6fPtjHexOST5RQ9GuryzWs151hGBl2Znri/Q=;
 b=ivbX7TAjXrWmYN8hdkfTzUZBJBQ1uY38DQs1aSaHc6ZdyGfJUyJ9kgvtXiTr/+nFGU
 7AddlUn+phr6it8v1OVKbGlFmrLdReRPlAP2OI25fOeCY7++M9mUmWBcHQytU3ARu3aX
 g4dyHSThyMa6qftPUER4f4v5MG07JV6R+tNyJczR1vWzPx1KFum5qxO219HdhvOFPDXc
 SqrEhxQJd3x6dPSnh3kkO9Jd4zW9YiHANgcxD8JzOyXZvzIx0BRNqoPMdcj7Xc4xeMuT
 6Ecmv34YKLDhGBZ3b6uURh+mf8GdvkO8ArbEzPE1TIjXOUvfPWcGCBHbSpYFEJH6QZIi
 XjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v5bX0Qu6fPtjHexOST5RQ9GuryzWs151hGBl2Znri/Q=;
 b=UrncdSLd8KTc1InH7A1zu62ca03f/tq3iSNw3qXmldt/f+9sebnJ8xZcP+fLMyByGW
 W9EX0KFWzkn5NAiP8nRhpobaIgRSX6brGdOf6NZJ8fAiXD+xGtX+MUit2QGpD1k8YX0K
 ED7YVWZLufgEQggDIdRyTqDp/1EVM2PMQNe0v2yXAb9YAlGLL0ghl8hCPrS4vo6yYVzV
 2/vv3hbPcBeBB9LWlIt2WVc8UEGf74rD8Ma4TrHihhRkS+3hPvdmJ2bd4tklTDZ5R0Pb
 5Bm2VYkw9l94OEIwZScf8fFfzcc083hBPiAvRBDoZrL/TCla6RDDDOM4tiESrcLC2y/L
 jhmg==
X-Gm-Message-State: APjAAAWR2lXrZbSI+m2TgVhJecooAXiKDiSIHHDcX4MgDkFcFP/OTHcV
 09oOtva0RcD/OXKi4Ef1R6DxYVFmTho=
X-Google-Smtp-Source: APXvYqzU9u55hcxuSE1C6Tt+uenR5W+2bhFMVxmWJ4i/DWJRXdhag523OTAe4W293rYSZ8IPe5DgZQ==
X-Received: by 2002:a62:4e09:: with SMTP id c9mr15053192pfb.152.1567526971340; 
 Tue, 03 Sep 2019 09:09:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:47 -0700
Message-Id: <20190903160858.5296-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 25/36] cputlb: Remove double-alignment in
 store_helper
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have already aligned page2 to the start of the next page.
There is no reason to do that a second time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7fb67d2f05..d0f8db33a2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1518,8 +1518,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         entry2 = tlb_entry(env, mmu_idx, page2);
         tlb_addr2 = tlb_addr_write(entry2);
         if (!tlb_hit_page(tlb_addr2, page2)
-            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off,
-                               page2 & TARGET_PAGE_MASK)) {
+            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
             tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-- 
2.17.1


