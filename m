Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656CDC2D0C8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346412067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktYEIq46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346412067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMxR-0003Lr-AX
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ifMwi-0002n9-3Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:47:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ifMwg-0004vc-Kn
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:47:51 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ifMwg-0004t9-Bz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:47:50 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so2354143wrl.13
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 03:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QM15Kq7l2rtZD3l31WMeE+oAwNwZWxd9GAGGi1JsolM=;
 b=ktYEIq46Dpaf+Iz5Q+YGqaYUgueNheaKh7TOKJbh4IbqbZkb2PRw35ImuJn/D9PNeU
 RGiKQ6YKsydAv5LNThtsZYiUQ0LI+O9AVctG9Tzh7gt2AuTCERReMC0HHimzZ7tM7hdT
 9Het8vLiSp6ecOQ9AfFZLHJp1mmRH40mU1P5vjajtJ+pKa9yi/63IAHKluLsshGC38FE
 vqgv1qfbmzlUiRVbkH7Aom9JdKi2erQS965SaTsQyYB0ySLIVQTty9GXgpnlWpGzEaHT
 WiHzGA1mFE18E4PX29j/SWOBA6nZ76KJElELBJ2TyXGOBJ/R04iDtLpcrl7lNqzaPioX
 R0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QM15Kq7l2rtZD3l31WMeE+oAwNwZWxd9GAGGi1JsolM=;
 b=QLlbL2sWpvm7ouMi3nUFEa67G2iE5q7NjxwDepydp+1AegTMCFHDQ3RGa5A1/o2rWA
 bPeMxnSBiguK+bG+XyNlQxsCxRBHxTV2Ot6KKp+JqpARXV+ZkoNwoRj9xPy4Kf13IHns
 /5EYzqD3d4GQNVA8E+0Dp65dMvGAp76Sr9jYgJHdQRahRU2az7zg0/yQ825DY5j7pR08
 lcQVxluQwhwNh1XhwFJJURdQgGISWFe1gVG7sXjltP8GfbvvWHSBK+UaGosbT4ZcuGPf
 KG5M8CQVGfIDgvGR3s/RgKcUyd79G0NzSuxwa4T4L+i6PviYZJ9ZZPz/KusJYcd+fTnE
 DuYw==
X-Gm-Message-State: APjAAAVGnJRUZQ59NzHUSMO8khJlD1p+rL9fCPdx5Tn0F9xs0+3p3vCP
 HeHVjAn+RBOgSAcsnv/AscTqXw==
X-Google-Smtp-Source: APXvYqzF7F77ukhJrmaFi6wsHEfW/RR9wOdyj5fjBaXxqJbxPtwNqqWc1ioSSIm+lZoBtrhmTmGYHA==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr5404817wrl.377.1576151268470; 
 Thu, 12 Dec 2019 03:47:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n3sm5492409wrs.8.2019.12.12.03.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 03:47:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 097061FF87;
 Thu, 12 Dec 2019 11:47:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] target/arm: ensure we use current exception state after
 SCR update
Date: Thu, 12 Dec 2019 11:47:34 +0000
Message-Id: <20191212114734.6962-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A write to the SCR can change the effective EL by droppping the system
from secure to non-secure mode. However if we use a cached current_el
from before the change we'll rebuild the flags incorrectly. To fix
this we introduce the ARM_CP_NEWEL CP flag to indicate the new EL
should be used when recomputing the flags.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191209143723.6368-1-alex.bennee@linaro.org>

---
v2
  - don't override a ARM_CP_SPECIAL, use a new flag
---
 target/arm/cpu.h       |  8 ++++++--
 target/arm/helper.h    |  1 +
 target/arm/helper.c    | 14 +++++++++++++-
 target/arm/translate.c |  6 +++++-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4bac..c3ab47d8962 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2238,6 +2238,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
  * RAISES_EXC is for when the read or write hook might raise an exception;
  * the generated code will synchronize the CPU state before calling the hook
  * so that it is safe for the hook to call raise_exception().
+ * NEWEL is for writes to registers that might change the exception
+ * level - typically on older ARM chips. For those cases we need to
+ * re-read the new el when recomputing the translation flags.
  */
 #define ARM_CP_SPECIAL           0x0001
 #define ARM_CP_CONST             0x0002
@@ -2257,10 +2260,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_SVE               0x2000
 #define ARM_CP_NO_GDB            0x4000
 #define ARM_CP_RAISES_EXC        0x8000
+#define ARM_CP_NEWEL             0x10000
 /* Used only as a terminator for ARMCPRegInfo lists */
-#define ARM_CP_SENTINEL          0xffff
+#define ARM_CP_SENTINEL          0xfffff
 /* Mask of only the flag bits in a type field */
-#define ARM_CP_FLAG_MASK         0xf0ff
+#define ARM_CP_FLAG_MASK         0x1f0ff
 
 /* Valid values for ARMCPRegInfo state field, indicating which of
  * the AArch32 and AArch64 execution states this register is visible in.
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3d4ec267a2c..e345bdb726a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -91,6 +91,7 @@ DEF_HELPER_2(get_user_reg, i32, env, i32)
 DEF_HELPER_3(set_user_reg, void, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
+DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0bf8f53d4b8..b92ef9d1905 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5096,7 +5096,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.scr_el3),
       .resetvalue = 0, .writefn = scr_write },
-    { .name = "SCR",  .type = ARM_CP_ALIAS,
+    { .name = "SCR",  .type = ARM_CP_ALIAS | ARM_CP_NEWEL,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.scr_el3),
@@ -11332,6 +11332,18 @@ void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
     env->hflags = rebuild_hflags_m32(env, fp_el, mmu_idx);
 }
 
+/*
+ * If we have triggered a EL state change we can't rely on the
+ * translator having passed it too us, we need to recompute.
+ */
+void HELPER(rebuild_hflags_a32_newel)(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+    env->hflags = rebuild_hflags_a32(env, fp_el, mmu_idx);
+}
+
 void HELPER(rebuild_hflags_a32)(CPUARMState *env, int el)
 {
     int fp_el = fp_exception_el(env, el);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4d5d4bd8886..83aa331b1ec 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7083,7 +7083,11 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             if (arm_dc_feature(s, ARM_FEATURE_M)) {
                 gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
             } else {
-                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+                if (ri->type & ARM_CP_NEWEL) {
+                    gen_helper_rebuild_hflags_a32_newel(cpu_env);
+                } else {
+                    gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+                }
             }
             tcg_temp_free_i32(tcg_el);
             /*
-- 
2.20.1


