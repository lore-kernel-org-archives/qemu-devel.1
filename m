Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1898C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E162074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omN5poI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E162074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnmJ-0005oy-KV
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQnlK-0004l6-Sq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQnlK-0004rx-A9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:56:10 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQnlI-0004lt-7X; Tue, 21 Apr 2020 03:56:08 -0400
Received: by mail-lj1-x244.google.com with SMTP id w20so6672200ljj.0;
 Tue, 21 Apr 2020 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=F0OK7LaCdd9rNu4BYX2JLFSq9KCkMRs2Gs/PfWwJkFA=;
 b=omN5poI34SHWyyisVQlFXOj49+AIiZQC4lM2VH5yJIGLxRjw1LQj504Hd3ao/M/I/5
 t6i2NolFr7kYtmegAhz8GrEHaGcgRfCU+OgLjplfiTgf5WBkcrBcYsU41X2ydHwbQ1O4
 fH+I0VVIZkBTPV0MPR1cadd4StyXeV6MiM5O+IGQ2+MsG2W0wpdLEnQ1bD7ujgDXDXAT
 QiNsNXxEZPkUl3nquNsZKf/FZpP9DhyLYu7vQw/J5f46YCAZeNODuSlriA9IhXyhQK2A
 OqhxVVHVKhkQBkknrdqmyZHxIQBYFEUccd8n/79H0jf/0Aue62Oz014WB+S1O9vT5qdT
 RsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F0OK7LaCdd9rNu4BYX2JLFSq9KCkMRs2Gs/PfWwJkFA=;
 b=emEyXg0TxI58/JWX7xXHSm1GQf7nNUj+dVkGMlkwKu4VuY3IJRZdl3GscojirKQwPM
 m2rtpbH/thbXlG2arff5KB/CjZTh5QezyQmU/TH+tBnypRn2WmTQ2ctKCa5U1NUi1Ouc
 jBSDP6jiKgDOWniAhUKv0NIWRQdcl98Cx9DByXaLzfEbqyQW4vuMycjpgQC6wqCTzJLg
 menpPFf9Dn3z7Az/UqMT5IrTMUAkzOCSGk/OeqVdNHUyJenIdH1TJJylmbVqPkN6tnxS
 bXP8Ym4iQ4BBe4YhxJI2lYdekEKuULiGpk8zFh45dx4cZvF3QkamyPFE2ab5JtW/Rmyj
 2DTw==
X-Gm-Message-State: AGi0PuZaQGxy+Z/dy4N5lRnBQgKiYw8guJIuZlBsyQM2QK9TPbwq3lhw
 2ckrxKuksiqYlBxGexAy57s=
X-Google-Smtp-Source: APiQypJi8LsZJPYXgIQqSw1YlBNQj6d3ZhI9xKXfxo6m42elxC8mymlrcRbVu3hTNPlRa9pLXX052w==
X-Received: by 2002:a2e:9616:: with SMTP id v22mr3029796ljh.62.1587455765861; 
 Tue, 21 Apr 2020 00:56:05 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id w27sm1578889lfn.45.2020.04.21.00.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 00:56:05 -0700 (PDT)
Date: Tue, 21 Apr 2020 09:57:16 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] linux-user/arm: Fix identification of syscall numbers
Message-ID: <20200421075715.GH2669@toto>
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420212206.12776-5-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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
Cc: omerg681@gmail.com, qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 10:22:06PM +0100, Peter Maydell wrote:
> Our code to identify syscall numbers has some issues:
>  * for Thumb mode, we never need the immediate value from the insn,
>    but we always read it anyway
>  * bad immediate values in the svc insn should cause a SIGILL, but we
>    were abort()ing instead (via "goto error")
> 
> We can fix both these things by refactoring the code that identifies
> the syscall number to more closely follow the kernel COMPAT_OABI code:
>  * for Thumb it is always r7
>  * for Arm, if the immediate value is 0, then this is an EABI call
>    with the syscall number in r7
>  * otherwise, we XOR the immediate value with 0x900000
>    (ARM_SYSCALL_BASE for QEMU; __NR_OABI_SYSCALL_BASE in the kernel),
>    which converts valid syscall immediates into the desired value,
>    and puts all invalid immediates in the range 0x100000 or above
>  * then we can just let the existing "value too large, deliver
>    SIGILL" case handle invalid numbers, and drop the 'goto error'


I guess the -2 vs -4 issue has propagated into this patch but with that fixed:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> You might prefer to read this patch with an "ignore whitespace
> changes" diff, as a big chunk of code is no longer inside an if()
> and got re-indented out one level.
> ---
>  linux-user/arm/cpu_loop.c | 143 ++++++++++++++++++++------------------
>  1 file changed, 77 insertions(+), 66 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index f042108b0be..eeb042829e2 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -299,85 +299,96 @@ void cpu_loop(CPUARMState *env)
>                  env->eabi = 1;
>                  /* system call */
>                  if (env->thumb) {
> -                    /* FIXME - what to do if get_user() fails? */
> -                    get_user_code_u16(insn, env->regs[15] - 2, env);
> -                    n = insn & 0xff;
> +                    /* Thumb is always EABI style with syscall number in r7 */
> +                    n = env->regs[7];
>                  } else {
> +                    /*
> +                     * Equivalent of kernel CONFIG_OABI_COMPAT: read the
> +                     * Arm SVC insn to extract the immediate, which is the
> +                     * syscall number in OABI.
> +                     */
>                      /* FIXME - what to do if get_user() fails? */
>                      get_user_code_u32(insn, env->regs[15] - 4, env);
>                      n = insn & 0xffffff;
> -                }
> -
> -                if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
> -                    /* linux syscall */
> -                    if (env->thumb || n == 0) {
> +                    if (n == 0) {
> +                        /* zero immediate: EABI, syscall number in r7 */
>                          n = env->regs[7];
>                      } else {
> -                        n -= ARM_SYSCALL_BASE;
> +                        /*
> +                         * This XOR matches the kernel code: an immediate
> +                         * in the valid range (0x900000 .. 0x9fffff) is
> +                         * converted into the correct EABI-style syscall
> +                         * number; invalid immediates end up as values
> +                         * > 0xfffff and are handled below as out-of-range.
> +                         */
> +                        n ^= ARM_SYSCALL_BASE;
>                          env->eabi = 0;
>                      }
> -                    if ( n > ARM_NR_BASE) {
> -                        switch (n) {
> -                        case ARM_NR_cacheflush:
> -                            /* nop */
> -                            break;
> -                        case ARM_NR_set_tls:
> -                            cpu_set_tls(env, env->regs[0]);
> -                            env->regs[0] = 0;
> -                            break;
> -                        case ARM_NR_breakpoint:
> -                            env->regs[15] -= env->thumb ? 2 : 4;
> -                            goto excp_debug;
> -                        case ARM_NR_get_tls:
> -                            env->regs[0] = cpu_get_tls(env);
> -                            break;
> -                        default:
> -                            if (n < 0xf0800) {
> -                                /*
> -                                 * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
> -                                 * 0x9f07ff in OABI numbering) are defined
> -                                 * to return -ENOSYS rather than raising
> -                                 * SIGILL. Note that we have already
> -                                 * removed the 0x900000 prefix.
> -                                 */
> -                                qemu_log_mask(LOG_UNIMP,
> -                                    "qemu: Unsupported ARM syscall: 0x%x\n",
> -                                              n);
> -                                env->regs[0] = -TARGET_ENOSYS;
> +                }
> +
> +                if (n > ARM_NR_BASE) {
> +                    switch (n) {
> +                    case ARM_NR_cacheflush:
> +                        /* nop */
> +                        break;
> +                    case ARM_NR_set_tls:
> +                        cpu_set_tls(env, env->regs[0]);
> +                        env->regs[0] = 0;
> +                        break;
> +                    case ARM_NR_breakpoint:
> +                        env->regs[15] -= env->thumb ? 2 : 4;
> +                        goto excp_debug;
> +                    case ARM_NR_get_tls:
> +                        env->regs[0] = cpu_get_tls(env);
> +                        break;
> +                    default:
> +                        if (n < 0xf0800) {
> +                            /*
> +                             * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
> +                             * 0x9f07ff in OABI numbering) are defined
> +                             * to return -ENOSYS rather than raising
> +                             * SIGILL. Note that we have already
> +                             * removed the 0x900000 prefix.
> +                             */
> +                            qemu_log_mask(LOG_UNIMP,
> +                                "qemu: Unsupported ARM syscall: 0x%x\n",
> +                                          n);
> +                            env->regs[0] = -TARGET_ENOSYS;
> +                        } else {
> +                            /*
> +                             * Otherwise SIGILL. This includes any SWI with
> +                             * immediate not originally 0x9fxxxx, because
> +                             * of the earlier XOR.
> +                             */
> +                            info.si_signo = TARGET_SIGILL;
> +                            info.si_errno = 0;
> +                            info.si_code = TARGET_ILL_ILLTRP;
> +                            info._sifields._sigfault._addr = env->regs[15];
> +                            if (env->thumb) {
> +                                info._sifields._sigfault._addr -= 2;
>                              } else {
> -                                /* Otherwise SIGILL */
> -                                info.si_signo = TARGET_SIGILL;
> -                                info.si_errno = 0;
> -                                info.si_code = TARGET_ILL_ILLTRP;
> -                                info._sifields._sigfault._addr = env->regs[15];
> -                                if (env->thumb) {
> -                                    info._sifields._sigfault._addr -= 2;
> -                                } else {
> -                                    info._sifields._sigfault._addr -= 2;
> -                                }
> -                                queue_signal(env, info.si_signo,
> -                                             QEMU_SI_FAULT, &info);
> +                                info._sifields._sigfault._addr -= 2;
>                              }
> -                            break;
> -                        }
> -                    } else {
> -                        ret = do_syscall(env,
> -                                         n,
> -                                         env->regs[0],
> -                                         env->regs[1],
> -                                         env->regs[2],
> -                                         env->regs[3],
> -                                         env->regs[4],
> -                                         env->regs[5],
> -                                         0, 0);
> -                        if (ret == -TARGET_ERESTARTSYS) {
> -                            env->regs[15] -= env->thumb ? 2 : 4;
> -                        } else if (ret != -TARGET_QEMU_ESIGRETURN) {
> -                            env->regs[0] = ret;
> +                            queue_signal(env, info.si_signo,
> +                                         QEMU_SI_FAULT, &info);
>                          }
> +                        break;
>                      }
>                  } else {
> -                    goto error;
> +                    ret = do_syscall(env,
> +                                     n,
> +                                     env->regs[0],
> +                                     env->regs[1],
> +                                     env->regs[2],
> +                                     env->regs[3],
> +                                     env->regs[4],
> +                                     env->regs[5],
> +                                     0, 0);
> +                    if (ret == -TARGET_ERESTARTSYS) {
> +                        env->regs[15] -= env->thumb ? 2 : 4;
> +                    } else if (ret != -TARGET_QEMU_ESIGRETURN) {
> +                        env->regs[0] = ret;
> +                    }
>                  }
>              }
>              break;
> -- 
> 2.20.1
> 
> 

