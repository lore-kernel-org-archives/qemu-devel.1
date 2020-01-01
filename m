Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3615C2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 16:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7562080A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 16:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqC7Dwwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7562080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imghT-00045B-PD
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 11:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imggK-0003Lv-0q
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 11:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imggH-0007aT-Dc
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 11:17:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imggH-0007Wa-3b
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 11:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577895428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TB2qeUfjNzPayNhs7grNU1cLsnDB8AzhPXrIGhCt+M=;
 b=QqC7DwwkWNjEgPKnHrleJnmhLHPVAhLBsRiuulkMgIQ7g0uHho2CXm2TBGmdMos2v0UugL
 SwdUtDfG126yxOGuczy7Z/5Fnb/l9NtYZMKoUcLVVipkRgwdVtZY/K5uKTfRBoa0dMgLfr
 CwWponA86B5vT9x62b4IMoASOQxsb4c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-XIiAdRsONfqG2EO7IoYe8Q-1; Wed, 01 Jan 2020 11:17:05 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so20513142wrt.15
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 08:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zWjgdSBretFRmMMGnMcVXVWegMbbw3YeYljaydlJRg8=;
 b=ZsAkG55IEPVua1ys8nAX9ewZXZ+cm8nR1UhYTZd8IdPyBO5YOIf7CDoFQkfHJmSQrj
 eKz0j4wjhcbFLGWaZTy7iIqU4SkyD+rB8UiwSZQMNd9NT8TyufugbTjM3b5Tr4OqP4a7
 Im5Uw0i0TwtObnbX2UhXWbP7NQkqXwi5rLTsLWl+9SpLZ1YTHAu3uSD1guWz2KyFUyQ6
 s7szCTsd8+yhBTeJvYaR6jKQFKUEFQ+IAiiTUeb5xYOanmdRhMtukD0XOIEDb8Qjrh7u
 gDRuyJmBS/WCwnB45yyFIH5SPq4HsZE9uLzGocj9MmoiYTtUuE4clqwwwQZq+eszIZt+
 txwA==
X-Gm-Message-State: APjAAAUaDfSkKb65Sbxw4Zkw/FsGLqB5y1kJlkOeFeGelAwmzfOsQnau
 YHSbfczMNOOSRktIgNH1Uoj3ntFIUAai/vextkyXuVLXsaCzoFO6wCiASm48iePxxx0KcjYQrxP
 wx6Z6UO0AnjhC3rY=
X-Received: by 2002:a5d:528e:: with SMTP id c14mr81445987wrv.308.1577895424355; 
 Wed, 01 Jan 2020 08:17:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKQ5dMv7ji6LsC4dXalGwE98EMv3KbURHbZKmRbpRz/VmU+wOCBOUhJn3K7yOe2XlvnJpd7w==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr81445951wrv.308.1577895424071; 
 Wed, 01 Jan 2020 08:17:04 -0800 (PST)
Received: from [10.30.42.123] ([62.102.229.57])
 by smtp.gmail.com with ESMTPSA id q11sm52357710wrp.24.2020.01.01.08.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2020 08:17:03 -0800 (PST)
Subject: Re: [PATCH 05/14] hw/i2c/Kconfig: Add an entry for the SMBus
To: cminyard@mvista.com
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-6-philmd@redhat.com> <20191231191600.GB6497@minyard.net>
 <89c243b7-bbd0-78cc-67ba-34e0fb19e1bd@redhat.com>
 <20200101161558.GC6454@minyard.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e171b2b3-22de-d4d5-1b1d-c988dbe3744c@redhat.com>
Date: Wed, 1 Jan 2020 17:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200101161558.GC6454@minyard.net>
Content-Language: en-US
X-MC-Unique: XIiAdRsONfqG2EO7IoYe8Q-1
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

On 1/1/20 5:15 PM, Corey Minyard wrote:
> On Wed, Jan 01, 2020 at 11:25:42AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 12/31/19 8:16 PM, Corey Minyard wrote:
>>> On Tue, Dec 31, 2019 at 07:32:07PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>>> The System Management Bus is more or less a derivative of the I2C
>>>> bus, thus the Kconfig entry depends of I2C.
>>>> Not all boards providing an I2C bus support SMBus.
>>>> Use two different Kconfig entries to be able to select I2C without
>>>> selecting SMBus.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>> Cc: Corey Minyard <cminyard@mvista.com>
>>>> ---
>>>>    default-configs/mips-softmmu-common.mak | 1 +
>>>>    hw/i2c/Kconfig                          | 8 ++++++--
>>>>    hw/i2c/Makefile.objs                    | 3 ++-
>>>>    3 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs=
/mips-softmmu-common.mak
>>>> index da29c6c0b2..ac76d944b8 100644
>>>> --- a/default-configs/mips-softmmu-common.mak
>>>> +++ b/default-configs/mips-softmmu-common.mak
>>>> @@ -37,6 +37,7 @@ CONFIG_R4K=3Dy
>>>>    CONFIG_MALTA=3Dy
>>>>    CONFIG_PCNET_PCI=3Dy
>>>>    CONFIG_MIPSSIM=3Dy
>>>> +CONFIG_SMBUS=3Dy
>>>
>>> Why is the above necessary?  Wouldn't CONFIG_ACPI_SMBUS=3Dy below cause
>>> this to be done?
>>
>> Yes you are correct!
>>
>>>
>>>>    CONFIG_ACPI_SMBUS=3Dy
>>>>    CONFIG_SMBUS_EEPROM=3Dy
>>>>    CONFIG_TEST_DEVICES=3Dy
>>>> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
>>>> index 2bbd395813..09642a6dcb 100644
>>>> --- a/hw/i2c/Kconfig
>>>> +++ b/hw/i2c/Kconfig
>>>> @@ -1,9 +1,13 @@
>>>>    config I2C
>>>>        bool
>>>> +config SMBUS
>>>> +    bool
>>>> +    select I2C
>>>> +
>>>>    config SMBUS_EEPROM
>>>>        bool
>>>> -    depends on I2C
>>>> +    select SMBUS
>>>>    config VERSATILE_I2C
>>>>        bool
>>>> @@ -11,7 +15,7 @@ config VERSATILE_I2C
>>>>    config ACPI_SMBUS
>>>>        bool
>>>> -    select I2C
>>>> +    select SMBUS
>>>>    config BITBANG_I2C
>>>>        bool
>>>> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
>>>> index d7073a401f..cbbc8507a3 100644
>>>> --- a/hw/i2c/Makefile.objs
>>>> +++ b/hw/i2c/Makefile.objs
>>>> @@ -1,4 +1,5 @@
>>>> -common-obj-$(CONFIG_I2C) +=3D core.o smbus_slave.o smbus_master.o
>>>> +common-obj-$(CONFIG_I2C) +=3D core.o
>>>> +common-obj-$(CONFIG_SMBUS) +=3D smbus_slave.o smbus_master.o
>>>>    common-obj-$(CONFIG_SMBUS_EEPROM) +=3D smbus_eeprom.o
>>>>    common-obj-$(CONFIG_VERSATILE_I2C) +=3D versatile_i2c.o
>>>>    common-obj-$(CONFIG_ACPI_X86_ICH) +=3D smbus_ich9.o
>>>
>>> There is some messiness with ICH, but it appears that everything will
>>> work correctly there and this patch is not the right place to fix it.
>>
>> I did some cleaning with the ICH9 chipset last year, I need to find some
>> time to refresh it.
>>
>>> This looks fine and avoids including smbus code when it is not
>>> necessary.  With the MIPS config item removed (assuming it is not
>>> necessary):
>>>
>>> Reviewed-by: Corey Minyard <cminyard@mvista.com>
>>
>> Thanks!
>>
>>>
>>> I can take it into my tree if you like.
>>
>> Sure, do you mind cleaning default-configs/mips-softmmu-common.mak or yo=
u
>> prefer a respin of this single patch?
>=20
> I removed that piece and have it queued.

Thanks!

Phil.


