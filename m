Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E37F20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2sLDM2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E37F20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv55f-0001BR-Gi
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 14:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv552-0000fh-Uh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv551-00012D-RZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:57:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv551-00010R-KQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:57:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so3468634wrr.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 11:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6nqbfgboS0nYe8Fhx62nOwA+X8vS8dwz4519fr3gj6o=;
 b=R2sLDM2RJmysVh8GYYA/dFaERJ18mF7ahW2Ku/4+8VVsZ/EP7GWa3JiUXTQLaCg3SV
 9TV3OnKrJEWVZ7PxZln8hxIoXyOzs1zLQIT3baVbQyzH37hflz+cNI4GftLRldjsSC8z
 QSG8ZHWpKh9ih854Inb0NvLmxnvOEJzcGK/8eFPU8YKKM6j7dXnnu5yd4tOR2LkZQk7o
 qQxKIAN9ijbrMDY0usXG1Jv3CNolFQU5wkJ4M2eHGGd/YpG1vlnHbC0TpG7gB75NGCQo
 LFdUfdWLjyY62ZCdaCB/msHr3eb1rx8W7F3SFpxaeMhINSju2VcCh3W/5qroaen0D8Ay
 LUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6nqbfgboS0nYe8Fhx62nOwA+X8vS8dwz4519fr3gj6o=;
 b=s76snm/thQo+7iO5YsBPRKOy6A2TjRHkz/8T1Ef1pNR9ZEbxPwa3smxgkH3MFcdkQC
 joFt5x16K66weQg8Rsjv6g/FZaikHq3vy6+8py9qfFcU5FKWKXrTEiz7U6J+s69LPjWZ
 nnT0WyYua7t8lYzzMvRWOTNOSF5XLzUTUvvbH/TS9cL37sSDVGy0pDRyulRuaGXCnYtw
 +wIOjrbLNwugqKTrThkP+va8Cfv3Dcc/IpQkYeHkjVGWkADZiKGgRGql9An3jDHrGmR7
 buqaJohiHfQmvid5oHwXuxr+a6i/ed9EhWhGMACnTyAh5sZdn2C67fgZHqYF+6HKFINU
 BQ4g==
X-Gm-Message-State: APjAAAXJYYezsJnahtuQdRiRO8YtMKO97OpcZkkY4ye1VpffpwnWWo6Y
 aCbVchSeKy/MTMev5lnwyTrtrw==
X-Google-Smtp-Source: APXvYqxgK4/gGh8ww0S8/ZZR1x9v4pgv1vGPEPFtUY8lQr/hN1g2Wmsp9U5nLXsLl4oOHv+iNu5YhQ==
X-Received: by 2002:a05:6000:1044:: with SMTP id
 c4mr6539908wrx.204.1579895842140; 
 Fri, 24 Jan 2020 11:57:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm8596106wrr.80.2020.01.24.11.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 11:57:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 580E71FF87;
 Fri, 24 Jan 2020 19:57:20 +0000 (GMT)
References: <20200124172954.28481-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm/arm-semi: Don't let the guest close
 stdin/stdout/stderr
In-reply-to: <20200124172954.28481-1-peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 19:57:20 +0000
Message-ID: <87zhec8w67.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

> The guest can use the semihosting API to open a handle
> corresponding to QEMU's own stdin, stdout, or stderr.
> When the guest closes this handle, we should not
> close the underlying host stdin/stdout/stderr
> the way we would do if the handle corresponded to
> a host fd we'd opened on behalf of the guest in SYS_OPEN.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/arm-semi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 788fe61b51a..8718fd01948 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -403,6 +403,15 @@ static uint32_t host_closefn(ARMCPU *cpu, GuestFD *g=
f)
>  {
>      CPUARMState *env =3D &cpu->env;
>=20=20
> +    /*
> +     * Only close the underlying host fd if it's one we opened on behalf
> +     * of the guest in SYS_OPEN.
> +     */
> +    if (gf->hostfd =3D=3D STDIN_FILENO ||
> +        gf->hostfd =3D=3D STDOUT_FILENO ||
> +        gf->hostfd =3D=3D STDERR_FILENO) {
> +        return 0;
> +    }
>      return set_swi_errno(env, close(gf->hostfd));
>  }


--=20
Alex Benn=C3=A9e

