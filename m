Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40823C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6EB2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWPdnY3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6EB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvDu-0003j5-72
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49149)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcuLb-0002mp-6R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcuLZ-0002wM-B3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:19:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcuLX-0002uS-95
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:19:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id k11so10662700wrl.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ED/pJk9ZrzdGSHDp/fUhxmm/2qaScIkmgxBfKJAxdWc=;
 b=uWPdnY3fVBW5++NdDf0Rx1wi5A+bKUeCGPHN0Old81hUKU3/Ycbia7R2g2VxmnzxjR
 KdOAsFaGhwMlu0a9yIHmGXAlOsUYBdHjzwXhA1bF78YTCcE38CweM5wlDHwaYrlmxvaN
 hOY5uR45JZYkzgd/TE4Da8Q0lopPKNG2kOkf8nG55+9mYApP76j081iGd0B1zpTvKaW8
 feaMDHDQlxSEyJg4aJk02v7ypjDuEA+Edja0JaSoSanjrwjq6iB2qSGb4BQ/7zkc5X0G
 4NeWd7eRtgNZYNOmrSlFqJ6BwKpoE+ACRu135hXQrTfYZxkjWhbJ2B9Aazv6IgUY1uX4
 tjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ED/pJk9ZrzdGSHDp/fUhxmm/2qaScIkmgxBfKJAxdWc=;
 b=qV2VoHDtSrSMfw4M3EBYdFXg/vUoLvtuFc2awKWuzBCkW4h37UY/Y79HIjYjblAZOm
 JpxYqYRJSCWztNYEJsrbOUXtOvK0EZyM9CvM3etcGaVODg6MiojcpIZetxr+zTcPtvOB
 ABQ2h8HLo59t+HiUAB7ZTLp90qV3V7KX06bnuMnW1RBNZgsUi4y+YDqs/8/yiF5K4zio
 eDgUGQj5zWnJQXEyiC0dDJn03/keohUWkDs4RD9QATXlc19gl5fIoguCm8+UCLgPplHb
 PnbuaQ3NllhL0AfLmEnpkYcJDeIhj1AyVQQSZm7e3AbHPjY4UqMiE7p0XkZ/Fi5Se2ln
 gXIA==
X-Gm-Message-State: APjAAAWhLcWAod9FCw6IZcs5CDnsmM+PH/fUgAxLJIfidj+G9KnepzlI
 ycX4xwC5AZfLqjBt6/locCwuug==
X-Google-Smtp-Source: APXvYqwy0zJx9cWUEPTkZ+O/fIYZBgyzxhApBuas4O9olj2OxD9Lq5jE9rsSOkBBo4ARCc08j/3iyg==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr16870592wrw.254.1560788340844; 
 Mon, 17 Jun 2019 09:19:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x8sm9004104wre.73.2019.06.17.09.19.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 09:19:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D060F1FF87;
 Mon, 17 Jun 2019 17:18:59 +0100 (BST)
References: <20190616210546.17221-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <20190616210546.17221-1-richard.henderson@linaro.org>
Date: Mon, 17 Jun 2019 17:18:59 +0100
Message-ID: <875zp49ocs.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix mmap lock assert on translation
 failure
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
Cc: christophe.lyon@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Check page flags before letting an invalid pc cause a SIGSEGV.
>
> Prepare for eventially validating PROT_EXEC.  The current wrinkle being
> that we have a problem with our implementation of signals.  We should
> be using a vdso like the kernel, but we instead put the trampoline on
> the stack.  In the meantime, let PROT_READ match PROT_EXEC.

We can come up with a test case for this right? Would it be triggered by
having:

__attribute__((aligned(PAGE_SIZE)))
void some_func(void) {
     /* does something */
}

__attribute__((aligned(PAGE_SIZE)))
... rest of code ...

main () {
     mmap(&some_func, PAGE_SIZE, PROT_READ, MAP_ANONYMOUS, 0, 0);
     some_func()
     /* causes SEGV */
     mmap(&some_func, PAGE_SIZE, PROT_READ|PROT_EXEC, MAP_ANONYMOUS, 0, 0);
     some_func()
     /* works */
}

Or is it trickier to mess with your own mapped memory?

>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1832353
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h                    |  1 +
>  include/exec/cpu_ldst_useronly_template.h |  8 +++++--
>  accel/tcg/translate-all.c                 | 29 +++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 536ea58f81..58b8915617 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -259,6 +259,7 @@ int walk_memory_regions(void *, walk_memory_regions_f=
n);
>  int page_get_flags(target_ulong address);
>  void page_set_flags(target_ulong start, target_ulong end, int flags);
>  int page_check_range(target_ulong start, target_ulong len, int flags);
> +void validate_exec_access(CPUArchState *env, target_ulong s, target_ulon=
g l);
>  #endif
>
>  CPUArchState *cpu_copy(CPUArchState *env);
> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
> index bc45e2b8d4..f095415149 100644
> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ b/include/exec/cpu_ldst_useronly_template.h
> @@ -64,7 +64,9 @@
>  static inline RES_TYPE
>  glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  {
> -#if !defined(CODE_ACCESS)
> +#ifdef CODE_ACCESS
> +    validate_exec_access(env, ptr, DATA_SIZE);
> +#else
>      trace_guest_mem_before_exec(
>          env_cpu(env), ptr,
>          trace_mem_build_info(SHIFT, false, MO_TE, false));
> @@ -88,7 +90,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUAr=
chState *env,
>  static inline int
>  glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  {
> -#if !defined(CODE_ACCESS)
> +#ifdef CODE_ACCESS
> +    validate_exec_access(env, ptr, DATA_SIZE);
> +#else
>      trace_guest_mem_before_exec(
>          env_cpu(env), ptr,
>          trace_mem_build_info(SHIFT, true, MO_TE, false));
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5d1e08b169..1d4a8a260f 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2600,10 +2600,39 @@ int page_check_range(target_ulong start, target_u=
long len, int flags)
>                  }
>              }
>          }
> +        /*
> +         * FIXME: We place the signal trampoline on the stack,
> +         * even when the guest expects that to be in the vdso.
> +         * Until we fix that, allow execute on any readable page.
> +         */
> +        if ((flags & PAGE_EXEC) && !(p->flags & (PAGE_EXEC | PAGE_READ))=
) {
> +            return -1;
> +        }
>      }
>      return 0;
>  }
>
> +/*
> + * Called for each code read, longjmp out to issue SIGSEGV if the page(s)
> + * do not have execute access.
> + */
> +void validate_exec_access(CPUArchState *env,
> +                          target_ulong ptr, target_ulong len)
> +{
> +    if (page_check_range(ptr, len, PAGE_EXEC) < 0) {
> +        CPUState *cs =3D env_cpu(env);
> +        CPUClass *cc =3D CPU_GET_CLASS(cs);
> +
> +        /* Like tb_gen_code, release the memory lock before cpu_loop_exi=
t.  */
> +        assert_memory_lock();
> +        mmap_unlock();
> +
> +        /* This is user-only.  The target must raise an exception.  */
> +        cc->tlb_fill(cs, ptr, 0, MMU_INST_FETCH, MMU_USER_IDX, false, 0);
> +        g_assert_not_reached();
> +    }
> +}
> +
>  /* called from signal handler: invalidate the code and unprotect the
>   * page. Return 0 if the fault was not handled, 1 if it was handled,
>   * and 2 if it was handled but the caller must cause the TB to be


--
Alex Benn=C3=A9e

