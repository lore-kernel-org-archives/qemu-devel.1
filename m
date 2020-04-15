Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C9BC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75F920857
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zma1R5GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75F920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjjN-0000Qe-UV
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOjiN-0007y2-A6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOjiL-0006nU-TS
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:12:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOjiL-0006mw-IS
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:12:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id k1so290348wrx.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ojil0rocTue9e/JMOsBzVdWCw9mHL1kYa+RqLeiGsVw=;
 b=Zma1R5GS2gLZm2SB0Xe3/lhp68Slgiq1AQec/GT9KMiu2CxfTcxvSfARtPS1hhhVcs
 SkGJhgpb4HF6VWAXIJ1pDpBZlkCg5f4vwpGSoglfDqWR64j3zo0+xZvEQpwxrEr2tC+g
 UORuAfNcitx9Ozf6YX2DEsonCbWWaRQEEF2W0rdgMVseyZKy11EV7AfAcL8p2liAYpun
 0VwwpyfjEsNHf1fE1Il5TRTEUF6rZ07/IiD3avfx1RC5Vu+neJfqeVbClei7ARdTWkHj
 ZKmy3D/GMyiZCvB0jQseGuLs07TykSzooR62ieDNRG95cO6I19S0PIpe02JyvuLcnD64
 lq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ojil0rocTue9e/JMOsBzVdWCw9mHL1kYa+RqLeiGsVw=;
 b=kEiSTx+q+q8krd2nvApT1Tv/7hVr71dEhVm8Ob4S+phFYRWB3fAIK2QT30RoBLBBdU
 Ma/9pRBasjsmz3bHR+/XGiBpklXnCYxNe1mgOrYblPwgn+eAMjKt0p6pWOEnydF1YLBQ
 PeyhPXkBF2AATknjpU/tnSi6sObT4XpwQkU+mRVA9Nmd+MwfwEIhZAtyv81RLenDKc9G
 DlRYaXmUry0BShURB4aKHfxYiRjjYGzeIjnvXvviXoe7A5GiMnJpQ3yMq8saW/QMg/kE
 kEQAEPF7jLr13PknUGG8slIjCsjChr4H5J+Pd11/nC0V8nRiyH2f20R3c7p8b1ruMWoJ
 Tk6g==
X-Gm-Message-State: AGi0PuY6r7ylgLo2xtzrADtiWbXSF3Vx/TbRYjeFoCtpsl2Ws+xOMH9E
 8k+j1Y2Khu7HwtRg0GfXCn/FZA==
X-Google-Smtp-Source: APiQypLJEdCBOygZV3wKJz/E6vW7FyGyLFokGIImgw4FeYifJOaFNypvdfoD5iv1AQZXlL4O3AZjAw==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr11003595wrt.191.1586963552013; 
 Wed, 15 Apr 2020 08:12:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 19sm15355193wmo.3.2020.04.15.08.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 08:12:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 87A681FF7E;
 Wed, 15 Apr 2020 16:12:29 +0100 (BST)
References: <20200414120935.12719-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [for-5.0] Deprecate KVM support for AArch32
In-reply-to: <20200414120935.12719-1-peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 16:12:29 +0100
Message-ID: <873694hjfm.fsf@linaro.org>
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The Linux kernel has dropped support for allowing 32-bit Arm systems
> to host KVM guests (kernel commit 541ad0150ca4aa663a2, which just
> landed upstream in the 5.7 merge window).  Mark QEMU's support for
> this configuration as deprecated, so that we can delete that support
> code in 5.2.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> I was reading the 5.7 merge window writeup on LWN this weekend
> and saw that the dropping of 32-bit support had gone in; just
> enough time to squeeze our deprecation warning into 5.0 so we
> can drop the code in 5.2 rather than 6.0...
>
>  docs/system/deprecated.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index c633fe2beff..3142fac3865 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -336,6 +336,14 @@ The ``compat`` property used to set backwards compat=
ibility modes for
>  the processor has been deprecated. The ``max-cpu-compat`` property of
>  the ``pseries`` machine type should be used instead.
>=20=20
> +KVM guest support on 32-bit Arm hosts (since 5.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The Linux kernel has dropped support for allowing 32-bit Arm systems
> +to host KVM guests as of the 5.7 kernel. Accordingly, QEMU is deprecating
> +its support for this configuration and will remove it in a future versio=
n.
> +Running 32-bit guests on a 64-bit Arm host remains supported.
> +
>  System emulator devices
>  -----------------------


--=20
Alex Benn=C3=A9e

