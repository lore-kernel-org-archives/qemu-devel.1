Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E607C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D434B20449
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8wCkuw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D434B20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRPK-0005cZ-5J
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52566)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPqO-0007tL-A9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPqM-0000DS-AH
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:32:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbPqK-0000BW-SO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:32:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id p11so20830242wre.7
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uvNzLERCNx/G/M6pBVrbtkepYOvYJQh+bp8Sukri6j8=;
 b=w8wCkuw2+RsPEFZKXPXq3eriwwEX0xUkvxgk4xPtrKMtsqCWrNvVEvX8Svfh3XjOQN
 UIzVZTPMS1lXymaEdeVNfZiNOGgjd+wsrKGsiTWdJZbrfW9cwblqS2Vpbe5trV/lOCS3
 FNNalx2K/ioNIP10AYUGGsPMISRh8C//lKgP9fwtIpEkmMh5zfBQbtJzH2Wfy17AJVCb
 nw65aBoXjsPJA303ROSLHaS/4K+RwZANzPHBwo4t4pc2E2Os+aXdUcUWcDEUh2XcGQ+a
 Aa1fx20ld2Dktzp1tCgWaFq/vuKJxgJZ5P0RSsJ82rKKza9EZenJbxcwxfs3SQRU1u73
 MYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uvNzLERCNx/G/M6pBVrbtkepYOvYJQh+bp8Sukri6j8=;
 b=b9Ez0+pF2+4XRtvEtXTnx7ewVKTQHepno1T4UtRxKi9i3gztct+Tdv3r9UqnG++NDI
 PgcmiTPRUZGTEV1PTHge05+8ByjBU6OCU0cRx0NaW+k8YLVINo+I1Gc6vDcWxhZDq9Ob
 A7KScwmMCravwYeLjVWfI2JWjdPjryhIsbEWpIhhsoQc2/qYxCJErCeE3mKNmndp9aql
 i6xrXKWt9FkA2s4I+nERwgf70wTF/GZc1Ab7igqjrN78GsoRyBrxoUQfnWL3VJ5Ft8Nl
 AnBePz1agxSYgdgZQ3Yvl46URgtcjd6T8eTFQ+wRGiEvFMdkCOH1fntq46PKaX56yRNy
 jxcA==
X-Gm-Message-State: APjAAAXZdxoVLiw37A2r6U6/fhTRN2W8QHGiNiKoP9UZEMcXhap2OZTW
 wsE3F8BnTDfytxa0//dgYWO0wg==
X-Google-Smtp-Source: APXvYqwxXRtPkJMxB3+pT5mFi6R2Rj8ijg5e1fPw6iyM/TKaPVxo5O4GbD9ipJInbssC3dXkyhybZw==
X-Received: by 2002:adf:8183:: with SMTP id 3mr46146178wra.181.1560432759220; 
 Thu, 13 Jun 2019 06:32:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g8sm1578578wme.20.2019.06.13.06.32.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 06:32:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB2361FF87;
 Thu, 13 Jun 2019 14:32:37 +0100 (BST)
References: <20190517174046.11146-1-peter.maydell@linaro.org>
 <20190517174046.11146-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190517174046.11146-3-peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 14:32:37 +0100
Message-ID: <878su5ehl6.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 2/4] target/arm: Allow M-profile CPUs to
 disable the DSP extension via CPU property
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Allow the DSP extension to be disabled via a CPU property for
> M-profile CPUs. (A and R-profile CPUs don't have this extension
> as a defined separate optional architecture extension, so
> they don't need the property.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h |  2 ++
>  target/arm/cpu.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 778fb293e7c..b1c7ab3ee94 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -801,6 +801,8 @@ struct ARMCPU {
>      bool has_vfp;
>      /* CPU has Neon */
>      bool has_neon;
> +    /* CPU has M-profile DSP extension */
> +    bool has_dsp;
>
>      /* CPU has memory protection unit */
>      bool has_mpu;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 406fd360a2a..c43139ba897 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -769,6 +769,9 @@ static Property arm_cpu_has_vfp_property =3D
>  static Property arm_cpu_has_neon_property =3D
>              DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
>
> +static Property arm_cpu_has_dsp_property =3D
> +            DEFINE_PROP_BOOL("dsp", ARMCPU, has_dsp, true);
> +
>  static Property arm_cpu_has_mpu_property =3D
>              DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
>
> @@ -881,6 +884,12 @@ void arm_cpu_post_init(Object *obj)
>          }
>      }
>
> +    if (arm_feature(&cpu->env, ARM_FEATURE_M) &&
> +        arm_feature(&cpu->env, ARM_FEATURE_THUMB_DSP)) {
> +        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property,
> +                                 &error_abort);
> +    }
> +
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
>          qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property,
>                                   &error_abort);
> @@ -1100,6 +1109,26 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>          cpu->isar.mvfr0 =3D u;
>      }
>
> +    if (arm_feature(env, ARM_FEATURE_M) && !cpu->has_dsp) {
> +        uint32_t u;
> +
> +        unset_feature(env, ARM_FEATURE_THUMB_DSP);
> +
> +        u =3D cpu->isar.id_isar1;
> +        u =3D FIELD_DP32(u, ID_ISAR1, EXTEND, 1);
> +        cpu->isar.id_isar1 =3D u;
> +
> +        u =3D cpu->isar.id_isar2;
> +        u =3D FIELD_DP32(u, ID_ISAR2, MULTU, 1);
> +        u =3D FIELD_DP32(u, ID_ISAR2, MULTS, 1);
> +        cpu->isar.id_isar2 =3D u;
> +
> +        u =3D cpu->isar.id_isar3;
> +        u =3D FIELD_DP32(u, ID_ISAR3, SIMD, 1);
> +        u =3D FIELD_DP32(u, ID_ISAR3, SATURATE, 0);
> +        cpu->isar.id_isar3 =3D u;
> +    }
> +
>      /* Some features automatically imply others: */
>      if (arm_feature(env, ARM_FEATURE_V8)) {
>          if (arm_feature(env, ARM_FEATURE_M)) {


--
Alex Benn=C3=A9e

