Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54868C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2001820704
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQbzxfc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2001820704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7IZ-0001wt-4o
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY7Hu-0001WR-Tv
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY7Ht-0000DP-1q
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:39:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY7Hs-0000DF-UX
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574422784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1FWKGeyKwgvCy5ETVT/ygBzDu7yCaLGqB8442hViJ3o=;
 b=dQbzxfc9ltyadAlr6ousUedy35JrDTUtbKUAo7c+5zsFfJfszBSZpj6JqAe7HBuVw4k4Xv
 J5mQ2kskCvGQpu1ToMjRYlTkOOIyaM1Ce3fDA7qjy1rj+2hJrTnGSHiglXzPu10xc9d89I
 dpQwt6TrzlbuwKwCKM4I1QFMLTKvT00=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-0U19xHFqOuuBRofZpV3sFw-1; Fri, 22 Nov 2019 06:39:41 -0500
Received: by mail-wm1-f69.google.com with SMTP id 199so3319770wmb.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oDwPa/XvT2dejPyPpGh04XD/bGPM/opj42AdgqucEb8=;
 b=PJcC+mQ33S5j3WimikL1cVOSNaQP+dMJjX/l5cwQugVm+HvFj/WPtc6lIG4F2bAvO3
 UixuaZygbA27dEaDYGAJqrKr5YqQuBRmcxu6HLOJ7bkQESCLKb/nRGfEyoBaF3Rw9NWW
 l08CI+z0jikDuYnLmAlaCqashJ7jE9//6ukIrhsKQCVYa71+Wii12KDweVt1/ybO5PkO
 QUh8UIRNx91M3EQd3jFXdHrmd3uPPNGRzri24aaQBwxwYcGKB9cUeAJKZ5i1gRUn3Fva
 DofmkYFwRxJ3JpvfMtYQjxFtfzq3/4UCYH+nm7RCtIqN02ZZcdmIlAEZuelXG5yk7MHP
 YxNg==
X-Gm-Message-State: APjAAAWIN0MNB007A9RZ4Bk5tu9Ac0NdC9xwUUzAPsFu0o6Ic4Ogp34d
 Px9HXRZ4Ft5jFIedzCwGx1T8P1Iq1e0soDnQeiA6t1Jpr5yzKv8cUOFZxD5W9Lk48G4OXD3mhyt
 QOMze5fBboCtWDiE=
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr16529748wma.116.1574422780717; 
 Fri, 22 Nov 2019 03:39:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFYonKeq93oZtEG/WiY9KoRCjHJkyf+9vvfv8Czl6QJawd4O1SwfMSoHKgY86nfBjE9htqDg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr16529726wma.116.1574422780506; 
 Fri, 22 Nov 2019 03:39:40 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id m1sm7546957wrv.37.2019.11.22.03.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:39:39 -0800 (PST)
Subject: Re: [PATCH v1 3/3] tests/vm/ubuntu: update i386 image to 18.04
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191122112231.18431-1-alex.bennee@linaro.org>
 <20191122112231.18431-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b91b6119-fc01-9cc0-b8cb-730d5484ede4@redhat.com>
Date: Fri, 22 Nov 2019 12:39:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122112231.18431-4-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: 0U19xHFqOuuBRofZpV3sFw-1
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 12:22 PM, Alex Benn=C3=A9e wrote:
> The current image is broken while running qtests but the bug go away
> when built with a newer Ubuntu i386 image. I was unable to replicate
> the crash on Debian Buster for i386 either so I'm concluding it is a
> distro problem. Let's paper over that crack by updating our 32 bir

typo "our 32 bit"

> test image.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/ubuntu.i386 | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 18b1ea2b72c..f611bebdc9d 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -66,8 +66,8 @@ class UbuntuX86VM(basevm.BaseVM):
>  =20
>       def build_image(self, img):
>           cimg =3D self._download_with_cache(
> -            "https://cloud-images.ubuntu.com/releases/16.04/release-2019=
0605/ubuntu-16.04-server-cloudimg-i386-disk1.img",
> -            sha256sum=3D"e30091144c73483822b7c27193e9d47346dd1064229da57=
7c3fedcf943f7cfcc")

This one is in QCow2 format.

> +            "https://cloud-images.ubuntu.com/releases/bionic/release-201=
91114/ubuntu-18.04-server-cloudimg-i386.img",
> +            sha256sum=3D"28969840626d1ea80bb249c08eef1a4533e8904aa51a327=
b40f37ac4b4ff04ef")

This one is announced as USB format (ISO) but is in QCow2 format too...

Using '18.04' instead of 'bionic' in the URL is not important because=20
the information is also in the filename.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           img_tmp =3D img + ".tmp"
>           subprocess.check_call(["cp", "-f", cimg, img_tmp])
>           subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>=20


