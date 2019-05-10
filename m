Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D21C04AB2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27AF2084A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gz4GjQPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27AF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwGK-00072s-1c
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:31:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBq-0002wZ-OE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBp-0001PC-66
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:18 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBo-0001Ok-UX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id l132so2407808pfc.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XUS5O0Wsp1uZAHY7PV259DmtfHHmlKN4309ndxqVouY=;
	b=Gz4GjQPtL1E3Yv539k/vYUvTN3tWGTYXHEvkcVeoA1qOmXra+knF5YYuTtM5+Pa8ot
	/XqjuJhTd1eEhmEtfkSSB5MNzWs9zkRfKoh0LtMyfbzF2DY20GMbfcaoyHBte9CZ1uP8
	+NEhEEGucCpOeYWtd1Rwhb3BSfXDLiX0se8VkKEy20MDFyXVEYQpy83dwDC8OzAbi3n9
	gX+73q2ar5plCpX6alf2PCqkwTTB1WPjAftUwKxKtLyStOQwjrlw/51+pTqn5kBjHLQm
	XiZkIPWv5QWnkFvY0Ab0IN67mJTFocsb4aektpcoPMclD56oCgzda7i2i6TW3PsZSLYf
	hirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=XUS5O0Wsp1uZAHY7PV259DmtfHHmlKN4309ndxqVouY=;
	b=fbZeXsJ566qB7Yf5hkRq1FlPIvVYHAn2L3mv+NigGDbapa3zr3QFfncoFtv+sBrdqJ
	7FgXjLtwqy9/z+1Dh8uzUzkMSwHfqTP2D9udqrFAsz81TykLLeqTrvWMlhySYSVQP8da
	/QWoDuq+0tpsPJXU9R1V/ytWL8TKHi4SvrnwQ3Y8clITC2cIby6nnIUQpsPU+5uhP4cA
	J+Tzj9T2JZsQu0mB2z7/iBI/fhC5m4oIIFrNUgi1t1mN9Pb6PitWy8jFyUrYCxBY2yef
	iv+yHidkPwjUsTlJChncEiK94EsyGUgBRUTd1wBf2WTmBRUZpYe4nw2GNMGzGE/X6tsF
	HArA==
X-Gm-Message-State: APjAAAX7KUosf8Ms0s3jPnfjpa2jWct+iDDyArHpxKaiLLiKN9VIaC5g
	eyF/rBoh0tK58u4QW13RJhgWOcJswD4=
X-Google-Smtp-Source: APXvYqyB7JgPJGAhFvGELy32mTKrNXZrS6u2/CJYCVt/pJwzm7LqTJ5SzxZCIHjLLl4neUK1W1LLPg==
X-Received: by 2002:a63:e550:: with SMTP id z16mr10692500pgj.329.1557458835613;
	Thu, 09 May 2019 20:27:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:04 -0700
Message-Id: <20190510032710.23910-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510032710.23910-1-richard.henderson@linaro.org>
References: <20190510032710.23910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 2/8] linux-user: Pass the parent env to
 cpu_clone_regs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implementing clone for sparc requires that we make modifications
to both the parent and child cpu state.  In all other cases, the
new argument can be ignored.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
 linux-user/xtensa/target_cpu.h     | 3 ++-
 linux-user/syscall.c               | 2 +-
 19 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index a021c95fa4..130177115e 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef AARCH64_TARGET_CPU_H
 #define AARCH64_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUARMState *env, CPUARMState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->xregs[31] = newsp;
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index ac4d255ae7..750ffb50d7 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef ALPHA_TARGET_CPU_H
 #define ALPHA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUAlphaState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUAlphaState *env, CPUAlphaState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->ir[IR_SP] = newsp;
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 8a3764919a..5538b6cb29 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -23,7 +23,8 @@
    See validate_guest_space in linux-user/elfload.c.  */
 #define MAX_RESERVED_VA  0xffff0000ul
 
-static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUARMState *env, CPUARMState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regs[13] = newsp;
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index 2309343979..baf842b400 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef CRIS_TARGET_CPU_H
 #define CRIS_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUCRISState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUCRISState *env, CPUCRISState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regs[14] = newsp;
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 1c539bdbd6..7cd8d168a7 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef HPPA_TARGET_CPU_H
 #define HPPA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUHPPAState *env, CPUHPPAState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->gr[30] = newsp;
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index ece04d0966..8fbe36670f 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef I386_TARGET_CPU_H
 #define I386_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUX86State *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUX86State *env, CPUX86State *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regs[R_ESP] = newsp;
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index 7a26f3c3fc..00b3535fae 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -21,7 +21,8 @@
 #ifndef M68K_TARGET_CPU_H
 #define M68K_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUM68KState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUM68KState *env, CPUM68KState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->aregs[7] = newsp;
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index 73e139938c..3394e98918 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef MICROBLAZE_TARGET_CPU_H
 #define MICROBLAZE_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUMBState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUMBState *env, CPUMBState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regs[R_SP] = newsp;
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 02cf5eeff7..109348a5c9 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef MIPS_TARGET_CPU_H
 #define MIPS_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUMIPSState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUMIPSState *env, CPUMIPSState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->active_tc.gpr[29] = newsp;
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index 14f63338fa..09d2db74dc 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef TARGET_CPU_H
 #define TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUNios2State *env, CPUNios2State *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regs[R_SP] = newsp;
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index 32ff135089..361b192735 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -20,7 +20,9 @@
 #ifndef OPENRISC_TARGET_CPU_H
 #define OPENRISC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUOpenRISCState *env,
+                                  CPUOpenRISCState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         cpu_set_gpr(env, 1, newsp);
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index c4641834e7..f42e266047 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef PPC_TARGET_CPU_H
 #define PPC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUPPCState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUPPCState *env, CPUPPCState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->gpr[1] = newsp;
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 7e090f376a..b112832d95 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -1,7 +1,8 @@
 #ifndef TARGET_CPU_H
 #define TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPURISCVState *env, CPURISCVState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->gpr[xSP] = newsp;
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index aa181ceaee..31d9d9d75f 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef S390X_TARGET_CPU_H
 #define S390X_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUS390XState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUS390XState *env, CPUS390XState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regs[15] = newsp;
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index b0be9a2c1b..ca0d1bb0bb 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef SH4_TARGET_CPU_H
 #define SH4_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUSH4State *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUSH4State *env, CPUSH4State *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->gregs[15] = newsp;
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 1ffc0ae9f2..a92748cae3 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef SPARC_TARGET_CPU_H
 #define SPARC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUSPARCState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUSPARCState *env, CPUSPARCState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regwptr[22] = newsp;
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index d1aa5824f2..35100a3d43 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef TILEGX_TARGET_CPU_H
 #define TILEGX_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUTLGState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUTLGState *env, CPUTLGState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regs[TILEGX_R_SP] = newsp;
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index e31efe3ea0..0e9681e9f9 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -4,7 +4,8 @@
 #ifndef XTENSA_TARGET_CPU_H
 #define XTENSA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUXtensaState *env, target_ulong newsp)
+static inline void cpu_clone_regs(CPUXtensaState *env, CPUXtensaState *old_env,
+                                  target_ulong newsp)
 {
     if (newsp) {
         env->regs[1] = newsp;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f7d0754c8d..80d7f3788e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5493,7 +5493,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         /* we create a new CPU instance. */
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
-        cpu_clone_regs(new_env, newsp);
+        cpu_clone_regs(new_env, env, newsp);
         new_cpu = ENV_GET_CPU(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
-- 
2.17.1


