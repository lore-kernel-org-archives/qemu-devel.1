Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DAFC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDE320656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2YVAfLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDE320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVbV-0000yk-7h
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipVZa-0007EF-Hz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipVZT-00022t-TB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:01:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipVZT-0001wd-HC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:01:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so6882042wro.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=b+6VX3rCkX2/nivwxaRjXSSkiHZYyRMoyhvSuFjJ4vU=;
 b=Q2YVAfLWr+PE77IxsCUjCxh9xsKOzqf3c2mFB9+In8ccPGvvofd/oKy1vpnqwJKgLO
 Goj4HribktbsPH7yHzuiidwHNCIE26mOEH9sg2CdA9coeV3K2MK0aaTI2zxMPC2HPpfz
 Lch0L1E+xHyJwTMJGGYsdBaP8tGNL1A4R/5bEMBrxPVLCaYLEHW8XHWC9AZtPgiaEyrb
 QV8t7JJXGjBzZE9j+QAVLhntUox5YYnaVs18JIqI393n5pdjPovg5AIH070jCHQSlzcV
 z0Ss/GZ2RT+Vo2ilBygnbnCb2yZY1oGCeEjV4ftjIUO20B9j2BBl/8UMcnO58qrw2IJU
 qbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=b+6VX3rCkX2/nivwxaRjXSSkiHZYyRMoyhvSuFjJ4vU=;
 b=dRZjIYGh7J+oW68vrQM/q5pFr2+XL4E91iAHobcFP5ZqomV9qbfuaDtmv6Rf5MC7uJ
 pm25/6sOz/N7nOIsa8SM7AVT9zTkDN9RpT9DkXYBXpBD5hPguqGBPfF1c2eLdMfJhjyy
 VYGWaJGRjT5mf/z3QAZv/1DR9AQLZzPE9DdPMe4Qmr/hU8X+S4hvXdxl4eEEGA/wzmqP
 ccqY/Z+uHoM9QRhFAKzMk0Ezjx2SF7T3vBF0/M3dfjyFM0goWjuAyAHxzH34Y2/dL8wx
 S2lI3t/1L7nfTHbTOfsnGagtD3BFQYJx7xZuv01A47+k0m4IjLQWW28HlI0BFKwYaRiP
 e5Lg==
X-Gm-Message-State: APjAAAVtTdX1vmp9Fngvp6QL4Vp9dOGz/HjUBe/XdmeD3wCSCGp26myS
 EC+4/6OkkY2ysVhEvR4cHQWUvnYJ2wQ=
X-Google-Smtp-Source: APXvYqy648oKBe76ycmP4gGfhKFVJWR/Aj/Vx1NmCpxAoVJJWSRUQIyDmnkZFV8cJPrk6vUC3CGzpw==
X-Received: by 2002:adf:a141:: with SMTP id r1mr10403960wrr.285.1578567705121; 
 Thu, 09 Jan 2020 03:01:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v8sm7635423wrw.2.2020.01.09.03.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:01:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E8A6F1FF87;
 Thu,  9 Jan 2020 11:01:42 +0000 (GMT)
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] vl: Remove unused variable in configure_accelerators
In-reply-to: <20200109021710.1219-2-richard.henderson@linaro.org>
Date: Thu, 09 Jan 2020 11:01:42 +0000
Message-ID: <871rs8ki5l.fsf@linaro.org>
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The accel_initialised variable no longer has any setters.
>
> Fixes: 6f6e1698a68c
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  vl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 86474a55c9..be79b03c1a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2749,7 +2749,6 @@ static void configure_accelerators(const char *prog=
name)
>  {
>      const char *accel;
>      char **accel_list, **tmp;
> -    bool accel_initialised =3D false;
>      bool init_failed =3D false;
>=20=20
>      qemu_opts_foreach(qemu_find_opts("icount"),
> @@ -2776,7 +2775,7 @@ static void configure_accelerators(const char *prog=
name)
>=20=20
>          accel_list =3D g_strsplit(accel, ":", 0);
>=20=20
> -        for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp+=
+) {
> +        for (tmp =3D accel_list; tmp && *tmp; tmp++) {
>              /*
>               * Filter invalid accelerators here, to prevent obscenities
>               * such as "-machine accel=3Dtcg,,thread=3Dsingle".


--=20
Alex Benn=C3=A9e

