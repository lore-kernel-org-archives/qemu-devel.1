Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59A4ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B3820873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yicwb6J7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B3820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2gF-0005GE-Kn
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK2fQ-0004QK-Fw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK2fP-0003uY-6k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:53:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK2fO-0003t1-Vw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:53:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id y21so17275046wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RhUZn+IBGVca8nwr1WO4zWXivDlJk8sWGgmEvbv5Jqg=;
 b=Yicwb6J7DjiCyCgZ6Ah52BDr17Nn3zX90aRzppSGDog6FOrRztRRpT5WXtSzLtQMf4
 ikaQRpy1wAsWWGGEdF9iyldophxwPNFPqS5jkl+kbLO1T0a4VQrJxd91bXxx/JSlGZZL
 SeY4ujypnbmraJw3fRF08zW1PF1nAT95r5FIRfBlNb/M8BhnE6MwjengvouR22jHX60Z
 D2/lODkugHc76NAtWmX7JYwdFvg1aNh3Q32Oq68rMvnnuGTfxUUyZBIutWpZLk7N+ZRp
 BUkeug+E7wP5ICUzyF1chMvWfnMoDmCXKrNYTeYm4LUSh4fezTPyRZaDdO3g24TurvFO
 HijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RhUZn+IBGVca8nwr1WO4zWXivDlJk8sWGgmEvbv5Jqg=;
 b=WRcyl/3WqF8Z+Q7UFTUbYxmjH4Za7RaXJyhGku0bPMlcr/DRkcPTiflebl76QNaP6p
 cEwpxqSNURiQ5trJxLZj0RBhf9MPiE0xYEwngqQyuLtOGMKc/ad3wTZ26DCZ7uwxTmGb
 /Sw+kiYhcmx/43VRIAH6JBio7xhxI56qf/2J8nV2SFTNkiDepkfACyKolJd28wivR+6f
 fdsJPQexAlmVPNp4/b9D7Hf4GjpAsdLlVKdeKPCwPB3ZKHjhwRUd6zvlK8JYssbTN7OY
 EyDLD6u9jsQeZNLmEVPd3fOowVsu81+2mWcF8pch2KWdbA8fmUiPa+jvzYWZNo7kLZbY
 fNsw==
X-Gm-Message-State: APjAAAXi8vRNW3z+O7iGzniFovGB6FEBCKVaqjof4rXSJndk8RbS1bWg
 pdF96S5j5tsHi06s7XJCS7CL1Q==
X-Google-Smtp-Source: APXvYqyU8eeAaTVxB+Dy8CWURxBX+OrZ2Xd0td0PqaFDxwkfLdOEQ4oGxjHJPOPlx5SexIaYD0t2iA==
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr15749191wmd.176.1571068429479; 
 Mon, 14 Oct 2019 08:53:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 3sm19810780wmo.22.2019.10.14.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 08:53:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2A2CA1FF87;
 Mon, 14 Oct 2019 16:53:48 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 03/20] target/arm: Split out rebuild_hflags_common_32
In-reply-to: <20191011155546.14342-4-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 16:53:48 +0100
Message-ID: <87tv8bmigj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Create a function to compute the values of the TBFLAG_A32 bits
> that will be cached, and are used by all profiles.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 69da04786e..f05d042474 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11070,6 +11070,15 @@ static uint32_t rebuild_hflags_common(CPUARMStat=
e *env, int fp_el,
>      return flags;
>  }
>
> +static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
> +                                         ARMMMUIdx mmu_idx, uint32_t fla=
gs)
> +{
> +    flags =3D FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
> +    flags =3D FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
> +
> +    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
> +}
> +
>  static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>                                     ARMMMUIdx mmu_idx)
>  {
> @@ -11141,7 +11150,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>      ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
>      int current_el =3D arm_current_el(env);
>      int fp_el =3D fp_exception_el(env, current_el);
> -    uint32_t flags =3D 0;
> +    uint32_t flags;
>
>      if (is_a64(env)) {
>          *pc =3D env->pc;
> @@ -11151,12 +11160,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, tar=
get_ulong *pc,
>          }
>      } else {
>          *pc =3D env->regs[15];
> +        flags =3D rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len=
);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_=
stride);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_=
bits);
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env=
));
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(e=
nv));
>          if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
>              || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)=
) {
>              flags =3D FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
> @@ -11166,8 +11174,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>              flags =3D FIELD_DP32(flags, TBFLAG_A32,
>                                 XSCALE_CPAR, env->cp15.c15_cpar);
>          }
> -
> -        flags =3D rebuild_hflags_common(env, fp_el, mmu_idx, flags);
>      }
>
>      /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine


--
Alex Benn=C3=A9e

