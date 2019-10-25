Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9457CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D9C21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bM3TJ03b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D9C21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy7w-0005sY-3C
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwV-0006qX-Um
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwP-0006fl-2s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:41 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwO-0006eV-U6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:37 -0400
Received: by mail-qk1-x744.google.com with SMTP id y189so1414701qkc.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vn70UJTo0fstge9Ke9wJC+Kr4lifWc+iunKsVrVX6Oo=;
 b=bM3TJ03b9fHB0OAVP9OvNj+ONB000mTRXgCt5VoknLpNKKO78Pb7v73tIiW4g/e10B
 OSN50aqIQwbjR/bKhFOwnmMsrMuFu5txbbOlNuR2D/hYIl73pHSLj8heTW9WcYbUgOPI
 bTdlOxGIK7lwvdFH4vJDq1MbkG6EqRwQ0Hq103vUruHBO/Ga2T4kpTlJ7YivsIOs42Uu
 LNuk5l81wj6Q0cZZUVV4ZIZjPOcvmK362pL2Oo3mT7BNrBQfjMiyEq4PGH0jmunbUYEk
 55oKxIYCJ0Qqt1spfXsbi+/RHi/wByJVu3zEGFMEuNI+Is0dgrS25Ppo9A2Zy+v+DHJ0
 tKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vn70UJTo0fstge9Ke9wJC+Kr4lifWc+iunKsVrVX6Oo=;
 b=e2gcJBKJwOC2CbJrYUikseCvScu3DzB3rOfWXAU0sIPC80LE5WJqF+bAPYMJiA7u4z
 DDsdRawDFCRizHirZO9LvZRJs0QXlq7hZkLTYJZl+IsNpbXTIUfb4aQOyBRjpI8ksHQm
 wo1CnpDgHfHKkyNuMJoz+k/OnSb3xF79jEos+LKFHIy7oUpBuoBl3mMfGga7c6Z3wlgw
 2IWksuOK8JovWsqqXYFP+QchfQ/MkA+/w69xbVQyLMl1YQROTdCtanh6DUftKBgrC8RL
 BU2L/f59BjcPScu28eD4Yi9HbA8yK+ukyZACAaFbA2nmf8K+Qw32I+z5dcOiSWRi6uv0
 KAeQ==
X-Gm-Message-State: APjAAAWunITzP93ypK2sMdjpKYmU3TMQC2pFER6qvaEhLkGX0MXyuMgc
 K6UshbwebbKtasc6rlmVFiQcqF03qL8=
X-Google-Smtp-Source: APXvYqw4qOM1DESoye6OJ6RzBMSCAXxpE6qnBDSmp61NgZJTdKw9UNqYJE2cvd4baXoluMz/2vpZLA==
X-Received: by 2002:a05:620a:1374:: with SMTP id
 d20mr2458240qkl.229.1572003573458; 
 Fri, 25 Oct 2019 04:39:33 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] linux-user: Introduce cpu_clone_regs_parent
Date: Fri, 25 Oct 2019 07:39:19 -0400
Message-Id: <20191025113921.9412-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need a target-specific hook for adjusting registers
in the parent during clone.  Add an empty inline function for
each target, and invoke it from the proper places.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_cpu.h    | 4 ++++
 linux-user/alpha/target_cpu.h      | 4 ++++
 linux-user/arm/target_cpu.h        | 4 ++++
 linux-user/cris/target_cpu.h       | 4 ++++
 linux-user/hppa/target_cpu.h       | 4 ++++
 linux-user/i386/target_cpu.h       | 4 ++++
 linux-user/m68k/target_cpu.h       | 4 ++++
 linux-user/microblaze/target_cpu.h | 4 ++++
 linux-user/mips/target_cpu.h       | 4 ++++
 linux-user/nios2/target_cpu.h      | 4 ++++
 linux-user/openrisc/target_cpu.h   | 4 ++++
 linux-user/ppc/target_cpu.h        | 4 ++++
 linux-user/riscv/target_cpu.h      | 4 ++++
 linux-user/s390x/target_cpu.h      | 4 ++++
 linux-user/sh4/target_cpu.h        | 4 ++++
 linux-user/sparc/target_cpu.h      | 4 ++++
 linux-user/tilegx/target_cpu.h     | 4 ++++
 linux-user/xtensa/target_cpu.h     | 4 ++++
 linux-user/syscall.c               | 2 ++
 19 files changed, 74 insertions(+)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index cd012e0dc1..6cc02e7dcd 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
     env->xregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUARMState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
 {
     /* Note that AArch64 Linux keeps the TLS pointer in TPIDR; this is
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index 37ba00cf41..dd25e18f47 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
     env->ir[IR_A3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUAlphaState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
 {
     env->unique = newtls;
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 6e2ba8ad4b..2747211b24 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -50,6 +50,10 @@ static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
     env->regs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUARMState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
 {
     if (access_secure_reg(env)) {
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index eacc4d8d13..74ead55c81 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp,
     env->regs[10] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUCRISState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUCRISState *env, target_ulong newtls)
 {
     env->pregs[PR_PID] = (env->pregs[PR_PID] & 0xff) | newtls;
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index f250770790..71654b3cd4 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -32,6 +32,10 @@ static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp,
     env->iaoq_b = env->gr[31] + 4;
 }
 
+static inline void cpu_clone_regs_parent(CPUHPPAState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
 {
     env->cr[27] = newtls;
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index 1fadbf57c3..0b44530854 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUX86State *env, target_ulong newsp,
     env->regs[R_EAX] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUX86State *env, unsigned flags)
+{
+}
+
 #if defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr);
 
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index 57b647bc07..c3f288dfe8 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -30,6 +30,10 @@ static inline void cpu_clone_regs_child(CPUM68KState *env, target_ulong newsp,
     env->dregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUM68KState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
 {
     CPUState *cs = env_cpu(env);
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index e9bc0fce65..ce7b22ece7 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUMBState *env, target_ulong newsp,
     env->regs[3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUMBState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUMBState *env, target_ulong newtls)
 {
     env->regs[21] = newtls;
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 8601f712e0..758ae4d933 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUMIPSState *env, target_ulong newsp,
     env->active_tc.gpr[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUMIPSState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
 {
     env->active_tc.CP0_UserLocal = newtls;
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index fe5de7a9e3..50f0381067 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUNios2State *env, target_ulong newsp,
     env->regs[R_RET0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUNios2State *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUNios2State *env, target_ulong newtls)
 {
     /*
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index 309cf3eeb7..74370d67c4 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -30,6 +30,10 @@ static inline void cpu_clone_regs_child(CPUOpenRISCState *env,
     cpu_set_gpr(env, 11, 0);
 }
 
+static inline void cpu_clone_regs_parent(CPUOpenRISCState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
 {
     cpu_set_gpr(env, 10, newtls);
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index 028b28312c..76b67d2882 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUPPCState *env, target_ulong newsp,
     env->gpr[3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUPPCState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUPPCState *env, target_ulong newtls)
 {
 #if defined(TARGET_PPC64)
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 26dcafab1c..9c642367a3 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -11,6 +11,10 @@ static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
     env->gpr[xA0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPURISCVState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPURISCVState *env, target_ulong newtls)
 {
     env->gpr[xTP] = newtls;
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index 0b19e42f75..7cd71e2dba 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUS390XState *env, target_ulong newsp,
     env->regs[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUS390XState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
 {
     env->aregs[0] = newtls >> 32;
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index 857af43ee3..5114f19424 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUSH4State *env, target_ulong newsp,
     env->gregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUSH4State *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUSH4State *env, target_ulong newtls)
 {
   env->gbr = newtls;
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 029b0fc547..8ff706adce 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -37,6 +37,10 @@ static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
 #endif
 }
 
+static inline void cpu_clone_regs_parent(CPUSPARCState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
 {
     env->gregs[7] = newtls;
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index 0523dc414c..316b7a639c 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUTLGState *env, target_ulong newsp,
     env->regs[TILEGX_R_RE] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUTLGState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUTLGState *env, target_ulong newtls)
 {
     env->regs[TILEGX_R_TP] = newtls;
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index 84f67d469e..0c77bafd66 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -16,6 +16,10 @@ static inline void cpu_clone_regs_child(CPUXtensaState *env,
     env->regs[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUXtensaState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUXtensaState *env, target_ulong newtls)
 {
     env->uregs[THREADPTR] = newtls;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a07d4b4774..ed18bcc825 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5719,6 +5719,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
         cpu_clone_regs_child(new_env, newsp, flags);
+        cpu_clone_regs_parent(env, flags);
         new_cpu = env_cpu(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
@@ -5815,6 +5816,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
             if (flags & CLONE_CHILD_CLEARTID)
                 ts->child_tidptr = child_tidptr;
         } else {
+            cpu_clone_regs_parent(env, flags);
             fork_end(0);
         }
     }
-- 
2.17.1


