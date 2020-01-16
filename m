Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56662C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280702073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDruzHEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280702073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isB8t-0004Ot-Bs
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 14:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isB3a-00055D-P7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isB3Z-0007Qo-A8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:54 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isB3Z-0007Px-4K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id b137so10420953pga.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 11:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qBPdekzuUF9u9zLQuW/YaQ745tnM5NNl1KlJ3/Nz0A8=;
 b=XDruzHEP9bTEFFDvOKhWyaZaBZp5KHGlLgFzImlsI+1Yrrvg39ocHMEzGRKEJY7Chy
 WpD7TBUGnMpzfLkOBqgRDGT3peseFWq1zH1tFGZbyzZ+3Sapo4fql38QyyLNQrpSJYpT
 4EMW3OF/Z6TOaFFf2jo5r/xQGaGCu8bXcfAj4lPSyxktE75LqIvScbv9PQCZfmgwSBZJ
 DV5VNp/9OjoclIxgVLo2JB+BgvygbBBJTJBzu7wfrS01xvjoCkc7OltYh5PVnUFkFEwd
 isu90XbjUsHxigXUsfkilMUEInCOTYbI2A+sE21dNPyUQwqLObJ1cingHCKB5YLe1DuS
 0rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qBPdekzuUF9u9zLQuW/YaQ745tnM5NNl1KlJ3/Nz0A8=;
 b=ZyYpwGJc/usLIH8WstMBK4psrpkdpAYuYZXLi0U2CfXlq9GCLamb9/Q6+i5sZgLVEo
 B++o256bUSi9CDBQHWOSurWWvA/D3CWTYwrZGJugAI+AvxpAunEOV1hvG24/PJKhM7xW
 6xKDEPRLEn+Mc63QyZI2VmtAmxxzzHEYwh4JTi/+Ajlk5QrQ0HVqMu5YV8N1PU9y6LUn
 WashOh6K1eP8Pa5u+H/SLHHR0Xi9bwNRfFQuzbS4cwZHu59RI69vUhnBoOR2Cp8aTd7Q
 cFaHQlufDuRtIISG7c7jbCQCQOrDjVo7Yi+XuBx3EtsNpdBy2ckAdvxmUuFqLe7aNP7+
 8iTg==
X-Gm-Message-State: APjAAAWq1Aay6z6Unrt3kelpm7YBGHHpp485XyAm+uhfkPMqYN0NZmYz
 X/XPMyFjEa1IBPgfvbUvB8cqtkEDq4I=
X-Google-Smtp-Source: APXvYqyPBqIPdueyDCZgwwFPpeGd+tAucpF3F8Ja08MkN8MQX7+dAkEumI4P8B+E9b5x7RlciXMyFA==
X-Received: by 2002:aa7:9816:: with SMTP id e22mr39608070pfl.229.1579203831646; 
 Thu, 16 Jan 2020 11:43:51 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id g2sm26411831pgn.59.2020.01.16.11.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 11:43:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] linux-user/i386: Emulate x86_64 vsyscalls
Date: Thu, 16 Jan 2020 09:43:39 -1000
Message-Id: <20200116194341.402-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116194341.402-1-richard.henderson@linaro.org>
References: <20200116194341.402-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Notice the magic page during translate, much like we already
do for the arm32 commpage.  At runtime, raise an exception to
return cpu_loop for emulation.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h          |   1 +
 linux-user/i386/cpu_loop.c | 105 +++++++++++++++++++++++++++++++++++++
 target/i386/translate.c    |  16 +++++-
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 164d038d1f..3fb2d2a986 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1000,6 +1000,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define EXCP_VMEXIT     0x100 /* only for system emulation */
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
+#define EXCP_VSYSCALL   0x102 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index e217cca5ee..f9bf6cec27 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -92,6 +92,106 @@ static void gen_signal(CPUX86State *env, int sig, int code, abi_ptr addr)
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
+     * during translation, now verify the offset.
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
+    sigsegv:
+        /* Like force_sig(SIGSEGV).  */
+        gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
+        return;
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
+     * Perform the syscall.  None of the vsyscalls should need restarting,
+     * and all faults should have been caught above.
+     */
+    ret = do_syscall(env, syscall, env->regs[R_EDI], env->regs[R_ESI],
+                     env->regs[R_EDX], env->regs[10], env->regs[8],
+                     env->regs[9], 0, 0);
+    g_assert(ret != -TARGET_ERESTARTSYS);
+    g_assert(ret != -TARGET_QEMU_ESIGRETURN);
+    g_assert(ret != -TARGET_EFAULT);
+    env->regs[R_EAX] = ret;
+
+    /* Emulate a ret instruction to leave the vsyscall page.  */
+    env->eip = caller;
+    env->regs[R_ESP] += 8;
+}
+#endif
+
 void cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
@@ -141,6 +241,11 @@ void cpu_loop(CPUX86State *env)
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
index 7c99ef1385..391b4ef149 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8555,7 +8555,21 @@ static bool i386_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
 static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong pc_next = disas_insn(dc, cpu);
+    target_ulong pc_next;
+
+#if defined(TARGET_X86_64) && \
+    defined(CONFIG_USER_ONLY) && \
+    defined(CONFIG_LINUX)
+    /*
+     * Detect entry into the vsyscall page and invoke the syscall.
+     */
+    if ((dc->base.pc_next & TARGET_PAGE_MASK) == 0xffffffffff600000ull) {
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


