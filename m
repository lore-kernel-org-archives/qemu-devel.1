Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55731C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB60206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJUv67jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB60206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihNky-0005pX-9f
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 20:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihNkL-0005Ik-Hk
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihNkI-000050-9g
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:03:24 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihNkI-0008Ux-25
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:03:22 -0500
Received: by mail-pj1-x1044.google.com with SMTP id ep17so58477pjb.4
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 17:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qDktnqJFILHEe9UmAzxJWXQjAQ6RxhjYlF1ehUzBsNk=;
 b=lJUv67jzPq4LKQonclJjvnnyhUhhAIy9tGQrdLTOsjQxF7iZbkt84zeRZhP3d1tBcv
 k85ICsohSFopESlOZuQjOItYNN1d94TIG/yKM6l2mIwGYpuSfB2Z6cQOxcBEIZtACicG
 12Ilzr6J7TVL8yLGG29S2Q9Ynpk6q8u/BO2UB6s+k1duiyuZ+4gP4TBOx+tZXL2SOqw8
 ZzksMZvD7bPG4LvzW069p/Ls1+f/6Oo3POaJnVyLU3Pz/nXgAUUJf+yenw5RB+l0JWc7
 eMXC8Jn26fDDq7uqzvXsLQ6IiFuQWdRubbUAMI+FF9vDj8TA+zkDnYn4u7ln9WHeV5d/
 ozwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qDktnqJFILHEe9UmAzxJWXQjAQ6RxhjYlF1ehUzBsNk=;
 b=iJJmvFzAi32k4kdlfcW04XoX+oJk1MfUIfhxq+2Kp1dmLmnz6r6FzzZigYjj1Wb926
 v/FqEdJp379va5fzELV5cF9+pLlRdiiB/hAxCUL9A5jPrcsMh7IK32GlkUcaLaeol4WD
 MQKq+R2otACOr7dbv02/d6H6znMORPe9az+9WmewH84E7X9ZoMnkOB38LZDYoeb9387F
 GebNaXUr1HODe5EtAAhFRkY76h2J//raNnbBP7rLFMFLtEi3E+P08ohTFAQSfaQtSboO
 rquIvVKYr6vfaMqVJhG/2LM09uz+DUWlM67q9K0MWlopFBffRrQfZ3V/k9sdijiDsO7D
 8skg==
X-Gm-Message-State: APjAAAXynr91RRIXNVrQTmX1zfpwyc3Cs6qC6Cubfv2hzqI28AvRU8BR
 AM0d1cpBIQvsql2SuAdmCX7Zug==
X-Google-Smtp-Source: APXvYqxnZmkqQRgcxw31QdkFyaBeasPChr58EeAao/NwDX9By51ZylYy6wOPucD7LXGKKnGCIl/GTg==
X-Received: by 2002:a17:90a:26ec:: with SMTP id
 m99mr279651pje.130.1576631000487; 
 Tue, 17 Dec 2019 17:03:20 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id o8sm177926pjo.7.2019.12.17.17.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 17:03:19 -0800 (PST)
Subject: Re: [PATCH] target/arm: fix IL bit for data abort exceptions
To: Jeff Kubascik <jeff.kubascik@dornerworks.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191217210230.99559-1-jeff.kubascik@dornerworks.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a274247-e593-5828-73f8-2042971e8633@linaro.org>
Date: Tue, 17 Dec 2019 15:03:16 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217210230.99559-1-jeff.kubascik@dornerworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 11:02 AM, Jeff Kubascik wrote:
> diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
> index 5feb312941..e63f8bda29 100644
> --- a/target/arm/tlb_helper.c
> +++ b/target/arm/tlb_helper.c
> @@ -44,7 +44,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
>          syn = syn_data_abort_with_iss(same_el,
>                                        0, 0, 0, 0, 0,
>                                        ea, 0, s1ptw, is_write, fsc,
> -                                      false);
> +                                      true);
>          /* Merge the runtime syndrome with the template syndrome.  */
>          syn |= template_syn;

This doesn't look correct.  Surely the IL bit should come from template_syn?

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index d4bebbe629..a3c618fdd9 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -14045,6 +14045,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
>      s->pc_curr = s->base.pc_next;
>      insn = arm_ldl_code(env, s->base.pc_next, s->sctlr_b);
>      s->insn = insn;
> +    s->is_16bit = false;
>      s->base.pc_next += 4;

Should not be necessary, as the field is not read along any a64 path.  (Also,
while it's not yet in master, there's a patch on list that zero initializes the
entire structure.)

> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 2b6c1f91bf..300480f1b7 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8555,7 +8555,7 @@ static ISSInfo make_issinfo(DisasContext *s, int rd, bool p, bool w)
>  
>      /* ISS not valid if writeback */
>      if (p && !w) {
> -        ret = rd;
> +        ret = rd | (s->is_16bit ? ISSIs16Bit : 0);
>      } else {
>          ret = ISSInvalid;
>      }
> @@ -11057,6 +11057,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>      dc->pc_curr = dc->base.pc_next;
>      insn = arm_ldl_code(env, dc->base.pc_next, dc->sctlr_b);
>      dc->insn = insn;
> +    dc->is_16bit = false;
>      dc->base.pc_next += 4;
>      disas_arm_insn(dc, insn);
>  
> @@ -11126,6 +11127,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>      dc->pc_curr = dc->base.pc_next;
>      insn = arm_lduw_code(env, dc->base.pc_next, dc->sctlr_b);
>      is_16bit = thumb_insn_is_16bit(dc, dc->base.pc_next, insn);
> +    dc->is_16bit = is_16bit;
>      dc->base.pc_next += 2;
>      if (!is_16bit) {
>          uint32_t insn2 = arm_lduw_code(env, dc->base.pc_next, dc->sctlr_b);
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index b837b7fcbf..c16f434477 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -14,6 +14,8 @@ typedef struct DisasContext {
>      target_ulong pc_curr;
>      target_ulong page_start;
>      uint32_t insn;
> +    /* 16-bit instruction flag */
> +    bool is_16bit;
>      /* Nonzero if this instruction has been conditionally skipped.  */
>      int condjmp;
>      /* The label that will be jumped to when the instruction is skipped.  */

The rest of this looks both correct and necessary.


r~

