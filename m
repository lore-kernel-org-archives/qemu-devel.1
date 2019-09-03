Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F977C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8A821881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPGdGnGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8A821881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Buk-0006sU-JW
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNF-0001hJ-7j
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BND-00042T-Hk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:41 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:44179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BND-00041P-Bt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:39 -0400
Received: by mail-pg1-x52b.google.com with SMTP id i18so9387712pgl.11
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C13i/X6uJZDwcnVhjZoMCIfnOZdw0d+2p6DUGgXSKUw=;
 b=uPGdGnGVygXv9BzXdeIe2EVY6OOzHRjNpUxhXHc8ddGvW6GmqKQ6eP78f/wLS/7Fno
 uNeN+Wqo2Sj02wkqFurAy80j/2A4aSMOzP+I7EscwNgucUiXHNXjmv68ohFYOBkXQXaJ
 tUirD72KsiddYIr6Kx9jiv439MvO/2H53tc55/RYu7VpaPzSAA7jTbvDjvs3FHT4pHqD
 0NH8FvSUkRvZ3VxbVtaAw4Mijt/OQcnR5q1J/AKjo1P04PTrVNYxX87qsweu4jAleXGe
 SnV9boh8y7Z/w5zup6CbNzV27JO8yKy7RREgH4fH4CtQQ+afjRSpQYwsw9UsAaZ2/UEE
 AA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C13i/X6uJZDwcnVhjZoMCIfnOZdw0d+2p6DUGgXSKUw=;
 b=tcx0mV2utUcjZxoYZqsjjQfofH4yIW1NBnGL6eriCFpy78Ap3UtcQbYUzxQFuDc4yO
 HCU0OhRop1/zhsXlWPITFo6DIwjY7bN6VzxXIHKKWF3Pu+LFYmXwPUrD1ebyZWKhph+3
 Y51piLimDYnq+kP5DcU2+Pvrj9Kj/ykNlh+O2oLUCx+7z0iWqJanfZugX/8kKHWgtLb8
 BbTvx8WH6gAIRP/4SJyypf//XKgVMfiE+bIgpyXpKv9xzfL0ebxYrjI/sTkN3dyvR0dG
 Nok3aZAl2D0S1kV3GN4EsAZ0anyoj/6h2lSTKDaXr+AmyNN7cl7BlPCPTXKxx234jYf9
 yRVw==
X-Gm-Message-State: APjAAAVCbNE31TmgkzMtmalfgN4lWyA7bp0KjsbvL5UOLbM60BVvsbZ9
 1L+VtDJdJviGM+w7VeuvpHuix5gbrUw=
X-Google-Smtp-Source: APXvYqyJm+SSzZFuHximgAJkHKJS/eH9RTK3SGsDSfl3ti93BL1/Nzu9NnTgdww10O9117I1XcXTLQ==
X-Received: by 2002:a62:e205:: with SMTP id a5mr41561506pfi.137.1567526978092; 
 Tue, 03 Sep 2019 09:09:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:53 -0700
Message-Id: <20190903160858.5296-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52b
Subject: [Qemu-devel] [PATCH 31/36] tcg: Enforce single page access in
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

Let's enforce the interface restriction.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190826075112.25637-5-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c    | 2 ++
 accel/tcg/user-exec.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 010c4c6e3c..707adf7631 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1088,6 +1088,8 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr = tlb_addr_write(entry);
 
+    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
+
     if (unlikely(!tlb_hit(tlb_addr, addr))) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 86e6827201..625c33f893 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -191,6 +191,8 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
 void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr)
 {
+    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
+
     if (!guest_addr_valid(addr) ||
         page_check_range(addr, size, PAGE_WRITE) < 0) {
         CPUState *cpu = env_cpu(env);
-- 
2.17.1


