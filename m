Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5315C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9466620658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xA8PiyGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9466620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaCA-0004ap-Mj
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyaBT-000460-0B
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyaBQ-0002ah-Hk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:46:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyaBP-0002ZR-3L
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:46:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id m10so14131695wmc.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NgtKPEP8ZdRA53CRUqcLQzq0EY5wXSOQj/FEO/MsvOs=;
 b=xA8PiyGcm97KBMPBTdFaCQjZtbp7NmVKA78vPokiUlYidc+Y8lMDtt5MiBo69HGhl4
 QdRG8B4gU5Z10nfhJ5tpXY8kfSNEtz4V+7AVxFAfYr71aUQO6hESY/tn/yL7wATArG7k
 EGOcUJIQ+mQl/b2DIvl4/z/VJoyvTBLQwK1tLuRhna0QYYSJWEvgdisOiy6D9jjCRTZd
 gEFWjcPptzhpjdFMmFRT+Tmge/vZ8SS5o4h/Yw1PCbzOYbd+dJ2igNtt3AJkN0nY7SZd
 gx7HfquN9JJF+1wFfEKAnZ29eWRI+Dv/f1ozJTtvj41Aw5oRi7b7HipIJzqHQPAkXNyw
 9vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NgtKPEP8ZdRA53CRUqcLQzq0EY5wXSOQj/FEO/MsvOs=;
 b=ET+YGndxBQLUGwKV3HvUNgkZtWWWyRh0ZnLF+GwhjrEiDQODgrg5YjeRoxnMVnMRef
 gtlOgDCnzc3EcoYHLMBaPaFrnW9kZBwRAjMLvfk2JreEutriQBvhxvMFp+epCFp5DGrH
 mIPO9iLPc6r4KwoM60hxSWnaFOkIprhPU+iqUW9Gt0VALEYiWD2IqCPMFPHn6LW3nCYr
 c0ejEMDubSQhBFzIn0XKnRSJvpTgaqxykj4oqeAHV5CRhkcHpoNx6Zn3vZ00yUw+ViZq
 sqJUxrCdKCnKH6OefAXWDLGCZ+j5XU1/dkKaJztvW9tP1LM0DXD/YAszN3yaYq6/zi28
 bC8A==
X-Gm-Message-State: APjAAAUFddn3i5AZQtCrFqxctDFBkbN3FY/Vw2CyMD1GM87uoNRYAZsp
 0/DWd786i8bYT/D4A2DaCkodEjukK4U=
X-Google-Smtp-Source: APXvYqy8FuDMAV5KNu4W2BPOvVptCJycnoKqznBVOeDP9ww3P5tNCIHnYm7Qwb5N6cCBwPyApRDcNQ==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr30034276wmi.17.1580730385606; 
 Mon, 03 Feb 2020 03:46:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l15sm24615246wrv.39.2020.02.03.03.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:46:24 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 939FD1FF87;
 Mon,  3 Feb 2020 11:46:23 +0000 (GMT)
References: <20200202010439.6410-1-richard.henderson@linaro.org>
 <20200202010439.6410-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 01/14] target/arm: Add arm_mmu_idx_is_stage1_of_2
In-reply-to: <20200202010439.6410-2-richard.henderson@linaro.org>
Date: Mon, 03 Feb 2020 11:46:23 +0000
Message-ID: <87v9onao6o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org,
 Philippe =?utf-8?Q?Ma?= =?utf-8?Q?thieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Use a common predicate for querying stage1-ness.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Rename from arm_mmu_idx_is_stage1 to arm_mmu_idx_is_stage1_of_2
> ---
>  target/arm/internals.h | 18 ++++++++++++++++++
>  target/arm/helper.c    |  8 +++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 6d4a942bde..1f8ee5f573 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1034,6 +1034,24 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMS=
tate *env)
>  ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
>  #endif
>=20=20
> +/**
> + * arm_mmu_idx_is_stage1_of_2:
> + * @mmu_idx: The ARMMMUIdx to test
> + *
> + * Return true if @mmu_idx is a NOTLB mmu_idx that is the
> + * first stage of a two stage regime.
> + */
> +static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_Stage1_E0:
> +    case ARMMMUIdx_Stage1_E1:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>  /*
>   * Parameters of a given virtual address, as extracted from the
>   * translation control register (TCR) for a given regime.
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 70b10428c5..852fd71dcc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3261,8 +3261,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint=
64_t value,
>          bool take_exc =3D false;
>=20=20
>          if (fi.s1ptw && current_el =3D=3D 1 && !arm_is_secure(env)
> -            && (mmu_idx =3D=3D ARMMMUIdx_Stage1_E1 ||
> -                mmu_idx =3D=3D ARMMMUIdx_Stage1_E0)) {
> +            && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
>              /*
>               * Synchronous stage 2 fault on an access made as part of the
>               * translation table walk for AT S1E0* or AT S1E1* insn
> @@ -9294,8 +9293,7 @@ static inline bool regime_translation_disabled(CPUA=
RMState *env,
>          }
>      }
>=20=20
> -    if ((env->cp15.hcr_el2 & HCR_DC) &&
> -        (mmu_idx =3D=3D ARMMMUIdx_Stage1_E0 || mmu_idx =3D=3D ARMMMUIdx_=
Stage1_E1)) {
> +    if ((env->cp15.hcr_el2 & HCR_DC) && arm_mmu_idx_is_stage1_of_2(mmu_i=
dx)) {
>          /* HCR.DC means SCTLR_EL1.M behaves as 0 */
>          return true;
>      }
> @@ -9604,7 +9602,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, AR=
MMMUIdx mmu_idx,
>                                 hwaddr addr, MemTxAttrs txattrs,
>                                 ARMMMUFaultInfo *fi)
>  {
> -    if ((mmu_idx =3D=3D ARMMMUIdx_Stage1_E0 || mmu_idx =3D=3D ARMMMUIdx_=
Stage1_E1) &&
> +    if (arm_mmu_idx_is_stage1_of_2(mmu_idx) &&
>          !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
>          target_ulong s2size;
>          hwaddr s2pa;


--=20
Alex Benn=C3=A9e

