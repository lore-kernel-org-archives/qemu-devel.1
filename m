Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE6CC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FF9205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMrW34h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FF9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVnd-0005FL-AI
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icVm6-0003lz-9y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icVm5-0004gD-22
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:37:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icVm4-0004eK-PP
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:37:05 -0500
Received: by mail-wr1-x443.google.com with SMTP id t2so8920675wrr.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qGFBFQBNkpPulheKDaQwWbMxhS7VSvK6frDw7Pu6SWU=;
 b=OMrW34h6PrR/AoXg7IcYD/9+RZllLqna2fCNqXgk7MOpBKFhTok1zJgsFFxmlYrENB
 W2RhkfytML/XDds+i7j1oZ3PdyVQ+4p3P4ijji2qPVOUGlolvn9nDMHT2IRAVuD0QIJ9
 MKU2GDLnirJgzODalsFHd0VhJmSWK9Alc3apACtZyv5fh8O9s9UXatkuDPzmz7pom/1z
 HXg707ktR/piEsroBteXfaWwwQy+khm0xCLaVISzg18B0fqBBUEXiBP9XfcQNd8BTfTz
 2hcScy8aJ4LIlK2MsUD0z3SL2cAPiGZLWe9GC9/gySFq7AByqoXH0b0zUaNjx/YjJLMv
 JwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qGFBFQBNkpPulheKDaQwWbMxhS7VSvK6frDw7Pu6SWU=;
 b=fOFmAK1gDxI4qcorcGU5hwylZrEQNEemtXF57AFp/j0RujZF2ZKA4mFbH1GQnW3x6T
 3cj6PK0hDCf6ueDtwFRlJmYMKYsB/iwo0R9lJuYr8uRPYJMalJu5KuDwntHf2I0cKT7f
 iBWZ3tm0I1kHhskzFmoM3snUyOC65mZHUPJepQH6g3OKLmsLhXhZco5T3KBV28/0qoiR
 XJowYvxmeukC3rk8Es/7gU8y4Idcf9T/veZ43KiPP1TaI7mjVypg3+WfREjkk5gIprZw
 N4BVh8tDPly8WxDQvM6g1iRnGBlYbaSoq65A0NXerGSKXn4v+5PZ/dMGID2rgUFGw/26
 K7OQ==
X-Gm-Message-State: APjAAAVPheYM3ZvMubH1dFBM9LcGX/pusbzIYvAkOmGTc+5KIpSev3Qd
 HtMEY9hjS55q9w7RosIMPp196A==
X-Google-Smtp-Source: APXvYqy1+rTgXk1MVYHrLwR+dIfjjyORM3zDobK7muRZL9fQvlahrnz5BfhgIq9N0rwq3YqdFvJcNQ==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr4490612wrm.241.1575470223273; 
 Wed, 04 Dec 2019 06:37:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l204sm7218176wmf.2.2019.12.04.06.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 06:37:02 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A6EB1FF87;
 Wed,  4 Dec 2019 14:37:01 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-21-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 20/40] target/arm: Update arm_mmu_idx for VHE
In-reply-to: <20191203022937.1474-21-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 14:37:01 +0000
Message-ID: <878sns88du.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Return the indexes for the EL2&0 regime when the appropriate bits
> are set within HCR_EL2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 27adf24fa6..c6b4c0a25f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11172,12 +11172,16 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int =
el)
>          return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
>      }
>=20=20
> +    /* See ARM pseudo-function ELIsInHost.  */
>      switch (el) {
>      case 0:
> -        /* TODO: ARMv8.1-VHE */
>          if (arm_is_secure_below_el3(env)) {
>              return ARMMMUIdx_SE0;
>          }
> +        if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) =3D=3D (HCR_E2H | =
HCR_TGE)
> +            && arm_el_is_aa64(env, 2)) {
> +            return ARMMMUIdx_EL20_0;
> +        }
>          return ARMMMUIdx_EL10_0;
>      case 1:
>          if (arm_is_secure_below_el3(env)) {
> @@ -11185,8 +11189,11 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int e=
l)
>          }
>          return ARMMMUIdx_EL10_1;
>      case 2:
> -        /* TODO: ARMv8.1-VHE */
>          /* TODO: ARMv8.4-SecEL2 */
> +        /* Note that TGE does not apply at EL2.  */
> +        if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
> +            return ARMMMUIdx_EL20_2;
> +        }
>          return ARMMMUIdx_E2;
>      case 3:
>          return ARMMMUIdx_SE3;


--=20
Alex Benn=C3=A9e

