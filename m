Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCF9C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D342133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHa/hU+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D342133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFcsF-0001cc-Le
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFcqa-0000id-3X
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFcqY-00086H-I5
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:31:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFcqY-00085q-5p
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570015865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WdaSxW92qd5T/lqyUmayjtG4+85CSvKjiZbH5XMeqLc=;
 b=eHa/hU+01myWh94FHaAop5ajcDzwa277q6WMksuNxrrA2CnaXvK9uI0R+Jy51WF3SNrhql
 IPbFV7D10uqLHYpSa6FIGcRUTR+yhOwQ3Y6JPNtV7KBjl2VkEVAjZF9OZIEYusYbeU6EgF
 D4fWz8dhi6tucYOypywsTEHLMTCw/j8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-256X608nMXWh_6oD2HWMEA-1; Wed, 02 Oct 2019 07:31:03 -0400
Received: by mail-wm1-f70.google.com with SMTP id o8so2881713wmc.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 04:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rfy8jShrwghwj6spBMk6l+V2vyTzkBooV4RuJEtMc28=;
 b=bkxpLCateJ8nLZM+/dO+DphV8fibZrzKsvQ9b/1tF1h1od8lgajpYMpTKXsfg6s+kc
 BlqoypXYTblWmkRiREpKwjcN1z5SH0T5FUj1wpWjwIqOS2IUEe51MS1pFY/Ve6q9z7eJ
 sW6VuLu7x8yR4T7YDWquLgEZki8yWcNKkq5qVG6XbTO0rBreaPb7F5hJKgKKx/6ST7NQ
 3sjqbDnJH+ruaA39WEetJSC9XZPjhmLRrEWuSyqyF/x1zT4hF5YubAa/NZnETmeMqMG6
 wVr7a6RUpyo/6z/bQKBj9peQUWjchwHzC10Z4OkCC4Za1qRJ/3AnV7WSLYOiXelhuync
 l11A==
X-Gm-Message-State: APjAAAWyq3tbrEFVWWX7gzc+OTjCiYLN5gVkdM0sVhU3NSjKqCqHiQj/
 YZJPWfLi5HYi/svvctaMf7Mo/N3cICXdZxxWai5Y6tE15f1Z/ecfO+agbskYUyxhMmgeGb82Chg
 02o2FasD6ISMCuuw=
X-Received: by 2002:a05:600c:2386:: with SMTP id
 m6mr2560222wma.164.1570015862670; 
 Wed, 02 Oct 2019 04:31:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqynh1+yhhHslxF3+MkKGvMgahMzxx+wj/fsoKhWtoS0w92e3W6AYBFlMhokhknaVuScyZK15w==
X-Received: by 2002:a05:600c:2386:: with SMTP id
 m6mr2560204wma.164.1570015862468; 
 Wed, 02 Oct 2019 04:31:02 -0700 (PDT)
Received: from [10.201.33.15] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id n1sm31809615wrg.67.2019.10.02.04.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 04:31:01 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 12/19] hw/isa: Declare device little or big
 endian
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566829168.git.tony.nguyen@bt.com>
 <27e2352289217228aa255eaeb997ed1fded48c01.1566829168.git.tony.nguyen@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <595b3aff-9682-29fd-10c9-cbaf84423557@redhat.com>
Date: Wed, 2 Oct 2019 13:31:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <27e2352289217228aa255eaeb997ed1fded48c01.1566829168.git.tony.nguyen@bt.com>
Content-Language: en-US
X-MC-Unique: 256X608nMXWh_6oD2HWMEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/19 4:21 PM, Tony Nguyen wrote:
> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> targets from the set of target/hw/*/device.o.
>=20
> If the set of targets are all little or all big endian, re-declare
> as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN respectively.
>=20
> Then, on inspection:
> - if not used, re-declare as DEVICE_HOST_ENDIAN.
> - if max/min size=3D1, re-declare as DEVICE_HOST_ENDIAN.

Here you say DEVICE_HOST_ENDIAN,

> - if just a bit bucket, re-declare as DEVICE_HOST_ENDIAN
> - if PCI, re-declare as DEVICE_LITTLE_ENDIAN.
> - if for {ARM|unicore32} only, re-declare as DEVICE_LITTLE_ENDIAN.
> - if for SPARC only, re-declare as DEVICE_BIG_ENDIAN.
>=20
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>   hw/isa/vt82c686.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 50bd28fa82..400f2b3c87 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -109,7 +109,7 @@ static uint64_t superio_ioport_readb(void *opaque, hw=
addr addr, unsigned size)
>   static const MemoryRegionOps superio_ops =3D {
>       .read =3D superio_ioport_readb,
>       .write =3D superio_ioport_writeb,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,

But here you use DEVICE_LITTLE_ENDIAN.

For 8-bit I/O port endianess doesn't matter, so I'm not sure what is the=20
correct choice. Can we simply remove the .endianness line, since the=20
won't be ever used?

>       .impl =3D {
>           .min_access_size =3D 1,
>           .max_access_size =3D 1,
>=20


