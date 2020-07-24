Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C21206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAP1ccHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C21206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz21C-0000VC-TO
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz1zx-00082b-Tu
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:00:45 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz1zv-0006SG-Ug
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:00:45 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mn17so5717402pjb.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=NRotk3IxvscnFrJ6v2EwM4deffVDyHAQM/E/1IddJOw=;
 b=NAP1ccHOZC9gtILQeJMxisYE39dJhbWi+03n8Xs2kaHY0Vk0UNyrjethdRNRytzXZf
 ztAEe7+AQvCBtW1DKax42m3VYFBjiHXi9QDcB6NauMiySgzud3Hsg3LPScuXYjGJuyXE
 k+NqdK9nyHrV42JNFLK/GR0apFdDed8PLJp/Hked3DK5d4VxiAphDcvafdmleGbNbJAV
 ZRB80k29J3TEyAdO6Ip+BTgFZVljdugduP+yZkmYjEPKZh2puRGGHl2NSIEzcWohAivR
 UyDIvRNNlp66pIavhACfEg0KXhdyMZpQeOyr2uifGDqIOJz1OZGChligdRb9Se4CRUwf
 /3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NRotk3IxvscnFrJ6v2EwM4deffVDyHAQM/E/1IddJOw=;
 b=kgXLmjScmGjyNYm376yWXCe4jnNXKiSrTFVOof8QUichBPiHEzY01p1Nm6+YVTs0p2
 uHDMc/BmgAAg5vhniMLm2gr8pqnSAiZPak4SgrLqhvLl9MWVOG58jERiTFhhM+Z5nJ+n
 l11t84JRu2NPF94mNEty6OJJ2oWuwjzwwIKMxGGgV7ORL2IdHhXQU8dsb7/7cg/0Sc8B
 H0W3pUa/OG33IzJ0VNpyVHxHPjrVdDlnYqfEJGFn54OU1YaT9FB51Ma+A2oPrFcLOJCI
 zFRS0tENyQ56frELvty7y6DjWYbPf5kgL+2AHICAd9zpQavr4GOYEJf+PlctOPJJYEMX
 Cp0Q==
X-Gm-Message-State: AOAM532Qh7BhbN9sF2eue75iJRWf9swqPkHAMa07IQZjqUyEfTrDmw/a
 Re2rDg7dtm0MFDv5j8h+cDMt8A==
X-Google-Smtp-Source: ABdhPJyAEAXrKqdLQKrbS07DmNmyqj6ZUBrd+Cd9VXEBT+SDJ274aoithjP/ehj6oXJCkNXE+Clt6A==
X-Received: by 2002:a17:90b:3748:: with SMTP id
 ne8mr6056328pjb.7.1595613642147; 
 Fri, 24 Jul 2020 11:00:42 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 g5sm7151781pfh.168.2020.07.24.11.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 11:00:41 -0700 (PDT)
Subject: Re: [PATCH v5 6/6] target/ppc: add vmsumudm vmsumcud instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
References: <20200724045845.89976-1-ljp@linux.ibm.com>
 <20200724045845.89976-7-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca98ae77-d5db-7e22-5cfc-fb855d79fed5@linaro.org>
Date: Fri, 24 Jul 2020 11:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724045845.89976-7-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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

On 7/23/20 9:58 PM, Lijun Pan wrote:
> vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned Doubleword Modulo
> VA-form.
> vmsumcud (Power ISA 3.1) - Vector Multiply-Sum & write Carry-out Unsigned
> Doubleword VA-form.
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v5: update instruction flag for vmsumcud.
>     integrate into this isa3.1 patch series
> v3: implement vmsumudm/vmsumcud through int128 functions,
>     suggested by Richard Henderson.
> 
>  disas/ppc.c                         |  2 ++
>  target/ppc/helper.h                 |  4 ++-
>  target/ppc/int_helper.c             | 49 ++++++++++++++++++++++++++++-
>  target/ppc/translate.c              |  1 -
>  target/ppc/translate/vmx-impl.inc.c | 39 ++++++++++++-----------
>  target/ppc/translate/vmx-ops.inc.c  |  2 ++
>  6 files changed, 76 insertions(+), 21 deletions(-)
> 
> diff --git a/disas/ppc.c b/disas/ppc.c
> index 63e97cfe1d..bd76fae4c4 100644
> --- a/disas/ppc.c
> +++ b/disas/ppc.c
> @@ -2261,7 +2261,9 @@ const struct powerpc_opcode powerpc_opcodes[] = {
>  { "vmsumshs",  VXA(4,  41), VXA_MASK,	PPCVEC,		{ VD, VA, VB, VC } },
>  { "vmsumubm",  VXA(4,  36), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
>  { "vmsumuhm",  VXA(4,  38), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
> +{ "vmsumudm",  VXA(4,  35), VXA_MASK,   PPCVEC,         { VD, VA, VB, VC } },
>  { "vmsumuhs",  VXA(4,  39), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
> +{ "vmsumcud",  VXA(4,  23), VXA_MASK,   PPCVEC,         { VD, VA, VB, VC } },
>  { "vmulesb",   VX(4,  776), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
>  { "vmulesh",   VX(4,  840), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
>  { "vmuleub",   VX(4,  520), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 70a14029ca..00a31d64bc 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -274,10 +274,12 @@ DEF_HELPER_3(vpkpx, void, avr, avr, avr)
>  DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)
> +DEF_HELPER_5(vmsumudm, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
> -DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
> +DEF_HELPER_5(vmsumcud, void, env, avr, avr, avr, avr)
> +DEF_HELPER_5(vmladduhm, void, env, avr, avr, avr, avr)
>  DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
>  DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
>  DEF_HELPER_3(lvebx, void, env, avr, tl)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 62b93b4568..2e919a7b8e 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -913,7 +913,8 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
>      }
>  }
>  
> -void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
> +void helper_vmladduhm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
> +                      ppc_avr_t *b, ppc_avr_t *c)

Why?

> +void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r,
> +                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
> +{

...

> +void helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r,
> +                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)

You don't actually use env in either helper, so you shouldn't pass it in.


r~

