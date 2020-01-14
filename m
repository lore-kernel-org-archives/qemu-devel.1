Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746CAC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF4E24658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9CGgoAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF4E24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irTTN-0004EF-DM
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 16:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irTRN-00024v-Dy
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irTRM-0001Sh-5e
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:33 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irTRL-0001Rv-WB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:32 -0500
Received: by mail-pf1-x441.google.com with SMTP id x185so7187157pfc.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 13:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OtMkA9jtkqDohRDArG4G7wi+OMjr6/nJEha17cuXw6E=;
 b=Z9CGgoAa+dsFr6+KZtK2eUY1b0RHugwIy4f4fwN+Hdy5kaiiSt0LCIDvclEUIDG3pu
 7FXktKQodAQnJiYuM8XHAWiBNg8EwvoiUUjeMkTCgSigj+XkXjbpn8rj4R8ckvG/aZD3
 cfr+5B9rtB58b5ICN108inS/WNlisYaQDtVR1rXr6EbSUZN9tsG5XYMpX5WBB+HazUzB
 x7vPmrfWQDxiQ+1tiqNVfglODA2CHUbCcEmAGdERFWHn0LS6i+T7aldZkuDXAkV8hXhg
 PCOsE9bLvmBDhXiZgASzp62NLjGjXLlwtcY+BI18NhgIQ98riWRZXNxU6y7/4PJvEXb0
 g0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OtMkA9jtkqDohRDArG4G7wi+OMjr6/nJEha17cuXw6E=;
 b=FJL62jpfkFWXMl3XguHJAkcAVUQtbOUi3I4yP74ncj02qorCiygly5uux8umQcLErZ
 wpKuIebP8AMAHm8223MNd+bK74kAPM6zQTk+tWKjxZCph7ssQBVRUcBlrHAnsuJV/UCR
 3nefrjdTWD52DaqkRL5SElbgmTRw7bg7Gz18TstWRA6tYYgPWIuqtRSdyMvySdirohO9
 aS+66oLB6iMHVCwq/6Xsg3tCZ6tNwgbHmg+vsdbr7LE+ZigXd9B1i+lUArtHDKXKdOkb
 s1XjnwK6Lz4oQrIns/8Zx8PukYX8jgrq2Bml9DDzKK1Zx2dL88RxfSRIE/5G/KxzyILQ
 AnlQ==
X-Gm-Message-State: APjAAAUMxv+5ewVCZDr3yoYUW7GXftxhVolGJp/VXnxcuuXAWbHb2Qd8
 SVuSxZYic42/FL3EJRlJiblzOD9m400=
X-Google-Smtp-Source: APXvYqxGDRkX9hZgZp0Ho6y4PR2LRuXqQISsM5/IbZiS8JB/xc80iJfg0Dm8DvZvcT/GfK3rXHnNzA==
X-Received: by 2002:aa7:9a10:: with SMTP id w16mr26927694pfj.107.1579036170851; 
 Tue, 14 Jan 2020 13:09:30 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id d26sm17881020pgv.66.2020.01.14.13.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 13:09:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] linux-user/i386: Split out gen_signal
Date: Tue, 14 Jan 2020 11:09:20 -1000
Message-Id: <20200114210921.11216-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114210921.11216-1-richard.henderson@linaro.org>
References: <20200114210921.11216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

This is a bit tidier than open-coding the 5 lines necessary
to initialize the target_siginfo_t.  In addition, this zeros
the remaining bytes of the target_siginfo_t, rather than
passing in garbage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/cpu_loop.c | 93 ++++++++++++++------------------------
 1 file changed, 33 insertions(+), 60 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 024b6f4d58..e217cca5ee 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -81,13 +81,23 @@ static void set_idt(int n, unsigned int dpl)
 }
 #endif
 
+static void gen_signal(CPUX86State *env, int sig, int code, abi_ptr addr)
+{
+    target_siginfo_t info = {
+        .si_signo = sig,
+        .si_code = code,
+        ._sifields._sigfault._addr = addr
+    };
+
+    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+}
+
 void cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
     int trapnr;
     abi_ulong pc;
     abi_ulong ret;
-    target_siginfo_t info;
 
     for(;;) {
         cpu_exec_start(cs);
@@ -134,70 +144,45 @@ void cpu_loop(CPUX86State *env)
 #endif
         case EXCP0B_NOSEG:
         case EXCP0C_STACK:
-            info.si_signo = TARGET_SIGBUS;
-            info.si_errno = 0;
-            info.si_code = TARGET_SI_KERNEL;
-            info._sifields._sigfault._addr = 0;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            gen_signal(env, TARGET_SIGBUS, TARGET_SI_KERNEL, 0);
             break;
         case EXCP0D_GPF:
             /* XXX: potential problem if ABI32 */
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
                 handle_vm86_fault(env);
-            } else
-#endif
-            {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                info.si_code = TARGET_SI_KERNEL;
-                info._sifields._sigfault._addr = 0;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
             }
+#endif
+            gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
             break;
         case EXCP0E_PAGE:
-            info.si_signo = TARGET_SIGSEGV;
-            info.si_errno = 0;
-            if (!(env->error_code & 1))
-                info.si_code = TARGET_SEGV_MAPERR;
-            else
-                info.si_code = TARGET_SEGV_ACCERR;
-            info._sifields._sigfault._addr = env->cr[2];
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            gen_signal(env, TARGET_SIGSEGV,
+                       (env->error_code & 1 ?
+                        TARGET_SEGV_ACCERR : TARGET_SEGV_MAPERR),
+                       env->cr[2]);
             break;
         case EXCP00_DIVZ:
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
                 handle_vm86_trap(env, trapnr);
-            } else
-#endif
-            {
-                /* division by zero */
-                info.si_signo = TARGET_SIGFPE;
-                info.si_errno = 0;
-                info.si_code = TARGET_FPE_INTDIV;
-                info._sifields._sigfault._addr = env->eip;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
             }
+#endif
+            gen_signal(env, TARGET_SIGFPE, TARGET_FPE_INTDIV, env->eip);
             break;
         case EXCP01_DB:
         case EXCP03_INT3:
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
                 handle_vm86_trap(env, trapnr);
-            } else
+                break;
+            }
 #endif
-            {
-                info.si_signo = TARGET_SIGTRAP;
-                info.si_errno = 0;
-                if (trapnr == EXCP01_DB) {
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    info._sifields._sigfault._addr = env->eip;
-                } else {
-                    info.si_code = TARGET_SI_KERNEL;
-                    info._sifields._sigfault._addr = 0;
-                }
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            if (trapnr == EXCP01_DB) {
+                gen_signal(env, TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->eip);
+            } else {
+                gen_signal(env, TARGET_SIGTRAP, TARGET_SI_KERNEL, 0);
             }
             break;
         case EXCP04_INTO:
@@ -205,31 +190,19 @@ void cpu_loop(CPUX86State *env)
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
                 handle_vm86_trap(env, trapnr);
-            } else
-#endif
-            {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                info.si_code = TARGET_SI_KERNEL;
-                info._sifields._sigfault._addr = 0;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
             }
+#endif
+            gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
             break;
         case EXCP06_ILLOP:
-            info.si_signo = TARGET_SIGILL;
-            info.si_errno = 0;
-            info.si_code = TARGET_ILL_ILLOPN;
-            info._sifields._sigfault._addr = env->eip;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            gen_signal(env, TARGET_SIGILL, TARGET_ILL_ILLOPN, env->eip);
             break;
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_DEBUG:
-            info.si_signo = TARGET_SIGTRAP;
-            info.si_errno = 0;
-            info.si_code = TARGET_TRAP_BRKPT;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            gen_signal(env, TARGET_SIGTRAP, TARGET_TRAP_BRKPT, 0);
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
-- 
2.20.1


