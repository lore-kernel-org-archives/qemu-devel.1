Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D976DC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A609020726
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmtxOL5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A609020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3PtD-0008SU-Sw
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpX-0003fS-KU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpW-0005ar-Lf
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:51 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3PpW-0005Zg-Gk
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:50 -0500
Received: by mail-pj1-x1042.google.com with SMTP id ep11so6195656pjb.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kTU4kvjUvlD0h7Jj4NNpawxNwnsR3vNHE9107ezVFjs=;
 b=cmtxOL5kHvvK3TYlt2ehi6SDl2PmQyf35h8xvMYpWmeBDAwDFczD9b+Qtyd/L807w1
 iFr5z/scXDrOHbq00htBTB3OZ0wslkXwSM0NkiGgB8nZCP4dY6xPT+RfTaPcS54bwZfI
 vudXMK0I23AQJ04DHuexcua8630IZ/JT8p6w7SuqHEolb3lZlrIFbE09VuQTCAZqqkBR
 JyqwXkhvqUsMv2V5AVAOy+8uGgxz3h2IVL52mQORrWwOA7TWAsHsHxnKLp/YpmryO72m
 nYLOZofZbScqGcT9xsRjX2Tv6dnhZBH0GPulR0tOshnSD1E3CMMKhGA88OjZpsdPdGbr
 Ieyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kTU4kvjUvlD0h7Jj4NNpawxNwnsR3vNHE9107ezVFjs=;
 b=Q+tG7jeVvOfumHDysLaEtziGQOfJ6Q5LCunzsKn85IsmmnnfImmLyRO/23GPFQ89dS
 xLhq3P9TM0j0S4vY+rNDputrMMjtWQqI3ch2mXqxcwCN/ItXxt/Z6pmqfLGf7+pHU8Ql
 XCHjaxnEgix8OTryCuMfWpi9cD/8hZibpfIZY6huBaIheS5L3lz7re7ifmzQuYKte7eQ
 Dt3rGEOBhahpy6+erM6nk8jlP3GqUkX/u3Hx7lPtEnZki1vpmXGUymu3fyIjO1NFuCog
 XVrDFgR/U3rA6bJAuLxQBU9gHJl03FllYRCHGOyWhg4nOdkbNBy6u8NByexPZZjyiDGr
 3AiQ==
X-Gm-Message-State: APjAAAVZ04V37bWGsERM985yaNAfX66DhyUAKG/235JxD83dud+Wgj1j
 iQ/cAS6k+9UJ9eFSP9o+GoEYew+8dz0=
X-Google-Smtp-Source: APXvYqxJcPM1rz/Uj8eWMOKdbfMNsIzI5EkBbpGeWpZ32EXW5TvOT1f0LXg0mKxX/80tgVtrTE+n5A==
X-Received: by 2002:a17:90a:b30b:: with SMTP id
 d11mr15832011pjr.22.1581882229133; 
 Sun, 16 Feb 2020 11:43:49 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y127sm13945188pfg.22.2020.02.16.11.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 11:43:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] target/arm: Remove ttbr1_valid check from
 get_phys_addr_lpae
Date: Sun, 16 Feb 2020 11:43:42 -0800
Message-Id: <20200216194343.21331-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216194343.21331-1-richard.henderson@linaro.org>
References: <20200216194343.21331-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that aa64_va_parameters_both sets select based on the number
of ranges in the regime, the ttbr1_valid check is redundant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b09a501284..eec7b01ab3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10390,7 +10390,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     TCR *tcr = regime_tcr(env, mmu_idx);
     int ap, ns, xn, pxn;
     uint32_t el = regime_el(env, mmu_idx);
-    bool ttbr1_valid;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
     bool guarded = false;
@@ -10405,14 +10404,11 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         param = aa64_va_parameters(env, address, mmu_idx,
                                    access_type != MMU_INST_FETCH);
         level = 0;
-        ttbr1_valid = regime_has_2_ranges(mmu_idx);
         addrsize = 64 - 8 * param.tbi;
         inputsize = 64 - param.tsz;
     } else {
         param = aa32_va_parameters(env, address, mmu_idx);
         level = 1;
-        /* There is no TTBR1 for EL2 */
-        ttbr1_valid = (el != 2);
         addrsize = (mmu_idx == ARMMMUIdx_Stage2 ? 40 : 32);
         inputsize = addrsize - param.tsz;
     }
@@ -10429,7 +10425,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     if (inputsize < addrsize) {
         target_ulong top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
-        if (-top_bits != param.select || (param.select && !ttbr1_valid)) {
+        if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
             fault_type = ARMFault_Translation;
             goto do_fault;
-- 
2.20.1


