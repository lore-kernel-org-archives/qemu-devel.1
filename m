Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DCEC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E101A20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtLTY/x/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E101A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9jW-000666-2D
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is9iY-0005Ed-1r
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is9iU-0006JB-K7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:18:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54907
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is9iT-0006I1-Qn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579198680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TS92KNPOQ3Casj1UAe3qTkGLAjBTil5WalvRii5b0c=;
 b=KtLTY/x/8BGp3P7PAPdi6kys6DJR6KPeqcAjjEPXhMUNRq3nzC2x95XagClHD2R6UTKwfA
 jcnQv6eeLkqpCNHSJaKdMT9ZSMeVi8VuImR9cA9vvzqqfYxRMDcBQq59EuNZbLrnTAX3Sg
 6K+7MKt8QsKbR7crIxzVs0zck5YchRA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308--4jQdqQ3MfaDkCXMAD5A4w-1; Thu, 16 Jan 2020 13:17:57 -0500
Received: by mail-wm1-f72.google.com with SMTP id y125so2559540wmg.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aLZiOjhgeh5lCktLBRbCgm3aR8OMd0lwmQ4APTSbkO0=;
 b=Ki8e6HTTjUwf1+V4dJtifHUNSEJ4Lf0bRAR2HYgVwBAlS5AbTiZZPKFFVp3hFTiOAC
 3wJ1yvM1b/L506vg4Iu1j7p5UnVsG/OEWRQPxk5B7h4YX+ZpnblB43dlXvLvZ+VtK+kJ
 RL9d4ksJylaW+A66TSgSe8l0J3EEsYacSeiITk3FfNQdrDzO8PvMxBCmpM432UjgiLTg
 0OYIKPdFZGLB7SGvqtouALA+Oi35VYtr9ZAq3ggCXQgVtO101f4I18kWR/tBizIICHxL
 ImFjvPdr10XI8i/HzkS24f5gkrNOW9vwsX75+52/gOKwv1HnyCwXnPfPqlxK4m1I7Gli
 sRpQ==
X-Gm-Message-State: APjAAAUZUN7MSizNx6I1xLTny9dnwCoSqH7cJlAfpV8N9ukOdq43Qn4l
 XLFzcTDBu8gSti1Anl8eBfZIpb39hbI/Xh6/YEa1YEmXmDa0q68adHv2i3hP9Ci2Hi8W4J0JUiW
 CX0+2aLeJeHuJgPY=
X-Received: by 2002:adf:ca07:: with SMTP id o7mr4720110wrh.49.1579198675742;
 Thu, 16 Jan 2020 10:17:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEceg4zYJIv2a3ncGhFmwWzO8UL48MVw1pPQIknk5rycDfiXeU9W3dibYfhX+/wWTEl7Hw4Q==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr4720080wrh.49.1579198675428;
 Thu, 16 Jan 2020 10:17:55 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id s8sm29411686wrt.57.2020.01.16.10.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 10:17:54 -0800 (PST)
Subject: Re: [PATCH v2 10/86] arm:aspeed: use memdev for RAM
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-11-git-send-email-imammedo@redhat.com>
 <8473fe69-36da-35f7-930b-f800bb899732@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2184f034-821e-53c9-b9f5-b834d5a59b34@redhat.com>
Date: Thu, 16 Jan 2020 19:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8473fe69-36da-35f7-930b-f800bb899732@kaod.org>
Content-Language: en-US
X-MC-Unique: -4jQdqQ3MfaDkCXMAD5A4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 10:24 AM, C=C3=A9dric Le Goater wrote:
> On 1/15/20 4:06 PM, Igor Mammedov wrote:
>> memory_region_allocate_system_memory() API is going away, so
>> replace it with memdev allocated MemoryRegion. The later is
>> initialized by generic code, so board only needs to opt in
>> to memdev scheme by providing
>>    MachineClass::default_ram_id
>> and using MachineState::ram instead of manually initializing
>> RAM memory region.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
>=20
> We need to check 'max_ram' is still needed. I remember that old firmwares
> were testing the RAM size by doing write/read checks at the top of the RA=
M.
> This was breaking QEMU sometime ago.

Do you remember any version we can use to test this? Also add to our=20
acceptance tests.

> C.
>=20
>> ---
>> CC: clg@kaod.org
>> CC: peter.maydell@linaro.org
>> CC: andrew@aj.id.au
>> CC: joel@jms.id.au
>> CC: qemu-arm@nongnu.org
>> ---
>>   hw/arm/aspeed.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 525c547..330254b 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -35,7 +35,6 @@ static struct arm_boot_info aspeed_board_binfo =3D {
>>   struct AspeedBoardState {
>>       AspeedSoCState soc;
>>       MemoryRegion ram_container;
>> -    MemoryRegion ram;
>>       MemoryRegion max_ram;
>>   };
>>  =20
>> @@ -184,6 +183,7 @@ static void aspeed_machine_init(MachineState *machin=
e)
>>  =20
>>       memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-containe=
r",
>>                          UINT32_MAX);
>> +    memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
>>  =20
>>       object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
>>                               (sizeof(bmc->soc)), amc->soc_name, &error_=
abort,
>> @@ -215,8 +215,6 @@ static void aspeed_machine_init(MachineState *machin=
e)
>>       object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
>>                                &error_fatal);
>>  =20
>> -    memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_si=
ze);
>> -    memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
>>       memory_region_add_subregion(get_system_memory(),
>>                                   sc->memmap[ASPEED_SDRAM],
>>                                   &bmc->ram_container);
>> @@ -393,6 +391,7 @@ static void aspeed_machine_class_init(ObjectClass *o=
c, void *data)
>>       mc->no_floppy =3D 1;
>>       mc->no_cdrom =3D 1;
>>       mc->no_parallel =3D 1;
>> +    mc->default_ram_id =3D "ram";
>>   }
>>  =20
>>   static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *=
data)
>>
>=20
>=20


