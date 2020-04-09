Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801E2C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4445520692
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tG30lyUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4445520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMeNg-0007pG-GC
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeLu-0006fL-UP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeLs-0007X7-VV
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:04:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeLs-0007W2-PB
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:04:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id f13so7080651wrm.13
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LNTZ/sg9Mw0xfIA0dTy8R+HvNXpE8CNBdQKJnrngXiU=;
 b=tG30lyUOU6m220eAyT4wOuXcPFBjsTrQDReBky716tn0Ltrkx+MkRql3c+YpdIDDlR
 m2zRvtw6IDOWUbOLZyNra7bMyT59OHPO1zWD59G3xIXnW8jh67PtY1OXSLAHl/5x0IzC
 dmqhdoxcGS2K0396ou1K9B1hj3929l8H0GHIUs//cQuUEu0Y/UBFyIyyAcQIcHdc87rz
 THu7hgm8tSxBFNC/UMoz0ti/qQWvU3ToiuGs1Ae++U7VYJD1JIym5u4tqAfWH2rz2tPZ
 T3OGSGrv55UlZZ3AQi1HTbQNbDV5kwyMdQHbltrS/Phjb7jYMlW2MlOaADBZlisT8UB5
 wIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LNTZ/sg9Mw0xfIA0dTy8R+HvNXpE8CNBdQKJnrngXiU=;
 b=dRvLA4IX3grjyiJSYi0I0Lxi3I0t3ZZ9y/mPdAwKnSCuSEUFouBn/79F4aBkXBDn+G
 zUHKjm+N5Olx8guJpKSxi40TO5AReuVC2+yxLkXPKKkGL25bSxi0aP9e1dYfsQmZLbQ1
 NBvBpWSeAlstVZ22qlTDYxj41P/bdyIcmePTKJX5pD3z8GK4mG092YLAg/dyE8MrMjsD
 9dPSSFngAaViw0sWSpwybHlJ4Vv7p9JAFQ4ieB7+x45fBB47P5C3j8Szd+ydM5S6PGQ7
 BbxiLrKB5NF8Ibuj1O34kORnMg32XBEbbjTlG7UyLnpfu2ZDWLmU+c8TtTZH/dSAkD2U
 9oqw==
X-Gm-Message-State: AGi0PuYQ2JIA6Su268epjNlBN93642oK8itfFN5p0rFxOlDdApvRVXJY
 1amrrhMayZ20bWxyHR/NopdlSw==
X-Google-Smtp-Source: APiQypLb3VGd0LIqdtQilttlR/YDnHzg3AlCiDlYkPe3AksUfY3YrqXGcKBAs1CF2yg7GG7SurzmwA==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr1027712wrj.165.1586466283346; 
 Thu, 09 Apr 2020 14:04:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l185sm4960545wml.44.2020.04.09.14.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:04:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 353181FF7E;
 Thu,  9 Apr 2020 22:04:41 +0100 (BST)
References: <20200409190618.7402-1-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] .travis.yml: Build OSX 10.14 with Xcode 10.0
In-reply-to: <20200409190618.7402-1-philmd@redhat.com>
Date: Thu, 09 Apr 2020 22:04:41 +0100
Message-ID: <87lfn49xqu.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Daniel_P?= =?utf-8?Q?_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Travis recently made a change which generates various warnings
> such [*]:
>
>     CC      utils.o
>   In file included from cs.c:11:
>   In file included from /Library/Developer/CommandLineTools/SDKs/MacOSX10=
.14.sdk/usr/include/stdio.h:64:
>   /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_s=
tdio.h:93:16: warning: pointer is missing a nullability type specifier (_No=
nnull, _Nullable, or _Null_unspecified) [-Wnullability-completeness]
>           unsigned char   *_base;
>                           ^
>   /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_s=
tdio.h:93:16: note: insert '_Nullable' if the pointer may be null
>           unsigned char   *_base;
>                           ^
>                             _Nullable
>
> We only aim to support MacOS 10.14 and 10.15. 10.14 comes with
> Xcode 10.0. These warnings are not emitted with this Xcode version,
> so switch back to it.
>
> [*] https://travis-ci.org/github/qemu/qemu/jobs/673000302#L1387
>
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued to for-5.0/more-random-fixes, thanks.

> ---
>  .travis.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 2fd63eceaa..7c92206ea3 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -272,12 +272,12 @@ jobs:
>=20=20
>      # MacOSX builds - cirrus.yml also tests some MacOS builds including =
latest Xcode
>=20=20
> -    - name: "OSX Xcode 10.3"
> +    - name: "OSX 10.14 (Xcode 10.0)"
>        env:
>          - BASE_CONFIG=3D"--disable-docs --enable-tools"
>          - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
>        os: osx
> -      osx_image: xcode10.3
> +      osx_image: xcode10
>        compiler: clang
>        addons:
>          homebrew:


--=20
Alex Benn=C3=A9e

