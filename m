Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BBBC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 18:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A30220675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 18:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tp6D/5GZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A30220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icZWG-0002Nx-I4
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 13:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icZUo-0001PM-FJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icZUk-0004IS-G0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:35:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55852)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icZUg-0004Hb-9F
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:35:24 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so780216wmj.5
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 10:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AuhPIKXcLUfw0uutoo6RrZhKPZqaS1SQZ/mCofUVe2Y=;
 b=Tp6D/5GZn1dDafPu1/fwGwbPZptCZLzEHDOFXb5cz4TM5uIJ8Fn+XOImSG2/y+Kr0f
 KOL2sgo/4vKY/6DdcMdKqDkWO86Zg5bggPXuuXVB5ALNN9gw9s5nkf1Jgy9QSNLhPPfa
 wMKPZFrlEpQwpVEsl+AKy8zS6bTAqRJLDAyqETnfPCpGV0Uh/oaPyETMkplqGiNOsaw3
 4PgUyjchrUxYYtKg5cDHVhYxhU2/RTAj7WjJhV0SdZBL8YzFwfym99P/1XpiZBK9IsO+
 szu5BhL//uykxe6DNAxkCe/DVYMFN+dZYBlHLzuCZDSszUrPRIZ2fP2aIJ7vwXfrmIx6
 tGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AuhPIKXcLUfw0uutoo6RrZhKPZqaS1SQZ/mCofUVe2Y=;
 b=TCjBrTF+IxtzqbkKIZevvdIlkqKjBmvopLgiiEaABrQ95RtDeFav4/Uzje0198nRF5
 rOhCoLSffBoUoo37V2eTdxbgLeSQXxgh7esEihtBvg/EXbmsAKTW9jDbj/GK11ndR/pG
 VlY/GV+Y6FxtcLby+DdNRydxi+npBUYNInTWMHjzSwDt1E++NVKsYyvgCtyeVPuqJs0F
 YeelvQEWagz69ieNJrFnja0u9OglII16vwMnYBDYdPNZCKqK+iCxtdcwLOtrAlWEK+UY
 m4XlpON0rdgeC5rSXypyylX9D3KeTvYBP7TS9cLLVlvYQr/CjX+MKqTCSlynGa83+ADL
 b0pw==
X-Gm-Message-State: APjAAAUIS4SYTtulYB36kAMdx2GOexGqiTmZa0iz/m+a+rNPvHNngBuy
 VjVsuH6lFmqEOIfE8Amt2UbM1Q==
X-Google-Smtp-Source: APXvYqxevuGSuyhUM++i3Mu5LZr+vuq1IjlrxBkGEk9JJOklEoWdxl0yaFa3irk/pVKeOSQ8rNZIhg==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr956654wmj.53.1575484515811;
 Wed, 04 Dec 2019 10:35:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l26sm7746638wmj.48.2019.12.04.10.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 10:35:14 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C85E01FF87;
 Wed,  4 Dec 2019 18:35:13 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-26-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 25/40] target/arm: Update timer access for VHE
In-reply-to: <20191203022937.1474-26-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 18:35:13 +0000
Message-ID: <87wobc6ise.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 102 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 81 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a4a7f82661..023b8963cf 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2287,10 +2287,18 @@ static CPAccessResult gt_cntfrq_access(CPUARMStat=
e *env, const ARMCPRegInfo *ri,
>       * Writable only at the highest implemented exception level.
>       */
>      int el =3D arm_current_el(env);
> +    uint64_t hcr;
> +    uint32_t cntkctl;
>=20=20
>      switch (el) {
>      case 0:
> -        if (!extract32(env->cp15.c14_cntkctl, 0, 2)) {
> +        hcr =3D arm_hcr_el2_eff(env);
> +        if ((hcr & (HCR_E2H | HCR_TGE)) =3D=3D (HCR_E2H | HCR_TGE)) {
> +            cntkctl =3D env->cp15.cnthctl_el2;
> +        } else {
> +            cntkctl =3D env->cp15.c14_cntkctl;
> +        }
> +        if (!extract32(cntkctl, 0, 2)) {
>              return CP_ACCESS_TRAP;
>          }
>          break;
> @@ -2318,17 +2326,47 @@ static CPAccessResult gt_counter_access(CPUARMSta=
te *env, int timeridx,
>  {
>      unsigned int cur_el =3D arm_current_el(env);
>      bool secure =3D arm_is_secure(env);
> +    uint64_t hcr =3D arm_hcr_el2_eff(env);
>=20=20
> -    /* CNT[PV]CT: not visible from PL0 if ELO[PV]CTEN is zero */
> -    if (cur_el =3D=3D 0 &&
> -        !extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
> -        return CP_ACCESS_TRAP;
> -    }
> +    switch (cur_el) {
> +    case 0:
> +        /* If HCR_EL2.<E2H,TGE> =3D=3D '11': check CNTHCTL_EL2.EL0[PV]CT=
EN. */
> +        if ((hcr & (HCR_E2H | HCR_TGE)) =3D=3D (HCR_E2H | HCR_TGE)) {
> +            return (extract32(env->cp15.cnthctl_el2, timeridx, 1)
> +                    ? CP_ACCESS_OK : CP_ACCESS_TRAP_EL2);
> +        }
>=20=20
> -    if (arm_feature(env, ARM_FEATURE_EL2) &&
> -        timeridx =3D=3D GTIMER_PHYS && !secure && cur_el < 2 &&
> -        !extract32(env->cp15.cnthctl_el2, 0, 1)) {
> -        return CP_ACCESS_TRAP_EL2;
> +        /* CNT[PV]CT: not visible from PL0 if EL0[PV]CTEN is zero */
> +        if (!extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
> +            return CP_ACCESS_TRAP;
> +        }
> +
> +        /* If HCR_EL2.<E2H,TGE> =3D=3D '10': check CNTHCTL_EL2.EL1PCTEN.=
 */
> +        if (hcr & HCR_E2H) {
> +            if (timeridx =3D=3D GTIMER_PHYS &&
> +                !extract32(env->cp15.cnthctl_el2, 10, 1)) {
> +                return CP_ACCESS_TRAP_EL2;
> +            }
> +        } else {
> +            /* If HCR_EL2.<E2H> =3D=3D 0: check CNTHCTL_EL2.EL1PCEN. */
> +            if (arm_feature(env, ARM_FEATURE_EL2) &&
> +                timeridx =3D=3D GTIMER_PHYS && !secure &&
> +                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
> +                return CP_ACCESS_TRAP_EL2;
> +            }
> +        }
> +        break;
> +
> +    case 1:
> +        /* Check CNTHCTL_EL2.EL1PCTEN, which changes location based on E=
2H. */
> +        if (arm_feature(env, ARM_FEATURE_EL2) &&
> +            timeridx =3D=3D GTIMER_PHYS && !secure &&
> +            (hcr & HCR_E2H
> +             ? !extract32(env->cp15.cnthctl_el2, 10, 1)
> +             : !extract32(env->cp15.cnthctl_el2, 0, 1))) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +        break;
>      }
>      return CP_ACCESS_OK;
>  }
> @@ -2338,19 +2376,41 @@ static CPAccessResult gt_timer_access(CPUARMState=
 *env, int timeridx,
>  {
>      unsigned int cur_el =3D arm_current_el(env);
>      bool secure =3D arm_is_secure(env);
> +    uint64_t hcr =3D arm_hcr_el2_eff(env);
>=20=20
> -    /* CNT[PV]_CVAL, CNT[PV]_CTL, CNT[PV]_TVAL: not visible from PL0 if
> -     * EL0[PV]TEN is zero.
> -     */
> -    if (cur_el =3D=3D 0 &&
> -        !extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
> -        return CP_ACCESS_TRAP;
> -    }
> +    switch (cur_el) {
> +    case 0:
> +        if ((hcr & (HCR_E2H | HCR_TGE)) =3D=3D (HCR_E2H | HCR_TGE)) {
> +            /* If HCR_EL2.<E2H,TGE> =3D=3D '11': check CNTHCTL_EL2.EL0[P=
V]TEN. */
> +            return (extract32(env->cp15.cnthctl_el2, 9 - timeridx, 1)
> +                    ? CP_ACCESS_OK : CP_ACCESS_TRAP_EL2);
> +        }
>=20=20
> -    if (arm_feature(env, ARM_FEATURE_EL2) &&
> -        timeridx =3D=3D GTIMER_PHYS && !secure && cur_el < 2 &&
> -        !extract32(env->cp15.cnthctl_el2, 1, 1)) {
> -        return CP_ACCESS_TRAP_EL2;
> +        /*
> +         * CNT[PV]_CVAL, CNT[PV]_CTL, CNT[PV]_TVAL: not visible from
> +         * EL0 if EL0[PV]TEN is zero.
> +         */
> +        if (!extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
> +            return CP_ACCESS_TRAP;
> +        }
> +        /* fall through */
> +
> +    case 1:
> +        if (arm_feature(env, ARM_FEATURE_EL2) &&
> +            timeridx =3D=3D GTIMER_PHYS && !secure) {
> +            if (hcr & HCR_E2H) {
> +                /* If HCR_EL2.<E2H,TGE> =3D=3D '10': check CNTHCTL_EL2.E=
L1PTEN. */
> +                if (!extract32(env->cp15.cnthctl_el2, 11, 1)) {
> +                    return CP_ACCESS_TRAP_EL2;
> +                }
> +            } else {
> +                /* If HCR_EL2.<E2H> =3D=3D 0: check CNTHCTL_EL2.EL1PCEN.=
 */
> +                if (!extract32(env->cp15.cnthctl_el2, 1, 1)) {
> +                    return CP_ACCESS_TRAP_EL2;
> +                }
> +            }
> +        }
> +        break;
>      }
>      return CP_ACCESS_OK;
>  }


--=20
Alex Benn=C3=A9e

