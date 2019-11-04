Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E3BCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF282080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vm5EQflm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF282080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRfqn-0003w1-UZ
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRfpz-0003Ty-7r
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRfpx-0007f6-S7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:08:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRfpx-0007ei-L6
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:08:17 -0500
Received: by mail-wm1-x343.google.com with SMTP id 6so14530281wmf.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Gy/Qc35w4nzAwOQQmBrcDp/XldF1FLrN9oQjHngOM0A=;
 b=vm5EQflm+JF/56/xsKG8zPTkbjbcSwUE8M2kug7nfetFujEboM6ImvFfKMxOKljf70
 CZFWhRh512ZRSVclkx38/nu04ipPf9nPyXc7pEPVAOGy0NR+NfIXnFYdNjxUeNbFhV3n
 /KyhLKEWCvO4gl0XPYM+hBWWKiKD4OIFqOUaPRxyebD9rbYfbKwyMoeVF2M5xrdKjOI4
 6j6TAPuLTT9muC2A9jTIIp4f0SHtM0YeqoK6JWn+1o3fZO7msjqrA3Mdtkd1NUr3XT6R
 JSVBnmUIYpbE7vGnGFr1eAE6DsclBRoocoF3yfaPgq1ZMCLb6meE8hcTfYQDChi4BtNV
 NFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Gy/Qc35w4nzAwOQQmBrcDp/XldF1FLrN9oQjHngOM0A=;
 b=PjAEpolhGgtEQ2q+SBcfyH/e86kOQZRLnuzh3THNaATLqRafxdTyuvhlrpTvFGQbI0
 MYj6hSGBudKVkoJ7o+R2gFroR7lhLGp4N2TGx0eFEOIn3rkvsXZ5EoaGsr11cJfSfOhQ
 sfe8U2hATnLZF9DEYFUxrHnUtk5gCxLJzTe7K2eJGHjWzBLn09GHiT9EKcAAjMPaBdvR
 cXOyO4KOJIV0RvoSBRgWubUfYX+8zIDWAB9QWhObboDLQdALnTOhQpujHfiN7+cuZrLd
 y04Zx5UWfNDm4uS9GBv7/ROuVubsajYcOYyl14Ew12XBR0b+eMgYfxmIpEQ+jCbDjZwP
 rkAw==
X-Gm-Message-State: APjAAAWWIQ299hglOk/HGR0zjBXNvaldby91kX7q9yE2kr0Lbjun7i4P
 6xY03VZAS3NnW0F5LWz0PzhX/w==
X-Google-Smtp-Source: APXvYqwAq0HAnWWDHR/JqvNeBNSa85pFUsTMHsqZUsej5Bn2EJUNSKk9vtmvCPdgD/BAg+79bo8u8Q==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr133651wmi.124.1572887296108;
 Mon, 04 Nov 2019 09:08:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm18689868wrb.67.2019.11.04.09.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 09:08:15 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7F1961FF87;
 Mon,  4 Nov 2019 17:08:14 +0000 (GMT)
References: <20191025090841.10299-1-christophe.lyon@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] target/arm: Add support for cortex-m7 CPU
In-reply-to: <20191025090841.10299-1-christophe.lyon@linaro.org>
Date: Mon, 04 Nov 2019 17:08:14 +0000
Message-ID: <87r22nk1s1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, Christophe Lyon <christophe.lyon@linaro.org>,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Christophe Lyon <christophe.lyon@linaro.org> writes:

> This is derived from cortex-m4 description, adding DP support and FPv5
> instructions with the corresponding flags in isar and mvfr2.
>
> Checked that it could successfully execute
> vrinta.f32 s15, s15
> while cortex-m4 emulation rejects it with "illegal instruction".

I couldn't verify the cpu->midr values as most of the sections seem to
be IMPDEF but the rest of the feature bits look OK to me:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Christophe Lyon <christophe.lyon@linaro.org>
> ---
>  target/arm/cpu.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 13813fb..ccae849 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1954,6 +1954,37 @@ static void cortex_m4_initfn(Object *obj)
>      cpu->isar.id_isar6 =3D 0x00000000;
>  }
>
> +static void cortex_m7_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> +    cpu->midr =3D 0x411fc272; /* r1p2 */
> +    cpu->pmsav7_dregion =3D 8;
> +    cpu->isar.mvfr0 =3D 0x10110221;
> +    cpu->isar.mvfr1 =3D 0x12000011;
> +    cpu->isar.mvfr2 =3D 0x00000040;
> +    cpu->id_pfr0 =3D 0x00000030;
> +    cpu->id_pfr1 =3D 0x00000200;
> +    cpu->id_dfr0 =3D 0x00100000;
> +    cpu->id_afr0 =3D 0x00000000;
> +    cpu->id_mmfr0 =3D 0x00100030;
> +    cpu->id_mmfr1 =3D 0x00000000;
> +    cpu->id_mmfr2 =3D 0x01000000;
> +    cpu->id_mmfr3 =3D 0x00000000;
> +    cpu->isar.id_isar0 =3D 0x01101110;
> +    cpu->isar.id_isar1 =3D 0x02112000;
> +    cpu->isar.id_isar2 =3D 0x20232231;
> +    cpu->isar.id_isar3 =3D 0x01111131;
> +    cpu->isar.id_isar4 =3D 0x01310132;
> +    cpu->isar.id_isar5 =3D 0x00000000;
> +    cpu->isar.id_isar6 =3D 0x00000000;
> +}
> +
>  static void cortex_m33_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> @@ -2538,6 +2569,8 @@ static const ARMCPUInfo arm_cpus[] =3D {
>                               .class_init =3D arm_v7m_class_init },
>      { .name =3D "cortex-m4",   .initfn =3D cortex_m4_initfn,
>                               .class_init =3D arm_v7m_class_init },
> +    { .name =3D "cortex-m7",   .initfn =3D cortex_m7_initfn,
> +                             .class_init =3D arm_v7m_class_init },
>      { .name =3D "cortex-m33",  .initfn =3D cortex_m33_initfn,
>                               .class_init =3D arm_v7m_class_init },
>      { .name =3D "cortex-r5",   .initfn =3D cortex_r5_initfn },


--
Alex Benn=C3=A9e

