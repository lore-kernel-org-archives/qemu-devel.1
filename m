Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203EEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8582082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIj8fgMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8582082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfRD-0008KH-Uh
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihfPq-0007LB-Sn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihfPp-00048B-7m
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:55:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihfPo-000425-Rd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:55:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id d139so5403425wmd.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Qd28oSsXA3Jo2hDwIsxITatMrNbLZDLfD+BONUswBYM=;
 b=gIj8fgMZwVjP5xpLjzJYmGqoVVSOzdJDYJU90vBoUAa8THshmqszT51WZOPJgdkSA5
 uoBe59M+/eFrvfh8tAIHKhl33JVmdSTDDJ1GZ/UuhcPgF8oCeUEaVpqQzKjWRJmTL7w+
 qGSwKVDrYGld6kPAcc39EOYkgZNAK4azIetGT/83ueaP2viRrhXEfggaidsj2xXf8jsS
 64n8ir0p+L5s4jJ2D7e0vLaTgvyserlnF6WaortoNnvLjeLsvh227SoL3Tnaaf8gtmAa
 lZd+QPcNOf0sz9TCrUcf61OdXw8K7ekFDorqWEfh/lUOkM9apEOgGoxQCZ/WoV0oJAms
 AlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Qd28oSsXA3Jo2hDwIsxITatMrNbLZDLfD+BONUswBYM=;
 b=LXqncCqdWuntsosguTkCKbVn32npGOXpD98KnFQo805ID323ZYSUfWd8upc9/mLA5m
 0jXFUBrdJw842USPay4TbWFSyuubB+/nD4bsHwGqA1biXVEz5JENyQbOpeJ/iczxYvIz
 VQb1z3ygo93dXAmB/UHtL7J/ZDYN9hLhOJ5UlKKe4GmcjNV51MSPzGyNVG6BYbQY9UDI
 EDOh1wsFapgURVzAb/3ACo16EXuylXcTEjf7HY9P4IuNYuy2y3Dv4FHumbZvVtTCJQZb
 JyEABilGm07zyQMFgSdrj6hxQgMzv8oiIXQKwKTpyxqLFTTcv9Cyda5/FfZVUhxiFaA6
 7XHg==
X-Gm-Message-State: APjAAAXEr2DaYNCbbjwuxUZIcP37zXi4qdCrpHLTDHk6Yaw7Zg8l1ozi
 vl/cs0ZTDt8d4c3e1P/q9hiPvg==
X-Google-Smtp-Source: APXvYqxbGa22OpYnMZYkDUh8XGOqRttEg0AF7d9INmiQN+FLARcCM2PQbEsOtWnehieyz21trOnwsw==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr5278328wmg.163.1576698923428; 
 Wed, 18 Dec 2019 11:55:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g21sm3998577wrb.48.2019.12.18.11.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 11:55:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0B4401FF87;
 Wed, 18 Dec 2019 19:55:21 +0000 (GMT)
References: <20191119092147.4260-1-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] travis.yml: Remove the redundant
 clang-with-MAIN_SOFTMMU_TARGETS entry
In-reply-to: <20191119092147.4260-1-thuth@redhat.com>
Date: Wed, 18 Dec 2019 19:55:21 +0000
Message-ID: <871rt1flxy.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> We test clang with the MAIN_SOFTMMU_TARGETS twice, once without
> sanitizers and once with sanitizers enabled. That's somewhat redundant
> since if compilation and tests succeeded with sanitizers enabled, it
> should also work fine without sanitizers. Thus remove the clang entry
> without sanitizers to speed up the CI testing a little bit.

Queued to pullreq/testing-logging-misc, thanks.

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index b9a026c8ee..47875bdafe 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -181,12 +181,6 @@ matrix:
>        compiler: clang
>=20=20
>=20=20
> -    - env:
> -        - CONFIG=3D"--disable-user --target-list=3D${MAIN_SOFTMMU_TARGET=
S}"
> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-default"
> -      compiler: clang
> -
> -
>      - env:
>          - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS} "
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-sanitize"


--=20
Alex Benn=C3=A9e

