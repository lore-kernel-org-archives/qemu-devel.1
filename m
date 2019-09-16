Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAF6C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 10:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74862067B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 10:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCrXEZRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74862067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nrG-0007Gu-JF
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 06:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i9nou-00060e-Ts
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i9not-00059A-4y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:01:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i9nor-00058O-9g
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:01:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id r3so8030720wrj.6
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=U5fMvZVgGm0JtYr11rc8jEtD3MnDLmxagCi7doLfANs=;
 b=iCrXEZRByaufabAg5S7pTvAdr108xRgBSjByz4E8wXkz+5tX35ZV/gMib1oKdfGxVM
 b9WhXxQMVFV9iZ9AvgxdJ4IgWN5CqrBv+TsAt0sosHrs4QOUc3rbIGAfms/EiAZLxJif
 POR6M6HIQIhdjsXqzW7J/0V/nllqkd1XssY+m5F6QdBS6bX8vBW5KQeyoO1OWIHHloNc
 3iZIE4UlTVvnVGKiDd10LePyQDcdeNdumwa0/3cLn6L4r9W+Aa+GqFbKGiwFTUGI5x5i
 fqO2SsbLn5Bu+tCxf3Jyj0RgVIzfS/VRxcS3VkVoodlFEBkSB/psLImeuec5zLvsAFbL
 6eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=U5fMvZVgGm0JtYr11rc8jEtD3MnDLmxagCi7doLfANs=;
 b=fftSWa8qhpS3v4OWhiYGmODD3hmcQ+15NUG5/SzIr4eLSsgqswwPl4tNvqFjdorvB7
 Zw+7OWjxLry2q9Lzn4s8nI/+zu36QsL7F3GWp/oOTi/UVwqCzxv+pc3TJ2o4Ac6gEbWA
 z6ZftRFgAEkO72utKjzTSLAQkw8gU2PNt0McmFu+ealJqdeLmGGoZla+sw5I/Eh8/gqC
 AnhM7ExxeJF9exiMnKTOwO2h2Zep6ISUPKyqd02JCjVClYBxsJI6/CS8hu5FujRJYzik
 TEDXFJsDBCR5gPvkZQd0ceKpHgT+pPtrcUmd6p+0BZJ7cOMaH7DSx5uyZOTmcs1lbTnq
 137Q==
X-Gm-Message-State: APjAAAVSTMqSqsrRsuFQxYEqbv3gkXjpIcb3gEwCwtr1hBjxixLr9OCH
 1jWCWJLFz07XSlhsAj5oZkj5ZA==
X-Google-Smtp-Source: APXvYqxgUC0VrBkI0RlfaYeOyPQbmyiv1rP6A5qUvEyes2UxflL3myGVWHB/bdI8Rc24kfDwTxCqfQ==
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr4179342wrx.84.1568628076007; 
 Mon, 16 Sep 2019 03:01:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i1sm7424512wmb.19.2019.09.16.03.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 03:01:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 955EA1FF87;
 Mon, 16 Sep 2019 11:01:14 +0100 (BST)
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-6-f4bug@amsat.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
In-reply-to: <20190915211940.30427-6-f4bug@amsat.org>
Date: Mon, 16 Sep 2019 11:01:14 +0100
Message-ID: <87k1a81rx1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 5/6] .travis.yml: Let the avocado job
 run the 40p tests
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> If this list continues to grow we can
> - split it (as other jobs)
> - move them to GitLab where we can have multi-stage jobs,
>   avocado tests run on top of build jobs.
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index d0b9e099b9..69a37f7387 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -267,7 +267,7 @@ matrix:
>
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-soft=
mmu,alpha-softmmu,ppc64-softmmu,m68k-softmmu"
> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-soft=
mmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu"
>          - TEST_CMD=3D"make check-acceptance"
>        after_failure:
>          - cat tests/results/latest/job.log


--
Alex Benn=C3=A9e

