Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C675AC2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 10:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890AC2072C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 10:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dleZ5t/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890AC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imbCx-0001r2-Lg
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 05:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imbCJ-0001Mj-Ca
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 05:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imbCG-0007un-UX
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 05:25:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57249
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imbCG-0007q9-Qp
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 05:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577874347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZkfJutedCIw0/pZfm2id8hQShuefXwjzB7aFMrxVmg=;
 b=dleZ5t/qcGthEeMNocCkl0+lKBGSOqNcFhlSEArYz181px/HhN+sqvbSAncDtkliyQMRVA
 3cFT2bD4MNocR0pPRry/J5dm4zW3Npu5yWDw9ZW+49xRkfZHH9YznmhO32rPeqTrzHDKzg
 Oe47D6SnBtZy92edO3tXIJNq8wXn0pk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-IpoM-erUPIeit3OE8ZZ3fg-1; Wed, 01 Jan 2020 05:25:46 -0500
Received: by mail-wr1-f71.google.com with SMTP id z15so2366759wrw.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 02:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rUfewwdeAGajwO5/LUlGZlQoB27aPJn3ZYyk8X9BX6A=;
 b=YD1u0VHgRChf11P51xKtDfs5EkFkvHwDRYNeRnrGoh88WsMN7cAr26YPxDEGDz6bgh
 zbREY7JqECUkLF81vQQPJJmrfekfTG8eU+Xc1rK2THh6a9Sw2kwNVFq5ecjsuFMdNNcK
 8Oo9jFkaB6Ov4GRqW1ez4hYuybTkBPHUF1FTw6Gt9dStuOBs85FZoz/XCGwh5EZqFWW0
 GKiIWPtxMd85hLdDkdjmPtxZ79BSIZtvfX69uda0OekqltX8sIsvdKsZuZogVrUMSmvL
 moVafEGBB1fSy+8roOd9J8D3p9enF63/uHTjMdzDzHgz3cK0luWQ1f0uMNYC3ndn/uzk
 1m+Q==
X-Gm-Message-State: APjAAAXQIF0UuXXOhBOVMA4BjFxosyRRWfTFZ8CcPYRy/63kIzcdHo43
 LgHQuYBvjenOo6rH96ZAOpJROzd8HIwZfA05c652Rj6lrY1JaCO4YE3548LGHLlq4jPdSEA52Kp
 P6zWkVBoCIEzy+OI=
X-Received: by 2002:a1c:9a52:: with SMTP id c79mr8811443wme.127.1577874345424; 
 Wed, 01 Jan 2020 02:25:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxS1dfu8uqra1KqeJg8psF8qsd5poX+7XTgRzUjujZ4Q1qmNGwIeTvhB8szJtn1/yWmAOcDrQ==
X-Received: by 2002:a1c:9a52:: with SMTP id c79mr8811412wme.127.1577874345129; 
 Wed, 01 Jan 2020 02:25:45 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-140-248.w86-222.abo.wanadoo.fr.
 [86.222.91.248])
 by smtp.gmail.com with ESMTPSA id z6sm53994720wrw.36.2020.01.01.02.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2020 02:25:44 -0800 (PST)
Subject: Re: [PATCH 05/14] hw/i2c/Kconfig: Add an entry for the SMBus
To: cminyard@mvista.com
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-6-philmd@redhat.com> <20191231191600.GB6497@minyard.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <89c243b7-bbd0-78cc-67ba-34e0fb19e1bd@redhat.com>
Date: Wed, 1 Jan 2020 11:25:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191231191600.GB6497@minyard.net>
Content-Language: en-US
X-MC-Unique: IpoM-erUPIeit3OE8ZZ3fg-1
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 8:16 PM, Corey Minyard wrote:
> On Tue, Dec 31, 2019 at 07:32:07PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> The System Management Bus is more or less a derivative of the I2C
>> bus, thus the Kconfig entry depends of I2C.
>> Not all boards providing an I2C bus support SMBus.
>> Use two different Kconfig entries to be able to select I2C without
>> selecting SMBus.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Corey Minyard <cminyard@mvista.com>
>> ---
>>   default-configs/mips-softmmu-common.mak | 1 +
>>   hw/i2c/Kconfig                          | 8 ++++++--
>>   hw/i2c/Makefile.objs                    | 3 ++-
>>   3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/m=
ips-softmmu-common.mak
>> index da29c6c0b2..ac76d944b8 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -37,6 +37,7 @@ CONFIG_R4K=3Dy
>>   CONFIG_MALTA=3Dy
>>   CONFIG_PCNET_PCI=3Dy
>>   CONFIG_MIPSSIM=3Dy
>> +CONFIG_SMBUS=3Dy
>=20
> Why is the above necessary?  Wouldn't CONFIG_ACPI_SMBUS=3Dy below cause
> this to be done?

Yes you are correct!

>=20
>>   CONFIG_ACPI_SMBUS=3Dy
>>   CONFIG_SMBUS_EEPROM=3Dy
>>   CONFIG_TEST_DEVICES=3Dy
>> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
>> index 2bbd395813..09642a6dcb 100644
>> --- a/hw/i2c/Kconfig
>> +++ b/hw/i2c/Kconfig
>> @@ -1,9 +1,13 @@
>>   config I2C
>>       bool
>>  =20
>> +config SMBUS
>> +    bool
>> +    select I2C
>> +
>>   config SMBUS_EEPROM
>>       bool
>> -    depends on I2C
>> +    select SMBUS
>>  =20
>>   config VERSATILE_I2C
>>       bool
>> @@ -11,7 +15,7 @@ config VERSATILE_I2C
>>  =20
>>   config ACPI_SMBUS
>>       bool
>> -    select I2C
>> +    select SMBUS
>>  =20
>>   config BITBANG_I2C
>>       bool
>> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
>> index d7073a401f..cbbc8507a3 100644
>> --- a/hw/i2c/Makefile.objs
>> +++ b/hw/i2c/Makefile.objs
>> @@ -1,4 +1,5 @@
>> -common-obj-$(CONFIG_I2C) +=3D core.o smbus_slave.o smbus_master.o
>> +common-obj-$(CONFIG_I2C) +=3D core.o
>> +common-obj-$(CONFIG_SMBUS) +=3D smbus_slave.o smbus_master.o
>>   common-obj-$(CONFIG_SMBUS_EEPROM) +=3D smbus_eeprom.o
>>   common-obj-$(CONFIG_VERSATILE_I2C) +=3D versatile_i2c.o
>>   common-obj-$(CONFIG_ACPI_X86_ICH) +=3D smbus_ich9.o
>=20
> There is some messiness with ICH, but it appears that everything will
> work correctly there and this patch is not the right place to fix it.

I did some cleaning with the ICH9 chipset last year, I need to find some=20
time to refresh it.

> This looks fine and avoids including smbus code when it is not
> necessary.  With the MIPS config item removed (assuming it is not
> necessary):
>=20
> Reviewed-by: Corey Minyard <cminyard@mvista.com>

Thanks!

>=20
> I can take it into my tree if you like.

Sure, do you mind cleaning default-configs/mips-softmmu-common.mak or=20
you prefer a respin of this single patch?

>=20
> Thanks,
>=20
> -corey
>=20
>> --=20
>> 2.21.0
>>
>=20


