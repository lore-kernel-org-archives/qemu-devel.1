Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F13C47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D4C21582
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEu3ZyKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D4C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQB0a-0006Aj-Ql
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQAvG-00033r-6S
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:00:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQAvD-0007WP-VJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:00:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id n18so2572775wrs.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Qi4UiNQj5hOPKgDoPmfBZqIKb5l9fjXDNTmOGcW1hKY=;
 b=UEu3ZyKNif7Jv9IOkVOv4Yr/eyGif40QgnhWYTYvAdEwXm2Q5pZq/aGxS97YveUEY0
 muDcqKXHp/vK9QxAWu5ryE8753TqfJ9Gv/nbqTdlnT/GeLQr7tyy6FvGDjCSAmgGAIj/
 CPzu0fkjhgv7ONEAbvbwkD6eymcCt4gx51Ec+PAB+YMPjAZw9qfJKsJsLFdIm2N6AHdG
 k2hyNbVb6DQ8BAN8+8n3dqhJm8/Cs5cPecdRSadUuM7eMxtBrjT4MaMA5r3/pyRGQXaz
 6AABDFxs+jz3nxsdWzcCmnOI93M1KBWBUu+31d8Ft1NPcNJ06AGgUzFDMDWTd4t2mTJN
 FCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Qi4UiNQj5hOPKgDoPmfBZqIKb5l9fjXDNTmOGcW1hKY=;
 b=bhG3tONcGTy/4LA71LpKq98evEexbINBbQmfCfLFuGVwZvu3ujO7Tx/2efXPG2QSik
 NNQiBMtlLJRx6pHeR6cpN233whUROZVAUpGyuxpIbDT+onOkKiqNvFIPI8rIUNA/T0ix
 XB1SmpGI2ayXenwFgdnnEBdEVoUKLrGmfJURz6Etjqoge/1wK7CVVCcJ2vyGOBaHQyIO
 7DUfcVIu9KaYjMUPBr2K+mp/OZ2s4YVZIfqSDFRUqjWC9pK5jd79WI0HEQPodhiT5dgk
 HGN92Kj3WeqEppgak1H2xWzhpcTQRg75ciHNSjKYa4OWR9PZZXfHuMC5OcCQ/FHU+Orq
 mjcA==
X-Gm-Message-State: AOAM531QlSj5F0vL4n0shdjvD/tJtiQ0tglLDQOG7abe9a+P5mnG4I8C
 X+16afHUbOrhUmKb/gJ3sGkU98NJFf6f2w==
X-Google-Smtp-Source: ABdhPJw5MR1jTJ2ThrMQyiVbDd5jNFo3h/iDso+gsX2x7huCon1rgdq9kjsAm4VuPRspBPs9eUXD8A==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr4010033wrv.200.1602082801321; 
 Wed, 07 Oct 2020 08:00:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm3445233wrt.53.2020.10.07.07.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 07:59:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 354471FF7E;
 Wed,  7 Oct 2020 15:59:59 +0100 (BST)
References: <20201007140103.711142-1-pbonzini@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] cirrus: use V=1 when running tests on FreeBSD and macOS
In-reply-to: <20201007140103.711142-1-pbonzini@redhat.com>
Date: Wed, 07 Oct 2020 15:59:59 +0100
Message-ID: <87o8leytcg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Using "V=3D1" makes it easier to identify hanging tests, especially
> since they are run with -j1.  It is already used on Windows builds,
> do the same for FreeBSD and macOS.
>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Queued to prepr/misc-testing-gitdm-plugin-fixes, thanks.

> ---
>  .cirrus.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index d58782ce67..4d236fdefa 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -15,7 +15,7 @@ freebsd_12_task:
>      - cd build
>      - ../configure --enable-werror || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
> -    - gmake -j$(sysctl -n hw.ncpu) check
> +    - gmake -j$(sysctl -n hw.ncpu) check V=3D1
>=20=20
>  macos_task:
>    osx_instance:
> @@ -29,7 +29,7 @@ macos_task:
>                     --extra-cflags=3D'-Wno-error=3Ddeprecated-declaration=
s'
>                     || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
> -    - gmake check
> +    - gmake check V=3D1
>=20=20
>  macos_xcode_task:
>    osx_instance:
> @@ -43,7 +43,7 @@ macos_xcode_task:
>      - ../configure --extra-cflags=3D'-Wno-error=3Ddeprecated-declaration=
s'
>                     --enable-werror --cc=3Dclang || { cat config.log; exi=
t 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
> -    - gmake check
> +    - gmake check V=3D1
>=20=20
>  windows_msys2_task:
>    windows_container:


--=20
Alex Benn=C3=A9e

