Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE090C2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 10:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604482072C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 10:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUQLHTan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604482072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imbIS-0003HN-Ho
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 05:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imbHk-0002k7-2h
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 05:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imbHi-0007J0-RH
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 05:31:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imbHi-0007F9-M3
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 05:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577874685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zYnJk+9pYxnzuuQHTRHYlKqz9/MuFjxPOmzoQy3LeQ=;
 b=OUQLHTanJ9H0vTp9xwTOYROAeJBAsMAFhhdebNlq1ADC7K3e2nwQGFD6Th1q72Olw2PsMc
 vqarTVYCFDTh+Kwz6iaxvMp9QZq4GLHViwxv/SIq2z1o9njl2idYgM62ZhabVY/WE+r6Pm
 2Dn47h3D0Xe0puegWVFhd1i5A3fgWPk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-i9SN7enpMSKcVlykPQ3qtQ-1; Wed, 01 Jan 2020 05:31:23 -0500
Received: by mail-wr1-f69.google.com with SMTP id f15so5884574wrr.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 02:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vh632iazcbuSSGM+h03501jK3EvlAArxM+8pvCRARp8=;
 b=jjpb6No++H7EOnFf9sm52oDYicjsFjCWZ+785mKw+XZPhdLrrSIhQyCdoDnheOOPTu
 VSAvvN+RTkOg8F9eHTA6XlLsqsBGwJ16RWJtH/379wjp2fsFY1PERqYWTay/arxv8Vbr
 J0TPm+ZGndEB57H9N3vRHjvdFuFvBTMP8AU6rgKJZ495jBIfBXF9cWRK7/erKuG+LTlC
 NByFquCL/4UOIWdU23o+iAMyGEkaVfBeJVYwqro46PgJmsjfHFraGwvYQDpKoNA05I64
 3b6Eh2pv9hvVF7H/O4dyyIlrZaDFNAgP+EGDwG8UC98Sc3rUZ2pYvrfaVZSHus62Dn90
 1h6g==
X-Gm-Message-State: APjAAAXayp5bA9+gKQ1gW5sNQRym1CoEN075uo+7Mfxum1lUOkgjU4SN
 hw4/YaXU7KiTNUPTLFcGuAZKm1DrH8yt6jEUhyNRpDWNTzy84USmgkFRKMFPxZiQ+/nc4hMby/h
 Vv3rWdl2W4o17uuo=
X-Received: by 2002:adf:dd46:: with SMTP id u6mr30796701wrm.13.1577874681724; 
 Wed, 01 Jan 2020 02:31:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8GLBv92DEHYLIssVQvVoIkWypwMQbYgAXPhio3iOlVN2l2asXnXg1jEBDzoGDkUTjHua2hQ==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr30796674wrm.13.1577874681528; 
 Wed, 01 Jan 2020 02:31:21 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-140-248.w86-222.abo.wanadoo.fr.
 [86.222.91.248])
 by smtp.gmail.com with ESMTPSA id a5sm5126817wmb.37.2020.01.01.02.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2020 02:31:20 -0800 (PST)
Subject: Re: [PATCH 12/14] hw/nvram/Kconfig: Add an entry for the NMC93xx
 EEPROM
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-13-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf1bc1ee-99c2-e8b0-d4b1-8123d01b1165@redhat.com>
Date: Wed, 1 Jan 2020 11:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191231183216.6781-13-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: i9SN7enpMSKcVlykPQ3qtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 7:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The NMC93xx EEPROM is only used by few NIC cards and the
> Am53C974 SCSI controller.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Stefan Weil <sw@weilnetz.de>
> ---
>   hw/net/Kconfig         | 2 ++
>   hw/nvram/Kconfig       | 4 ++++
>   hw/nvram/Makefile.objs | 2 +-
>   hw/scsi/Kconfig        | 1 +
>   4 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 3856417d42..af6a11baf3 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -14,6 +14,7 @@ config EEPRO100_PCI
>       bool
>       default y if PCI_DEVICES
>       depends on PCI
> +    select NMC93XX_EEPROM
>  =20
>   config PCNET_PCI
>       bool
> @@ -28,6 +29,7 @@ config TULIP
>       bool
>       default y if PCI_DEVICES
>       depends on PCI
> +    select NMC93XX_EEPROM
>  =20
>   config E1000_PCI
>       bool
> diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
> index ebaa749ce9..e082a5610c 100644
> --- a/hw/nvram/Kconfig
> +++ b/hw/nvram/Kconfig
> @@ -7,3 +7,7 @@ config AT24C
>  =20
>   config MAC_NVRAM
>       bool
> +
> +# NMC93XX uses the NS =CE=BCWire interface (similar to SPI but less conf=
igurable)

Ah this line triggers:

Traceback (most recent call last):
   File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line=20
700, in <module>
     parser.parse_file(fp)
   File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line=20
362, in parse_file
     self.parse_config()
   File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line=20
575, in parse_config
     self.parse_clause()
   File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line=20
564, in parse_clause
     self.do_include(val)
   File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line=20
413, in do_include
     KconfigParser(self.data).parse_file(fp)
   File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line=20
355, in parse_file
     self.src =3D fp.read()
   File "/usr/lib/python3.5/encodings/ascii.py", line 26, in decode
     return codecs.ascii_decode(input, self.errors)[0]
UnicodeDecodeError: 'ascii' codec can't decode byte 0xce in position=20
138: ordinal not in range(128)

> +config NMC93XX_EEPROM
> +    bool
> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
> index 26f7b4ca35..a4bdfbf187 100644
> --- a/hw/nvram/Makefile.objs
> +++ b/hw/nvram/Makefile.objs
> @@ -1,5 +1,5 @@
>   common-obj-$(CONFIG_DS1225Y) +=3D ds1225y.o
> -common-obj-y +=3D eeprom93xx.o
> +common-obj-$(CONFIG_NMC93XX_EEPROM) +=3D eeprom93xx.o
>   common-obj-$(CONFIG_AT24C) +=3D eeprom_at24c.o
>   common-obj-y +=3D fw_cfg.o
>   common-obj-y +=3D chrp_nvram.o
> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> index b3ba540c17..77d397c949 100644
> --- a/hw/scsi/Kconfig
> +++ b/hw/scsi/Kconfig
> @@ -34,6 +34,7 @@ config ESP_PCI
>       default y if PCI_DEVICES
>       depends on PCI
>       select ESP
> +    select NMC93XX_EEPROM
>  =20
>   config SPAPR_VSCSI
>       bool
>=20


