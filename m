Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB1DC04E30
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EB62068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATlAoMgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EB62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKHa-0006WV-JO
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieKGe-0005YS-No
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieKGd-00076m-GM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:44:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31499
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieKGd-00076b-Cm
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575902646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZQkGXdsQ1RB30Jbju683CacArBZeBitZxh5soE8RrY=;
 b=ATlAoMgsz9voUnMz+b1xLSwCiliG+FHICm6FlQQaymWBaXSjjSfO1v5rEgAON1/b7hFHpQ
 NCQf0cdZUU+Mduu8EFzXxlZXK30Es3hn+AxqEIT8/dSzwtNULsO45rt6VPaPfKmrgP70tm
 Eyp3wz6DIUza5AYYcUOUUtfbkgA+eh4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-vzQqgT-nPryujlJS5Zwxcg-1; Mon, 09 Dec 2019 09:44:05 -0500
Received: by mail-wm1-f70.google.com with SMTP id i17so3937919wmd.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 06:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qIxvmkrue2cTE6iOOQ2HHxg9X3QWCLMCv26POzpwbEY=;
 b=DRM3K33yEaJslNNSpDngKtrtNwNKXnRfVKLT7zIWwqv5qqXLwo94nsbuUFktyMtBxs
 ypyNpsWVHW2hMGT+vYX04eRVQ5T5vOzWZ/S4UJsos6nmXkXrsiD+xhJyaBSrbIxCgv4W
 sJRBAVQ2jXkIZtpXX843JE4hTeNu1omdsCNX2CQ3/wLim4i7nMIiWhVBMPNdLH1jOcu2
 ZCQ6LrifAVM8A7lp8RNv0csvtmzbwyaELDvCk5cO2iTrbShrblQwIq71ybnQmccdFMpq
 ZY5B1pve4TFjAcVh0rNOFqUIK3fBsQQXa4xJrH9LIzybJ/5LLtM57evk4UlPetCV5JmJ
 9AXQ==
X-Gm-Message-State: APjAAAW8cjLjScGp9p5opVXM3Nvz7QE+NlkBkS4fFT0w/M0GISakxOmB
 8QPj3tnhVXEWS7ygjXGBDjHNopck2nxuImMPqJQoD10pgmbEFpfGsVRW6FgTJdQ35Af/12XGr58
 biratgnbZhC+GtQo=
X-Received: by 2002:a05:6000:1052:: with SMTP id
 c18mr2596167wrx.268.1575902644443; 
 Mon, 09 Dec 2019 06:44:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqya0oNYb5xXPA/oIy+mOPWp80bvxQs4/FOKzChEDleg71CXlc/n8i8n7JriVGgx1+fcImIBcQ==
X-Received: by 2002:a05:6000:1052:: with SMTP id
 c18mr2596136wrx.268.1575902644187; 
 Mon, 09 Dec 2019 06:44:04 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id n10sm27352635wrt.14.2019.12.09.06.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 06:44:03 -0800 (PST)
Subject: Re: [PATCH] target/arm: ensure we use current exception state after
 SCR update
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191209143723.6368-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1042c399-0bf4-ef61-dec3-0c35822cf530@redhat.com>
Date: Mon, 9 Dec 2019 15:44:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209143723.6368-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: vzQqgT-nPryujlJS5Zwxcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 3:37 PM, Alex Benn=C3=A9e wrote:
> A write to the SCR can change the effective EL by droppping the system
> from secure to non-secure mode. However if we use a cached current_el
> from before the change we'll rebuild the flags incorrectly. To fix
> this we overload the ARM_CP_CURRENTEL flag for the register and ensure
> the new EL is used when recomputing the flags.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks! This patch indeed fixes my problem :)

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/cpu.h       |  1 +
>   target/arm/helper.h    |  1 +
>   target/arm/helper.c    | 14 +++++++++++++-
>   target/arm/translate.c |  6 +++++-
>   4 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index bd4d5b4445b..d2ef4644d8f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2262,6 +2262,7 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpr=
egid)
>   #define ARM_CP_NOP               (ARM_CP_SPECIAL | 0x0100)
>   #define ARM_CP_WFI               (ARM_CP_SPECIAL | 0x0200)
>   #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
> +/* Re-read the current EL, don't use cached values */
>   #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
>   #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
>   #define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 3d4ec267a2c..e345bdb726a 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -91,6 +91,7 @@ DEF_HELPER_2(get_user_reg, i32, env, i32)
>   DEF_HELPER_3(set_user_reg, void, env, i32, i32)
>  =20
>   DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
> +DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
>   DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
>   DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
>  =20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 489c31504a6..db2e33224d6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5179,7 +5179,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] =3D {
>         .opc0 =3D 3, .opc1 =3D 6, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
>         .access =3D PL3_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.s=
cr_el3),
>         .resetvalue =3D 0, .writefn =3D scr_write },
> -    { .name =3D "SCR",  .type =3D ARM_CP_ALIAS,
> +    { .name =3D "SCR",  .type =3D ARM_CP_ALIAS | ARM_CP_CURRENTEL,
>         .cp =3D 15, .opc1 =3D 0, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
>         .access =3D PL1_RW, .accessfn =3D access_trap_aa32s_el1,
>         .fieldoffset =3D offsetoflow32(CPUARMState, cp15.scr_el3),
> @@ -11437,6 +11437,18 @@ void HELPER(rebuild_hflags_m32)(CPUARMState *env=
, int el)
>       env->hflags =3D rebuild_hflags_m32(env, fp_el, mmu_idx);
>   }
>  =20
> +/*
> + * If we have triggered a EL state change we can't rely on the
> + * translator having passed it too us, we need to recompute.
> + */
> +void HELPER(rebuild_hflags_a32_newel)(CPUARMState *env)
> +{
> +    int el =3D arm_current_el(env);
> +    int fp_el =3D fp_exception_el(env, el);
> +    ARMMMUIdx mmu_idx =3D arm_mmu_idx_el(env, el);
> +    env->hflags =3D rebuild_hflags_a32(env, fp_el, mmu_idx);
> +}
> +
>   void HELPER(rebuild_hflags_a32)(CPUARMState *env, int el)
>   {
>       int fp_el =3D fp_exception_el(env, el);
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4d5d4bd8886..59213310065 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7083,7 +7083,11 @@ static int disas_coproc_insn(DisasContext *s, uint=
32_t insn)
>               if (arm_dc_feature(s, ARM_FEATURE_M)) {
>                   gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
>               } else {
> -                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
> +                if (ri->type & ARM_CP_CURRENTEL) {
> +                    gen_helper_rebuild_hflags_a32_newel(cpu_env);
> +                } else {
> +                    gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
> +                }
>               }
>               tcg_temp_free_i32(tcg_el);
>               /*
>=20


