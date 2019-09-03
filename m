Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E6E23431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCG4En9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E6E23431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BZZ-0005uq-56
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN6-0001TV-Tz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN5-0003vT-Mk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BN5-0003us-Gb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id i18so9387529pgl.11
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bqopH4IHC6JwFjvyUE21txeIhpfHSXwxJEKmWcLZGEA=;
 b=hCG4En9/lls3POlFLDUIBv+WFRva2oYKDZUEkbP38DxL3jMVR270pJ8bERazBDsF8o
 ylzOvrw2Ixl3Pv3ZpZ1oURxynJR6Cu6Ge7d2tzTWeSoPYyDwbPurXWySG1G4y6AeoXbO
 hL6PpiWLpbyCPDpIhxfIIjIbDo7ljv6hS2GgkQ8s30VKC/Ww3ZYmANjKhhu4HLxAtUvX
 NBtjmpID1wTFA4E9SKQjWcBvKBLe8kgHW/V9gebkcff82wVX6wDw3hKJOLz2oH2TUTh6
 hsQLKYvEJJxpurZQIhltFh7Zcn/1ODYLfHJCwmltvixGXwOh/ZZ0TujqM8nC6fXtDP2f
 MnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bqopH4IHC6JwFjvyUE21txeIhpfHSXwxJEKmWcLZGEA=;
 b=P3ulD6FhDkdCBKvrdqI1XyJF9+V3bAn3Pm49TExChpOAaFQXj4sm8IPIAgR1IrIZUb
 0Y9OwKMr03nHOP2lKamYP188CARIKH5x+Pmc1WUhx6IIZOyTuhsszYVQshZq60aLH9QP
 YAn/aJ0+E5tN4u5ebmuEE6+arIAcK+YNxu+WydxjgwY/CX7oI5WPjy6awhs3klZQWOzQ
 tHKIWkW8zNRdgagXh3Tq4L/waEjjZDsO4KG5FqBWIh2V7teBOPcyRWqpmRqTRerwaK3p
 BgTTMaL2vsmiaYJ1eEqSpeETHPtaPGlsYXrQOxnvJxWTmjw/Gfqy0p2yLZo3fUTJD4qI
 XdBg==
X-Gm-Message-State: APjAAAUMS3idBYIQ+XDpN+vtOwPNpGWO8wfZk9Syof+iyipI9JxF+xeg
 efB1lS0UQC52i+n+gvL18B193piLe0E=
X-Google-Smtp-Source: APXvYqznJY27MalcuN8Xh8BrzUL6r3gpRVCBmoU/6JpYmUW1XgZNui/frUOd2gb/BjAcUWTTCuHDvQ==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr30395763pgh.24.1567526970256; 
 Tue, 03 Sep 2019 09:09:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:46 -0700
Message-Id: <20190903160858.5296-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 24/36] cputlb: Fix size operand for tlb_fill on
 unaligned store
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

We are currently passing the size of the full write to
the tlb_fill for the second page.  Instead pass the real
size of the write to that page.

This argument is unused within all tlb_fill, except to be
logged via tracing, so in practice this makes no difference.

But in a moment we'll need the value of size2 for watchpoints,
and if we've computed the value we might as well use it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


