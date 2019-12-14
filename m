Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B0C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BB62077B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pcu6gENk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BB62077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifwPL-0006xx-GP
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 20:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifwOi-0006Wq-SQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifwOh-0007uQ-7N
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:39:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifwOh-0007sf-19
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576287546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUh+xtArYtEffdKd7hr3LMOsE0p1PYuwn2xOw86Uueo=;
 b=Pcu6gENk+PRCgnBnABz32jMMFb8eaJXfNYTHFBNmnoQ3qRxHztISV0hxgl+Dc/O0ImEO7K
 xSeeIXtuSPBL/DJBbGcH/leESF5/s8QnA25MpdFx2OWVKl5nnrfd00mOe1VBHTU1RGVoza
 6lJwxgUBR+mUuQPGZYEEIiyGNqdTXR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-AOlZ2BwyPziPAkT9QZdy2g-1; Fri, 13 Dec 2019 20:39:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id b13so326503wrx.22
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 17:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6pihhpOz+OkwI5H51pJn3ch1EeTbGZAXU5rriEBpMgg=;
 b=A5Ype31J/NcoWIoAjnMFJHLffbQv7leW5qC5xdjeDITARHZRADi9kWonGc5j+2v03G
 f7gD6QuaxmmB1cEN7p7sCSNPlc5/AHGpKM7rOW0fEP055PTSej6THNHiQaP45uCRTVqU
 NJpcb7Jdht3y5Qf9CP+QSqrOJtoCTNJ+cz5N/mplVx+Ho0Ymzut9a/Fmwd5KNbOIBCkJ
 mrKy/GUrJfbLn9OblRO2lYjoqpv8gNP7xZUPkhRigUdVEcETBBQ1Kwf1wFGPH2D82CBI
 IU68joY6NtOqOOWi20TEbGkIY0pWQl9OdE0RLZxNQdyTbqZY7WAUyyf1L/WLyfVJffxY
 6k6Q==
X-Gm-Message-State: APjAAAVsiJCJX/yK7PngrTDIscjMnBJqqJ14qDnm8hroZvXH5dgnRxvO
 8HxdwoMZxs+tHbH2x+YOGZ1J81/fiZuW4ncGFjPeE7B4gcrmsUDRtfXMz9Y1fumyRHay2caZINY
 LEfRR7p7ouyyt4BA=
X-Received: by 2002:a5d:4386:: with SMTP id i6mr15985365wrq.63.1576287541369; 
 Fri, 13 Dec 2019 17:39:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxREcFAGrlzjN3y9GLu16XYm3zNnzqm/a+gc8vP72m9K6LIRIrPHBAkZQnuB+GmWMa9m423zw==
X-Received: by 2002:a5d:4386:: with SMTP id i6mr15985353wrq.63.1576287541165; 
 Fri, 13 Dec 2019 17:39:01 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id f17sm12223582wmc.8.2019.12.13.17.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 17:39:00 -0800 (PST)
Subject: Re: MIPS cache bypass on custom board
To: "Bensch, Alexander" <Alexander.Bensch@parsons.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <e3c2df7ae90747729a47d5f854e450e5@ALHUN12EXCH02.Parsons.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9ba23651-746a-5085-eff8-a048385e29ed@redhat.com>
Date: Sat, 14 Dec 2019 02:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e3c2df7ae90747729a47d5f854e450e5@ALHUN12EXCH02.Parsons.com>
Content-Language: en-US
X-MC-Unique: AOlZ2BwyPziPAkT9QZdy2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexander,

On 12/13/19 7:59 PM, Bensch, Alexander wrote:
> Hi all,
>=20
> Currently stuck on a problem in QEMU 4.0.0. I=92m trying to implement a=
=20
> custom device using a MIPS 24Kc CPU. The device boots from an SPI flash=
=20
> device that is mapped to 0x9F000000 (physical address 0x1F000000). I got=
=20
> the initial load and execute working by direct loading a flash dump to a=
=20
> MemoryRegion based at 0x1F000000, which worked great until the ROM=20
> needed to access the SPI registers that are addressed to 0xBF000000=20
> (/also /physical address 0x1F000000). QEMU cannot differentiate reads=20
> and writes to 0xBF000000 from reads and writes to 0x9F000000.
>=20
> Initially I assumed this was a caching problem, as I know that the SPI=20
> registers are located in the KSEG1 memory segment which uses uncached=20
> writes, while the flash mapping is in KSEG0 with cached writes. I also=20
> can see that QEMU has logic to handle caching in a few source files=20
> within /targets/mips//. However, when I read from addresses in the KSEG1=
=20
> region, I still see contents from the KSEG0 region.
>=20
> My question is whether there is any way to configure a MIPS board such=20
> that I can correctly bypass the cache for KSEG1 as expressed by the MIPS=
=20
> documentation?

Unfortunately QEMU doesn't model microarchitecture, thus no cache is=20
modelled, meaning KSEG1 is the same as KSEG0.

Peter Maydell had the similar problem you describe last year:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg556999.html

>=20
> Apologies if details are lacking. Please request more info if needed.
>=20
> Thank you,
>=20
> *Alex Bensch*


