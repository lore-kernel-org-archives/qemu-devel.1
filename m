Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388ACC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0772C2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9Nc9NtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0772C2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomZw-0000Bx-R9
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iolnB-0002Ib-1H
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ioln9-0005Ce-F1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:08:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ioln9-0005CD-BV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/P9VLF0io03BjGg4rKlfATlz5W/poXmAz89j60scz7g=;
 b=Y9Nc9NtU1V4cfh97Uzra8U8IA5w5aasCx/Hz/up+4cBdvn6q1YINHtgVr05rCfTwp+gX8l
 5INY8ilwGteBjXCvBY/7bLIuPGepSjWMzDBzWF04nxS0nzrksdu5rAZg+kNbwQ3Fwv6i10
 Zwpc0p4/Ij19n3tRhMWUv7L6ZBKkMb8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-0Zyt1zPCPsSpxFDVvctj3g-1; Tue, 07 Jan 2020 05:08:49 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so27196587wrm.16
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7dqdNCqzoLIXdB/GkpZC55KyDexZZMslXoKBOViIu6k=;
 b=NQjPIDQPX5at4atgqPtDCAjvIzct6iprusoK+Z3s+c1xA8K17zdVZk1Meyy2O3sxng
 L2MpfNVh4F8NFSJv3024FciHMnOwmZNiYQ39i8nU15uz/D0Lny0A67fK3TgtFj8nGrhV
 JnyMX3T4iYXEEmjMgQO6J0yNP245xA9ewq5M5dodlmdmDANRuSeW0dsN+/+D1j4khbTb
 qkwuuzVVP+uccHCg7tbdOT1OmorqsKqK2TYR7ASxQG8yusQIacwcElG6MBp5lqsJHVJ9
 GPwrIrXYKPEhsEQln/QLNxuEl7X4HF14J8xk6fMxuB9DO5pS5OhEHElRtmCoJobE7SfU
 /QWg==
X-Gm-Message-State: APjAAAXvEmCRNTj3bss/n965bOacX3SDG7B0zZzfni/NgP38/tyKMlws
 EPpO3BgHmQN8j6vx8Hs1xbUN5G6xoEGipOH/u+BfRR68is8JWki9/e1YNvjOTigTtv8ddAsv2zw
 73lbEqAS/79ByrHg=
X-Received: by 2002:a1c:80d4:: with SMTP id
 b203mr38716011wmd.102.1578391728484; 
 Tue, 07 Jan 2020 02:08:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuayVu5etcXl6mB4VcWFJime7aHa5RaezjRxhcB0P2SxuRm56dfZPVXwCxTyCxdXegwEvfbw==
X-Received: by 2002:a1c:80d4:: with SMTP id
 b203mr38715986wmd.102.1578391728230; 
 Tue, 07 Jan 2020 02:08:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id f1sm76266465wru.6.2020.01.07.02.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:08:47 -0800 (PST)
Subject: Re: [PATCH 12/14] hw/nvram/Kconfig: Add an entry for the NMC93xx
 EEPROM
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-13-philmd@redhat.com>
 <bf1bc1ee-99c2-e8b0-d4b1-8123d01b1165@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a355b8fc-dfaf-f42f-71f2-8318fa1b5dcd@redhat.com>
Date: Tue, 7 Jan 2020 11:08:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bf1bc1ee-99c2-e8b0-d4b1-8123d01b1165@redhat.com>
Content-Language: en-US
X-MC-Unique: 0Zyt1zPCPsSpxFDVvctj3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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

On 01/01/20 11:31, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/31/19 7:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> The NMC93xx EEPROM is only used by few NIC cards and the
>> Am53C974 SCSI controller.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Stefan Weil <sw@weilnetz.de>
>> ---
>> =C2=A0 hw/net/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2 ++
>> =C2=A0 hw/nvram/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
>> =C2=A0 hw/nvram/Makefile.objs | 2 +-
>> =C2=A0 hw/scsi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>> =C2=A0 4 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
>> index 3856417d42..af6a11baf3 100644
>> --- a/hw/net/Kconfig
>> +++ b/hw/net/Kconfig
>> @@ -14,6 +14,7 @@ config EEPRO100_PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y if PCI_DEVICES
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on PCI
>> +=C2=A0=C2=A0=C2=A0 select NMC93XX_EEPROM
>> =C2=A0 =C2=A0 config PCNET_PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> @@ -28,6 +29,7 @@ config TULIP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y if PCI_DEVICES
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on PCI
>> +=C2=A0=C2=A0=C2=A0 select NMC93XX_EEPROM
>> =C2=A0 =C2=A0 config E1000_PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
>> index ebaa749ce9..e082a5610c 100644
>> --- a/hw/nvram/Kconfig
>> +++ b/hw/nvram/Kconfig
>> @@ -7,3 +7,7 @@ config AT24C
>> =C2=A0 =C2=A0 config MAC_NVRAM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> +
>> +# NMC93XX uses the NS =CE=BCWire interface (similar to SPI but less
>> configurable)

Changed to uWire.  Gotta love Python 3. :)

Paolo

> Ah this line triggers:
>=20
> Traceback (most recent call last):
> =C2=A0 File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line
> 700, in <module>
> =C2=A0=C2=A0=C2=A0 parser.parse_file(fp)
> =C2=A0 File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line
> 362, in parse_file
> =C2=A0=C2=A0=C2=A0 self.parse_config()
> =C2=A0 File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line
> 575, in parse_config
> =C2=A0=C2=A0=C2=A0 self.parse_clause()
> =C2=A0 File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line
> 564, in parse_clause
> =C2=A0=C2=A0=C2=A0 self.do_include(val)
> =C2=A0 File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line
> 413, in do_include
> =C2=A0=C2=A0=C2=A0 KconfigParser(self.data).parse_file(fp)
> =C2=A0 File "/root/src/github.com/philmd/qemu/scripts/minikconf.py", line
> 355, in parse_file
> =C2=A0=C2=A0=C2=A0 self.src =3D fp.read()
> =C2=A0 File "/usr/lib/python3.5/encodings/ascii.py", line 26, in decode
> =C2=A0=C2=A0=C2=A0 return codecs.ascii_decode(input, self.errors)[0]
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xce in position
> 138: ordinal not in range(128)
>=20
>> +config NMC93XX_EEPROM
>> +=C2=A0=C2=A0=C2=A0 bool
>> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
>> index 26f7b4ca35..a4bdfbf187 100644
>> --- a/hw/nvram/Makefile.objs
>> +++ b/hw/nvram/Makefile.objs
>> @@ -1,5 +1,5 @@
>> =C2=A0 common-obj-$(CONFIG_DS1225Y) +=3D ds1225y.o
>> -common-obj-y +=3D eeprom93xx.o
>> +common-obj-$(CONFIG_NMC93XX_EEPROM) +=3D eeprom93xx.o
>> =C2=A0 common-obj-$(CONFIG_AT24C) +=3D eeprom_at24c.o
>> =C2=A0 common-obj-y +=3D fw_cfg.o
>> =C2=A0 common-obj-y +=3D chrp_nvram.o
>> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
>> index b3ba540c17..77d397c949 100644
>> --- a/hw/scsi/Kconfig
>> +++ b/hw/scsi/Kconfig
>> @@ -34,6 +34,7 @@ config ESP_PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y if PCI_DEVICES
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ESP
>> +=C2=A0=C2=A0=C2=A0 select NMC93XX_EEPROM
>> =C2=A0 =C2=A0 config SPAPR_VSCSI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>>
>=20


