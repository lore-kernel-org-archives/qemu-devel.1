Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BD8C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C816121E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PobXaYrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C816121E6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJUW-0002Vl-5Y
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47364)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvJTq-0001nJ-GJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvJTp-0007R2-16
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:47:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvJTo-0007PQ-Ox
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:47:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so65781956wrr.4
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=L03NxVLVs+G5CYj/vM9koLQLCiFl/EJHX5f5QfU0bGo=;
 b=PobXaYrx6ObuHIcBDtz4LX451wNnCO9ZMybaAClK0kJ0G4MwbQMqnVRoaI+XSORDH+
 DW1vz+LMp4Vh+heEGwkjoz7PaKeq1oTMyJle22OaQhAPeWu5rkyfz9ACDXnnFiJy/Dm5
 142duiZpeW/+Rtb/cdL7s1CFgGqNh3nH7G02R1Pv3zCbeaDwwoniVXXN7ICms6GEzICE
 OssypD39YXU51RyYWB+ORsxZ//xKtw+VA3fYcbrTHRUjj7gKmTCb3wXCkQDkds89m5i8
 ouHhIPxoohu4Yrx6y75AtCvjGPLYbBfiCuQtq2/YSvK/XSKpjgGXrCDWuhcEfbU7PSEC
 g1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=L03NxVLVs+G5CYj/vM9koLQLCiFl/EJHX5f5QfU0bGo=;
 b=OLahXVlzIBHMQM0CtVtWFit8WPwnoDN6ODsGZkdDFyLn3SrcC1humad9XUwbsBKHwI
 0jUzooecT5nrw3WecKKOD53u5QrzTHMoFT4UzXkzrhV5A3pDebsbwoFOAM8RSxNmdv+P
 CpvM1R2zM+unpy+uVQF2hbHHl+JNJYcbVtzYhvpe88I6NR/8r9KRIXmJXL9fo2aDtbL+
 24jXX0YyC6QEVYQHG3TsVYmcsP3GmBxZvjJCGFsTnu8ttYNsWpaskZ55aiZbb1s/SjHc
 N/DidYJ0TKLGTRM0GzN7rIx8bpxAITGI0ON0W0bNj1Vyd3yklGex51wgMm9m5CgpaUN2
 SOOw==
X-Gm-Message-State: APjAAAXQqSrR9LN3uq91/HbVy4r11wCVCgkbBKtdSl2e31l20GUzxMpC
 4EgGyTSo2cRNdxz6jk6GX6Nx5Q==
X-Google-Smtp-Source: APXvYqzoo2INUW9O9Y2txzVf7c+IcIJmnyv1eNvSubfV2EuW7cd3voCLbzeyEmJYP3M4lIFdV2BQWg==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr7113637wrn.230.1565174859070; 
 Wed, 07 Aug 2019 03:47:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k9sm3826233wrq.15.2019.08.07.03.47.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 03:47:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 07DB11FF87;
 Wed,  7 Aug 2019 11:47:38 +0100 (BST)
References: <20190805130952.4415-1-peter.maydell@linaro.org>
 <20190805130952.4415-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190805130952.4415-3-peter.maydell@linaro.org>
Date: Wed, 07 Aug 2019 11:47:37 +0100
Message-ID: <87sgqdi75i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] target/arm: Fix routing of
 singlestep exceptions
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> When generating an architectural single-step exception we were
> routing it to the "default exception level", which is to say
> the same exception level we execute at except that EL0 exceptions
> go to EL1. This is incorrect because the debug exception level
> can be configured by the guest for situations such as single
> stepping of EL0 and EL1 code by EL2.
>
> We have to track the target debug exception level in the TB
> flags, because it is dependent on CPU state like HCR_EL2.TGE
> and MDCR_EL2.TDE. (That we were previously calling the
> arm_debug_target_el() function to determine dc->ss_same_el
> is itself a bug, though one that would only have manifested
> as incorrect syndrome information.) Since we are out of TB
> flag bits unless we want to expand into the cs_base field,
> we share some bits with the M-profile only HANDLER and
> STACKCHECK bits, since only A-profile has this singlestep.
>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1838913
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> In theory it would be possible to use just a single TB flag
> bit, because other than the route_to_el2 bool, all the
> state arm_debug_target_el() checks is either constant or
> known from other TB flags. But I think trying to do this
> would be pretty hard to maintain and might well break
> anyway with future architectural changes.
>
> Slightly less painfully we could reclaim the existing
> TBFLAG_ANY_SS_ACTIVE, since the debug target EL can't
> be 0 and is irrelevant if SS is not active, so we
> could arrange for SS_ACTIVE to be DEBUG_TARGET_EL =3D=3D 0.
> But we're going to have to overspill into cs_base pretty
> soon anyway so I'm not too keen on being very stingy with
> the current flags word at the expense of maintainability.
> ---
>  target/arm/cpu.h           |  5 +++++
>  target/arm/translate.h     | 15 +++++++++++----
>  target/arm/helper.c        |  6 ++++++
>  target/arm/translate-a64.c |  2 +-
>  target/arm/translate.c     |  4 +++-
>  5 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 94c990cddbd..23ca6c79144 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3142,6 +3142,11 @@ FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
>  /* Target EL if we take a floating-point-disabled exception */
>  FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
>  FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
> +/*
> + * For A-profile only, target EL for debug exceptions.
> + * Note that this overlaps with the M-profile-only HANDLER and STACKCHEC=
K bits.
> + */
> +FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
>
>  /* Bit usage when in AArch32 state: */
>  FIELD(TBFLAG_A32, THUMB, 0, 1)
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index 45053190baa..b65954c669b 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -50,6 +50,8 @@ typedef struct DisasContext {
>      uint32_t svc_imm;
>      int aarch64;
>      int current_el;
> +    /* Debug target exception level for single-step exceptions */
> +    int debug_target_el;
>      GHashTable *cp_regs;
>      uint64_t features; /* CPU features bits */
>      /* Because unallocated encodings generate different exception syndro=
me
> @@ -70,8 +72,6 @@ typedef struct DisasContext {
>       * ie A64 LDX*, LDAX*, A32/T32 LDREX*, LDAEX*.
>       */
>      bool is_ldex;
> -    /* True if a single-step exception will be taken to the current EL */
> -    bool ss_same_el;
>      /* True if v8.3-PAuth is active.  */
>      bool pauth_active;
>      /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
> @@ -251,8 +251,15 @@ static inline void gen_exception(int excp, uint32_t =
syndrome,
>  /* Generate an architectural singlestep exception */
>  static inline void gen_swstep_exception(DisasContext *s, int isv, int ex)
>  {
> -    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, isv, ex),
> -                  default_exception_el(s));
> +    bool same_el =3D (s->debug_target_el =3D=3D s->current_el);
> +
> +    /*
> +     * If singlestep is targeting a lower EL than the current one,
> +     * then s->ss_active must be false and we can never get here.
> +     */
> +    assert(s->debug_target_el >=3D s->current_el);
> +
> +    gen_exception(EXCP_UDEF, syn_swstep(same_el, isv, ex), s->debug_targ=
et_el);
>  }
>
>  /*
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b74c23a9bc0..24806c16ca2 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11170,6 +11170,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>          }
>      }
>
> +    if (!arm_feature(env, ARM_FEATURE_M)) {
> +        int target_el =3D arm_debug_target_el(env);
> +
> +        flags =3D FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL, target_=
el);
> +    }
> +
>      *pflags =3D flags;
>      *cs_base =3D 0;
>  }
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index f6729b96fd0..90850eadc1b 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -14180,7 +14180,7 @@ static void aarch64_tr_init_disas_context(DisasCo=
ntextBase *dcbase,
>      dc->ss_active =3D FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
>      dc->pstate_ss =3D FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
>      dc->is_ldex =3D false;
> -    dc->ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
> +    dc->debug_target_el =3D FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_TARGE=
T_EL);
>
>      /* Bound the number of insns to execute to those left on the page.  =
*/
>      bound =3D -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 19b9d8f2725..b32508cd2f9 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11882,7 +11882,9 @@ static void arm_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      dc->ss_active =3D FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
>      dc->pstate_ss =3D FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
>      dc->is_ldex =3D false;
> -    dc->ss_same_el =3D false; /* Can't be true since EL_d must be AArch6=
4 */
> +    if (!arm_feature(env, ARM_FEATURE_M)) {
> +        dc->debug_target_el =3D FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_T=
ARGET_EL);
> +    }
>
>      dc->page_start =3D dc->base.pc_first & TARGET_PAGE_MASK;


--
Alex Benn=C3=A9e

