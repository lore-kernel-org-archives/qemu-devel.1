Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE6C2D0F4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 11:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8456206D3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 11:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzVcfS3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8456206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJxih-0006LD-Rc
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 07:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJxi9-0005vs-Er
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJxi7-0006l3-Mq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:08:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27407
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJxi7-0006kn-IQ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585825714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nddRZc4PDWX99WW6MMAItLuvFZ5IPi1anm6EcU3KiKk=;
 b=gzVcfS3WcC1m0OpFxf0WYIu/B2BQbnmzL87a+hlcAWJ4C7JdNHoeyawEx7FlveSniFIoyb
 bsbIvydIyq6aaS5MmKv3QENv/p6J3abxzJT24Ow61BcJG+tnjAK9Wxfpq7R4yTFWUBtkhP
 r5Bp7RIzNmgK/xf6/RxrOhqKLNhecB4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-N9BebI_xMlOUxnMcpFl--A-1; Thu, 02 Apr 2020 07:08:30 -0400
X-MC-Unique: N9BebI_xMlOUxnMcpFl--A-1
Received: by mail-ed1-f71.google.com with SMTP id b7so2439986edz.9
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 04:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GgXLvfpyaAXd8dHhs+EOoJ82+/rI9lVHG1gJP+TG1Tw=;
 b=CF1xwUCCVqRKiFAv7cVi4P4txAaD2X4X3yfpWQzFzJ6matJJ57CpslNfOir5Gz55+n
 GzhcYy7+WGMCrc80lDLgo3QOb1MMkLYHOlTSG8P7AnKmqesy1xD1PUVBfQucOzCwnLiE
 abL/Em2Pict4w/wPSBPIM/2ANj41p9Ens/LdOAp3MYsqXWb6zj95PqRvV4thHLawvmH+
 gziFGfS+8IR4OwrnL+/IwJVtUTo5pATFAL18ptpEAqyDBITolrk2G/JLsVY2KVUj/HuZ
 HG/rw5nmGjBhxQfngktD+yNsZywWpnSLynckOakIBlCKynxLnU/Df0PtF50Vrziw9oQm
 7uAg==
X-Gm-Message-State: AGi0PuYDCaUVFhGAr4w97d6AaJn7QgKLlbzqiYNxLXqfylAqUO05OyB7
 aOzMNMIbOln/dl3Ugjxwe2zAk9aNx866tHqQbb8HlfcqojKYoP4l52iZq7ZpnKtJ4t/ffZDcmUJ
 rXdKH0+EH/YnWebI=
X-Received: by 2002:a17:906:77d3:: with SMTP id
 m19mr2559751ejn.307.1585825709635; 
 Thu, 02 Apr 2020 04:08:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypLA5QbgFowsnj4Fs1abGMfUQ5PAqMm2zYPjHqeHomoYiUZpympNHwgYXdvI+GkqN1kHO46fHQ==
X-Received: by 2002:a17:906:77d3:: with SMTP id
 m19mr2559714ejn.307.1585825709306; 
 Thu, 02 Apr 2020 04:08:29 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f12sm884860edw.42.2020.04.02.04.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 04:08:28 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Willian Rampazzo <wrampazz@redhat.com>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
 <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
 <CAKJDGDaE_OjqigaxXSJRkv7wfouLV-tsDQaXnWJXpn4F8DkPwQ@mail.gmail.com>
 <96219ba3-c114-0cec-8ace-bc19b254077a@redhat.com>
 <CAKJDGDbXeDrDWgxoZ=+LwPmexestnXJxqD5Mcrq9C4Aiy9x3dg@mail.gmail.com>
 <d52e1d9d-f892-f760-6bca-e37689cff362@redhat.com>
Message-ID: <581e054a-b3a0-fe3c-fc09-f9dcab7f08c7@redhat.com>
Date: Thu, 2 Apr 2020 13:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d52e1d9d-f892-f760-6bca-e37689cff362@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 12:01 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> I'm now using this kludge to include your bugfix:
>=20
> -- >8 --
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index f9c84b4ba1..d625b32dbb 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -1,5 +1,5 @@
>  =C2=A0# Add Python module requirements, one per line, to be installed
>  =C2=A0# in the tests/venv Python virtual environment. For more info,
>  =C2=A0# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> -avocado-framework=3D=3D76.0
> +-e=20
> git+https://github.com/avocado-framework/avocado.git@f9b4dc7c58a6424eb8d0=
ed6781a1d76ae3a5ab06#egg=3Davocado-framework=20
>=20
>  =C2=A0pycdlib=3D=3D1.9.0
> ---
>=20
> But I'm getting another error:
>=20
> https://travis-ci.org/github/philmd/qemu/builds/669898682#L1702
>=20
> ...
> avocado.test: Asset not in cache, fetching it.
> avocado.test: Fetching=20
> ftp://ftp.boulder.ibm.com/rs6000/firmware/7020-40p/P12H0456.IMG ->=20
> /home/travis/avocado/data/cache/by_location/9234e55550fdde347e2a4604c133f=
a2c8d9e9291/P12H0456.IMG.dp3lw27q=20
>=20
> avocado.test: FileNotFoundError: [Errno 2] No such file or directory:=20
> '/home/travis/avocado/data/cache/by_location/9234e55550fdde347e2a4604c133=
fa2c8d9e9291/P12H0456.IMG.dp3lw27q'=20
>=20
> Failed to fetch P12H0456.IMG.
> /home/travis/build/philmd/qemu/tests/Makefile.include:910: recipe for=20
> target 'fetch-acceptance-assets' failed
> make: *** [fetch-acceptance-assets] Error 4
>=20
> I don't understand because all the other directories are created, I'm=20
> not sure what is missing here, any idea?
>=20
> (test branch is=20
> https://github.com/philmd/qemu/commits/travis_fetch_avocado)

This issue persists, OTOH the good news is caching is working:

https://travis-ci.org/github/philmd/qemu/builds/670078763#L1626


