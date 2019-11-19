Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE82C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D515F208A1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmhK+mnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D515F208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7NW-0002o5-OX
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX7Ls-0001dU-GA
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX7Lq-0001yf-DN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:31:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX7Lq-0001yQ-9N
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574184701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jtc+gnKwdvqbDjwas8Ak+BcYZgy1tDLiPFCXNnXUaLE=;
 b=OmhK+mnXalDDp7jfNkexwVe0JvqP67Z0uRZuz0U3befQngdtIJnSfpVaWLj2b9/iHw3hXu
 OMhLKm6Bt4faHvLlxuhILNJGho7xnahi6NmnuUQ3tQj6u1QF79NpPOncvzKY0zvfyMsWSi
 +OLFC1MmYSg1XvFscHjTSnUzXRLVXBg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-wvMrNT7zPt-oxSPZZna8OA-1; Tue, 19 Nov 2019 12:31:40 -0500
Received: by mail-wr1-f69.google.com with SMTP id l3so18883383wrx.21
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=urPjpGekBsAbRumbSWbGniZecurBVnooQyl+L9kJhLA=;
 b=hSW2s04lWZuX22vqKFNlbUnGxSR22iVvU4DOQt2cs/4JT6zEV0UNapC13NyKWTfwYM
 CH6HDenjZoeh3pEI625GNRLufKiXNUQpXAOBkT0EXzU2Q+A0aJ0XkMtFL3E9nmtTipOo
 cGDFqAFM7zjzYy4U/ijmGQJt2O3t9JzMMcxpWCRgmvl7TwiWRIdgvf9AeZqiW8TD/Q7f
 hKLV1MXRyVPjLboLQ3Az9ptFcNvV3xgsMaEb1uq2M6BAyDEpbJXz5uqkT9muI52iRzLm
 2qAXqNtpAb4Un07TcUhu2+xZLj0X3ULW8HAQgc/cLr6ukL8sSAdw+2S8RYzAMTJpOU8v
 hInA==
X-Gm-Message-State: APjAAAVnEAsica3EN+oaL8D3DDfcjIklyuggep8E1TWglBiH9j3tZYQ1
 A83tWxvTiqL87obnHGmnCPJn9svgWyLrpcfkRAsAsaXdU7dF+BOVHjyug2qxaNBnQxJ6WRuGNRA
 54x+xjTOBBo2Cs9o=
X-Received: by 2002:a1c:1fcc:: with SMTP id f195mr7003193wmf.137.1574184699228; 
 Tue, 19 Nov 2019 09:31:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/SaBfZiOxQfXKBMQiSLZbZjFd7Agt6yz1+ZqQn2TCgSBaY13YkWb4+ntIsm2n5ZBiJPArtg==
X-Received: by 2002:a1c:1fcc:: with SMTP id f195mr7003159wmf.137.1574184699041; 
 Tue, 19 Nov 2019 09:31:39 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id v184sm3952954wme.31.2019.11.19.09.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 09:31:38 -0800 (PST)
Subject: Re: [PATCH 5/6] travis.yml: drop 32 bit systems from
 MAIN_SOFTMMU_TARGETS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <07137251-f4fc-ee16-8b17-e48458025bbb@redhat.com>
Date: Tue, 19 Nov 2019 18:31:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119170822.45649-6-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: wvMrNT7zPt-oxSPZZna8OA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 6:08 PM, Thomas Huth wrote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> The older clangs are still struggling to build and run everything
> withing the 50 minute timeout so lets lighten the load a bit more. We
> still have coverage for GCC and hopefully no obscure 32 bit guest only
> breakages slip through the cracks.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index b9a026c8ee..c09b6a0014 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -79,7 +79,7 @@ env:
>       - BASE_CONFIG=3D"--disable-docs --disable-tools"
>       - TEST_CMD=3D"make check V=3D1"
>       # This is broadly a list of "mainline" softmmu targets which have s=
upport across the major distros
> -    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu,m=
ips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_=
64-softmmu"
> +    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-softm=
mu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
>       - CCACHE_SLOPPINESS=3D"include_file_ctime,include_file_mtime"
>       - CCACHE_MAXSIZE=3D1G
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


