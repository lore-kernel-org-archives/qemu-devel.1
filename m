Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F835C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C06A20675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeZmlHts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C06A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgOk-0001oL-G5
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBgHT-0006h9-SJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBgHS-0001b3-Ox
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBgHS-0001Y7-Il
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id x3so952818wmj.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pTvmK3jYPT6Iu41FZrT0VvBC26o8xE3yr2kPNA4NW7M=;
 b=PeZmlHtsxP1cn7UT966EC6ulbyYKYfVxLnFgzfwVBSW8S9ka81578w+OPRMd5DzyFF
 xmSoDoXcF3EWT1QIFD7LJ2L7ACl+HpniZa+ogp0/UOoGORS/yo+aYZz6ZWpienrRh51K
 dze8n3E8pQP2FP+Nw/1rjdV1Ia0YcMILwHUt4BTvSsHcTcw76GPzpL2sm9tHyIXqGp5+
 O7cID3W7IPgoHwDR1WoHgNs+/i0fzFwjb8KFOcc18iuVwDGEdEVGNaVFYxSYJ8IMxg6R
 c1bb7NaXR4yf+iGoBnicui6aoe8zD2PfKygF/chWq88ZdSX7mjRz50YQ1rCrxBVfM3DY
 Uqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pTvmK3jYPT6Iu41FZrT0VvBC26o8xE3yr2kPNA4NW7M=;
 b=HtCJxND3F5/AN9wUjXAZhX7pUuQNYZmtcx+70+ucR4rdMl8vUhgKbcWcW3WrNU9QOG
 jhDlMNkoTo9p99dc97PBM/kVR/6cXdeu2qdSsKYgDVRhZlwqJ0Awam7kHb1TKOgciOo2
 kqzI8PRpWsf4q9+D+EkEjv3jFXPm0KOZL9QEC/XKlQLk9+Dpu/RsnGDRPhM5+7N+SBk9
 ig0eaJbhfF/ULyERv1fv5P7bOZc6GrDvpm7knFEELl6VtRjjMNTKPcASNr7ywxNTAWp1
 z/3bNJ5PAukjbnrqODO0CdhML5HVIz87tMDFk7tSGqpKwsJIiuZxmlp/OqgWmcDGCG4X
 XEDg==
X-Gm-Message-State: ANhLgQ3uxRlUAwPNJxKLjSUOU6dRatfSWbuXFpGXxnSa6aRJzHc2TGjc
 IcecZx+dEUO3gB3ZAgQvOURESw==
X-Google-Smtp-Source: ADFU+vvVWy1t1hLUVNE5ZvnlzUFGScmZZO1YePhwcygIeWEJ32UqoYWQmUHOqpNf3nVrz5HdmGktCA==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr2430449wmi.37.1583852089425; 
 Tue, 10 Mar 2020 07:54:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w9sm28780055wrn.35.2020.03.10.07.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 07:54:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 81FEC1FF7E;
 Tue, 10 Mar 2020 14:54:47 +0000 (GMT)
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-5-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/5] docs: Move arm-cpu-features.rst into the system manual
In-reply-to: <20200309215818.2021-5-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 14:54:47 +0000
Message-ID: <874kuwi7k8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Now we have somewhere to put arm-specific rst documentation,
> we can move arm-cpu-features.rst from the docs/ top level
> directory into docs/system/arm/.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .../{arm-cpu-features.rst =3D> system/arm/cpu-features.rst} | 8 +-------
>  docs/system/target-arm.rst                                | 6 ++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
>  rename docs/{arm-cpu-features.rst =3D> system/arm/cpu-features.rst} (99%)
>
> diff --git a/docs/arm-cpu-features.rst b/docs/system/arm/cpu-features.rst
> similarity index 99%
> rename from docs/arm-cpu-features.rst
> rename to docs/system/arm/cpu-features.rst
> index fc1623aeca5..7495b7b672b 100644
> --- a/docs/arm-cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -1,11 +1,5 @@
> +Arm CPU Features
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -ARM CPU Features
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Examples of probing and using ARM CPU features
> -
> -Introduction
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
>  CPU features are optional features that a CPU of supporting type may
>  choose to implement or not.  In QEMU, optional CPU features have
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 86ea6f2f568..1425bd5303a 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -78,3 +78,9 @@ undocumented; you can get a complete list by running
>     arm/stellaris
>     arm/musicpal
>     arm/sx1
> +
> +Arm CPU features
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   arm/cpu-features


--=20
Alex Benn=C3=A9e

