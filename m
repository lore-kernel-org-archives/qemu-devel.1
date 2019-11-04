Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF25CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 16:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7998520869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiljoHm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7998520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRfRA-0002Nf-NP
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 11:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christophe.lyon@linaro.org>) id 1iRfQ7-0001On-L9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 11:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christophe.lyon@linaro.org>) id 1iRfQ5-0007Nf-W0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 11:41:35 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christophe.lyon@linaro.org>)
 id 1iRfQ5-0007M6-Na
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 11:41:33 -0500
Received: by mail-lj1-x242.google.com with SMTP id v8so2732653ljh.5
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xF3cI8UG4B/CG7eveBfsOnF9gKQtSTS81LbJuWT86OA=;
 b=kiljoHm4esglX3aaDxIvRwsdJ4x5abu4KuJzgjw5yWTuRZ6rguh2jEmGXRVw3XYL37
 SeVwVz4TBMg41dKrgf6Cm4UPtlSo+uJzk4is0/p3Cp90MhVrQGjBrht1onGof8Z7yGm8
 ZssfRqR61tTpFWtSr1NS0wh2lqRFJgZCCKWaoWxVTAn4qo5gUK7Ir13KS73C3d6sUeGu
 tbpwqhKx80EMytoetzeqaidJRfaetIv5veZOL1mZWptdjHhsoMSVUDw+M1m6ay+ZzmGC
 GuAfwPMwcF0OyVZ4t5stRUOJzLICp34mf/iKiENMjZAhtotGiG3NGyUD/aaMRNJcRe4c
 RLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xF3cI8UG4B/CG7eveBfsOnF9gKQtSTS81LbJuWT86OA=;
 b=RpHWas4rww+0xB41BC9i1AIh2QpEE68sv3xJPpvCQ5RRm3GIGmzsy8MYsAis1ll1Pc
 xt6uGvR3viqdFMm8po0asO/yw5CD3DQZeSQ49ep4UPc6OhujcNmQ4QdxfY0r47Ej03Rs
 9qZsY9vcDTPx7aH63qgJ3GYph4E0oQuSK/YbWbCRwya3FySqTaO6QjyLfpwVjhC/cVND
 u0BVKYznPcylMVW7a0SE9cGo8GiI2reXu7Cgn4kQmV/gXregdVC3kXd+qVmdXoQyHduB
 su7wTnOVFcyK2GA2ScYtaIXD56jfa4LT+JFGBvd3NFDUf9mBW8VSBLePHKQ6WHxVAZpn
 nt9Q==
X-Gm-Message-State: APjAAAUwdY2QBDjPvV2K2C6a7xvF0yKCecBE3h+Hhr3mslmNDQ0pr+Xb
 5LlljePr8Xw3MCqanRbI0qg2FWRSx3skyq7w9NimqSo8
X-Google-Smtp-Source: APXvYqzrg0HeID6zxYhMe/i366ehlFX6D9VN7hjAB8ynQ7E8QnyuhIJ2trGpKNCKzeMp9010MhJTzZ6bzSl1D/Fecfg=
X-Received: by 2002:a2e:91ca:: with SMTP id u10mr17946771ljg.208.1572885691207; 
 Mon, 04 Nov 2019 08:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20191025090841.10299-1-christophe.lyon@linaro.org>
In-Reply-To: <20191025090841.10299-1-christophe.lyon@linaro.org>
From: Christophe Lyon <christophe.lyon@linaro.org>
Date: Mon, 4 Nov 2019 17:41:20 +0100
Message-ID: <CAKdteOZ9dYWhL7GDofCTFuYqN+Z60Z_daUAzDTPdhXODTYP9xw@mail.gmail.com>
Subject: Re: [PING] [PATCH 1/1] target/arm: Add support for cortex-m7 CPU
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

http://patchwork.ozlabs.org/patch/1183934/

On Fri, 25 Oct 2019 at 11:08, Christophe Lyon
<christophe.lyon@linaro.org> wrote:
>
> This is derived from cortex-m4 description, adding DP support and FPv5
> instructions with the corresponding flags in isar and mvfr2.
>
> Checked that it could successfully execute
> vrinta.f32 s15, s15
> while cortex-m4 emulation rejects it with "illegal instruction".
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
>      cpu->isar.id_isar6 = 0x00000000;
>  }
>
> +static void cortex_m7_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> +    cpu->midr = 0x411fc272; /* r1p2 */
> +    cpu->pmsav7_dregion = 8;
> +    cpu->isar.mvfr0 = 0x10110221;
> +    cpu->isar.mvfr1 = 0x12000011;
> +    cpu->isar.mvfr2 = 0x00000040;
> +    cpu->id_pfr0 = 0x00000030;
> +    cpu->id_pfr1 = 0x00000200;
> +    cpu->id_dfr0 = 0x00100000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->id_mmfr0 = 0x00100030;
> +    cpu->id_mmfr1 = 0x00000000;
> +    cpu->id_mmfr2 = 0x01000000;
> +    cpu->id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01101110;
> +    cpu->isar.id_isar1 = 0x02112000;
> +    cpu->isar.id_isar2 = 0x20232231;
> +    cpu->isar.id_isar3 = 0x01111131;
> +    cpu->isar.id_isar4 = 0x01310132;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +}
> +
>  static void cortex_m33_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -2538,6 +2569,8 @@ static const ARMCPUInfo arm_cpus[] = {
>                               .class_init = arm_v7m_class_init },
>      { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
>                               .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m7",   .initfn = cortex_m7_initfn,
> +                             .class_init = arm_v7m_class_init },
>      { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
>                               .class_init = arm_v7m_class_init },
>      { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
> --
> 2.7.4
>

