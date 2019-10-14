Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B91BECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E456E20873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TO6Dy4C3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E456E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4IK-0006YO-33
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK34j-000755-J2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK34i-0007oM-Cc
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:20:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK34i-0007nL-5n
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:20:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id a6so17883050wma.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DmW9G6FZcAKdMaM6SQSmwramiRS1r47zdy8/Hdwn1QA=;
 b=TO6Dy4C3jNa1txYX4OysXUVqfoC0PHIvqVY0gB3T3HtkXLj8FsDIJIyNbud9y7uMRR
 8XoFcO+/nIR1KoZZeY4d9Z/m7cOKagGrQ5iEwoR8miZt27/Wx3S8Q2Wp9oXfKF/oX62S
 FeSpuG8ucZeLShXnK9PCXDC12DV/JmqIhPsEVexuunsxT1dvCYFlR3nOrk6ozmaNkrmk
 CKpspaOhKQT18JgqGx0kvmgS5beYYzJfo941GJX+qTLBIwBrUJ8n1oLGw1REPVxc1+kt
 gTQnDPoAupZ1gMIaPPJpDITmwJ0OfNKd46MC0+i/38BW1K5LgtKky5opThgrh+b+6+PY
 OHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DmW9G6FZcAKdMaM6SQSmwramiRS1r47zdy8/Hdwn1QA=;
 b=DGO447xcotnbUPtA+wE+tijywD5ysrMbRA/RvLdtV8cMzpaS/UudjFQa0JPp2Zpc+1
 MLJrcg971ZiTcAJWeIj3GX5qLA++piHZv4p6zE/2JC+KbQtjWNYBMp8DXsT9knFG47eZ
 DwfQyHvWyvN1/zKGv0UKDP110qpcVwmHvcivdFSS/t3ew/ziCHr22yUnC670sLFvtvLQ
 Xt81nKZVBcSyJAiw4fMefsjJItO/sciWbeCRGcojNzWwjwK//YYSHMal988DgNLo40/G
 EmtWJVSM89QymzlIp9IjyfJ38VRQ7DSwjZ6yX3YUgQ52/PuTLpZ4K/LX/sZZpmOjKV5z
 1Juw==
X-Gm-Message-State: APjAAAVpNzgzIipp7G30CDHl9PKwJCGmPNfzUCcrkA5NiWhjoDTSVAwf
 V8dOT3TMMcGD3k8KzGPjh/u5Uw==
X-Google-Smtp-Source: APXvYqzwfdZ6bHfNpeIxIZGq1oQ8JlFJbO7x91ojZr+f3fjyof+3pct428qFA0V/E9tv2Kk9yNfTbA==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr16036951wmc.29.1571069999032; 
 Mon, 14 Oct 2019 09:19:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n18sm15852220wmi.20.2019.10.14.09.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:19:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C44611FF87;
 Mon, 14 Oct 2019 17:19:57 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-9-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 08/20] target/arm: Split out rebuild_hflags_aprofile
In-reply-to: <20191011155546.14342-9-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 17:19:57 +0100
Message-ID: <87mue3mh8y.fsf@linaro.org>
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Create a function to compute the values of the TBFLAG_ANY bits
> that will be cached, and are used by A-profile.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d1cd54cc93..ddd21edfcf 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11106,18 +11106,28 @@ static uint32_t rebuild_hflags_m32(CPUARMState =
*env, int fp_el,
>      return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
>  }
>
> +static uint32_t rebuild_hflags_aprofile(CPUARMState *env)
> +{
> +    int flags =3D 0;
> +
> +    flags =3D FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL,
> +                       arm_debug_target_el(env));
> +    return flags;
> +}
> +
>  static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
>                                     ARMMMUIdx mmu_idx)
>  {
> -    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
> +    uint32_t flags =3D rebuild_hflags_aprofile(env);
> +    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
>  }
>
>  static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>                                     ARMMMUIdx mmu_idx)
>  {
> +    uint32_t flags =3D rebuild_hflags_aprofile(env);
>      ARMMMUIdx stage1 =3D stage_1_mmu_idx(mmu_idx);
>      ARMVAParameters p0 =3D aa64_va_parameters_both(env, 0, stage1);
> -    uint32_t flags =3D 0;
>      uint64_t sctlr;
>      int tbii, tbid;
>
> @@ -11262,12 +11272,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>          }
>      }
>
> -    if (!arm_feature(env, ARM_FEATURE_M)) {
> -        int target_el =3D arm_debug_target_el(env);
> -
> -        flags =3D FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL, target_=
el);
> -    }
> -
>      *pflags =3D flags;
>      *cs_base =3D 0;
>  }


--
Alex Benn=C3=A9e

