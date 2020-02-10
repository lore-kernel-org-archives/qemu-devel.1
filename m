Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F445C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFADE2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8kJZz+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFADE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15wN-00075i-6X
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 05:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j15uw-00061g-IN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j15uv-0000aa-4b
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:03:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j15uv-0000Zr-1i
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581329028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLYpZlV9+uDIFJrGMqLMbQayl69T21ST4M8dMLeBfp8=;
 b=c8kJZz+PeOK7/rcHn1lJSFFJBB6X5vRQWQsa2NPOVLp2iDIj5ySqQIO+DvSbrAB8tn6nH4
 3YHMk5ScwGBg7LCS7tftWJ+VlodLbTwA1H6ar8veLar/gbn1hzbJ9RmXsMXL28GzuWd0gY
 QhqMowWZHOdAiqpuL1ApUrDzUxulrUA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-ZyNlZyRWMVWfDvPHv4gKSg-1; Mon, 10 Feb 2020 05:03:44 -0500
Received: by mail-wm1-f69.google.com with SMTP id p2so2805646wma.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 02:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lEhnb6Cth6xROqsu5iiv/oZfGsAEK7hLaGuWixp3v6M=;
 b=n5IfctN3vTSd14Gc50qcgZiCvxJ3b6f0qWWKohHGfMoE2UUgpPg67tRgmxMB1k9owV
 6St6CRNm1nrEePLX1b0y1y4qZAETdGr38M3lXp61d/wMWdYhZ/UMXZJ3RZwOKbUrRygM
 tqR36rC5kGMkhquDRiIFQLn/jWDEiIm/AaAAA1MPA3U8IDlP868V55iPrY4RHje7E3xB
 eMIMhQeMUoZsT8Ci55+UUV4WsBlpA6T2rgMUV+avHbqOm+sH/4OYpqrsHmBj4lOY1p86
 EY77vjnRBADkD2XGHyimuG5kyg+8jxL+erxDnHViPV/9r9gOaI//a/kSmRm5nHLBoPMU
 xshw==
X-Gm-Message-State: APjAAAUN0eCO2FffD0DT8ogojzB2zywW3RH2TN01diH8aDteePliOLh3
 QNazBMJFg7lR4+hVPGw1RPcQEUG+p8Nufr7HNbvh6lNRTG/CvZNjIoUK0uap/gO67NReuhbs63j
 lXhaYNhZOXgs3cTM=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr14447779wmh.35.1581329022912; 
 Mon, 10 Feb 2020 02:03:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAjMAD3cL38mRzle1leoRt2C5sYgRN70zWU0/Aa8NLfptJBAB9nOC7bpQLRRuuhyT5q6591w==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr14447732wmh.35.1581329022505; 
 Mon, 10 Feb 2020 02:03:42 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id q3sm14482691wmj.38.2020.02.10.02.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 02:03:42 -0800 (PST)
Subject: Re: [PATCH v3 08/13] hw/arm/raspi: Make board_rev a field of
 RaspiMachineClass
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-9-f4bug@amsat.org> <20200210105042.7e76e4e6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2adc51a2-b526-7f6a-4c01-775f3ac06444@redhat.com>
Date: Mon, 10 Feb 2020 11:03:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210105042.7e76e4e6@redhat.com>
Content-Language: en-US
X-MC-Unique: ZyNlZyRWMVWfDvPHv4gKSg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 10:50 AM, Igor Mammedov wrote:
> On Sat,  8 Feb 2020 17:56:40 +0100
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>=20
>> We want to have a common class_init(). The only value that
>> matters (and changes) is the board revision.
>> Pass the board_rev as class_data to class_init().
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   hw/arm/raspi.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index 62b8df3c2e..fbfcd29732 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -46,6 +46,7 @@ typedef struct RaspiMachineClass {
>>       /*< private >*/
>>       MachineClass parent_obj;
>>       /*< public >*/
>> +    uint32_t board_rev;
>>   } RaspiMachineClass;
>>  =20
>>   #define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
>> @@ -227,9 +228,11 @@ static void setup_boot(MachineState *machine, int v=
ersion, size_t ram_size)
>>       arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
>>   }
>>  =20
>> -static void raspi_init(MachineState *machine, uint32_t board_rev)
>> +static void raspi_init(MachineState *machine)
>>   {
>> +    RaspiMachineClass *mc =3D RASPI_MACHINE_GET_CLASS(machine);
>>       RaspiMachineState *s =3D RASPI_MACHINE(machine);
>> +    uint32_t board_rev =3D mc->board_rev;
>>       int version =3D board_version(board_rev);
>>       uint64_t ram_size =3D board_ram_size(board_rev);
>>       uint32_t vcram_size;
>> @@ -279,13 +282,16 @@ static void raspi_init(MachineState *machine, uint=
32_t board_rev)
>>  =20
>>   static void raspi2_init(MachineState *machine)
>>   {
>> -    raspi_init(machine, 0xa21041);
>> +    raspi_init(machine);
>>   }
>>  =20
>>   static void raspi2_machine_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc =3D MACHINE_CLASS(oc);
>> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
>> +    uint32_t board_rev =3D (uint32_t)(uintptr_t)data;
>>  =20
>> +    rmc->board_rev =3D board_rev;
>=20
> instead of doing a bit obscure ".class_data     =3D (void *)0xa21041," an=
d
> using it here, I'd just do
>=20
>         rmc->board_rev =3D 0xa21041;
>=20
> using value specific for each leaf class

Leaf classes are removed in patch #12 "Use a unique=20
raspi_machine_class_init() method", see more uses of .class_data from v2:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg677164.html
https://www.mail-archive.com/qemu-devel@nongnu.org/msg677166.html

Are you disagreeing with them? Then we should document .class_data as=20
deprecated and show example of good code.

> with this change
>   Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>=20
>>       mc->desc =3D "Raspberry Pi 2B";
>>       mc->init =3D raspi2_init;
>>       mc->block_default_type =3D IF_SD;
>> @@ -302,13 +308,16 @@ static void raspi2_machine_class_init(ObjectClass =
*oc, void *data)
>>   #ifdef TARGET_AARCH64
>>   static void raspi3_init(MachineState *machine)
>>   {
>> -    raspi_init(machine, 0xa02082);
>> +    raspi_init(machine);
>>   }
>>  =20
>>   static void raspi3_machine_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc =3D MACHINE_CLASS(oc);
>> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
>> +    uint32_t board_rev =3D (uint32_t)(uintptr_t)data;
>>  =20
>> +    rmc->board_rev =3D board_rev;
>>       mc->desc =3D "Raspberry Pi 3B";
>>       mc->init =3D raspi3_init;
>>       mc->block_default_type =3D IF_SD;
>> @@ -327,11 +336,13 @@ static const TypeInfo raspi_machine_types[] =3D {
>>           .name           =3D MACHINE_TYPE_NAME("raspi2"),
>>           .parent         =3D TYPE_RASPI_MACHINE,
>>           .class_init     =3D raspi2_machine_class_init,
>> +        .class_data     =3D (void *)0xa21041,
>>   #ifdef TARGET_AARCH64
>>       }, {
>>           .name           =3D MACHINE_TYPE_NAME("raspi3"),
>>           .parent         =3D TYPE_RASPI_MACHINE,
>>           .class_init     =3D raspi3_machine_class_init,
>> +        .class_data     =3D (void *)0xa02082,
>>   #endif
>>       }, {
>>           .name           =3D TYPE_RASPI_MACHINE,
>=20


