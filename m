Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA463C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F15C206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5TqX2g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F15C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6xf-0005g9-ME
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iw6wq-00055N-I5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iw6wp-0004t1-2P
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:09:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iw6wo-0004sc-VQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580141350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVmB7YcFiUwYBFjLmovIRl9f7swqE+gVuOWaQiP6Fuc=;
 b=F5TqX2g/bgBtAiDDkkBPbjlIsltlE1x8bCw5yz0jqb0SgYIFsqTbvQYqhan5m3MClBa3Hh
 +zIGz8aWiTGIN26pIFJbS0QZSjRO9DJDLkJKCG1S3vdyR2k0CX8DGc05RZVIXgP2HCplE/
 rXzLLn6bxx10P91zGv7s7SRbxTcDzdE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-q1qBEzcMMD2pYnzsyEDhOQ-1; Mon, 27 Jan 2020 11:09:06 -0500
Received: by mail-wr1-f71.google.com with SMTP id u12so6287634wrt.15
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 08:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D+Yt3nJ7VwPy/OdeOqWBLKPQIy+lce60X+aaHgjgj0g=;
 b=RrF9vl99FI0iKgtFFISoRnAlLQY5XbJGrfcDoZxnU8ZBv0jLDoPZw3gVInfP5X+Hnt
 GG9ZYb0cMnPQM7DaQZfNrXDK8Cknn8RMsE6QMSX0vCMBkHfodY7LZ4LyRNCggxDBPfGe
 cW/s13yYpw9o2CFlbXF952VS738YZ42Ye9ieTOYvlvQv868DhhPk3jzKH0jvzrH27GZ6
 VBHyDFJf7Yd/lMbp57tIrPnk0hvw3PdZzRHhfLHarrZhKtHBmfZq48qRdKiD6lQa6mQJ
 Eci664pgUpBg16p59m3UPxleb2pa1FeghIW5mrZqK81ELnaHtxTsJhrXeFLQAB6ko/8e
 +VCw==
X-Gm-Message-State: APjAAAXM8jfTzO5Lhjq4POtaCEbYqU1bRomBvJyhNWYIfafBjWcIrvUe
 PyzkJS7Pqtk5695U5R5cisgPmcKswyfpLL4F2BEjKCquTLeWwPo/VeEkZxvsvILrzlJDwGky7Lv
 QT4xPJrmmgtNz//o=
X-Received: by 2002:a05:600c:2207:: with SMTP id
 z7mr14683968wml.138.1580141345156; 
 Mon, 27 Jan 2020 08:09:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjYf/x0euYVfFJFEN0eHouqkGj3uN7aIdO6AJPHGmiUu+MH5LJEeLP7J6CDO4tnwsc5VQ4IA==
X-Received: by 2002:a05:600c:2207:: with SMTP id
 z7mr14683950wml.138.1580141344869; 
 Mon, 27 Jan 2020 08:09:04 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z3sm21180411wrs.94.2020.01.27.08.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 08:09:04 -0800 (PST)
Subject: Re: [PATCH v4 5/7] tests/boot_linux_console: Test booting U-Boot on
 the Raspberry Pi 2
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-6-f4bug@amsat.org>
 <d432f2d7-f238-0503-a242-373be81b7622@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5e986679-7aff-a33c-eefb-d878b72089ad@redhat.com>
Date: Mon, 27 Jan 2020 17:09:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d432f2d7-f238-0503-a242-373be81b7622@redhat.com>
Content-Language: en-US
X-MC-Unique: q1qBEzcMMD2pYnzsyEDhOQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 5:02 PM, Thomas Huth wrote:
> On 21/01/2020 00.51, Philippe Mathieu-Daud=C3=A9 wrote:
>> This test runs U-Boot on the Raspberry Pi 2.
>> It is very simple and fast:
>>
>>    $ avocado --show=3Dapp,console run -t raspi2 -t u-boot tests/acceptan=
ce/
>>    JOB LOG    : avocado/job-results/job-2020-01-20T23.40-2424777/job.log
>>     (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_raspi2_uboot:
>>    console: MMC:   sdhci@7e300000: 0
>>    console: Loading Environment from FAT... Card did not respond to volt=
age select!
>>    console: In:    serial
>>    console: Out:   vidconsole
>>    console: Err:   vidconsole
>>    console: Net:   No ethernet found.
>>    console: starting USB...
>>    console: USB0:   Port not available.
>>    console: Hit any key to stop autoboot:  0
>>    console: U-Boot>
>>    console: U-Boot> bdinfo
>>    console: arch_number =3D 0x00000000
>>    console: boot_params =3D 0x00000100
>>    console: DRAM bank   =3D 0x00000000
>>    console: -> start    =3D 0x00000000
>>    console: -> size     =3D 0x3c000000
>>    console: baudrate    =3D 115200 bps
>>    console: TLB addr    =3D 0x3bff0000
>>    console: relocaddr   =3D 0x3bf64000
>>    console: reloc off   =3D 0x3bf5c000
>>    console: irq_sp      =3D 0x3bb5fec0
>>    console: sp start    =3D 0x3bb5feb0
>>    console: Early malloc usage: 2a4 / 400
>>    console: fdt_blob    =3D 0x3bfbdfb0
>>    console: U-Boot> version
>>    console: U-Boot 2019.01+dfsg-7 (May 14 2019 - 02:07:44 +0000)
>>    console: gcc (Debian 8.3.0-7) 8.3.0
>>    console: GNU ld (GNU Binutils for Debian) 2.31.1
>>    console: U-Boot> reset
>>    console: resetting ...
>>    PASS (0.46 s)
>>
>> U-Boot is built by the Debian project, see:
>> https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable=
_SD_Card_with_u-boot
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   tests/acceptance/boot_linux_console.py | 28 ++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/b=
oot_linux_console.py
>> index e40b84651b..682b801b4f 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>=20
> The file is called boot_*linux*_console.py ... so shouldn't tests that
> don't use Linux rather go into another file instead?
> Either machine_arm_raspi.py or maybe a boot_firmware_console.py file?

Yes I have a series ready splitting boot_linux_console.py per machines=20
(as suggested machine_arm_raspi.py) not for consistency with fw/linux=20
but because I'm tired of fixing conflicts while rebasing since months.


