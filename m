Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E1C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40FE20656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCSqbfMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40FE20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyTj-0004vb-Hz
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQj-0007wE-HG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQb-0007il-Bx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:37 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:37288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmerdabbelt@google.com>)
 id 1jQyQa-0007hc-UL
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:28 -0400
Received: by mail-pg1-x52e.google.com with SMTP id r4so7233670pgg.4
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=W51JHFyaTyJrjYrazYNfQIZabEagIWPjqp7ng1YyDdQ=;
 b=MCSqbfMaY9XlGDdHqDkV8cNh7RpJK3QZRrgH03UWu34P2RLJQSCsVsJGX5XmPVsHnz
 ui2J8RWFDnDnyTyuE+ni/dOMrTHh8lds78tddli9Dp7BCDlpDrR+mOrh+GVqqSyAPEIG
 kxE8iEk1LSjHGljsHqIwuhG+z1m+z5Wr/zuzDXdRsXkl4Zxe2gwXv8jsa3f5jfvx8oBz
 nrhz/zQJoRNgXGpPaEd8CQGuXOnbMJMFd4qCLhH7Lsq5mWYixKP2/lPOibmOF7VskBAf
 aM2j1Te4VtNJ8OsSQ9UFL+5bOYFKbnuiKOIGPUWZIwFAKtXVhnBgY9TbOTaKSZsYkEUd
 jyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=W51JHFyaTyJrjYrazYNfQIZabEagIWPjqp7ng1YyDdQ=;
 b=qvrBGU6r6AeSpbTALGCrlinnDPo/ARNUC0twSyoHCV7U0U5i4QPMYbJ3b69ZL9AX8u
 rjmiPyubmdRkvc32HlxB/GqhzQRrhh3QvGRjuOIxtuZiwgzHGFaI0UiAEkZ35cJ1BULI
 o57MJZLLD+Y/DYu0/qarN7uRkYt0zQOux6QI3EDSA0BobanHw/By3d4zYCYYR6yBWc8V
 Q7F7Ud7NT91TIpbBR+5VdHz64wGHH4eODYHD2QlK4FG8KQY41ErwGIbEtqh6+pv7AdV5
 1/n7E8A9tcRyg6dcSGgrMmwJXMFWHQLDh0DMqDen6srGthjnSOVZKgXQavmCVz2AMc8l
 i/wg==
X-Gm-Message-State: AGi0PuZoowruZ1gG16q1j0b3FjLljBPb7zx77Qmv1wCfrZD1wSBOaK5m
 DR8i5sHg1gvCzLIFPQYATnPslgUN7OM=
X-Google-Smtp-Source: APiQypL7WwLurdTFoKDi63Ah0mmzCoqtZ3tek4cwlsAoV91RMq2KiD0VhEfDwSUGotJ6XDnElJYnFw==
X-Received: by 2002:a62:d458:: with SMTP id u24mr21771891pfl.275.1587496767342; 
 Tue, 21 Apr 2020 12:19:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id t80sm3259016pfc.23.2020.04.21.12.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 12:19:26 -0700 (PDT)
Subject: [PULL 3/6] riscv: AND stage-1 and stage-2 protection flags
Date: Tue, 21 Apr 2020 12:09:58 -0700
Message-Id: <20200421191001.92644-4-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421191001.92644-1-palmerdabbelt@google.com>
References: <20200421191001.92644-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=palmerdabbelt@google.com; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::52e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Take the result of stage-1 and stage-2 page table walks and AND the two
protection flags together. This way we require both to set permissions
instead of just stage-2.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 48e112808b..700ef052b0 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -705,7 +705,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #ifndef CONFIG_USER_ONLY
     vaddr im_address;
     hwaddr pa = 0;
-    int prot;
+    int prot, prot2;
     bool pmp_violation = false;
     bool m_mode_two_stage = false;
     bool hs_mode_two_stage = false;
@@ -755,13 +755,15 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             /* Second stage lookup */
             im_address = pa;
 
-            ret = get_physical_address(env, &pa, &prot, im_address,
+            ret = get_physical_address(env, &pa, &prot2, im_address,
                                        access_type, mmu_idx, false, true);
 
             qemu_log_mask(CPU_LOG_MMU,
                     "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
                     TARGET_FMT_plx " prot %d\n",
-                    __func__, im_address, ret, pa, prot);
+                    __func__, im_address, ret, pa, prot2);
+
+            prot &= prot2;
 
             if (riscv_feature(env, RISCV_FEATURE_PMP) &&
                 (ret == TRANSLATE_SUCCESS) &&
-- 
2.26.1.301.g55bc3eb7cb9-goog


