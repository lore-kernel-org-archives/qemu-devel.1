Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D271C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB6F206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vx6EHATH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB6F206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf6C-00042e-3B
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoX-0003OM-Jl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoW-0007yx-7b
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:17 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoV-0007tf-Tx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:16 -0500
Received: by mail-wr1-x444.google.com with SMTP id a6so6528825wrx.12
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s6izLxVkzfpWzTSxiliPLXkwhbsXlNldqMSOd9icaXQ=;
 b=Vx6EHATH3Mea9UR/SecyMDGVqkHyHWQ9nJ22W+Zj1/ShJ9c4iVF1r6j6rTBeAxdlDl
 H4OoW//f0qf9Rff96I5s11u2gY6QhRXKVx9rVCcbFK2FsX2seKgb8mSfRXQT27iCDzf2
 aIiW/NIfN+ZhCbRyxC+wKITk/HwQC4eaMxo+7iIgTTnS1nbsBV11NOr6Y1PEcgavlq2P
 yZDSfAy6uo3bKDOoNgZqw+Wkb3rm3SmgGBeaWuve3EzYmopO7adQpAUXv/rV462dErvJ
 mKBdocBo87IdAlZfMsK73FO5ZV3BvWL/Lm/xmuoX0c6bgdUMn51SOaN1jd2O3xWzVjxB
 VxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s6izLxVkzfpWzTSxiliPLXkwhbsXlNldqMSOd9icaXQ=;
 b=oFDJrnPlrllV3uS6Iixrtw7kYzArKGXqxVsOXWwKUhjJw5+D52tXEvEz0Gmdg4ApDz
 NwqyY7gYZCSxckH0tboWrvN8OqHfekWMAJrt50hZeC9rDyET0dgpKgfqSRztrF0TFFCH
 K/skBpzdhMI2UoyidIN8RNEDLeq/k4As7HsDs6K8LIjXkQ4nqDSC47wTefC883Ui4OZz
 7NRaypt6/mbfgr0o3WkSRQiiNIKwMn/ZBLbhHBxOF5//xVZUqEYY8ngo9dcBqlVjSACY
 kpcMhSG4mI9WvtkvciLedBVRyHe9ZBdu7BZtvkBOVgAQYlBnnJ7mlEQxfGVvZhMzyd3q
 cSYw==
X-Gm-Message-State: APjAAAUGyigPwF+T5UfjdgYPWOPp+naQdWc6MNRNGh33Da92TfCM6QOd
 JiHwCGxvF2Nfk6J3Pe5plY1ddwWsabZU3w==
X-Google-Smtp-Source: APXvYqyHYSXkLluLDSsvBd/kzKGBnS4UgfEkTE+Bp4VUo+gnXs9PyEN6kbgUGUadNhnpEy9bKkr33w==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr3045030wrq.243.1580986514657; 
 Thu, 06 Feb 2020 02:55:14 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 30/41] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
Date: Thu,  6 Feb 2020 10:54:37 +0000
Message-Id: <20200206105448.4726-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we only support a single ASID, flush the tlb when it changes.

Note that TCR_EL2, like TCR_EL1, has the A1 bit that chooses between
the two TTBR* registers for the location of the ASID.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cfa6ce59dc..f9be6b052f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3763,7 +3763,7 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     tcr->base_mask = 0xffffc000u;
 }
 
-static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+static void vmsa_tcr_el12_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3789,7 +3789,17 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    /* TODO: There are ASID fields in here with HCR_EL2.E2H */
+    /*
+     * If we are running with E2&0 regime, then an ASID is active.
+     * Flush if that might be changing.  Note we're not checking
+     * TCR_EL2.A1 to know if this is really the TTBRx_EL2 that
+     * holds the active ASID, only checking the field that might.
+     */
+    if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
+        (arm_hcr_el2_eff(env) & HCR_E2H)) {
+        tlb_flush_by_mmuidx(env_cpu(env),
+                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
+    }
     raw_write(env, ri, value);
 }
 
@@ -3849,7 +3859,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW, .writefn = vmsa_tcr_el1_write,
+      .access = PL1_RW, .writefn = vmsa_tcr_el12_write,
       .resetfn = vmsa_ttbcr_reset, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[1]) },
     { .name = "TTBCR", .cp = 15, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
@@ -5175,10 +5185,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
-      .access = PL2_RW,
-      /* no .writefn needed as this can't cause an ASID change;
-       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
-       */
+      .access = PL2_RW, .writefn = vmsa_tcr_el12_write,
+      /* no .raw_writefn or .resetfn needed as we never use mask/base_mask */
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
-- 
2.20.1


