Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84AAC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914882071A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHdRZyZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914882071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioSIl-0007Zg-Lc
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 08:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioSHp-00076n-2F
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioSHo-0004ow-3B
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:19:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48836
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioSHn-0004oW-Vu
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578316751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EP9twcUXIne18d+yPPDMHkEUN4T7j9IGvSCed5uazYE=;
 b=WHdRZyZ/SiBt0l/mi7I5YIYfW0E3HzDeewaEETyUzvwD9QwtqeTkuw1YdyAl5L2cjfCjBR
 2bYT1FxDak5s8Qu/Qsm2KuufMwJVpsndQtSyrrGa+vpKdh1SIRa/DrCSjpAwzwuwbkCxx3
 rmHgNW9D63G+NQ3VlyC4rr0lSp8cXxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-CMFAtjyYNWuuk8z1o5YPoA-1; Mon, 06 Jan 2020 08:19:10 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so2838043wma.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 05:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aQqXr+QfpG4ruVihzftt0wK2hav0V1YGvF3AybQH8mE=;
 b=f1CO3hKkLEd6aYnfuypwzPU0ms/nIMjmS0TtnP7CPgu95z9Ox0DNH3a+5k2eih7+dn
 n4U4T9+Oa4yQsSRA7pG1AqgUQyeaI/j6mJga+XVaGKqKlQ7wE2VpfGfX2+9FkkC1IbSa
 vA0rnwSrYtPX/PBHOIGtt1gQkaCGWe6MnnCUyEEp1R7WbSts7JeLHZuZzGhRoTKHXuXP
 ZRDKUrQ44P+sPLTMhc/+3iEppQCk7bzTqk2WPdpzVDEpA14ES9eXcy4pTyyNF1UBkb0o
 BFK031r+wCjE/V1PefR4oOWWblyLjqAYgifIyFIr766/Y031DoBkzGxpArVDn2YuuIrV
 KztQ==
X-Gm-Message-State: APjAAAX+3C/KFQhG2x9MY9e/pTWGSzNKlzZqCXCvN1pwxEwsay6XbTwU
 3uhZ/eAqfOLJAA9AxZmxgcCuzjtMjFrQUSaimpwcuHvUQ2r2vpiyM/eSmpzpZs+GUHUmKC3TFFZ
 FBPaTbQI+Lhdo3SY=
X-Received: by 2002:a1c:bbc3:: with SMTP id
 l186mr34650678wmf.101.1578316749072; 
 Mon, 06 Jan 2020 05:19:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqznDOTZsYxLhp09ngpoZf5pO1vQc5a5X5pONUq3CE6BuAXvb+xH42n2IyG5GVvuChsA6sorSQ==
X-Received: by 2002:a1c:bbc3:: with SMTP id
 l186mr34650665wmf.101.1578316748894; 
 Mon, 06 Jan 2020 05:19:08 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id y6sm70903811wrl.17.2020.01.06.05.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 05:19:08 -0800 (PST)
Subject: Re: [PATCH] freebsd: use python37
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200106123746.18201-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb1948f0-e9df-f250-cad4-825c985b3141@redhat.com>
Date: Mon, 6 Jan 2020 14:19:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106123746.18201-1-kraxel@redhat.com>
Content-Language: en-US
X-MC-Unique: CMFAtjyYNWuuk8z1o5YPoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 1:37 PM, Gerd Hoffmann wrote:
> FreeBSD seems to use python37 by default now, which breaks the build
> script.  Add python to the package list, to explicitly pick the version,
> and also adapt the configure command line.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/vm/freebsd | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 1825cc58218b..33a736298a9a 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -32,6 +32,7 @@ class FreeBSDVM(basevm.BaseVM):
>           "git",
>           "pkgconf",
>           "bzip2",
> +        "python37",
>  =20
>           # gnu tools
>           "bash",
> @@ -63,7 +64,7 @@ class FreeBSDVM(basevm.BaseVM):
>           mkdir src build; cd src;
>           tar -xf /dev/vtbd1;
>           cd ../build
> -        ../src/configure --python=3Dpython3.6 {configure_opts};
> +        ../src/configure --python=3Dpython3.7 {configure_opts};
>           gmake --output-sync -j{jobs} {target} {verbose};
>       """
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


