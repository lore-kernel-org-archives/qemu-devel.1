Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D38C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFA3217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfFWKftN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFA3217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1kQ-0004XA-Fk
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK1jU-0003uT-2S
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK1jS-0007cr-Sp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:53:59 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK1jR-0007bU-NI
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:53:57 -0400
Received: by mail-pl1-x641.google.com with SMTP id f21so8121178plj.10
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7QWa8eTt2nOQ5Ctuydo2O0u/QXfT+K+hg58e0blcwSE=;
 b=DfFWKftNolQmLZrtxRDjMI6puNCNTr0a8cTS28L9v4/h53iaLWFYmvIA+5o9Oc36to
 O4wzR4zkKZ7ohLwAULSgj2mLvo8pfeC/SMi0Drru/khtQtgum3nhff2pHN1vSf0nqGd3
 lCFNWUG9NrI74w45IsTUMh3goa2RL0yr3V7E5vkc7SaSthU8ywXVNNuEqHz704gqzMFu
 GUFziPowHzM6Q3iojx3bGimCp7vIYky8WWX0xpY4clvCEKbNt3shY5+whYvK7o82nMfP
 K0xd+M7Xu0DqJfkoYA8xrUH+sUJR+OKNZsWohA3bMul00Giv1BMAQV+YpjQ4bNNOnYp0
 bRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7QWa8eTt2nOQ5Ctuydo2O0u/QXfT+K+hg58e0blcwSE=;
 b=eFp369pirGeWKMe6O5xBAHwcA2Y7UBIXfTNsXvErpthZN2hMAkH7RaIYVunKheyEOZ
 FqrHzdAU/P8uqvxTvpzzwR2ylVL6a2CPP8t6BYIe0cCRSUESSgyjKl0VDptVs1l/jM3P
 DUPMaqiD40yJoSfmpBaDvEku3yIsFVDZdX/7V/teNlA0WzgK22KfK3GcyBxVX+yKxtS1
 ORaLDFwr2teNQ8vZUYu24sifU7pjwPVFbo8pCS4QXkFda0OeA89xh0nneeHeSFjxcyKl
 FGlN/GKHx74SPl1NHmInF2eRPo2CuPbK35MkEIb8CpZzfRfg+CVc/D4rA3LJlvic8Ktl
 63kw==
X-Gm-Message-State: APjAAAU6Y8HYCH9/7+nDTvin0eB1G2YnFOsj70FeLUpP40EVcIjRBhma
 htSjhKYljUPGLdgKNMS1gI1eUA==
X-Google-Smtp-Source: APXvYqwhUO7kbtYdTGhrtJ5LTacwL0aeiVpgw35uAJ5Zgr/iBy4uQFvBOn09T1eZSoJsq2zPM4yKVg==
X-Received: by 2002:a17:902:d685:: with SMTP id
 v5mr29617771ply.95.1571064835479; 
 Mon, 14 Oct 2019 07:53:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i6sm21884229pfq.20.2019.10.14.07.53.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 07:53:54 -0700 (PDT)
Subject: Re: [PATCH v5 02/55] trace: add mmu_index to mem_info
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <32a1628d-55a1-fd1a-31c2-56bef720855f@linaro.org>
Date: Mon, 14 Oct 2019 07:53:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: robert.foley@futurewei.com, Riku Voipio <riku.voipio@iki.fi>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:48 AM, Alex Bennée wrote:
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index defc8d5929..1210d8f243 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1811,6 +1811,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
>  #define ATOMIC_MMU_DECLS
>  #define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr)
>  #define ATOMIC_MMU_CLEANUP
> +#define ATOMIC_MMU_IDX oi

That is not the mmu_idx.  That's the whole mmu_idx + MemOp combo.
Use get_mmuidx(oi).

> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -751,6 +751,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
>  #define ATOMIC_MMU_DECLS do {} while (0)
>  #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
>  #define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
> +#define ATOMIC_MMU_IDX 0

MMU_USER_IDX.  Best to be consistent, even if this is user-only and it isn't
really used.

> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ b/include/exec/cpu_ldst_useronly_template.h
> @@ -73,7 +73,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  #else
>      trace_guest_mem_before_exec(
>          env_cpu(env), ptr,
> -        trace_mem_build_info(SHIFT, false, MO_TE, false));
> +        trace_mem_build_info(SHIFT, false, MO_TE, false, 0));

Likewise for the other uses in this file.


r~

