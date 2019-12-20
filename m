Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BFEC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CA12072B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOOrM25Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CA12072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMdA-00033t-HM
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMbg-0002EL-U5
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMbf-0008Jo-QV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMbf-0008Hw-Ix
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so10267779wrt.6
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dv1yFttuiXS+ut0laV3Oiqerh+62kUhy9d6Be+DoKTE=;
 b=WOOrM25ZvDQGLG7VGo2h4PVr++1WWjQeKr2V3fGr2/dWwJRWYemEDpY2IH9J6vij5k
 U4lklaIlGLzZ4IHSp9DeKojI3KmP73hRzxvoODrBbOuZ08o5hSnjeHg5YEni4s0xAe9+
 K9lkuTFzm7GdLLvDo9NBe6ZudGcH1icrpJKxNe2hX61rz6N0VfMbgM0HO8dfPiDDn0VT
 Yqt+xjCyU08uDUsKxbIHbIKW/QNXGUifUnNUQEPc3Uv2Sstn3zLIpOtBBIE1mP4C0aYh
 F5/P+0nlVTZm+OQW0gBkyVDO2OTIvtlYN+BpXLnkMvSQ846bRwgJqckf3apBTatS8oiP
 3TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dv1yFttuiXS+ut0laV3Oiqerh+62kUhy9d6Be+DoKTE=;
 b=IOx0FUPi2Ws+XZ2YSWJwLEsT+OUYbHQcj3poWmcC4y5N4SBGU5mXG1LTFgmnOIdbKw
 iPxc9NOtzgnwrj//9Nzro0iTZvna5sh1R2XPEQkXMTqtzwO0+YGK9nSCNokwKq/wbEyN
 LWGxv0zB+/t8Xm0vwwxqiAXZOfXjiiL7yZg0q0yOldYZSqnPvdJTsx0+Fr6+1oO8d68S
 XMm26xaVEdNmg9CZBfKnLdPPuUJjTpg9IOkntYw+QZk05U+m7jj7QFLguYLUw3JM8mFt
 MgQrvu+kkMKE0+48en/hDQ6fHeGVyn1btBXdXUT/HgG+oMNIdUeYNHE83nvjasAsEkiK
 caKw==
X-Gm-Message-State: APjAAAVdJ6I2q3bDvkthNYhLOwoMcawzFk1lB2oFdFNGNis39KKX7A1d
 QcL8LMoXnr2CVqxsMLvV4gpS2Q==
X-Google-Smtp-Source: APXvYqxTK7riHyHEYYvUdrWZXr+9vaOnuQKsHCQ9O9fnBz1revxAoToHwUgJguPzNSkjh6U315BtuA==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr16029935wrs.330.1576864950367; 
 Fri, 20 Dec 2019 10:02:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm9937435wmi.25.2019.12.20.10.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:02:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C3651FF87;
 Fri, 20 Dec 2019 18:02:28 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-16-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 15/28] target/nios2: Remove MMU_MODE{0,1}_SUFFIX
In-reply-to: <20191216221158.29572-16-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 18:02:28 +0000
Message-ID: <877e2qdgej.fsf@linaro.org>
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The functions generated by these macros are unused.
>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/nios2/cpu.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index 361b06ffeb..78f633f970 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -217,8 +217,6 @@ void do_nios2_semihosting(CPUNios2State *env);
>  #define CPU_SAVE_VERSION 1
>=20=20
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _user
>  #define MMU_SUPERVISOR_IDX  0
>  #define MMU_USER_IDX        1


--=20
Alex Benn=C3=A9e

