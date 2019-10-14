Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B9C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80CA206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUV5uHUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80CA206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5a1-0005qa-Vk
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5Yr-00058H-DT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5Yq-0002Qg-8T
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:59:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK5Yq-0002QC-1W
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:59:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id b9so20957721wrs.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Zl6nowEhXZsinkEcj/r1hBF3BeMkw7O7Sf6gaZQpcEs=;
 b=IUV5uHUIOz21BHD2Vg3tBVOwRSpM2AtOuTFSZvxAyHX2rjhLjzKgDlrJQPPxRpHYAO
 VF0Es5QASEEFU0Gw8V54owSqzZmQRjVmpwhwpHB6keWNhGIzit5xanys642+QPp7fWVe
 Z86DESzTLEoo24VSjNwP7AQK3OBCtWjoXjyuwaw2MvM4eSgfB8QvMeN6Hta5BJQ00GKB
 uo+t94xCBhb+GjEO9dq8gB/2hWxO+dpRPj7z9uvkVYKQdE4yT+g+3sm5t4dNK2twLA9O
 9EKTm+Yk1vbXjkJdHUgdonQ9xbCVrKETkJ2ugT8k7biehQP5SoZG8akekgNCnltQhFNy
 rtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Zl6nowEhXZsinkEcj/r1hBF3BeMkw7O7Sf6gaZQpcEs=;
 b=kFXdbU6biVpwpriCeEdNAQsqnn+4+wua9ty2Pf4IHHTwE9g51HmF2FeFQvS5H1oJrh
 V4ev6llqKQUl8F8V5SEOeL3Y6IKiZF3bUrSlzWMMUsIaDYGhA/Ef/Uj9JiNolWLGrqtL
 vw6Jpsobsj+2jwzwIvteWx78zv9DpT9TQF+xX9p9ToooEE3fECVJlZyuEdykAi/N4occ
 9Breadi38SEqw1idrcf73aYPj8YdpzVpWAhCzXGZsMAI2CabogkXbgXzQTDkUoeQQDZH
 5GOOuQj0tqk5iU1z+AHTkJ2MbXz2B87bLXNvTxWW0mFzrAQyJubT2enLORyfgD6LpAYb
 Fp+g==
X-Gm-Message-State: APjAAAXmFN/wfOcVm0BpfdICTdn4qOAxcNBRfw7RVxbAgnS1mr7tr6gK
 BDYGzELp6Gj3qnMbrGtUFt0iog==
X-Google-Smtp-Source: APXvYqxGh3Ggmx12zRF+hbIH0otXgm8kLDs/9jEYkNZiWc+ndVT9PsaeKQo0PiH6our5Ay+KVq+QZQ==
X-Received: by 2002:adf:e283:: with SMTP id v3mr19633310wri.20.1571079554452; 
 Mon, 14 Oct 2019 11:59:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n1sm24138371wrg.67.2019.10.14.11.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 11:59:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4AACE1FF87;
 Mon, 14 Oct 2019 19:59:12 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-16-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 15/20] target/arm: Add HELPER(rebuild_hflags_{a32,
 a64, m32})
In-reply-to: <20191011155546.14342-16-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 19:59:12 +0100
Message-ID: <87a7a3m9vj.fsf@linaro.org>
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

> This functions are given the mode and el state of the cpu
> and writes the computed value to env->hflags.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.h |  4 ++++
>  target/arm/helper.c | 24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 1fb2cb5a77..3d4ec267a2 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -90,6 +90,10 @@ DEF_HELPER_4(msr_banked, void, env, i32, i32, i32)
>  DEF_HELPER_2(get_user_reg, i32, env, i32)
>  DEF_HELPER_3(set_user_reg, void, env, i32, i32)
>
> +DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env,
> int)
> +DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
> +DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
> +
>  DEF_HELPER_1(vfp_get_fpscr, i32, env)
>  DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 37424e3d4d..b2d701cf00 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11220,6 +11220,30 @@ void arm_rebuild_hflags(CPUARMState *env)
>      env->hflags =3D rebuild_hflags_internal(env);
>  }
>
> +void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
> +{
> +    int fp_el =3D fp_exception_el(env, el);
> +    ARMMMUIdx mmu_idx =3D arm_mmu_idx_el(env, el);
> +
> +    env->hflags =3D rebuild_hflags_m32(env, fp_el, mmu_idx);
> +}
> +
> +void HELPER(rebuild_hflags_a32)(CPUARMState *env, int el)
> +{
> +    int fp_el =3D fp_exception_el(env, el);
> +    ARMMMUIdx mmu_idx =3D arm_mmu_idx_el(env, el);
> +
> +    env->hflags =3D rebuild_hflags_a32(env, fp_el, mmu_idx);
> +}
> +
> +void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
> +{
> +    int fp_el =3D fp_exception_el(env, el);
> +    ARMMMUIdx mmu_idx =3D arm_mmu_idx_el(env, el);
> +
> +    env->hflags =3D rebuild_hflags_a64(env, el, fp_el, mmu_idx);
> +}
> +
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {


--
Alex Benn=C3=A9e

