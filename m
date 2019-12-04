Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334DAC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BF12081B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xlk6LghY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BF12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTkv-000612-2M
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icT9i-0002Ld-Bk
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icT9J-00037x-QL
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:48:58 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icT9C-0002Hp-7i
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:48:49 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so8212073wrh.5
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yS48uREcrBvNMuN4+7FJ6JfgHP0kQVgn5b7i52RXCc0=;
 b=Xlk6LghYjMQfZBYEESNKRhwKQI3VD8nRKjQw2E8VUsLbsS28ZSGJGyteKWKIumNVtj
 b1KJ5Jj3fTochtDOyqrxy1QxiyeGq9itlAEgJE8xi7uE4Hj0JbeS5Zn/6FaCwXN2WYpi
 G7hzm8b6lUX0IjMLLhOkKbZPbUk2t4a5PRdAH88O/B2QVjact5aUe1ayUFODmA4upKD/
 XFVVt4U3A7iQbv8kNj24x6t6iOL04avo7iwYLr3W9Hkzjj4ggvUhjLpagBWEN8grLPBR
 RKGbZ87QVtq//UV3HXbw9zWhhUZPgoIFfBKlcSaGQdO6D4/ZD6bCcKya4C8NGTmlLijG
 mCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yS48uREcrBvNMuN4+7FJ6JfgHP0kQVgn5b7i52RXCc0=;
 b=FSZx372u9Qt4Ku0pmbg6PchbnGuproLwsghQWQ0CO1OtCtIMMIdn+U2hjJrv+G+zIM
 9EJOz5DLfiHBeb6iRBEsOCi8FPCS5kZM8X2V5fvjgpnzB9376dUSR/ChmMKue2Qa3qfe
 qs3j8k9l8+AXfC2oPJFpZYxUGr0Ze34UUCALO3JPWaT1gsn2zsW8tbkEkSVBVtarkai5
 T0Djg9rP3yky8CO32rhWFc4SHEojbRmblC/Gsf3uoUxzqtKzIOzeiduWBPTH4bm0jdBi
 ix/4vw5Hfy79P4J0Dh2GX+AzgEs8EzeCHVfU8GHln9IUMYuzAgKVeohRSai7lIQjWPU+
 Yxcg==
X-Gm-Message-State: APjAAAWB3gtYC8BAweLJ2RjktAD+YZ0lJRjWceIuWDW19iYvpKzujyqJ
 G0wGDcsHXPMULq+iLPXH7z6ayA==
X-Google-Smtp-Source: APXvYqyQWCEn2/8GxRhi/X9zB14lpG+NpTOgyYsz5xd0oa0Z42P1THefMI7KycJgfEwZ/h2FjVijng==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr3673861wrr.306.1575460121177; 
 Wed, 04 Dec 2019 03:48:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z18sm6393475wmf.21.2019.12.04.03.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 03:48:39 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADC2E1FF87;
 Wed,  4 Dec 2019 11:48:38 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-16-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 15/40] target/arm: Expand TBFLAG_ANY.MMUIDX to 4 bits
In-reply-to: <20191203022937.1474-16-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 11:48:38 +0000
Message-ID: <87v9qw8g6h.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We are about to expand the number of mmuidx to 10, and so need 4 bits.
> For the benefit of reading the number out of -d exec, align it to the
> penultimate nibble.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ae9fc1ded3..5f295c7e60 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3176,17 +3176,17 @@ typedef ARMCPU ArchCPU;
>   * Unless otherwise noted, these bits are cached in env->hflags.
>   */
>  FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
> -FIELD(TBFLAG_ANY, MMUIDX, 28, 3)
> -FIELD(TBFLAG_ANY, SS_ACTIVE, 27, 1)
> -FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)     /* Not cached. */
> +FIELD(TBFLAG_ANY, SS_ACTIVE, 30, 1)
> +FIELD(TBFLAG_ANY, PSTATE_SS, 29, 1)     /* Not cached. */
> +FIELD(TBFLAG_ANY, BE_DATA, 28, 1)
> +FIELD(TBFLAG_ANY, MMUIDX, 24, 4)
>  /* Target EL if we take a floating-point-disabled exception */
> -FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
> -FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
> +FIELD(TBFLAG_ANY, FPEXC_EL, 22, 2)
>  /*
>   * For A-profile only, target EL for debug exceptions.
>   * Note that this overlaps with the M-profile-only HANDLER and STACKCHEC=
K bits.
>   */
> -FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
> +FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 20, 2)
>=20=20
>  /*
>   * Bit usage when in AArch32 state, both A- and M-profile.


--=20
Alex Benn=C3=A9e

