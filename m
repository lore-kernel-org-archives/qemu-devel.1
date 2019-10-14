Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A1ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDF520663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvzzZsNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDF520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3zx-00069D-7c
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK2y7-0007S6-By
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK2y5-0003R2-VM
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:13:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK2y5-0003Px-MW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:13:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id n14so20370478wrw.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WB5RpMlbc7Rn/mKCKLehE+yYPfvl6EUA76bzoTxAkvo=;
 b=cvzzZsNhCShGt+tnCQwQaApYD2YvU0Rk8IpyS3a+E+HRSdJW+3ouzohihsK61REGue
 XmWX0Pu3KIaibQts0nvJHmddimdspTdG117fADkwOX57tRTcVdkBd6sNqR4sIburhoOT
 rk8czMNTWbQU6GwnpgUD27m0axA48aP6jG3jg6GvBwL+3FWVfDQ14zPpeZX5Jc7ARw71
 d+EstwfbZYQkK/BNvwxj5A4ZYs3UOjfAM5VYqYdGYrnMER8qqe9LqxYWthudVS+so5Ng
 5VVjpAkXgtlK+dnK0uL6Fc3nJYvdjbSmGdlPgdfh9N3VO96BUpb/Eh5M5FVX4shrAKB9
 Di/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WB5RpMlbc7Rn/mKCKLehE+yYPfvl6EUA76bzoTxAkvo=;
 b=sLzQwqG+3eGMW+j+nK/gJrcHbZTaEGvd2qhpD/DDY4/z2wWcLDm43B+U+3YFvt44Ml
 UIQwk0S1mdc6enRDmdE/sGYAP98TTWBgYUWUEHOqZBYv3BdFc9HTOBanuFVly3YHyTCw
 uk/JmVa6vjCgqHUfIYsSsdvqXnyeasYcI7ST9DxHr20gQjym1uJoaMQ4ig4PQ22CVeBp
 oYXASBUCgvSw0Emy+hf9T1Qs9W65VZf3Zwplip+/ZYCIs9XN1DOg6YvZlb/ErGgKfLN8
 CIXwJg6xGtKtDRovo5YwOK2sKTnL3rQ2dK7OfMTnpfENSKpZWAbqFU4NXwcZBizYPop4
 Wsaw==
X-Gm-Message-State: APjAAAXEqCpcupm+xkp5EhGrCci/TYCn9E3DFJ+bjmDH6kxKbrRPHLQl
 3gJvTelJEDHZbGAnDRtQd1Z2ig==
X-Google-Smtp-Source: APXvYqwJB43umBtBcpzxCWBrf995pOw1pKSfh3vQlu5DQpPOhHkRr6ZkXQkzHae4iDUkwMcWI9dPuA==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr1666078wrn.353.1571069588186; 
 Mon, 14 Oct 2019 09:13:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o19sm23260481wmh.27.2019.10.14.09.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:13:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB22A1FF87;
 Mon, 14 Oct 2019 17:13:06 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 05/20] target/arm: Split out rebuild_hflags_m32
In-reply-to: <20191011155546.14342-6-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 17:13:06 +0100
Message-ID: <87r23fmhkd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
> that will be cached, and are used by M-profile.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 45 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4c65476d93..d4303420da 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11083,6 +11083,29 @@ static uint32_t rebuild_hflags_common_32(CPUARMS=
tate *env, int fp_el,
>      return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
>  }
>
> +static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
> +                                   ARMMMUIdx mmu_idx)
> +{
> +    uint32_t flags =3D 0;
> +
> +    if (arm_v7m_is_handler_mode(env)) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
> +    }
> +
> +    /*
> +     * v8M always applies stack limit checks unless CCR.STKOFHFNMIGN
> +     * is suppressing them because the requested execution priority
> +     * is less than 0.
> +     */
> +    if (arm_feature(env, ARM_FEATURE_V8) &&
> +        !((mmu_idx & ARM_MMU_IDX_M_NEGPRI) &&
> +          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))=
) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
> +    }
> +
> +    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
> +}
> +
>  static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>                                     ARMMMUIdx mmu_idx)
>  {
> @@ -11168,7 +11191,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>          }
>      } else {
>          *pc =3D env->regs[15];
> -        flags =3D rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
> +
> +        if (arm_feature(env, ARM_FEATURE_M)) {
> +            flags =3D rebuild_hflags_m32(env, fp_el, mmu_idx);
> +        } else {
> +            flags =3D rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
> +        }
> +
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len=
);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_=
stride);
> @@ -11204,20 +11233,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>          }
>      }
>
> -    if (arm_v7m_is_handler_mode(env)) {
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
> -    }
> -
> -    /* v8M always applies stack limit checks unless CCR.STKOFHFNMIGN is
> -     * suppressing them because the requested execution priority is less=
 than 0.
> -     */
> -    if (arm_feature(env, ARM_FEATURE_V8) &&
> -        arm_feature(env, ARM_FEATURE_M) &&
> -        !((mmu_idx  & ARM_MMU_IDX_M_NEGPRI) &&
> -          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))=
) {
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
> -    }
> -
>      if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
>          FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) !=3D env->v7m.=
secure) {
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);


--
Alex Benn=C3=A9e

