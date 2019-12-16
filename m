Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4B9C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F42206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOFCkSjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F42206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igojN-0006fu-QU
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoG2-0008Cn-M8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoG1-0000PU-7R
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:46 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoG1-0000JS-14
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id f4so4739813wmj.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DIuLYiQq5xzu9Y0KMgE74Fd5M3uLmxz+SEXsEQw/Wpg=;
 b=xOFCkSjQLtKJsLPMIl6l5z+OyX2kPYqU0eJrscUBUHKe694AP1xlpQXe4I155z6RyB
 n8LlgxejQiOaxPWf8HhQS1YiWqCi53Unq+p527EkxW06sxE2IVK6wHb+n+QmDVIbT+fa
 YgnCs8tCcg2jt412gnk9S/+C/6nThXrzrYhkmTfLZJ5H8GitGF7mklRbPUypcC8Y1aEL
 oSHmXwqlXb/vxSfZ0yKY7qHV8RKRNO4uL9YNotkqjgKM0wLC0bFie0fJ7gxUnO/FkS3T
 NA93h81MeMLdAoThT9DbnzPoRmvhOzpi/fUHz3JyhCXJLO5rivQMptv9HblmoAwOCNCC
 95Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DIuLYiQq5xzu9Y0KMgE74Fd5M3uLmxz+SEXsEQw/Wpg=;
 b=MCHWsozPNCVAsIibTycQXypClTYlE1s0rZLDlOPl1mii7HHTQ1xXtvZZTEhoyjYwck
 W5iQ4pU1yL4uBH7ke4lNCGDD81d+KkuWxoYv9M4TberD7iBK3cxsgac+n0tICwBLNU+0
 YdNrSt9mGUNeK8Y9HySxAvFFE+mmN+C00gkx2KDP5eVh+7ifDkslnHqjgXSf6bHTkqCg
 KXykBeJcVlFUOGJrU4b5v8APgTw+PujJkfW3Xo3aLlrGKLccyrat27eYL4vOWliaDduJ
 uz/ARwurBdi0s73kFCYrTFnCYyp1qZi+yP+Utxmkafm0ERd2a6AtcKAmRUuhJ645uqfA
 hx1g==
X-Gm-Message-State: APjAAAX5I8hqQULmSLmdzWcrZbYf7AJEmVf2B83tlCwkVdtq61mXJWyE
 P+Nb7CbfmVkxhdg5Bp2KMfkc1d+ejiW1Fg==
X-Google-Smtp-Source: APXvYqwnq1SLwdgXql3mLY9JHT5MmMxhIvUnn+v5B6bp1P2UifUeOMAG/sCdCneIHxeypWMKfYM06Q==
X-Received: by 2002:a1c:a504:: with SMTP id o4mr18825312wme.131.1576494583688; 
 Mon, 16 Dec 2019 03:09:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/34] target/arm: ensure we use current exception state after
 SCR update
Date: Mon, 16 Dec 2019 11:09:04 +0000
Message-Id: <20191216110904.30815-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Alex Bennée <alex.bennee@linaro.org>

A write to the SCR can change the effective EL by droppping the system
from secure to non-secure mode. However if we use a cached current_el
from before the change we'll rebuild the flags incorrectly. To fix
this we introduce the ARM_CP_NEWEL CP flag to indicate the new EL
should be used when recomputing the flags.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191212114734.6962-1-alex.bennee@linaro.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191209143723.6368-1-alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  8 ++++++--
 target/arm/helper.h    |  1 +
 target/arm/helper.c    | 14 +++++++++++++-
 target/arm/translate.c |  6 +++++-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4106e4ae590..5f70e9e0438 100644
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
index 7ce5169afb5..aa3d8cd08fa 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -91,6 +91,7 @@ DEF_HELPER_2(get_user_reg, i32, env, i32)
 DEF_HELPER_3(set_user_reg, void, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
+DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3a93844a3bc..5074b5f69ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5133,7 +5133,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.scr_el3),
       .resetvalue = 0, .writefn = scr_write },
-    { .name = "SCR",  .type = ARM_CP_ALIAS,
+    { .name = "SCR",  .type = ARM_CP_ALIAS | ARM_CP_NEWEL,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.scr_el3),
@@ -11472,6 +11472,18 @@ void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
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
index f162be8434f..2b6c1f91bf9 100644
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


