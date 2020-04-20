Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3051BC55183
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E081120782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZCMXfsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E081120782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdt6-0008OT-Un
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 17:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdrs-0006py-NN
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdrr-0006x2-Tu
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQdrr-0006uA-Fy
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id u16so1230128wmc.5
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3k0eiwTvqNDKNYgwZlfwBAueoo+movlXnk0iRVx+pjg=;
 b=pZCMXfsrCrWo8tR6l3NEQ7ZXI+8biNl037efUSEHNwL9vX+nqH56Bl2EG5Ci0dfmZe
 T2oD5/GnNcSAfsk9L/wnOYB2fZ0mibtcPzHhRAjKmUO/XYg1QcUnA1C/O3Lx6LTFucD0
 m6eGT3yXT+FLIe/lxG2RJ7ieK3sHBi+s3564NyxIE+Bn2JZx+ieG+oP7T1Ho9ulDfziy
 f/f1peGdkE7zWkN1ETWsD3EVCdXUORwrgbPyDu5/RKd0xcrRtBAGEkEyytgrQbi7RVBD
 EObKnyXao8Hi+u0y/hzukZXzUI9EhmRIdHAubwtecfdSG8378sP6yfcF8ojDse1+aMjZ
 nI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3k0eiwTvqNDKNYgwZlfwBAueoo+movlXnk0iRVx+pjg=;
 b=R/taYuFhdy7efNmD7AVYCe+f6uVkJC4lKwGi9Q81L51sPrR/HTt420Ea2T3nx5p1q1
 bJq1zuOqEEkbULmhRpWznSKX+HFNSnSZMujIXPJ70/kSObmBbxjFG4lBWj7K3RYnTK6j
 vJT/yR7mFa5eifLatk+dxPSgwhnCLP0PO+irf6NlpZLbJZRSkuBznecdONlioURv0xPj
 B+LgjBCM9YO1mbQ8ePrc2ppgbiSfqFOzyzhYewWDyfkg3M5497AnClSFvo5Tz23scBmJ
 6OtpCTFY2E6c7tdxwr3b8wTbb+XLPyXbDQVXKUGQd/KmlBRZYlc5KmQZnCPXz2EIm9z+
 SdKA==
X-Gm-Message-State: AGi0PuapGFGCWeglb16Rp9Gpk40uv4rM+QsKMqDjFey0+ZnDqTPIUXGF
 ErrwnZqo905iE1Unt6DbGug8SA==
X-Google-Smtp-Source: APiQypIvA6AxPvw/QiVN/BPisAsZdeeqpSqQH3Sxao9FdITrvGyxxJj94ua5QGAYj4hbSZbf+4R4GA==
X-Received: by 2002:a1c:a58b:: with SMTP id o133mr1337278wme.5.1587417734055; 
 Mon, 20 Apr 2020 14:22:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j10sm823663wmi.18.2020.04.20.14.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 14:22:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] linux-user/arm: Fix identification of syscall numbers
Date: Mon, 20 Apr 2020 22:22:06 +0100
Message-Id: <20200420212206.12776-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420212206.12776-1-peter.maydell@linaro.org>
References: <20200420212206.12776-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: omerg681@gmail.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our code to identify syscall numbers has some issues:
 * for Thumb mode, we never need the immediate value from the insn,
   but we always read it anyway
 * bad immediate values in the svc insn should cause a SIGILL, but we
   were abort()ing instead (via "goto error")

We can fix both these things by refactoring the code that identifies
the syscall number to more closely follow the kernel COMPAT_OABI code:
 * for Thumb it is always r7
 * for Arm, if the immediate value is 0, then this is an EABI call
   with the syscall number in r7
 * otherwise, we XOR the immediate value with 0x900000
   (ARM_SYSCALL_BASE for QEMU; __NR_OABI_SYSCALL_BASE in the kernel),
   which converts valid syscall immediates into the desired value,
   and puts all invalid immediates in the range 0x100000 or above
 * then we can just let the existing "value too large, deliver
   SIGILL" case handle invalid numbers, and drop the 'goto error'

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
You might prefer to read this patch with an "ignore whitespace
changes" diff, as a big chunk of code is no longer inside an if()
and got re-indented out one level.
---
 linux-user/arm/cpu_loop.c | 143 ++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 66 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index f042108b0be..eeb042829e2 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -299,85 +299,96 @@ void cpu_loop(CPUARMState *env)
                 env->eabi = 1;
                 /* system call */
                 if (env->thumb) {
-                    /* FIXME - what to do if get_user() fails? */
-                    get_user_code_u16(insn, env->regs[15] - 2, env);
-                    n = insn & 0xff;
+                    /* Thumb is always EABI style with syscall number in r7 */
+                    n = env->regs[7];
                 } else {
+                    /*
+                     * Equivalent of kernel CONFIG_OABI_COMPAT: read the
+                     * Arm SVC insn to extract the immediate, which is the
+                     * syscall number in OABI.
+                     */
                     /* FIXME - what to do if get_user() fails? */
                     get_user_code_u32(insn, env->regs[15] - 4, env);
                     n = insn & 0xffffff;
-                }
-
-                if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
-                    /* linux syscall */
-                    if (env->thumb || n == 0) {
+                    if (n == 0) {
+                        /* zero immediate: EABI, syscall number in r7 */
                         n = env->regs[7];
                     } else {
-                        n -= ARM_SYSCALL_BASE;
+                        /*
+                         * This XOR matches the kernel code: an immediate
+                         * in the valid range (0x900000 .. 0x9fffff) is
+                         * converted into the correct EABI-style syscall
+                         * number; invalid immediates end up as values
+                         * > 0xfffff and are handled below as out-of-range.
+                         */
+                        n ^= ARM_SYSCALL_BASE;
                         env->eabi = 0;
                     }
-                    if ( n > ARM_NR_BASE) {
-                        switch (n) {
-                        case ARM_NR_cacheflush:
-                            /* nop */
-                            break;
-                        case ARM_NR_set_tls:
-                            cpu_set_tls(env, env->regs[0]);
-                            env->regs[0] = 0;
-                            break;
-                        case ARM_NR_breakpoint:
-                            env->regs[15] -= env->thumb ? 2 : 4;
-                            goto excp_debug;
-                        case ARM_NR_get_tls:
-                            env->regs[0] = cpu_get_tls(env);
-                            break;
-                        default:
-                            if (n < 0xf0800) {
-                                /*
-                                 * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
-                                 * 0x9f07ff in OABI numbering) are defined
-                                 * to return -ENOSYS rather than raising
-                                 * SIGILL. Note that we have already
-                                 * removed the 0x900000 prefix.
-                                 */
-                                qemu_log_mask(LOG_UNIMP,
-                                    "qemu: Unsupported ARM syscall: 0x%x\n",
-                                              n);
-                                env->regs[0] = -TARGET_ENOSYS;
+                }
+
+                if (n > ARM_NR_BASE) {
+                    switch (n) {
+                    case ARM_NR_cacheflush:
+                        /* nop */
+                        break;
+                    case ARM_NR_set_tls:
+                        cpu_set_tls(env, env->regs[0]);
+                        env->regs[0] = 0;
+                        break;
+                    case ARM_NR_breakpoint:
+                        env->regs[15] -= env->thumb ? 2 : 4;
+                        goto excp_debug;
+                    case ARM_NR_get_tls:
+                        env->regs[0] = cpu_get_tls(env);
+                        break;
+                    default:
+                        if (n < 0xf0800) {
+                            /*
+                             * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
+                             * 0x9f07ff in OABI numbering) are defined
+                             * to return -ENOSYS rather than raising
+                             * SIGILL. Note that we have already
+                             * removed the 0x900000 prefix.
+                             */
+                            qemu_log_mask(LOG_UNIMP,
+                                "qemu: Unsupported ARM syscall: 0x%x\n",
+                                          n);
+                            env->regs[0] = -TARGET_ENOSYS;
+                        } else {
+                            /*
+                             * Otherwise SIGILL. This includes any SWI with
+                             * immediate not originally 0x9fxxxx, because
+                             * of the earlier XOR.
+                             */
+                            info.si_signo = TARGET_SIGILL;
+                            info.si_errno = 0;
+                            info.si_code = TARGET_ILL_ILLTRP;
+                            info._sifields._sigfault._addr = env->regs[15];
+                            if (env->thumb) {
+                                info._sifields._sigfault._addr -= 2;
                             } else {
-                                /* Otherwise SIGILL */
-                                info.si_signo = TARGET_SIGILL;
-                                info.si_errno = 0;
-                                info.si_code = TARGET_ILL_ILLTRP;
-                                info._sifields._sigfault._addr = env->regs[15];
-                                if (env->thumb) {
-                                    info._sifields._sigfault._addr -= 2;
-                                } else {
-                                    info._sifields._sigfault._addr -= 2;
-                                }
-                                queue_signal(env, info.si_signo,
-                                             QEMU_SI_FAULT, &info);
+                                info._sifields._sigfault._addr -= 2;
                             }
-                            break;
-                        }
-                    } else {
-                        ret = do_syscall(env,
-                                         n,
-                                         env->regs[0],
-                                         env->regs[1],
-                                         env->regs[2],
-                                         env->regs[3],
-                                         env->regs[4],
-                                         env->regs[5],
-                                         0, 0);
-                        if (ret == -TARGET_ERESTARTSYS) {
-                            env->regs[15] -= env->thumb ? 2 : 4;
-                        } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                            env->regs[0] = ret;
+                            queue_signal(env, info.si_signo,
+                                         QEMU_SI_FAULT, &info);
                         }
+                        break;
                     }
                 } else {
-                    goto error;
+                    ret = do_syscall(env,
+                                     n,
+                                     env->regs[0],
+                                     env->regs[1],
+                                     env->regs[2],
+                                     env->regs[3],
+                                     env->regs[4],
+                                     env->regs[5],
+                                     0, 0);
+                    if (ret == -TARGET_ERESTARTSYS) {
+                        env->regs[15] -= env->thumb ? 2 : 4;
+                    } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                        env->regs[0] = ret;
+                    }
                 }
             }
             break;
-- 
2.20.1


