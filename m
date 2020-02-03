Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E908C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB42F2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtleO4Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB42F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyclX-00049k-2L
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyckL-0003D3-OI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyckG-0002yL-LR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:30:41 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyckG-0002xB-DJ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:30:36 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so17381135wmi.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+iTglhIxnmmsQsF1wqSdk2u8VExqYqieQph0F+n+LM4=;
 b=vtleO4Lw/atZ4g0sO8LZ/lw9LQjml9kPzDwHIRAlug+Oaxp2TH7he8K/PCWwH5qqpv
 q1EK8XEaCDqYWLWyd/XNtFLAm/IiTu+SM7qi5/wOXW+UPSUW4bDGn+9Opst0jRkX1Ug5
 C7lomXsSYSrJ47teyfYACHMXbyuJE9bCvkJy7UEFU7w/nB5qpyzCQEcwkwVnqtjt0Zyr
 pGtUfpwYsfHoyelaexR8q4rp3tSjWppoVlnp0/p3G4KDmIIpCUXIi5de968eAbAdOQ0d
 MI12gdhsIGVEr0+bAr7+PB+2MC8+kmWZmw6oCve5e4aeNdYUGA/Y7esYAesij9mC8Gdf
 NSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+iTglhIxnmmsQsF1wqSdk2u8VExqYqieQph0F+n+LM4=;
 b=jFv4yJ9u2V97X3O4tqxwqdVoHCxvu1yAXDkjIavJ2icuGc6zGoSgWxVHA3EUHpDpy+
 isvYo42gWLi8O0jy4BhhxiIRvqRmjhqy04NhHxhGpgW+YXYjnc5k8m3XH553mW+yUgum
 GBqrLbYnUvewSEn6FAwcArba7vQp5K+Hxn8E5lRn4vhDdqWNLX18ZXjdwg4Z3Av91KVu
 rU7u3q55p6+5sAzCo2DIGMjEmcpwF1A3LEo2d0mABoyB+SmaqkI2EeoUV7P9OiNKkwDh
 hRzPsYgPg7T7fG72pMOqJiciN2VCLJJ/6mjgyVN/t6pUvMyz23GMaVr+qP07pUQREgu3
 PbVQ==
X-Gm-Message-State: APjAAAVWzJswgJDkq2+AFbiDlpEDgPEOdRYZ88xzummLsJzDWigrm/4D
 /BEZZ4dJDAao8rOV4VJWi92wtw==
X-Google-Smtp-Source: APXvYqwmv1JsH4ieWInAm38O4I5Fn4kTF9c/8k7uSonJIME3boNTlqKBPVemnkypE9HbhpohncCQMg==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr29040418wmk.67.1580740234998; 
 Mon, 03 Feb 2020 06:30:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z3sm8623116wrs.32.2020.02.03.06.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:30:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC2441FF87;
 Mon,  3 Feb 2020 14:30:32 +0000 (GMT)
References: <20200202010439.6410-1-richard.henderson@linaro.org>
 <20200202010439.6410-8-richard.henderson@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 07/14] target/arm: Enforce PAN semantics in get_S1prot
In-reply-to: <20200202010439.6410-8-richard.henderson@linaro.org>
Date: Mon, 03 Feb 2020 14:30:32 +0000
Message-ID: <87eevbagl3.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> If we have a PAN-enforcing mmu_idx, set prot =3D=3D 0 if user_rw !=3D 0.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/internals.h | 13 +++++++++++++
>  target/arm/helper.c    |  3 +++
>  2 files changed, 16 insertions(+)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 6be8b2d1a9..819de9037f 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -893,6 +893,19 @@ static inline bool regime_is_secure(CPUARMState *env=
, ARMMMUIdx mmu_idx)
>      }
>  }
>=20=20
> +static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_Stage1_E1_PAN:
> +    case ARMMMUIdx_E10_1_PAN:
> +    case ARMMMUIdx_E20_2_PAN:
> +    case ARMMMUIdx_SE10_1_PAN:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>  /* Return the FSR value for a debug exception (watchpoint, hardware
>   * breakpoint or BKPT insn) targeting the specified exception level.
>   */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 638abe6af0..18e4cbb63c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9578,6 +9578,9 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx m=
mu_idx, bool is_aa64,
>      if (is_user) {
>          prot_rw =3D user_rw;
>      } else {
> +        if (user_rw && regime_is_pan(env, mmu_idx)) {
> +            return 0;
> +        }
>          prot_rw =3D simple_ap_to_rw_prot_is_user(ap, false);
>      }


--=20
Alex Benn=C3=A9e

