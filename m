Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3247AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF154206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzsj35yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF154206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFgs-0000fa-Ik
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idErz-0007tT-2d
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idErx-0002Yv-Bp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:46:10 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idErx-0002XO-4U
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:46:09 -0500
Received: by mail-oi1-x244.google.com with SMTP id c16so6378174oic.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uhSPlg+i9CiAubF7ClC0ww2vNy2qAmWgFnaNVgQgOxE=;
 b=zzsj35yd960LbiaSBcl/usD7GRpWOsvW98l1RP+jhOWQfLebIUn2wV2+T9mfupbxch
 e93nHD4TZJlfhk5O0kSjTqVQ9kAmqFigsdzw6vbxNcKNbYHGBBJR4WtLJnOtCYmfeiWN
 Oc+Mal+rpJUHvmiVerGR7FkUHafsoCh0ZCI/9hWqOsB9KukvjFnW74gfHF3KczHaYLWp
 90mLdshDyOYx7g1tE/o7HSHRWfK5XlNlhEZz7D2BrQGNv608xXmdvKJr0jGdZnhSOT91
 Ecuk55bLRIX9g6M3EnNxsdA5sxTN0qkNTXzWj7muhFqvRD2MpCWlWU466cSZdN2ZMZ9+
 5LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uhSPlg+i9CiAubF7ClC0ww2vNy2qAmWgFnaNVgQgOxE=;
 b=pD+49TxdV3h0pGA4m0BIjQ8lnVoAs3S5N2Rs75BYIt7oYNjdDy+LCx0NnPFzSM3IfA
 bfQuz0RT1D1pDfdzTA6T/IgcRCWBgmzNwb22mitHmfnwySl6HcdjN5aDobBun9RUBkzG
 e1EECUxtJR7Xgj07ba/9O/4kyWoiA6LkHxSVfCvFmhIedatUu94UJIBfxEXvha4K19cY
 O//V3fwDkW4/7mgrJLvXKvrXimaeTzHMZJX23RUhRt+/htwAhHn4jrhuUoHvb3+Eya0q
 2uj9RYIeyHfpyVZQP2Nx2dorjuP6MBP0GijoO57UqxhSIE8l+nUSZhVUeRad85dYWV7H
 yXgg==
X-Gm-Message-State: APjAAAXzR/fVNT09vOkrMIfwZkD9FNe+Nb49e00rHn580fM6yaPJwil8
 opGPLcAd3UJsX5GPIrhG19UmtoX3Itvc0Pf64w7gnvfl
X-Google-Smtp-Source: APXvYqw2gpZf9eGRHwCYCA4+iyO+tNdoHE1d4WU9umvAw5Ya5N+sNHgm4KB59ivtXp+w1i5oD9gVxA0jXOWo5q4I3vU=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr12121697oih.98.1575632772773; 
 Fri, 06 Dec 2019 03:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-22-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 11:46:02 +0000
Message-ID: <CAFEAcA8aJZRMFEpKaUN_W4U5LXoWvvzYUe0FQYwTd=RiFHeFEQ@mail.gmail.com>
Subject: Re: [PATCH v5 21/22] target/arm: Add mmu indexes for tag memory
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The process by which one goes from an address space plus physical
> address to a host pointer is complex.  It is easiest to reuse the
> mechanism already present within cputlb, and letting that cache
> the results.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-param.h |  2 +-
>  target/arm/cpu.h       | 12 +++++++++---
>  target/arm/internals.h |  2 ++
>  target/arm/helper.c    | 25 +++++++++++++++++++++++--
>  4 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index 6e6948e960..18ac562346 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -29,6 +29,6 @@
>  # define TARGET_PAGE_BITS_MIN  10
>  #endif
>
> -#define NB_MMU_MODES 8
> +#define NB_MMU_MODES 9
>
>  #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index faca43ea78..c3609ef9d5 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2854,8 +2854,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>  #define ARM_MMU_IDX_M_NEGPRI 0x2
>  #define ARM_MMU_IDX_M_S 0x4
>
> -#define ARM_MMU_IDX_TYPE_MASK (~0x7)
> -#define ARM_MMU_IDX_COREIDX_MASK 0x7
> +#define ARM_MMU_IDX_TYPE_MASK (~0xf)
> +#define ARM_MMU_IDX_COREIDX_MASK 0xf
>
>  typedef enum ARMMMUIdx {
>      ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
> @@ -2865,6 +2865,9 @@ typedef enum ARMMMUIdx {
>      ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_TagNS = 7 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_TagS = 8 | ARM_MMU_IDX_A,
> +
>      ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
>      ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
>      ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
> @@ -2891,6 +2894,8 @@ typedef enum ARMMMUIdxBit {
>      ARMMMUIdxBit_S1SE0 = 1 << 4,
>      ARMMMUIdxBit_S1SE1 = 1 << 5,
>      ARMMMUIdxBit_S2NS = 1 << 6,
> +    ARMMMUIdxBit_TagNS = 1 << 7,
> +    ARMMMUIdxBit_TagS = 1 << 8,
>      ARMMMUIdxBit_MUser = 1 << 0,
>      ARMMMUIdxBit_MPriv = 1 << 1,
>      ARMMMUIdxBit_MUserNegPri = 1 << 2,
> @@ -3254,7 +3259,8 @@ enum {
>  /* Return the address space index to use for a memory access */
>  static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
>  {
> -    return attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
> +    return ((attrs.target_tlb_bit2 ? ARMASIdx_TagNS : ARMASIdx_NS)
> +            + attrs.secure);

If you want to do the "just add attrs.secure" can we have
a build-time assert that ARMASIdx_S is ARMASIdx_NS + 1, and
ditto for TagNS/TagS, please? It seems like the kind of thing
that will catch us out later on.

>  }

>      if (env->cp15.hcr_el2 & HCR_TGE) {
> @@ -10662,7 +10671,9 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
>                     target_ulong *page_size,
>                     ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
>  {
> -    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_S12NSE0:
> +    case ARMMMUIdx_S12NSE1:
>          /* Call ourselves recursively to do the stage 1 and then stage 2
>           * translations.
>           */
> @@ -10713,6 +10724,16 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
>               */
>              mmu_idx = stage_1_mmu_idx(mmu_idx);
>          }
> +        break;
> +
> +    case ARMMMUIdx_TagS:
> +    case ARMMMUIdx_TagNS:
> +        /* Indicate tag memory to arm_asidx_from_attrs.  */
> +        attrs->target_tlb_bit2 = true;
> +        break;

So here we fall through to the "handle a stage 1 lookup" code, which:
 * sets attrs->secure
 * sets attrs->user (always false, so we could have left it alone)
 * skips the FCSE handling (as we're v8)
 * skips the PMSA handling
 * hits the regime_translation_disabled() check, which fills in
   *phys_ptr, *prot and *page_size and returns

Maybe it would be clearer if this case here just did all of that:

    case ARMMMUIdx_TagS:
        attrs->secure = true;
        /* fall through */
    case ARMMMUIdx_TagNS:
        /* Indicate tag memory to arm_asidx_from_attrs.  */
        attrs->target_tlb_bit2 = true;
        *phys_ptr = address;
        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
        *page_size = TARGET_PAGE_SIZE;
        return 0;

Did I miss anything out?
Or are we going to want more things which are common between
the stage 1 codepath and the "just a tag ram access" case
in future?

thanks
-- PMM

