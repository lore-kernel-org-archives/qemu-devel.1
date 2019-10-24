Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD9DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648AC20659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDWx0gGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648AC20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgK6-0007Hc-Ic
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNfsT-0004d0-Tp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNfsS-0007LG-Jt
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:22:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNfsS-0007Jw-Fz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571934134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RndMaEZSHTK+Xh2FcqB56moVFW6n46YXMGknS8nq3sA=;
 b=JDWx0gGeMWjj+Ayz4mdWxBM0m7LJLosWYJQi74zeD9Pm04s6WaKEXOe4naCVw/ADtvg1bA
 LVjVXmL2HM6RxUca3F7HBV2zswdKK5PW9ctpN5hQkk8EGmhdaCa9hLIytWngoLLdDh85s4
 i+pKsScvWgyCqrolWroXYZClADirMd8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-g5aPa8QGN0CTW7BJbKduwQ-1; Thu, 24 Oct 2019 12:21:57 -0400
Received: by mail-wr1-f69.google.com with SMTP id 67so13094514wrm.18
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PhW7JFkZwDqQv5z9XfVaWagkWXu0pB1QxYRd89tEwpI=;
 b=a4DuS4XzVMhsbvGY2r8C0AaNLXVDlidekC9Co0UFSpBy0anUME6SCpzLZ2/DErkcT8
 YuwtY/5VHqdzAJyF9M/4+avVTa0PybvS5k+m5qsTS9Uxjm+pHZEdNcnQPRZsftIgC0Iu
 Jc8n9+at4AlB3r4+PKvWz7SiDPXYmrq+hBHbADI6+m/T2dgoVnqYn4AnSMHyEY5HCyFM
 KCDJqx92DVlSeIsD5VMor0KMGhRoGkkC1r8ZwLZPuAzDYJGh8mffxcpyoF3qZFtLclFL
 /GPImKU6GeLF0/ipHBQYuIEsMIdCunIr1MqW0RYprE+qo3HdHQVzT9bqPIhMfKh+p/oS
 d8WQ==
X-Gm-Message-State: APjAAAUk734gQpCW1xsN+Ze62Vsg1RVEHstX6cdn3CvPmWAF4xLeOsSL
 uDbNFm0mbCP+0R9mJorqy2OAvb4NkNeIbYYwtvhReEdSD3zEVrkxwBB235BZ57W0o9v83ERhDng
 Jz15PX9LyUGW+jjI=
X-Received: by 2002:a05:6000:118f:: with SMTP id
 g15mr4458417wrx.242.1571934116679; 
 Thu, 24 Oct 2019 09:21:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxULxWeaNYR65Sn5xkM9qYWEqdrhSxLE6C1scBu4Guql1F4Xt1YtFnjfovrwAEWoT1C2lPYA==
X-Received: by 2002:a05:6000:118f:: with SMTP id
 g15mr4458401wrx.242.1571934116423; 
 Thu, 24 Oct 2019 09:21:56 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id 200sm4052652wme.32.2019.10.24.09.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 09:21:55 -0700 (PDT)
Subject: Re: [PATCH] travis.yml: enable linux-gcc-debug-tcg cache
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191024160619.14179-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f36130d-f2cc-2432-7098-b73f82c1501e@redhat.com>
Date: Thu, 24 Oct 2019 18:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024160619.14179-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: g5aPa8QGN0CTW7BJbKduwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 6:06 PM, Alex Benn=C3=A9e wrote:
> Create a new cache for the --enable-debug-tcg builds which is separate
> from the normal debug builds which generate different code. We also
> enable debug-tcg for the new plugins based builds as we want to ensure
> any breakage to TCG is picked up by the sanity checks.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index e3f10a93683..34bc8134f5b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -135,7 +135,7 @@ matrix:
>       # TCG debug can be run just on its own and is mostly agnostic to us=
er/softmmu distinctions
>       - env:=09
>           - CONFIG=3D"--enable-debug-tcg --disable-system"
> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"

This one runs default TEST_CMD=3D"make check -j3 V=3D1"

>  =20
>  =20
>       - env:
> @@ -336,29 +336,29 @@ matrix:
>       - env:
>           - CONFIG=3D"--disable-system --enable-debug-tcg"
>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"

And this one "check-tcg", OK.
(Maybe we can reorder the $CONFIG arguments so both jobs are more similar).

Too bad Travis 'stages' are an enterprise feature:

https://docs.travis-ci.com/user/conditional-builds-stages-jobs/#conditional=
-stages

Because here we are building 2x the same, and cache isn't used.

Not this patch problem.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
>       # Run check-tcg against linux-user (with plugins)
>       # we skip sparc64-linux-user until it has been fixed somewhat
>       - env:
> -        - CONFIG=3D"--disable-system --enable-plugins --target-list-excl=
ude=3Dsparc64-linux-user"
> +        - CONFIG=3D"--disable-system --enable-plugins --enable-debug-tcg=
 --target-list-exclude=3Dsparc64-linux-user"
>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
>       # Run check-tcg against softmmu targets
>       - env:
>           - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmmu,a=
rm-softmmu,aarch64-softmmu,alpha-softmmu"
>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
>       # Run check-tcg against softmmu targets (with plugins)
>       - env:
> -        - CONFIG=3D"--enable-plugins --target-list=3Dxtensa-softmmu,arm-=
softmmu,aarch64-softmmu,alpha-softmmu"
> +        - CONFIG=3D"--enable-plugins --enable-debug-tcg --target-list=3D=
xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
>       # Release builds
>=20


