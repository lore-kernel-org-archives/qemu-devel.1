Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 08:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF192067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 08:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRCfI38w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF192067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIToP-00058I-GD
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 04:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iITmc-0004BY-Q2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 04:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iITma-0005D3-Rb
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 04:26:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iITma-0005Cj-JG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 04:26:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id m18so5757762wmc.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CwU+SuA5YqSNFXGDE2QHQibyHGzA0cVo+mlCA2lm+lI=;
 b=CRCfI38wAnXeElV/Ik4030+UUyacz2oPOpAXqS4qSev+0CGdyWCiym8tS449LmENrH
 cASU9PX2lcQtkcWpBcFSgl8amIA5xt6RHJVb9aAvAg6+sYGmn+toRGCSp8huJEQV4BUj
 UsUgkjzWD0+m32R6arbjy7HwWs7YoxHL3zBkiRVbOETGGf9oA2jSQDhap27UYFUh09/n
 6Jl9An2KHH2A2STYXCBZVUw6TcEpZGXXj3g326kzClDEj2nmLaGIyrhQfTLwGxLP4QG4
 HsDrBPxYqloIvMZk/KG5cIpWKEApuZfY4cEPtvMeUDurXORe/BTwP2mvTYudV/xLfN/X
 PW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CwU+SuA5YqSNFXGDE2QHQibyHGzA0cVo+mlCA2lm+lI=;
 b=Pwyt2YWW76J7HpE14PCMn2vkqUNGZOeczDUP49OQlusKLsUJ8vspnIYzTb8nST/Fgp
 qkVNi9Ok7IxyuRgw4G7/seaRkvjm+Iew85uEYEhTcBE9+5Y66iShD6lHbVcwe2aaRfYi
 4oilf7E+ItR/SlOE+q0c7Q3PsaGM8J8m6CdnDWFIDX634x5frLfOPtdNR9KmiS3R8QnC
 Y2gXhw3H3PLxQeIi2ykowHgYUuZuk987XlwACvtqOo0mWrIt7vUVCGL2kEhYKkeAEkJj
 k08PLqNpX2ik64NDJfQ9nHLjU8OzSRo7d3okUSViVrcLJKFzMDnIiCFTIi3XGJZSwjvN
 bmRg==
X-Gm-Message-State: APjAAAWdjCbnqp2AB4QioVB8/X2HmNJ7iuvuyyps2VZzuvTQTvRCnroy
 sDM7EXcxaTuzPt+x2/y+GTQ7Fw==
X-Google-Smtp-Source: APXvYqxAOttKBl5T/nw4Lgrv5QW2GIHqYGd6A7tlgCYrRaNzL+EMXxq2ZG2WVdzp5t53n3gMUK3q3A==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr6853109wml.43.1570696007274; 
 Thu, 10 Oct 2019 01:26:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o18sm11392441wrw.90.2019.10.10.01.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 01:26:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A55E81FF87;
 Thu, 10 Oct 2019 09:26:45 +0100 (BST)
References: <20191009110050.29271-1-david@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] s390x/tcg: MVCL: Exit to main loop if requested
In-reply-to: <20191009110050.29271-1-david@redhat.com>
Date: Thu, 10 Oct 2019 09:26:45 +0100
Message-ID: <874l0hm2ey.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> MVCL is interruptible and we should check for interrupts and process
> them after writing back the variables to the registers. Let's check
> for any exit requests and exit to the main loop. Introduce a new helper
> function for that: cpu_loop_exit_requested().
>
> When booting Fedora 30, I can see a handful of these exits and it seems
> to work reliable. Also, Richard explained why this works correctly even
> when MVCL is called via EXECUTE:
>
>     (1) TB with EXECUTE runs, at address Ae
>         - env->psw_addr stored with Ae.
>         - helper_ex() runs, memory address Am computed
>           from D2a(X2a,B2a) or from psw.addr+RI2.
>         - env->ex_value stored with memory value modified by R1a
>
>     (2) TB of executee runs,
>         - env->ex_value stored with 0.
>         - helper_mvcl() runs, using and updating R1b, R1b+1, R2b, R2b+1.
>
>     (3a) helper_mvcl() completes,
>          - TB of executee continues, psw.addr +=3D ilen.
>          - Next instruction is the one following EXECUTE.
>
>     (3b) helper_mvcl() exits to main loop,
>          - cpu_loop_exit_restore() unwinds psw.addr =3D Ae.
>          - Next instruction is the EXECUTE itself...
>          - goto 1.
>
> As the PoP mentiones that an interruptible instruction called via EXECUTE
> should avoid modifying storage/registers that are used by EXECUTE itself,
> it is fine to retrigger EXECUTE.
>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>
> v3 -> v4:
> - Switch to cpu_loop_exit_requested() and perform the actual exit in the
>   caller
>
> v2 -> v3:
> - Add TCG helper function
> - Add details about EXECUTE to description
> - Return to main loop only if there is work left to do
>
> v1 -> v2:
> - Check only if icount_decr.u32 < 0
> - Drop should_interrupt_instruction() and perform the check inline
> - Rephrase comment, subject, and description
>
> ---
>  include/exec/exec-all.h   | 17 +++++++++++++++++
>  target/s390x/mem_helper.c | 11 ++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 49db07ba0b..04795c49bf 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -72,6 +72,23 @@ void QEMU_NORETURN cpu_loop_exit(CPUState *cpu);
>  void QEMU_NORETURN cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
>  void QEMU_NORETURN cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
>
> +/**
> + * cpu_loop_exit_requested:
> + * @cpu: The CPU state to be tested
> + *
> + * Indicate if somebody asked for a return of the CPU to the main loop
> + * (e.g., via cpu_exit() or cpu_interrupt()).
> + *
> + * This is helpful for architectures that support interruptible
> + * instructions. After writing back all state to registers/memory, this
> + * call can be used to check if it makes sense to return to the main loop
> + * or to continue executing the interruptible instruction.
> + */
> +static inline bool cpu_loop_exit_requested(CPUState *cpu)
> +{
> +    return (int32_t)atomic_read(&cpu_neg(cpu)->icount_decr.u32) < 0;
> +}
> +
>  #if !defined(CONFIG_USER_ONLY)
>  void cpu_reloading_memory_map(void);
>  /**
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 44e535856d..740728368c 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1015,6 +1015,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t =
r1, uint32_t r2)
>      uint64_t srclen =3D env->regs[r2 + 1] & 0xffffff;
>      uint64_t src =3D get_address(env, r2);
>      uint8_t pad =3D env->regs[r2 + 1] >> 24;
> +    CPUState *cs =3D env_cpu(env);
>      S390Access srca, desta;
>      uint32_t cc, cur_len;
>
> @@ -1065,7 +1066,15 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t=
 r1, uint32_t r2)
>          env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destle=
n);
>          set_address_zero(env, r1, dest);
>
> -        /* TODO: Deliver interrupts. */
> +        /*
> +         * MVCL is interruptible. Return to the main loop if requested a=
fter
> +         * writing back all state to registers. If no interrupt will get
> +         * injected, we'll end up back in this handler and continue proc=
essing
> +         * the remaining parts.
> +         */
> +        if (destlen && unlikely(cpu_loop_exit_requested(cs))) {
> +            cpu_loop_exit_restore(cs, ra);
> +        }
>      }
>      return cc;
>  }


--
Alex Benn=C3=A9e

