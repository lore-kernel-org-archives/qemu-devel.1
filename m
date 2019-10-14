Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F4C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0273A2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3RRDcLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0273A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5QB-0000VE-6h
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5P3-0008JL-EA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5P2-000771-CB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:49:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK5P2-00076h-5L
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:49:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id y19so20920808wrd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lk9fCYTRyD8s7aBIfDdpcaOeu0uk8tHKseGhajyxTeo=;
 b=o3RRDcLLpO3DKnlnXY/I2W+z6fjgOYo+SSCAPZsFwtMEjqud+H/+HwxHtvJA/K+yZK
 rVmOhNVzihTd1K5AVVgp+mFC/ltKIXRoW62gsIBdfdlX/gX8QJTUsjQpL6d1l/d7HF/2
 vh55nS2KtNqamT2I1nHcEUCoBq7oVy9zjy5cOwVIrOQOd/D/eAV2M1BZL18BBLjKOKD8
 dLDT1ENv0EWu4b2EFHjiJ5WvP6WUqQVJXW1exba8KlTsBn8II4ieYSGCpn0zKEqP0H6V
 t2PJs0kEfoWc//i6UJpuoiYroWGVkD/Ius3S5aYYPheMEMU2psKtL6btowb8C2ZQYxeu
 gXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lk9fCYTRyD8s7aBIfDdpcaOeu0uk8tHKseGhajyxTeo=;
 b=RTFjJZQLj20NaNRngFIKfOiBNb9F4b1LgG7P/ep4g3SfTPfWi5hcuiZT2HBSPyGTDw
 8bhhy5qe2fjW0l2XjizYIPbeiSH19G3joEw5C6NcuYo5JaboQuQ2dRyHDonhFifyIdvr
 N0ujbSiX9mrVL7wxVRJj7eoyDyizs5b7zV2sxua9eKDyuipYiPBp4cofIZ69H8knXoyw
 1ZfKev8mBzeDiz3fSHuFdSGPvmZ/4Yjx0k4ywoF5ZpQ8ZiiFVDGZ8dxqQQ91l/loNT8O
 YZuiK43//GdrpBSPjvyY9rLTATkazfQi9xOHM0PLvzXSzIsvvH1FV4Uv1FoUy7szi2oL
 lYxg==
X-Gm-Message-State: APjAAAV3d/BuYCRH6mgIpJvjRu0HOFkehU6E3RE25jS2GnmqbArTcpee
 lBzCAToiXPsYZQrXIv2JYkeLow==
X-Google-Smtp-Source: APXvYqzO2wchzAnndQeyetkZC007YvO1ILnZgKf61UKcEuUkm08gqJd2l4yFEf+5ZfSPoAoeXMso9w==
X-Received: by 2002:a5d:6581:: with SMTP id q1mr26465707wru.393.1571078946827; 
 Mon, 14 Oct 2019 11:49:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o18sm48449050wrw.90.2019.10.14.11.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 11:49:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 877181FF87;
 Mon, 14 Oct 2019 19:49:05 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-14-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 13/20] target/arm: Split out arm_mmu_idx_el
In-reply-to: <20191011155546.14342-14-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 19:49:05 +0100
Message-ID: <87d0ezmace.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Avoid calling arm_current_el() twice.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/internals.h |  9 +++++++++
>  target/arm/helper.c    | 12 +++++++-----
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 232d963875..f5313dd3d4 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -949,6 +949,15 @@ void arm_cpu_update_virq(ARMCPU *cpu);
>   */
>  void arm_cpu_update_vfiq(ARMCPU *cpu);
>
> +/**
> + * arm_mmu_idx_el:
> + * @env: The cpu environment
> + * @el: The EL to use.
> + *
> + * Return the full ARMMMUIdx for the translation regime for EL.
> + */
> +ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
> +
>  /**
>   * arm_mmu_idx:
>   * @env: The cpu environment
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 85de96d071..3f7d3f257d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11026,15 +11026,12 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMSt=
ate *env, bool secstate)
>  }
>  #endif
>
> -ARMMMUIdx arm_mmu_idx(CPUARMState *env)
> +ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
>  {
> -    int el;
> -
>      if (arm_feature(env, ARM_FEATURE_M)) {
>          return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
>      }
>
> -    el =3D arm_current_el(env);
>      if (el < 2 && arm_is_secure_below_el3(env)) {
>          return ARMMMUIdx_S1SE0 + el;
>      } else {
> @@ -11042,6 +11039,11 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
>      }
>  }
>
> +ARMMMUIdx arm_mmu_idx(CPUARMState *env)
> +{
> +    return arm_mmu_idx_el(env, arm_current_el(env));
> +}
> +
>  int cpu_mmu_index(CPUARMState *env, bool ifetch)
>  {
>      return arm_to_core_mmu_idx(arm_mmu_idx(env));
> @@ -11202,7 +11204,7 @@ static uint32_t rebuild_hflags_internal(CPUARMSta=
te *env)
>  {
>      int el =3D arm_current_el(env);
>      int fp_el =3D fp_exception_el(env, el);
> -    ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
> +    ARMMMUIdx mmu_idx =3D arm_mmu_idx_el(env, el);
>
>      if (is_a64(env)) {
>          return rebuild_hflags_a64(env, el, fp_el, mmu_idx);


--
Alex Benn=C3=A9e

