Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF87C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA40C206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foKPMbwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA40C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1pc9-0001Y3-Qz
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 05:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j1pbS-00018w-Vh
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j1pbR-0008Ho-UG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:50:46 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j1pbR-0008H5-Mc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:50:45 -0500
Received: by mail-wr1-x443.google.com with SMTP id m16so1617082wrx.11
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 02:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3QfwizNo8Lw2tT2qYWgb5lpQAGCO0QRsu1VQeTjQIHg=;
 b=foKPMbwhTUhABzMdjVsW3FEmEsLDRDIirtnS6u0H06NEnNIsV8rzrnVpSFUXjn36CQ
 2ZHn2an/BcE3NsrVFsLl+kd/7tI+K1tWmeeXNPbehU4qzghJbOI3UFfW3n4X6BvtJZDT
 yhTJFEh47xIFIjBKtxdqFaDQH2Vlt8XjvtnzY/w7f+zsA+hg3h9mmM2f3s1W6cIwlcMK
 D7REhQBAxGyI9HJrxqmXSg3yk9nzEL8qNiESr9u8bMpIOc3AYCKrvs+qvsyfcofOvKbm
 ZWraPY5k2uAuHg8nf+plnjQ3Nn0XIu/EtSDKo7pp04txM48ce+onGxWtUJclo1t2xnR1
 Sr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3QfwizNo8Lw2tT2qYWgb5lpQAGCO0QRsu1VQeTjQIHg=;
 b=pNl/wR5evPBMYZqsGsHIPP6CC2Srkh+Vq1oRNTD45wrvioSrwnb4V3cgk67FwCILoy
 JGsU7h7UM7Pr5WjYXJ1buXtbrNg/N7MngFhNe8qwlfoiyTmX1OScLdlTq35OIw1YyZg7
 st1Cg9GV80xFYKKVfLhywPae2c+LzcdplP0fbnDG+YWU3YkCK52VhLY5LB0FA0mY5y2p
 oAA7QCmNRadWXTGcYBWQuz7fZN8VpB+AzA0x6Z02tytXaHCpVGa4FoXxoOSCZn227iaY
 VHbjg9jEckxqZszqpM2zDO4ilWZCBkk2F0jQPh2THCz1wozjNTYzHjNq5gg3NmRp2r7l
 gLlA==
X-Gm-Message-State: APjAAAUzbCxzqjHa2E+cQe7AhZd4Rz5sFO7Zzncm8WM0VY0u3CQ9L8em
 xHVIoSwuvgltxEjBK4O6jDQWJw==
X-Google-Smtp-Source: APXvYqzey0ZnTzYQew/98Q2JUO2eIJgKWRJZbEjWZBMeONRTxShdyps2ZagvaAFurMNlr6AAV32HwA==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr13935672wrl.190.1581504644416; 
 Wed, 12 Feb 2020 02:50:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm139207wrl.17.2020.02.12.02.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 02:50:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 667681FF87;
 Wed, 12 Feb 2020 10:50:42 +0000 (GMT)
References: <20200212025145.24300-1-richard.henderson@linaro.org>
 <20200212025145.24300-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.8; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
In-reply-to: <20200212025145.24300-3-richard.henderson@linaro.org>
Date: Wed, 12 Feb 2020 10:50:42 +0000
Message-ID: <87h7zwxenx.fsf@zen.linaroharston>
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
Cc: peter.maydell@linaro.org, tsimpson@quicinc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Now that we can pass 7 parameters, do not encode register
> operands within simd_data.

What defines the upper limit? Is it the ABI of the backend or just the
efficiency of implementing the prologue for the call?
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -3372,23 +3372,11 @@ DO_ZPZ_FP(sve_ucvt_dd, uint64_t,     , uint64_to_=
float64)
>=20=20
>  #undef DO_ZPZ_FP
>=20=20
> -/* 4-operand predicated multiply-add.  This requires 7 operands to pass
> - * "properly", so we need to encode some of the registers into DESC.
> - */
> -QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 20 > 32);
> -
> -static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
> +static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void=
 *vg,
> +                            float_status *status, uint32_t desc,
>                              uint16_t neg1, uint16_t neg3)
>  {
>      intptr_t i =3D simd_oprsz(desc);
> -    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    void *vd =3D &env->vfp.zregs[rd];
> -    void *vn =3D &env->vfp.zregs[rn];
> -    void *vm =3D &env->vfp.zregs[rm];
> -    void *va =3D &env->vfp.zregs[ra];
<snip>
> @@ -4010,25 +4001,14 @@ static bool trans_FCMLA_zpzzz(DisasContext *s, ar=
g_FCMLA_zpzzz *a)
>      }
>      if (sve_access_check(s)) {
>          unsigned vsz =3D vec_full_reg_size(s);
> -        unsigned desc;
> -        TCGv_i32 t_desc;
> -        TCGv_ptr pg =3D tcg_temp_new_ptr();
> -
> -        /* We would need 7 operands to pass these arguments "properly".
> -         * So we encode all the register numbers into the descriptor.
> -         */
> -        desc =3D deposit32(a->rd, 5, 5, a->rn);
> -        desc =3D deposit32(desc, 10, 5, a->rm);
> -        desc =3D deposit32(desc, 15, 5, a->ra);
> -        desc =3D deposit32(desc, 20, 2, a->rot);
> -        desc =3D sextract32(desc, 0, 22);
> -        desc =3D simd_desc(vsz, vsz, desc);
> -
> -        t_desc =3D tcg_const_i32(desc);
> -        tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
> -        fns[a->esz - 1](cpu_env, pg, t_desc);
> -        tcg_temp_free_i32(t_desc);
> -        tcg_temp_free_ptr(pg);
> +        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
> +        tcg_gen_gvec_5_ptr(vec_full_reg_offset(s, a->rd),
> +                           vec_full_reg_offset(s, a->rn),
> +                           vec_full_reg_offset(s, a->rm),
> +                           vec_full_reg_offset(s, a->ra),
> +                           pred_full_reg_offset(s, a->pg),
> +                           status, vsz, vsz, a->rot, fns[a->esz]);
> +        tcg_temp_free_ptr(status);
>      }
>      return true;
>  }

Good to see the code simplified ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

