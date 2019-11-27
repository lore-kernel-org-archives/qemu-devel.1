Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E44F20835
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWIgn3WA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E44F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1tE-0006r5-Lj
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ia1kP-0006ns-1U
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ia1kN-00046T-2d
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:09:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ia1kM-00045A-UB
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574878140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFzBbSrdqli3Vyr1U/lAw4MFkqUukGTYQMCetsbniRg=;
 b=PWIgn3WAE2UD22EwgXfVQjZ25f6rVYMvXA5jw1mchv8tba5DF7BeLbS6bOQdxSUTeULvdC
 VZbQhM23Lddhit3pZNLaHFntwKs8xf1g8aPU9Sn5pCpO2vqxrbrJ43XKfS2CWiIKUZSTsN
 +OxMb/cGkKsLhvaBdjqamC62u8vT/7g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-6-pv6p3MPU6eHb-3hlzJvA-1; Wed, 27 Nov 2019 13:08:57 -0500
Received: by mail-wr1-f71.google.com with SMTP id y1so12613132wrl.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 10:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bwTurDkAf51bZMPGgSVHsdQNeyfDQ3kU20qXgUge+i4=;
 b=SAgwRh1bdvLcjHIhDaebmXZsF6ih3jOwB4uyTjbwNpZpoUQSaNq/NWEp30nAXJp7mm
 J5OfkaCmlmhkxEGlOZEezxeY7kwNsnllK1gGjlNJ71IqD+ekHvoKQm1TDjIk+gMDmuFA
 E4zMInsYgqAT4I7o+KmNj9wRLjMI+tX1GAMsz9+9kwUcW7IWOxof8c4RZwPV0Rn0f3R9
 w1LwZwEAnOE+9d9iMTWlMhOkrHuK+2251u4kWf8P1kH5I2hHe06WsPwjW2duADnZz8OF
 FBZKCNDj+yYj8BZAtI8IS2OqIGo92Ca16Dzc6N9asFLCfvRbpFpM0v/cdXVvTAvzaTZb
 J5kg==
X-Gm-Message-State: APjAAAUztPaOhyo9YoO3ue41Ix3gfEsGSCB7aBhUXhy/bVD+ZabccICD
 juxPQb2VlLrI/DSV8TLRNvaI1cV0U0CoJZI8/ILB4ZtmaER79OG1AWiBp/KEP78Y2Wt+3vlc2Hs
 Yz5Ro+lJlMtppooY=
X-Received: by 2002:adf:aa92:: with SMTP id h18mr45505356wrc.150.1574878136341; 
 Wed, 27 Nov 2019 10:08:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAv64As4EASNVQAmeCRxyIN5sDRaeJ/MYk53zLECuZXcLFrFMR4ClY7YosNixM/iD+85ETLg==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr45505330wrc.150.1574878136058; 
 Wed, 27 Nov 2019 10:08:56 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l17sm1318555wro.77.2019.11.27.10.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 10:08:55 -0800 (PST)
Subject: Re: [PATCH] travis.yml: Run tcg tests with tci
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191127154857.3590-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c74e337e-a3ea-ac67-eb36-490166eba88e@redhat.com>
Date: Wed, 27 Nov 2019 19:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127154857.3590-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: 6-pv6p3MPU6eHb-3hlzJvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 4:48 PM, Thomas Huth wrote:
> So far we only have compile coverage for tci. But since commit
> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
> for INDEX_op_ld16u_i64") has been included, we can also run the
> x86 TCG tests with tci, so let's enable them in Travis now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Ran for 26 min 28 sec:
https://travis-ci.org/philmd/qemu/jobs/617823541

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index c09b6a0014..b0b634d484 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -218,7 +218,7 @@ matrix:
>       # We manually include builds which we disable "make check" for
>       - env:
>           - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
> -        - TEST_CMD=3D""
> +        - TEST_CMD=3D"make run-tcg-tests-x86_64-softmmu V=3D1"
>  =20
>  =20
>       # We don't need to exercise every backend with every front-end
>=20


