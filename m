Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C63C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF16B24658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfI/3fOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF16B24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irTWW-0007II-VW
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 16:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irTRS-0002Az-F0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irTRR-0001Wg-5W
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:38 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irTRQ-0001Va-VU
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:37 -0500
Received: by mail-pj1-x1041.google.com with SMTP id e11so4889309pjt.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 13:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9lI8WRIgAr/TmVWyIUuWbVdccm9/3r0w1XSlr2VZrj8=;
 b=jfI/3fOjamIo03jzwwbaELN6PgeBrvFi1IsmjMlqTlB7HaU2aiRr1l5WvFnOApXlhb
 +4AKpKLx3MJ3flhWrXYceb/hujvZdFY4Pzt4Kb1yt5lOa/Lwp0Scn0Mmm0wET02N1DAG
 Rw8qNPm2830jimxXFRbzLk7bhqP9C1jTbWkaP9DeyaMKsqTzQw3LRUuCy06OOq9W3ArG
 YcsbtqNdKYj9LMc14ytZo9zkMCniN4LiJc4TmVAkRwfQHIbZftDJshX4n3RXYmDfIbna
 NgSWlfdQwrlqRrAy7IP2W25fBie7CPJ7ZrHNTHDlboT7mPfQMT97ZYHtNHYPx0kcF2+L
 h4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9lI8WRIgAr/TmVWyIUuWbVdccm9/3r0w1XSlr2VZrj8=;
 b=cytF/mQClVoAIN6GmGuF1xD9pucj5geNkE2UOFl4HAw+Tgv871sNcDIPfnyrGYL/DT
 RaC81G9yU6t1W7mNOu/SJthbf1L5JhJsh0ATsxoFWUHnZ0H5cEgHsEI27Z43WUCAepYu
 WwjGwaAAm8m4zNCZStGal1DDXh7eIZzmo9eCEBxc8ciUx5rqZfRoZIx4EUtyMtp3YleO
 21y0zWaQRV+nVEiaeU6Iqft8BOrCptrLs8xC4Tb6lBpqJqp3OsXNujAQ65mMtjO00V3j
 QY9frGJbtJkedTXSxQdtQ+hJqOM1ZE5rWMm0OtEE9ffGX5TrvxdYDRMBmobeCuDqwMxm
 rGxw==
X-Gm-Message-State: APjAAAWHp/RgaVzZz+GACMF9U+o7hWxp/OJJbA5MojNREF788vjM5xGm
 5ne8uSBT1RkuVITNHbIzTXvE1IQ0gl8=
X-Google-Smtp-Source: APXvYqxyvWVvOZ46EzvrdrNyDuBtgQwVP+QAHkbNgUgbUYAiiqmU5zh6NFiB/2AC1OwhTrz+YTwSvQ==
X-Received: by 2002:a17:90a:7f01:: with SMTP id
 k1mr16441140pjl.81.1579036174507; 
 Tue, 14 Jan 2020 13:09:34 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id d26sm17881020pgv.66.2020.01.14.13.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 13:09:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] linux-user/i386: Emulate x86_64 vsyscalls
Date: Tue, 14 Jan 2020 11:09:21 -1000
Message-Id: <20200114210921.11216-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114210921.11216-1-richard.henderson@linaro.org>
References: <20200114210921.11216-1-richard.henderson@linaro.org>
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
Cc: pbonzini@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Notice the magic page during translate, much like we already
do for the arm32 commpage.  At runtime, raise an exception to
return cpu_loop for emulation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h          |   1 +
 linux-user/i386/cpu_loop.c | 104 +++++++++++++++++++++++++++++++++++++
 target/i386/translate.c    |  16 +++++-
 3 files changed, 120 insertions(+), 1 deletion(-)

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
index e217cca5ee..8b7c9f7337 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -92,6 +92,105 @@ static void gen_signal(CPUX86State *env, int sig, int code, abi_ptr addr)
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
@@ -141,6 +240,11 @@ void cpu_loop(CPUX86State *env)
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


