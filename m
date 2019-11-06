Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB36C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48A32077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6INsJ9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48A32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJgn-0004u9-OV
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZJ-0003yK-Gx
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZH-0007YV-HH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZH-0007Y3-9n
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id w18so25348794wrt.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gK8d2UmiWBT3h0lSEqqhxht5U+EPSU1YoDxkWG/UNhU=;
 b=Q6INsJ9JMKuYTx6wz/OO2a2ABr8bk2xueM9PvhvqlxMsPClKrJNXzrg71Xp97brHWW
 MikOiIFy4DD+RuNF1ApfXngCgKE3oOtLPmFLZteHYegI0ZC/XsB4lCNyLCUP6AjgGapT
 EfydUwWZUpJUbri3FrIOMadD8yarWk7DLevFJH4t3lg3E1Ydvf9N27t+TYtGjMb0AkW4
 iBLUXoh/ZVh/xZEiMi47sVS4QrWj5iNvzjHEFkfFjehyKyxrPkhidKWMti8AhqBKKDqU
 XFS5OAcM1ay37PotrbcH8d0rjY5EeiMZumdW53HmjiTRcgA2NoPKsf6kh9b9Pjkzo+QU
 9iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gK8d2UmiWBT3h0lSEqqhxht5U+EPSU1YoDxkWG/UNhU=;
 b=PhrRzMJZYq6iM8NxsX5GrgMwYCQ6YxIM3IjuV0gWoiwogGJnK6lp8QVzvVgfwcNbE9
 d/54mSP5wA77f9hkp63eYRArm5zlXo547yWxn+f7AlsZSiYkEDnidDOIeDwdQoMmR8pZ
 4xM+yeYid/gboROEayOOcR/E7SS1WEMJfO8ap7hLjX+iXEiX1wCjaYRRGGeDYAgE7P4J
 FiN/jjHX+VCMTOPfZVJ/GEUclTMmdDWJZhWW7cFOMgatQMgsbpWMZteqOyF7wqavSlSQ
 mqwte9ZhuZ/i2W8bbNsb/6x7VeNyucI4z9dmyPNSQ0l/W0fexvmpQ6jkhaAk5KkLhxpv
 wlYw==
X-Gm-Message-State: APjAAAUOP4PwxOyaaezsfpqYl8zOLUWErKfjlnOj13qTlafOTdZ4S/ft
 M0HWsgt62GyFYxDORZ0hcCw3RB59z+znOw==
X-Google-Smtp-Source: APXvYqxxhSKnsT32FVlTXxjkpYgpeWOql9Hyd3E907iBgscS2h4/djZK4yGdFp6KIiO8kGFOxc7Ajw==
X-Received: by 2002:adf:f452:: with SMTP id f18mr2335958wrp.264.1573040021991; 
 Wed, 06 Nov 2019 03:33:41 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/12] linux-user: Rename cpu_clone_regs to
 cpu_clone_regs_child
Date: Wed,  6 Nov 2019 12:33:15 +0100
Message-Id: <20191106113318.10226-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need a target-specific hook for adjusting registers
in the parent during clone.  To avoid confusion, rename the
one we have to make it clear it affects the child.

At the same time, pass in the flags from the clone syscall.
We will need them for correct behaviour for Sparc.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191025113921.9412-10-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/target_cpu.h    | 3 ++-
 linux-user/alpha/target_cpu.h      | 3 ++-
 linux-user/arm/target_cpu.h        | 3 ++-
 linux-user/cris/target_cpu.h       | 3 ++-
 linux-user/hppa/target_cpu.h       | 3 ++-
 linux-user/i386/target_cpu.h       | 3 ++-
 linux-user/m68k/target_cpu.h       | 3 ++-
 linux-user/microblaze/target_cpu.h | 3 ++-
 linux-user/mips/target_cpu.h       | 3 ++-
 linux-user/nios2/target_cpu.h      | 3 ++-
 linux-user/openrisc/target_cpu.h   | 4 +++-
 linux-user/ppc/target_cpu.h        | 3 ++-
 linux-user/riscv/target_cpu.h      | 3 ++-
 linux-user/s390x/target_cpu.h      | 3 ++-
 linux-user/sh4/target_cpu.h        | 3 ++-
 linux-user/sparc/target_cpu.h      | 3 ++-
 linux-user/tilegx/target_cpu.h     | 3 ++-
 linux-user/xtensa/target_cpu.h     | 4 +++-
 linux-user/syscall.c               | 4 ++--
 19 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index a021c95fa4..cd012e0dc1 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef AARCH64_TARGET_CPU_H
 #define AARCH64_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->xregs[31] = newsp;
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index ac4d255ae7..37ba00cf41 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef ALPHA_TARGET_CPU_H
 #define ALPHA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUAlphaState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->ir[IR_SP] = newsp;
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 3f79356a07..6e2ba8ad4b 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -41,7 +41,8 @@ static inline unsigned long arm_max_reserved_va(CPUState *cs)
 }
 #define MAX_RESERVED_VA  arm_max_reserved_va
 
-static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[13] = newsp;
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index 2309343979..eacc4d8d13 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef CRIS_TARGET_CPU_H
 #define CRIS_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUCRISState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[14] = newsp;
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 1c539bdbd6..f250770790 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef HPPA_TARGET_CPU_H
 #define HPPA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->gr[30] = newsp;
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index ece04d0966..1fadbf57c3 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef I386_TARGET_CPU_H
 #define I386_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUX86State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUX86State *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[R_ESP] = newsp;
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index bc7446fbaf..57b647bc07 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -21,7 +21,8 @@
 #ifndef M68K_TARGET_CPU_H
 #define M68K_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUM68KState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUM68KState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->aregs[7] = newsp;
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index 73e139938c..e9bc0fce65 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef MICROBLAZE_TARGET_CPU_H
 #define MICROBLAZE_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUMBState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUMBState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[R_SP] = newsp;
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 02cf5eeff7..8601f712e0 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef MIPS_TARGET_CPU_H
 #define MIPS_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUMIPSState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUMIPSState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->active_tc.gpr[29] = newsp;
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index 5596c05c9c..fe5de7a9e3 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef NIOS2_TARGET_CPU_H
 #define NIOS2_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUNios2State *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[R_SP] = newsp;
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index 32ff135089..309cf3eeb7 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -20,7 +20,9 @@
 #ifndef OPENRISC_TARGET_CPU_H
 #define OPENRISC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUOpenRISCState *env,
+                                        target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         cpu_set_gpr(env, 1, newsp);
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index c4641834e7..028b28312c 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef PPC_TARGET_CPU_H
 #define PPC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUPPCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUPPCState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->gpr[1] = newsp;
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 90f9a4171e..26dcafab1c 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -1,7 +1,8 @@
 #ifndef RISCV_TARGET_CPU_H
 #define RISCV_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->gpr[xSP] = newsp;
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index aa181ceaee..0b19e42f75 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef S390X_TARGET_CPU_H
 #define S390X_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUS390XState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUS390XState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[15] = newsp;
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index b0be9a2c1b..857af43ee3 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef SH4_TARGET_CPU_H
 #define SH4_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUSH4State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUSH4State *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->gregs[15] = newsp;
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index b30fbc72c4..029b0fc547 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef SPARC_TARGET_CPU_H
 #define SPARC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUSPARCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regwptr[22] = newsp;
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index d1aa5824f2..0523dc414c 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef TILEGX_TARGET_CPU_H
 #define TILEGX_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUTLGState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUTLGState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[TILEGX_R_SP] = newsp;
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index e31efe3ea0..84f67d469e 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -4,7 +4,9 @@
 #ifndef XTENSA_TARGET_CPU_H
 #define XTENSA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUXtensaState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUXtensaState *env,
+                                        target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[1] = newsp;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f6751eecb7..93749014e4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5719,7 +5719,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         /* we create a new CPU instance. */
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
-        cpu_clone_regs(new_env, newsp);
+        cpu_clone_regs_child(new_env, newsp, flags);
         new_cpu = env_cpu(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
@@ -5798,7 +5798,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ret = fork();
         if (ret == 0) {
             /* Child Process.  */
-            cpu_clone_regs(env, newsp);
+            cpu_clone_regs_child(env, newsp, flags);
             fork_end(1);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
-- 
2.17.1


