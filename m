Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A3C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A5820873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0j9dxdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A5820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2578-0005ys-IE
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j255E-0002E1-CT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j255D-0000IU-0p
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:32 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j255C-0000E3-QX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:30 -0500
Received: by mail-pj1-x1041.google.com with SMTP id j17so1772988pjz.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 19:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hRsQ7XlJN4rMifYbK1S2B4u9AT4d8Fx9ZqVq28vUwr8=;
 b=l0j9dxdzytU2BofWbBFLt+92/1oDuW3FSzq/JoTfrGb93GIpGcaR/InhGpzg8KKbmy
 jsBvuMcn6le2JfX4L1Z0pqMtzkvuhyv5Quzh0/m35/8bpF5YbTUhqfEoIPiUGuaSHGGN
 6hhHSU51ctjE4HqvZp6zBpJYnr+wc8HeJK8mKPaptz/ctnnCXPGvRNNHP5Ce5oI4JYQC
 dKFdaNPfJP2sMuXd3o8uZQH3iJlYFYVESclVCnTeGwor8/zqT+1FLnTzFezv6+3HE1vZ
 3r4ITl93TNuTxck+jRbrrnytqGB5uIZIfb3mu25DjbekgM8oR2ZYcsyXWtwZmi/DGa0G
 36DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hRsQ7XlJN4rMifYbK1S2B4u9AT4d8Fx9ZqVq28vUwr8=;
 b=bcMOX00oHEr/HuAAiPxpOmitOU6s5Vp86IB7cLigjzK388jZhiMVU3oiXSaDwZiNgU
 nvsRxGpqsU8CyWwDLyTQo5sxNRrPihMRut5VRiWySZOoJqQ5VV9Y1R5u7CDUy0U+tUwI
 Z0iO97DCygIysTAj3WU1scdipCwrIYslj4ednYfQ8rATYMOKBeBpfzVt4ReLZZ1wgSk7
 mA/NviKdjeUZtHAhVD7z2mOW6oQSuiEnZSYoSnrudWHEwxteKU1FTLXEiTUAg0A6eikr
 LJOzB8H0dmON6O87BJTmFEH82j3ih9e6PN+1bW4X12UaoZ7d+qWtaPv0SiegTG0e8+A6
 TizA==
X-Gm-Message-State: APjAAAVVYNdFF3Tme0xAvN+CCXQjSRqNjFBJOGEdLUZCLKxLGwpSigct
 x6MWSG5H4qghRumHLeAThz3LwbXw93E=
X-Google-Smtp-Source: APXvYqwvdaS/KDpDdl1vmq4Rni302aXJ1WGoT4oKpV2DlvdlJlbmvT+hn3usDSptN8b7qPYZn8Gwqw==
X-Received: by 2002:a17:90a:7187:: with SMTP id i7mr2553289pjk.6.1581564149193; 
 Wed, 12 Feb 2020 19:22:29 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm536067pgi.31.2020.02.12.19.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 19:22:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] linux-user/i386: Emulate x86_64 vsyscalls
Date: Wed, 12 Feb 2020 19:22:21 -0800
Message-Id: <20200213032223.14643-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213032223.14643-1-richard.henderson@linaro.org>
References: <20200213032223.14643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Notice the magic page during translate, much like we already
do for the arm32 commpage.  At runtime, raise an exception to
return cpu_loop for emulation.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Adjust the gotos.  Define TARGET_VSYSCALL_PAGE.
---
 target/i386/cpu.h          |   7 +++
 linux-user/i386/cpu_loop.c | 108 +++++++++++++++++++++++++++++++++++++
 target/i386/translate.c    |  14 ++++-
 3 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 08b4422f36..39be555db3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1001,6 +1001,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define EXCP_VMEXIT     0x100 /* only for system emulation */
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
+#define EXCP_VSYSCALL   0x102 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
@@ -2215,4 +2216,10 @@ static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
     return !!(cpu->hyperv_features & BIT(feat));
 }
 
+#if defined(TARGET_X86_64) && \
+    defined(CONFIG_USER_ONLY) && \
+    defined(CONFIG_LINUX)
+# define TARGET_VSYSCALL_PAGE  (UINT64_C(-10) << 20)
+#endif
+
 #endif /* I386_CPU_H */
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index e217cca5ee..70cde417e6 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -92,6 +92,109 @@ static void gen_signal(CPUX86State *env, int sig, int code, abi_ptr addr)
     queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
 }
 
+#ifdef TARGET_X86_64
+static bool write_ok_or_segv(CPUX86State *env, abi_ptr addr, size_t len)
+{
+    /*
+     * For all the vsyscalls, NULL means "don't write anything" not
+     * "write it at address 0".
+     */
+    if (addr == 0 || access_ok(VERIFY_WRITE, addr, len)) {
+        return true;
+    }
+
+    env->error_code = PG_ERROR_W_MASK | PG_ERROR_U_MASK;
+    gen_signal(env, TARGET_SIGSEGV, TARGET_SEGV_MAPERR, addr);
+    return false;
+}
+
+/*
+ * Since v3.1, the kernel traps and emulates the vsyscall page.
+ * Entry points other than the official generate SIGSEGV.
+ */
+static void emulate_vsyscall(CPUX86State *env)
+{
+    int syscall;
+    abi_ulong ret;
+    uint64_t caller;
+
+    /*
+     * Validate the entry point.  We have already validated the page
+     * during translation to get here; now verify the offset.
+     */
+    switch (env->eip & ~TARGET_PAGE_MASK) {
+    case 0x000:
+        syscall = TARGET_NR_gettimeofday;
+        break;
+    case 0x400:
+        syscall = TARGET_NR_time;
+        break;
+    case 0x800:
+        syscall = TARGET_NR_getcpu;
+        break;
+    default:
+        goto sigsegv;
+    }
+
+    /*
+     * Validate the return address.
+     * Note that the kernel treats this the same as an invalid entry point.
+     */
+    if (get_user_u64(caller, env->regs[R_ESP])) {
+        goto sigsegv;
+    }
+
+    /*
+     * Validate the the pointer arguments.
+     */
+    switch (syscall) {
+    case TARGET_NR_gettimeofday:
+        if (!write_ok_or_segv(env, env->regs[R_EDI],
+                              sizeof(struct target_timeval)) ||
+            !write_ok_or_segv(env, env->regs[R_ESI],
+                              sizeof(struct target_timezone))) {
+            return;
+        }
+        break;
+    case TARGET_NR_time:
+        if (!write_ok_or_segv(env, env->regs[R_EDI], sizeof(abi_long))) {
+            return;
+        }
+        break;
+    case TARGET_NR_getcpu:
+        if (!write_ok_or_segv(env, env->regs[R_EDI], sizeof(uint32_t)) ||
+            !write_ok_or_segv(env, env->regs[R_ESI], sizeof(uint32_t))) {
+            return;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /*
+     * Perform the syscall.  None of the vsyscalls should need restarting.
+     */
+    ret = do_syscall(env, syscall, env->regs[R_EDI], env->regs[R_ESI],
+                     env->regs[R_EDX], env->regs[10], env->regs[8],
+                     env->regs[9], 0, 0);
+    g_assert(ret != -TARGET_ERESTARTSYS);
+    g_assert(ret != -TARGET_QEMU_ESIGRETURN);
+    if (ret == -TARGET_EFAULT) {
+        goto sigsegv;
+    }
+    env->regs[R_EAX] = ret;
+
+    /* Emulate a ret instruction to leave the vsyscall page.  */
+    env->eip = caller;
+    env->regs[R_ESP] += 8;
+    return;
+
+ sigsegv:
+    /* Like force_sig(SIGSEGV).  */
+    gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
+}
+#endif
+
 void cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
@@ -141,6 +244,11 @@ void cpu_loop(CPUX86State *env)
                 env->regs[R_EAX] = ret;
             }
             break;
+#endif
+#ifdef TARGET_X86_64
+        case EXCP_VSYSCALL:
+            emulate_vsyscall(env);
+            break;
 #endif
         case EXCP0B_NOSEG:
         case EXCP0C_STACK:
diff --git a/target/i386/translate.c b/target/i386/translate.c
index d9af8f4078..5e5dbb41b0 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8555,7 +8555,19 @@ static bool i386_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
 static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong pc_next = disas_insn(dc, cpu);
+    target_ulong pc_next;
+
+#ifdef TARGET_VSYSCALL_PAGE
+    /*
+     * Detect entry into the vsyscall page and invoke the syscall.
+     */
+    if ((dc->base.pc_next & TARGET_PAGE_MASK) == TARGET_VSYSCALL_PAGE) {
+        gen_exception(dc, EXCP_VSYSCALL, dc->base.pc_next);
+        return;
+    }
+#endif
+
+    pc_next = disas_insn(dc, cpu);
 
     if (dc->tf || (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
         /* if single step mode, we generate only one instruction and
-- 
2.20.1


