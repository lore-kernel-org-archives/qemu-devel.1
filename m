Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7507B205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcuvIu39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7507B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw88y-00024F-PL
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jw88F-0001e5-1y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:57:19 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jw88B-0008Lv-F7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:57:18 -0400
Received: by mail-pl1-x642.google.com with SMTP id x8so4186535plm.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=RrgqiPB0Qv2gZiXHILw3ySKJGCdCSp7qOOeYOK/QHHc=;
 b=XcuvIu39ReNXG3YvldPeLYlh44j8vJk00qmACoptBRy80CgdGh8JCY5EkigCp9GA2G
 AWTTaWHRBnl20wkQK18pv+6GjNVC3jpUT95F/FjR7pqMH9/CqTiBFbd6Wx1u6VVywBro
 8vCksNOkcyKQYwgskao5ZTDGtuSdQ3mwmnxTknOdU/JuOp4TLnws9TWmsVOFMPFg6gdd
 S6cuzrW4odglJ5c6bYnSK0MJhB19kNCmiggzSll1Jp+NbQdBT0kkLLgA5sWfC5RwVZH4
 zW8Pd90BopAeoUm1BvOWfjCUpQ5N+O+eIiMR8ZyHKKCN7BFOfDKLXXzkSM2MVCyvUctl
 bOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RrgqiPB0Qv2gZiXHILw3ySKJGCdCSp7qOOeYOK/QHHc=;
 b=LjNHqCtXTtNJjESaflKj6T4sQjOUcU+EYv19t6e5kzL3tnLDCkKT7xUOHBDLzvog5b
 TjD2afvoNdjzCtctqz7FtQ8fKyVgPo6Q8ZvnNyxIR7xJ8KMlXOG1FswAPUsvcq6LOzrU
 Ev3LgS0bjb0EJbvgjE2/pHKTzKI3fZvqhX311sm/q7n9dRW9XKWHFECctTCEmx1vHfw0
 V5B4YT7S2317EforUXyBw8QBmorEHmuOBLT028Gv72XWqZ8rPr/ZJSPyAsGr4EFMLPZk
 HDHs8o8T35BSosYePSPxG89nwBJ6Fm0NF405H2C9GG6YNscSgc2y41QQmFJvWtvThGTn
 ftGw==
X-Gm-Message-State: AOAM531FE6wm07Mdy66UI2rYpcGupbI5ytWynKZCAkRiyrvSOhUHYyXx
 2cMWdGLqxoFbH65w4wilwHFMiA==
X-Google-Smtp-Source: ABdhPJyBC0S3XnXwXjcT4tArg9Gd7+7qrjU8hssfB6yXEiDOwsj6fLowerx5XryWN0wBXZKQ5a1jNQ==
X-Received: by 2002:a17:90a:1f08:: with SMTP id
 u8mr6302407pja.154.1594922230681; 
 Thu, 16 Jul 2020 10:57:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-148-13.tukw.qwest.net. [174.21.148.13])
 by smtp.gmail.com with ESMTPSA id y6sm669216pji.2.2020.07.16.10.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 10:57:09 -0700 (PDT)
Subject: Re: [RFC PATCH] tcg/cpu-exec: precise single-stepping after an
 exception
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
References: <20200716100445.3748740-1-luc.michel@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2117589b-5f08-f162-cace-f45e3cfd4f66@linaro.org>
Date: Thu, 16 Jul 2020 10:57:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716100445.3748740-1-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 3:04 AM, Luc Michel wrote:
> When single-stepping with a debugger attached to QEMU, and when an
> exception is raised, the debugger misses the first instruction after the
> exception:
> 
> $ qemu-system-aarch64 -M virt -display none -cpu cortex-a53 -s -S
> 
> $ aarch64-linux-gnu-gdb
> GNU gdb (GDB) 9.2
> [...]
> (gdb) tar rem :1234
> Remote debugging using :1234
> warning: No executable has been specified and target does not support
> determining executable automatically.  Try using the "file" command.
> 0x0000000000000000 in ?? ()
> (gdb) # writing nop insns to 0x200 and 0x204
> (gdb) set *0x200 = 0xd503201f
> (gdb) set *0x204 = 0xd503201f
> (gdb) # 0x0 address contains 0 which is an invalid opcode.
> (gdb) # The CPU should raise an exception and jump to 0x200
> (gdb) si
> 0x0000000000000204 in ?? ()
> 
> With this commit, the same run steps correctly on the first instruction
> of the exception vector:
> 
> (gdb) si
> 0x0000000000000200 in ?? ()
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
> 
> RFC because I'm really not sure this is the good place to do that since
> EXCP_DEBUG are usually raised in each target translate.c. It could also
> have implications with record/replay I'm not aware of.
> 
> ---
>  accel/tcg/cpu-exec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index d95c4848a4..e85fab5d40 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -502,10 +502,21 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>              CPUClass *cc = CPU_GET_CLASS(cpu);
>              qemu_mutex_lock_iothread();
>              cc->do_interrupt(cpu);
>              qemu_mutex_unlock_iothread();
>              cpu->exception_index = -1;
> +
> +            if (unlikely(cpu->singlestep_enabled)) {
> +                /*
> +                 * After processing the exception, ensure an EXCP_DEBUG is
> +                 * raised when single-stepping so that GDB doesn't miss the
> +                 * next instruction.
> +                 */
> +                cpu->exception_index = EXCP_DEBUG;
> +                return cpu_handle_exception(cpu, ret);

Plausible.  Although recursion on an inline function is going to defeat the
inline, in general.

We could expand the recursion by hand with

    if (unlikely(cpu->singlestep_enabled)) {
        *ret = EXCP_DEBUG;
        cpu_handle_debug_exception(cpu);
        return true;
    }

which might even be clearer.


r~

> +            }
> +
>          } else if (!replay_has_interrupt()) {
>              /* give a chance to iothread in replay mode */
>              *ret = EXCP_INTERRUPT;
>              return true;
>          }
> 


