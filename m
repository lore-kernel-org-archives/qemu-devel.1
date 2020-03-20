Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86FDC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A2520709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzuOFCGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A2520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIm4-00057L-Kh
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jFIlD-0003iJ-Pa
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jFIlB-0000pG-Cv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:36:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jFIlB-0000n7-64
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:36:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id j17so4340027wru.13
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uGGGqQcX+K5z8RVQc5V4M1PpO+4xmpbqkPeyuEjlhDA=;
 b=LzuOFCGdbKXTgfDmCuEoPkIgp+dTfAPoEA/EV3Mg3nuREII2GJH/+2aGxTO8rwva/k
 +VF6jY9TjKNP2rFXqwvbQwGwoSn2Eb4v8fCzEgWnmJdVQ2cXnC5qkloZ7j21/0UXlCMV
 9u/e19SyI9W06UKFnPAYti8QVgw0JT0u9qWlrsubOTwHOTUT8kNTHEnMElXqiV597o1l
 /eYTGYA4yf98+U9qwm9Pguo9hQsYt0p5uOikGjXm62pplXvPB6IaZn+H02Dn9d2GSrZQ
 3iq10vHMQSqRpJ+O4urm1G3bte4r4+G4yjlBv0xjDfvsVOuRDAblOhebe5qOxm0jzg5B
 AFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uGGGqQcX+K5z8RVQc5V4M1PpO+4xmpbqkPeyuEjlhDA=;
 b=oW9FPo0FdMBVNNkNTmS2Csh5E2XJG4nXQWAAtdeFOB1XbenZ59vUqbqj78stPg/WbC
 aq2ij4C5iLzuievBV26R0kS0knCHmCQV2z+yIUVLEkmH8QbKI0i1n3YH//hccN9w2IPI
 HnOY/MHjfgXUgwNQ9A+z6tyWu36EdnG0hmqKlJD4pkeUy7FCS9nD2mJ1zckPYwRpv0nE
 p/JWXV2tX31f3ZGK5+hic7v49EOYm5/KWQeSg0nB1km1+fjwjh/axFL76W8u3GUIwbjY
 YeEwFcKxZLW40l9/kMeujh1jfgdcCVS9TYQVnnSBmKVSxmzA/9rfPZ3IDie86orEVWQm
 l73w==
X-Gm-Message-State: ANhLgQ1jA4lrxumvB+mSbSWpzsgwfBAjandCautVO4k7ERLLqqGjbGGw
 5hK4Rt8G8C/ny2Z/1rtMxys6KQ==
X-Google-Smtp-Source: ADFU+vscXlV7AE4ydx6d0nDAg2RcCrMig82ExEWP017gPgWQC45HD68e6eD4Sjo9lveKKJSYt0jxgw==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr11474483wrs.339.1584714987788; 
 Fri, 20 Mar 2020 07:36:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w204sm8456262wma.1.2020.03.20.07.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 07:36:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 885761FF7E;
 Fri, 20 Mar 2020 14:36:25 +0000 (GMT)
References: <20200316112006.19107-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Update copyright date for user-facing copyright strings
In-reply-to: <20200316112006.19107-1-peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 14:36:25 +0000
Message-ID: <874kujhz4m.fsf@linaro.org>
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
Cc: John Arbuckle <programmingkidx@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Update the copyright date to 2020 for the copyright strings which are
> user-facing and represent overall copyright info for all of QEMU.
>
> Reported-by: John Arbuckle <programmingkidx@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu-common.h | 2 +-
>  docs/conf.py          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 082da59e852..d0142f29ac1 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -13,7 +13,7 @@
>  #define TFR(expr) do { if ((expr) !=3D -1) break; } while (errno =3D=3D =
EINTR)
>=20=20
>  /* Copyright string for -version arguments, About dialogs, etc */
> -#define QEMU_COPYRIGHT "Copyright (c) 2003-2019 " \
> +#define QEMU_COPYRIGHT "Copyright (c) 2003-2020 " \
>      "Fabrice Bellard and the QEMU Project developers"
>=20=20
>  /* Bug reporting information for --help arguments, About dialogs, etc */
> diff --git a/docs/conf.py b/docs/conf.py
> index 960043cb860..af55f506d5d 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -80,7 +80,7 @@ master_doc =3D 'index'
>=20=20
>  # General information about the project.
>  project =3D u'QEMU'
> -copyright =3D u'2019, The QEMU Project Developers'
> +copyright =3D u'2020, The QEMU Project Developers'
>  author =3D u'The QEMU Project Developers'
>=20=20
>  # The version info for the project you're documenting, acts as replaceme=
nt for


--=20
Alex Benn=C3=A9e

