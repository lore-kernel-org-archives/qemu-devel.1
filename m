Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D79C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA552173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezEZSRud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA552173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ok6-0007QA-F3
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8of4-0003k8-Lb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8of3-0007sn-QG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:15:22 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8of3-0007sc-In
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:15:21 -0500
Received: by mail-wm1-x342.google.com with SMTP id a141so96842wme.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=s1O9QqrAvNEq9kvqXkeDv+RrdHy9m2n658lvmX0I+S0=;
 b=ezEZSRud6UPmvmtfMcKyDnTPrAahbxdQ6olujwXMT5YFxIBN6W++HF0zXcJteiW/Jm
 Fea6f1lko+TxMuNQBxzFd4AxPdI67ixWCjzqSORjpvuInUSCbpWNQ2TKrZMCPnPtKzl8
 XnF7ZELwBB24y15SvfyRRA7ACuyz3uPyU3O2cyBq8j7opBasF9DIAGwOYQTY3b1+vebt
 P3/IsBLkhtjPWe8tzGozRRU5M8SymN4Pn6hR5YM4JhzSCT93DiCUxN8etm7+VT29GeTi
 58Ls+yK+MHk98XFLkbw1MRvp7wWszM9L9aOdn/e/mSOZIZ2mZPBNDDU7hEWSdAFzffzc
 7yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=s1O9QqrAvNEq9kvqXkeDv+RrdHy9m2n658lvmX0I+S0=;
 b=c4iOQVTS+crVeP9aHGpTxGrci7B440O7Mgcm92eXfgWIqetiO7eLJSc4upk+FCSmF9
 zffcmtbow/jVu1z2DAlZZP8zzRpSSTMepbEj6xaQM3gIT35brePSRI0zppfYQkFN0UzW
 pUHesDkwuOpSPX4AcdRjNj4MwUiq+1bp7MF3Y6giBtdf6I7jRLErZPhVQj9o7EqXD5w8
 KS8G5IR8CXLE9wlRbyTFNEG1Bp56VcP+PWV4lshv/Dw+mecXWdvQ9J8wcvu5clTdO3PO
 LgOG/GQbzesOGGexnXUQ4E+TCxOjSZkJ5yaACOhDZao7YVsA3Y/5Oe8xT3tFprQXrWic
 SH1w==
X-Gm-Message-State: ANhLgQ1g9aMzS0h4xf3tvO8onnSHybuvmjLaBHmJIFTiDoFOLEqEm7+x
 Jc4sQm5FYGnoVadMdbXgYv+okg==
X-Google-Smtp-Source: ADFU+vvmg1VvGlVx7c3/+jtDAU1sEFSVjZAQh/Pvt3+bgXJO22ufdG2ArQ4L/LviIn7lld2h9yuDgA==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr128520wml.4.1583169320412;
 Mon, 02 Mar 2020 09:15:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o9sm30378774wrw.20.2020.03.02.09.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:15:19 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 624551FF87;
 Mon,  2 Mar 2020 17:15:18 +0000 (GMT)
References: <20200302154630.45620-1-lvivier@redhat.com>
 <20200302154630.45620-3-lvivier@redhat.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 3/3] travis: enable tools build on OS X
In-reply-to: <20200302154630.45620-3-lvivier@redhat.com>
Date: Mon, 02 Mar 2020 17:15:18 +0000
Message-ID: <87a74y8yqh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <lvivier@redhat.com> writes:

> As we can build tools on OS X we should check we don't break build
> when we submit new codes.

I agree, snarfed this patch into testing/next, thanks.

>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 9867272177d4..70a24bf2fc8b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -273,6 +273,7 @@ jobs:
>=20=20
>      - name: "OSX Xcode 10.3"
>        env:
> +        - BASE_CONFIG=3D"--disable-docs --enable-tools"
>          - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
>        os: osx
>        osx_image: xcode10.3


--=20
Alex Benn=C3=A9e

