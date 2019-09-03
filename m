Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3322339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsfNrrie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3322339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bqm-0001T8-CP
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNA-0001aW-7L
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN9-0003xb-5Z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:36 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:42530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BN9-0003xA-08
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:35 -0400
Received: by mail-pg1-x536.google.com with SMTP id p3so9387936pgb.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7dARXMfy5m/YnyllejYFpw51kHS2wq0N+31r2HBVYEo=;
 b=BsfNrrieMqEkKeIZJ0S210hTrX2/yOWEJfg3+2Dqj+T6z+6WhORWt2mrf8m9n3XrZs
 RAYGnwFGskJyXtGWRtA1nyljGUnEe3ILbL+rnK9HH8bvfPCRXy4KRn4hV/MEOkkxky0r
 dGI/D/EO9zoF2h41VbTpGgkGsjOk8A8vHIGlVOR7m81/NCe7bg9HsJEVffuiW/UDxiOI
 Gt+wbiAjF+K3TZo8um+nMPT7T4vhnawAJ4M4Kgghoq7NsGp/LWoPAKxYAia6r0Y+ZKar
 Psqj8zXn22tF9cDvoaCgITZ/855bFhLzmwjbeDfacP23e1WFIfJlOV/gOpa+SQK7GXSK
 tH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7dARXMfy5m/YnyllejYFpw51kHS2wq0N+31r2HBVYEo=;
 b=BEiMJFwZWuLTWqczQtroMk0IdLR/rAf0HRwOXe78wXD7kEG+Msg8tOZ9vyd9q+pw9w
 j/zb3Sjkerpi4gANjPcYoWoE5XZU7ohWvjNAZPEay/e5Sdc77N+7gTH2YID2OwVX7J+X
 s/olUbuUm7wzm32P1p4zIg4iX+W24J8Xzzfjvor3m4TvAOL5f3bVMDuY+xFVupoee/Mz
 TaEeSJF0SRU2JY/oEgjodKiLDpjgBHUzShVEf/4F4QVfl5MMsSG8BhKQEx50JxbS8vl3
 /Na5fTtfydieNVjLUAQfuyYkhNLeYEwAzZOtQZoH4O59S++ZX7h4e5r9wjYzpJ/NGHhk
 xdsg==
X-Gm-Message-State: APjAAAWRxbzNURw5NvASscw8JvrFojU5xc8HjnB02JvYstcLdhU7a6a6
 SYDYSiTA2ih66G8tO3/WZWx5fCsJBlM=
X-Google-Smtp-Source: APXvYqy7qWTiK7XPvt7I7qlR2wJK2W7m7RfpRWhPBMIgeTmaEX1cj1FDT7r7/urCOsq1OtwJCrcx8w==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr5209710pfi.16.1567526973716;
 Tue, 03 Sep 2019 09:09:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:49 -0700
Message-Id: <20190903160858.5296-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::536
Subject: [Qemu-devel] [PATCH 27/36] tcg: Check for watchpoints in
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let size > 0 indicate a promise to write to those bytes.
Check for write watchpoints in the probed range.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


