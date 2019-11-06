Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA957C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9614C2077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9614C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLDf-0004rs-MW
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSL06-0003qX-Mk
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSL04-00035L-M7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:30 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:38071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSL04-00034n-CX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:28 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MG9c4-1iitPD3z9o-00GViD; Wed, 06 Nov 2019 14:05:16 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/13] linux-user: Introduce cpu_clone_regs_parent
Date: Wed,  6 Nov 2019 14:04:54 +0100
Message-Id: <20191106130456.6176-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fqCF6jQb4Tqp7Xg/84QPi/I3oc9P5g5PkjdYffnAgrZIN8CAzbu
 JwA1nw8pSUPPseM0OUskbsO4QCJefBUv58KW/a9FcnEhkJH3w4ZCBMYU4aRfTGfqcq/bhjc
 uKZmsAwf4a6Rf8P6myjo2f0JRfA1gVnEoOCtzBEax8gxKmXqrPMKrWeLaNHhefgUaTKZURE
 Xd7Fl6pvAN6CQJpXkudnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nxemIHFpLnY=:iSVcNWT5/zaNmytBSQAzk/
 qrX+YkTtVBoSdaS3aCpGu+8CP8/kerOPhwxwIRJWsi2xiF+QaRV3IRIOAtU8E8IZs1axsMiGe
 Dj0wk4DQoi6aNSkdt+kyrJ472nJ41F4VVEsZ+8xK9Y0FGrxSWt0XXcGblssakljz70V8BH9tp
 8+NsJkA+FLncyLioXRN8qP4hgpsDP2uENL5fZrQz7fPqAMx8JvmR4Mzop9/BpES+mDixHyVm3
 6UClvAvGXbQ72grILwxhJH2dFW1DDPG4PKROuEurbFC5kEJZ7yKBl353HvDWNqtuZcNyhvjmr
 sb9w8vyA6ySAVJYWFIF4AxNl2O2vZ/zKpdhoWNZ+y90UhUMmX202PZBwUKcdSGujSCoibWHTH
 k4fZYjmdn4ntEeTUDmBMcqcvaBp3OgysqDuNn/Q+Ac/9YHi1K/fz8RynsH96mlxaMAsnmBTHW
 3KQEhZoH2UYcytg94bhGmEg9XtjyFiPu7L9Y+lD+MMpwYH6Qsull1eWhzdj+UgdKmX+H/1xZ7
 trMDF3WbHH1ryz0I/GFl8eSspqJE+Ipcu52fROYP7Ta8tUrGaLWlRboBJp7KFdb8jUXPkg+I/
 py/nkaAcL21BFuCDJ7BVMr3ZnlAAQbrJg5hqNOWZWcnGBkftG3jGuiQ8WfygiH05K/HMti5eW
 /bwm8q7zL/AGlp2Cl2KTwM/eTl+mEVGHrGoRxWkAJoFJYbh7tEeUx+aVdLB057s5IATjlGBVN
 79TbfisBdMTpaLBJ8USA5S2bHZ0D/8jPNVN4jaeuqwmdkvQD8xLpvKgRxeCSwqm6tx9VqS9I6
 FMrvkBkekvr+xOsApAn70QPFegxaZuX9ZVFaeU5GjYZCDGllQokI1NDhjNmrE/8P0P1wDx5qk
 EEA+vTL+QJwzN2tjDeRQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We will need a target-specific hook for adjusting registers
in the parent during clone.  Add an empty inline function for
each target, and invoke it from the proper places.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191106113318.10226-11-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
 linux-user/syscall.c               | 2 ++
 linux-user/tilegx/target_cpu.h     | 4 ++++
 linux-user/xtensa/target_cpu.h     | 4 ++++
 19 files changed, 74 insertions(+)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index cd012e0dc1c8..6cc02e7dcdfb 100644
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
index 37ba00cf41d1..dd25e18f47fb 100644
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
index 6e2ba8ad4b8e..2747211b24ab 100644
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
index eacc4d8d13e9..74ead55c8114 100644
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
index f25077079088..71654b3cd4c0 100644
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
index 1fadbf57c367..0b44530854c8 100644
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
index 57b647bc0753..c3f288dfe83e 100644
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
index e9bc0fce6547..ce7b22ece7c4 100644
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
index 8601f712e086..758ae4d933fe 100644
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
index fe5de7a9e3c7..50f03810675a 100644
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
index 309cf3eeb73e..74370d67c45d 100644
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
index 028b28312c51..76b67d2882bf 100644
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
index 26dcafab1c77..9c642367a362 100644
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
index 0b19e42f758b..7cd71e2dbab3 100644
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
index 857af43ee3aa..5114f1942482 100644
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
index 029b0fc5475a..8ff706adcef7 100644
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
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 245ed315c834..ab9d933e53af 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5821,6 +5821,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
         cpu_clone_regs_child(new_env, newsp, flags);
+        cpu_clone_regs_parent(env, flags);
         new_cpu = env_cpu(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
@@ -5917,6 +5918,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
             if (flags & CLONE_CHILD_CLEARTID)
                 ts->child_tidptr = child_tidptr;
         } else {
+            cpu_clone_regs_parent(env, flags);
             fork_end(0);
         }
     }
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index 0523dc414cc5..316b7a639c3d 100644
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
index 84f67d469ec0..0c77bafd66f7 100644
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
-- 
2.21.0


