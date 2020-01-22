Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E7C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0A72087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7nGXgvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0A72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6CW-0006Ps-9W
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65s-0005p5-Ee
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65r-0002oC-3n
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:12 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:47003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65q-0002o1-UO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:11 -0500
Received: by mail-pl1-x642.google.com with SMTP id y8so2246577pll.13
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7JCjtS3iuX6LFH/2brU8boRCZGNEugPuBApINFMUJPI=;
 b=v7nGXgvceZauoiroQ5C1BTvb4JmA2VtBaBCBmGce2IZajSxdmj+A+6Eo4XNOMl9+tn
 absgO5sqdSLuAvd4TkPQ8L8mA4UmOF9NwM92JLExPAvuj2TdeDgVF2jAd/MX+fnID4ao
 PzSWFx3oGlUCx1xILyQszVfUlA3val0LALi6A2hIlawvWWP8QWRFYQeinlhCgET9k2Z3
 L+GXer2+LjtQ/XpGBG4r39KFgaBPdt2OxvYvcAHGZB09hBu/ZCPjQrtkNvtMDOCdmtw3
 4iriTdmzQm8DSP4YTq+uk31toPgyS14Z5Vc6D3BpvhsAOkVNB/5Chb+OXwR5+wDvlSXH
 kwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7JCjtS3iuX6LFH/2brU8boRCZGNEugPuBApINFMUJPI=;
 b=XCGCS6xOfInhNK8PFiKXracZFCvJqvErCSC5CnukHn8bE9u8UrnQfTVmGFyOhgkWJn
 NnTJOBw77ND9ZIy2DWW4rOvlNOR8dDA2xGsSYwBW7MWmgx8TdNLu0Q63E6Nd3NL4F+gr
 luz3iSo69xqow0s85ip+91Q/tEdX3bDFX4oigELuEzvwwX+cz59eH7MdPg7oBHP45aru
 TIedxX8bheRbK2F4ibc4VldGWieRbi1mO0zzATQoiHwD5cZMdg1BjYAGTQmFe+sDcZCU
 AUY4z1SaBJnLF4LvHSkGcdXMIbXBH2RnqGieRVI38xMy0fL/Jggp0lbOdC1M4b6vey9C
 WOOw==
X-Gm-Message-State: APjAAAVlgecwQ+f6jGdFcUU+mmLgPlhxxevZohcFcJILBA5HUQvBt8wb
 SxH0t9uqlRcQ5aebTmgIKgwIHQwA+Yg=
X-Google-Smtp-Source: APXvYqxmTN7k0288RjXc2Q6lDfgbG0voUGoxhM2bn1cearFEx9nH+UFAxXS7HcVMxJwi3QprXg+q4w==
X-Received: by 2002:a17:902:41:: with SMTP id 59mr8858013pla.39.1579661409648; 
 Tue, 21 Jan 2020 18:50:09 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:50:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] cputlb: Hoist tlb portions in tlb_flush_one_mmuidx_locked
Date: Tue, 21 Jan 2020 16:49:41 -1000
Message-Id: <20200122024946.28484-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change, but the smaller expressions make
the code easier to read.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5252bcb949..bffca0e7e7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -230,15 +230,16 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 
 static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 {
-    tlb_mmu_resize_locked(&env_tlb(env)->d[mmu_idx], &env_tlb(env)->f[mmu_idx]);
-    env_tlb(env)->d[mmu_idx].n_used_entries = 0;
-    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
-    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
-    env_tlb(env)->d[mmu_idx].vindex = 0;
-    memset(env_tlb(env)->f[mmu_idx].table, -1,
-           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
-    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
-           sizeof(env_tlb(env)->d[0].vtable));
+    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
+    CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
+
+    tlb_mmu_resize_locked(desc, fast);
+    desc->n_used_entries = 0;
+    desc->large_page_addr = -1;
+    desc->large_page_mask = -1;
+    desc->vindex = 0;
+    memset(fast->table, -1, sizeof_tlb(fast));
+    memset(desc->vtable, -1, sizeof(desc->vtable));
 }
 
 static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
-- 
2.20.1


