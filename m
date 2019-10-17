Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B8ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0582089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1lu7Byx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0582089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLAth-0002zo-VH
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 14:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArl-00012L-Te
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArk-0000pF-IA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:17 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLArk-0000ov-Cb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:16 -0400
Received: by mail-pg1-x543.google.com with SMTP id p30so1877102pgl.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qxe5WkTH2gH9OxzrQymT8yteWQToRtaNSxbFtmMzahk=;
 b=Q1lu7ByxrpzlIeZR7hd36AnvstqdCH0FqremQcY5bEBwh5ML/Pl+SQzmYM6o4oZDvf
 i0JNMSCcI1FS/HEY5FKmJ9q9nQwUcqxLNR7DQw264C0PoTbIj1Stf52BbBvosEHytdNo
 MKbj1yuPtBBGQJ2Bg012yCombWsvnBMG75dK6LoKU3JqIfPOT0dmhCK5nI09c8jRUFCG
 Lde/2Blk46bxNLtTmU6y04NShABoWxpLWv+iwcmB6GOWEDt8+rCs2xGiXVUslz98HFCp
 Fwkvsrc3LH55QPCtKsdcVYx9iVyxgrZppj5m5MTMzMJEi6so8O1l+daCziKqz9MvAWau
 aHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qxe5WkTH2gH9OxzrQymT8yteWQToRtaNSxbFtmMzahk=;
 b=qJVjwYeTthXRBhAvyG1nOK47VQXtxLg5+Uto1n4Z+Rb2ueQiYJfcYSYyIPLL/RNvBK
 9z2jxzwKcFwM+pyB5pyePHGGXSPO44MryY6/CVnds5AgP1Dw3WYnN87c6mZlDb4gkIi/
 KaaGzeVZ80VhjRCqTmpxahzl3GRpnTgdsyv1OykekeiOw60Q4EEmPoclWtZ9flvD0JPK
 3dUThO7QJzvqkmhDQgj5usaCV19PVVkOutu8vzbNfnWmzV/wcmYxUY7Onj1wiQ+mwdi6
 myCRy1AV/k+X/u15B9KdjFSw5qMvR/2g8oLwrPHdW9ek+j7V/OWu2TipeBGdL0ggX2Jw
 Wl3A==
X-Gm-Message-State: APjAAAWdlsR4Pi4sVhn3vjAj3SG4AP7U+VjvAv20Jn0wuhYEHV3yKy8C
 8ZG00nwfNMK3zlI8LA8aydTT1JWhnrI=
X-Google-Smtp-Source: APXvYqxyCbw4cbk9gUT+Jqt/5WgW8D8dBp1ZVatC7vcL/ZabkU/StWnaeIYVaykHdkG+sbVoHSlaPQ==
X-Received: by 2002:aa7:8ad0:: with SMTP id b16mr1855140pfd.255.1571338274993; 
 Thu, 17 Oct 2019 11:51:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/20] target/arm: Split out rebuild_hflags_a64
Date: Thu, 17 Oct 2019 11:50:52 -0700
Message-Id: <20191017185110.539-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Create a function to compute the values of the TBFLAG_A64 bits
that will be cached.  For now, the env->hflags variable is not
used, and the results are fed back to cpu_get_tb_cpu_state.

Note that not all BTI related flags are cached, so we have to
test the BTI feature twice -- once for those bits moved out to
rebuild_hflags_a64 and once for those bits that remain in
cpu_get_tb_cpu_state.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 131 +++++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 62 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8829d91ae1..69da04786e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11070,6 +11070,71 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
     return flags;
 }
 
+static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
+    ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
+    uint32_t flags = 0;
+    uint64_t sctlr;
+    int tbii, tbid;
+
+    flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
+
+    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+    if (regime_el(env, stage1) < 2) {
+        ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
+        tbid = (p1.tbi << 1) | p0.tbi;
+        tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
+    } else {
+        tbid = p0.tbi;
+        tbii = tbid & !p0.tbid;
+    }
+
+    flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
+    flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
+
+    if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
+        int sve_el = sve_exception_el(env, el);
+        uint32_t zcr_len;
+
+        /*
+         * If SVE is disabled, but FP is enabled,
+         * then the effective len is 0.
+         */
+        if (sve_el != 0 && fp_el == 0) {
+            zcr_len = 0;
+        } else {
+            zcr_len = sve_zcr_len_for_el(env, el);
+        }
+        flags = FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
+        flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
+    }
+
+    sctlr = arm_sctlr(env, el);
+
+    if (cpu_isar_feature(aa64_pauth, env_archcpu(env))) {
+        /*
+         * In order to save space in flags, we record only whether
+         * pauth is "inactive", meaning all insns are implemented as
+         * a nop, or "active" when some action must be performed.
+         * The decision of which action to take is left to a helper.
+         */
+        if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
+        }
+    }
+
+    if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
+        /* Note that SCTLR_EL[23].BT == SCTLR_BT1.  */
+        if (sctlr & (el == 0 ? SCTLR_BT0 : SCTLR_BT1)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, BT, 1);
+        }
+    }
+
+    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
@@ -11079,67 +11144,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     uint32_t flags = 0;
 
     if (is_a64(env)) {
-        ARMCPU *cpu = env_archcpu(env);
-        uint64_t sctlr;
-
         *pc = env->pc;
-        flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
-
-        /* Get control bits for tagged addresses.  */
-        {
-            ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
-            ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-            int tbii, tbid;
-
-            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-            if (regime_el(env, stage1) < 2) {
-                ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
-                tbid = (p1.tbi << 1) | p0.tbi;
-                tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
-            } else {
-                tbid = p0.tbi;
-                tbii = tbid & !p0.tbid;
-            }
-
-            flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
-            flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
-        }
-
-        if (cpu_isar_feature(aa64_sve, cpu)) {
-            int sve_el = sve_exception_el(env, current_el);
-            uint32_t zcr_len;
-
-            /* If SVE is disabled, but FP is enabled,
-             * then the effective len is 0.
-             */
-            if (sve_el != 0 && fp_el == 0) {
-                zcr_len = 0;
-            } else {
-                zcr_len = sve_zcr_len_for_el(env, current_el);
-            }
-            flags = FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
-            flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
-        }
-
-        sctlr = arm_sctlr(env, current_el);
-
-        if (cpu_isar_feature(aa64_pauth, cpu)) {
-            /*
-             * In order to save space in flags, we record only whether
-             * pauth is "inactive", meaning all insns are implemented as
-             * a nop, or "active" when some action must be performed.
-             * The decision of which action to take is left to a helper.
-             */
-            if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
-                flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
-            }
-        }
-
-        if (cpu_isar_feature(aa64_bti, cpu)) {
-            /* Note that SCTLR_EL[23].BT == SCTLR_BT1.  */
-            if (sctlr & (current_el == 0 ? SCTLR_BT0 : SCTLR_BT1)) {
-                flags = FIELD_DP32(flags, TBFLAG_A64, BT, 1);
-            }
+        flags = rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
+        if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
     } else {
@@ -11159,9 +11166,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A32,
                                XSCALE_CPAR, env->cp15.c15_cpar);
         }
-    }
 
-    flags = rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+        flags = rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+    }
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
-- 
2.17.1


