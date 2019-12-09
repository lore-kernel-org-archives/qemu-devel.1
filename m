Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5552C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE63207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LF6nP2+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE63207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKBH-00024f-Pe
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ieKAK-0001XH-Qc
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ieKAJ-0008PG-A6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:37:36 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ieKAJ-0008OQ-3D
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:37:35 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so15167595wmi.5
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 06:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ze9o5C9rN/nrAOSr5U48vX+lIHw5KxUruwz9gl3yE10=;
 b=LF6nP2+uGmuaxVelXb/OGN12zEzzIdZK39FKk24OcEO/mhK08yAPwD2ahBvWuUdRxz
 bp3IO66FA371MaHZbCGPsspeMqHv12/EIjDlr5OWQAHXfB0g4LgHifO8O3bZR38WP6JQ
 krxE6xm7J4+cncZnquqOLKi9qPvPdLq7vd8rPb6KI400IPbqY/fD9qeBHJRerzWIjRJT
 vJAQO3XlCdqolj1uOgdbU8FJFnIt0MTQ1Bc3JddCwYq+KtiIzboVrATQzGxIe+9Rydoq
 t3DDzrIC2f3p7NtNNhUNdmPCBJDjOJoPF1wPhb7Xk5liWdNwalZtH49OI/HgnOgCIwkV
 hwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ze9o5C9rN/nrAOSr5U48vX+lIHw5KxUruwz9gl3yE10=;
 b=QXWmBbMCpJgw9kqSo9IfDp6UHGlTpSeJbvr0Pnhj8SKn2cgQ8IOYJkdywnWJfVxsDs
 8eUdgrsH8QFtfsI6qcRWBe+F+/rMjQxvHsl9ZUob22gNSj+kKVRPi3w6DVvwkcPRzrkQ
 rHZxmVivyyzWOzfVaQM/n3nqH3/n5tPDBcirhKA+90gNHb/fx42Sxdnam5sIkvw97TOu
 rrdYvxRanRFG8wPqzf0Q2qEfROtoRFeXDzpldKyGmGQD4yL1YAZGokgUQ8/aIGXE/t9Y
 t4VSbvLbTlw1p0tsd7MPQSkcb6mksR+QA9kJ63zpYlZcK7p3Ai2JVIx2IJtyfxyBEniu
 obpA==
X-Gm-Message-State: APjAAAU3DM8ASSxti0RsYfc3yb7XZcNuPPRBvzg+vMTcmtk9Ks3wm9Gx
 FZFsfCZx2MA6o04tzsE1ynS+EQ==
X-Google-Smtp-Source: APXvYqwx8UGqeazJKzzsU1g3jr2kkVASx4I0MHroZKBodM+ezU8dJFNi3DEUJXoxEInbdZlQVpmyJg==
X-Received: by 2002:a05:600c:1109:: with SMTP id
 b9mr25227010wma.162.1575902253251; 
 Mon, 09 Dec 2019 06:37:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d16sm29784405wrg.27.2019.12.09.06.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 06:37:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D4701FF87;
 Mon,  9 Dec 2019 14:37:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: ensure we use current exception state after SCR
 update
Date: Mon,  9 Dec 2019 14:37:23 +0000
Message-Id: <20191209143723.6368-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A write to the SCR can change the effective EL by droppping the system
from secure to non-secure mode. However if we use a cached current_el
from before the change we'll rebuild the flags incorrectly. To fix
this we overload the ARM_CP_CURRENTEL flag for the register and ensure
the new EL is used when recomputing the flags.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/arm/cpu.h       |  1 +
 target/arm/helper.h    |  1 +
 target/arm/helper.c    | 14 +++++++++++++-
 target/arm/translate.c |  6 +++++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bd4d5b4445b..d2ef4644d8f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2262,6 +2262,7 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_NOP               (ARM_CP_SPECIAL | 0x0100)
 #define ARM_CP_WFI               (ARM_CP_SPECIAL | 0x0200)
 #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
+/* Re-read the current EL, don't use cached values */
 #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
 #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
 #define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
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
index 489c31504a6..db2e33224d6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5179,7 +5179,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.scr_el3),
       .resetvalue = 0, .writefn = scr_write },
-    { .name = "SCR",  .type = ARM_CP_ALIAS,
+    { .name = "SCR",  .type = ARM_CP_ALIAS | ARM_CP_CURRENTEL,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.scr_el3),
@@ -11437,6 +11437,18 @@ void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
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
index 4d5d4bd8886..59213310065 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7083,7 +7083,11 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             if (arm_dc_feature(s, ARM_FEATURE_M)) {
                 gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
             } else {
-                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+                if (ri->type & ARM_CP_CURRENTEL) {
+                    gen_helper_rebuild_hflags_a32_newel(cpu_env);
+                } else {
+                    gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+                }
             }
             tcg_temp_free_i32(tcg_el);
             /*
-- 
2.20.1


