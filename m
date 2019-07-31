Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A0C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E5F20659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrNtztSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E5F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvNx-0006Ly-PD
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60653)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMc-0003zv-8Q
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMa-0003Ig-KP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:22 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMa-0003Hq-Dt
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:20 -0400
Received: by mail-pl1-x641.google.com with SMTP id t14so30968102plr.11
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZRDl/Ha+kclTizhs/nHDa+7096PsBT003cOS/ic3LTY=;
 b=BrNtztSKwNJY0w/qMsV8+5wn4WcG6r4UAkotM3F1Fr5GTPMAXcVgrqHjx1FIW66bFr
 voGvXlo+sk+LOwKuxpVJmzUqP6ryvIWJ+RccWHsdrYBIA5zpjgEzLk0S2s7M08DnGhae
 RoxZK0x9byYFKU8QZ7+41B6YLY9eg1o2PafxegkAmZ2hPwr7IjgDGhd6ygh1wkZD58CV
 yjLmRLyQm37yaiDumd+HxvlJqBvPJbKDRDQw6BWfghL1BFsBuDB/vJjWmiHZ8Xot0pjP
 QA2Yg8OIKXIwsasWN/QJkbLmtVffUpmMmVrARxz3QX5wmngBTyscEuAK3HrcevjdsHmS
 5GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZRDl/Ha+kclTizhs/nHDa+7096PsBT003cOS/ic3LTY=;
 b=TIXf0/LRpyB8m470ryWotrn3Qqe5E/MBcvaGdUKlaIkQ/Gw0jLiDh5z6hrplD0mVJl
 7swGNFMXC3JY3OepOopUYBomxz/LPJljzDPWmxIoIAY5R0C04HIM7Cv11tsY14/oi/Cb
 U52W6TqHMq8maNDZ1Jkrzu/Ubl8+rITmkq9utSGn9lHFZQlyup1DBSykuSCOZzTdvR4j
 YfBdBRb6VXfMBkYK9hH8WgsT1G++BDtPpj41MBjlCJ1zMSm91R+fLUqiEOf3xOFwnag7
 KlvhJpqhITg3iZRbm9CGdh5N+RVDwv1xXKXTWjY7HX+WNyAraEmcPXej8OIFP5SNyhGW
 OQRw==
X-Gm-Message-State: APjAAAUP4r+nAVnNDRXX7SIE1Z7SPIWc38v5ARgJxjZNromQr5QaX8Ys
 L3owuizc908AQpfSH+OBdB+PuYoXGNg=
X-Google-Smtp-Source: APXvYqyWEV274dQZVgWi2Wu86iEvI+0HHvGMf3nXZJrLkcxk/IZ06QEj1btzVpyIJhovftlZLcbaGA==
X-Received: by 2002:a17:902:7d8b:: with SMTP id
 a11mr68507527plm.306.1564605499140; 
 Wed, 31 Jul 2019 13:38:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:44 -0700
Message-Id: <20190731203813.30765-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 03/32] target/arm: Install ASIDs for
 long-form from EL1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In addition to providing the core with the current ASID, this minimizes
both the number of flushes due to non-changing ASID as well as the set
of mmu_idx that are affected by each flush.

In particular, updates to the secure mode registers flushes only the
relevant secure mode mmu_idx's, and similarly non-secure updates only
affect non-secure mmu_idx's.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 73 +++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b74c23a9bc..2a65f4127e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3327,6 +3327,36 @@ static const ARMCPRegInfo pmsav5_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Called after a change to any of TTBR*_EL1 or TTBCR_EL1.  */
+static void update_lpae_el1_asid(CPUARMState *env, int secure)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t ttbr0, ttbr1, ttcr;
+    int asid, idxmask;
+
+    switch (secure) {
+    case ARM_CP_SECSTATE_S:
+        ttbr0 = env->cp15.ttbr0_s;
+        ttbr1 = env->cp15.ttbr1_s;
+        ttcr = env->cp15.tcr_el[3].raw_tcr;
+        /* Note that cp15.ttbr0_s == cp15.ttbr0_el[3], so S1E3 is affected.  */
+        /* ??? Secure EL3 really using the ASID field?  Doesn't make sense.  */
+        idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0 | ARMMMUIdxBit_S1E3;
+        break;
+    case ARM_CP_SECSTATE_NS:
+        ttbr0 = env->cp15.ttbr0_ns;
+        ttbr1 = env->cp15.ttbr1_ns;
+        ttcr = env->cp15.tcr_el[1].raw_tcr;
+        idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    asid = extract64(ttcr & TTBCR_A1 ? ttbr1 : ttbr0, 48, 16);
+
+    tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
+}
+
 static void vmsa_ttbcr_raw_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -3363,18 +3393,16 @@ static void vmsa_ttbcr_raw_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
     TCR *tcr = raw_ptr(env, ri);
 
-    if (arm_feature(env, ARM_FEATURE_LPAE)) {
-        /* With LPAE the TTBCR could result in a change of ASID
-         * via the TTBCR.A1 bit, so do a TLB flush.
-         */
-        tlb_flush(CPU(cpu));
-    }
     /* Preserve the high half of TCR_EL1, set via TTBCR2.  */
     value = deposit64(tcr->raw_tcr, 0, 32, value);
     vmsa_ttbcr_raw_write(env, ri, value);
+
+    if (arm_feature(env, ARM_FEATURE_LPAE)) {
+        /* The A1 bit controls which ASID is active.  */
+        update_lpae_el1_asid(env, ri->secure);
+    }
 }
 
 static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -3392,24 +3420,19 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    TCR *tcr = raw_ptr(env, ri);
-
-    /* For AArch64 the A1 bit could result in a change of ASID, so TLB flush. */
-    tlb_flush(CPU(cpu));
-    tcr->raw_tcr = value;
+    raw_write(env, ri, value);
+    /* The A1 bit controls which ASID is active.  */
+    update_lpae_el1_asid(env, ri->secure);
 }
 
-static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value)
+static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
 {
-    /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
-    if (cpreg_field_is_64bit(ri) &&
-        extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
-        ARMCPU *cpu = env_archcpu(env);
-        tlb_flush(CPU(cpu));
-    }
     raw_write(env, ri, value);
+    if (cpreg_field_is_64bit(ri)) {
+        /* The LPAE format (64-bit write) contains an ASID field.  */
+        update_lpae_el1_asid(env, ri->secure);
+    }
 }
 
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3455,12 +3478,12 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL1_RW, .writefn = vmsa_ttbr_el1_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
     { .name = "TTBR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL1_RW, .writefn = vmsa_ttbr_el1_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
@@ -3715,12 +3738,12 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .access = PL1_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr_el1_write, },
     { .name = "TTBR1", .cp = 15, .crm = 2, .opc1 = 1,
       .access = PL1_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr_el1_write, },
     REGINFO_SENTINEL
 };
 
-- 
2.17.1


