Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3CC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1546D20801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIxExpdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1546D20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Q28-0002Qt-A6
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4Q0N-0007aB-Is
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4Q0M-0004KB-CS
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:07:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4Q0M-0004Jy-8s
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582121229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izdh6d/EbjLYRUlMFvRz7KKjB+J7zvyF3FJJ+vol91k=;
 b=VIxExpdjCic+fDcT4L9Qw4W94c/boLgOI1NSj+a4gqL/mBzg1m+ApeKvBv21WW78NIZ/aE
 ZN5CsWOcC5jM9r2KO6VO3JXwhJXMuu98ZkIaIeZrOgi3UZGz1hCXfoKO/emSuIrEAGFNEL
 O2A4NvlsDhWTMOMgnk6lH+Qe8xmwFsY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-oNnP_phWPbqddNo5CDkhIQ-1; Wed, 19 Feb 2020 09:07:07 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so105244wru.7
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 06:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rGolTt5cp92iw/V7fmnIMm4AhXxXMDDZ/lciCPAuAX0=;
 b=WFS4sUGVgCVie4qdKcjzkHnBiQhCK567NOds1Sn9NdbC+059BeBhKR1o41jAPcU6YS
 Bq8tvhXFxIsASGGfHgGXnbjd9zrRZCHbXAZgVINPOOVz00fqTpx5aCDVUKHpdmHbxJHv
 PgL5jjo4P9ToQH8Y9eLNpgGsXaCEAGWITZPN6lnTVg06YgpYj/ugaC8R+RigEDMRC3zL
 oA0SKJqGVx0OYOqmgr4vJ27s/UCky21RaHadsT2WE+YQmXxGT19UJRObgggguA2yv63a
 wot8CaqXNQKaii+4j2/emcD8W31xedqIzY0uND2IDA/BGGiVTR4rWakm/A7d8V5Utprl
 qgeg==
X-Gm-Message-State: APjAAAVdNcgLFhLeVaX0ltqSGXYGMywjBLUcDMxfCkwFjlDgS9CsUSu4
 cz/lyAx0lgd4Ot7PupjLU3vOtQymv5Hzq7cu0NYosPb8OTF2tyAVnu9lV/uW3xc7sSSoA3ueqVF
 3oUvdhNlCTm4YVP4=
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr36718360wrg.266.1582121226588; 
 Wed, 19 Feb 2020 06:07:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyv7rRYa+WvfnnYHFSvNdOfDWqzp40+09VeztNAToCSqyXHhtb5NvXi+mJ3iBfNS3esne0ag==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr36718324wrg.266.1582121226353; 
 Wed, 19 Feb 2020 06:07:06 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o4sm3059884wrx.25.2020.02.19.06.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 06:07:05 -0800 (PST)
Subject: Re: [PATCH v5 34/79] arm/xilinx_zynq: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-35-imammedo@redhat.com>
 <bfc46ad0-fa98-0d1f-b452-be82c7dda85d@redhat.com>
 <20200219144457.5ed2367f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61a12527-3404-f991-24df-6619dcdd8305@redhat.com>
Date: Wed, 19 Feb 2020 15:07:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219144457.5ed2367f@redhat.com>
Content-Language: en-US
X-MC-Unique: oNnP_phWPbqddNo5CDkhIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 2:44 PM, Igor Mammedov wrote:
> On Tue, 18 Feb 2020 18:23:47 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 2/17/20 6:34 PM, Igor Mammedov wrote:
>>> If user provided non-sense RAM size, board will complain and
>>> continue running with max RAM size supported.
>>> Also RAM is going to be allocated by generic code, so it won't be
>>> possible for board to fix things up for user.
>>>
>>> Make it error message and exit to force user fix CLI,
>>> instead of accepting non-sense CLI values.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>    hw/arm/xilinx_zynq.c | 16 ++++++++--------
>>>    1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
>>> index 3a0fa5b23f..df950fc400 100644
>>> --- a/hw/arm/xilinx_zynq.c
>>> +++ b/hw/arm/xilinx_zynq.c
>>> @@ -158,7 +158,6 @@ static inline void zynq_init_spi_flashes(uint32_t b=
ase_addr, qemu_irq irq,
>>>   =20
>>>    static void zynq_init(MachineState *machine)
>>>    {
>>> -    ram_addr_t ram_size =3D machine->ram_size;
>>>        ARMCPU *cpu;
>>>        MemoryRegion *address_space_mem =3D get_system_memory();
>>>        MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
>>> @@ -168,6 +167,12 @@ static void zynq_init(MachineState *machine)
>>>        qemu_irq pic[64];
>>>        int n;
>>>   =20
>>> +    /* max 2GB ram */
>>> +    if (machine->ram_size > 0x80000000) {
>>> +        error_report("RAM size more than %d is not supported", 0x80000=
000);
>>
>> Eh? Maybe:
>>
>>          if (machine->ram_size > 2 * GiB) {
>>              error_report("RAM size more than 2 GiB is not supported");
>=20
> amended in v6

Then please add to v6:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks :)

>=20
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>>        cpu =3D ARM_CPU(object_new(machine->cpu_type));
>>>   =20
>>>        /* By default A9 CPUs have EL3 enabled.  This board does not
>>> @@ -184,14 +189,9 @@ static void zynq_init(MachineState *machine)
>>>                                &error_fatal);
>>>        object_property_set_bool(OBJECT(cpu), true, "realized", &error_f=
atal);
>>>   =20
>>> -    /* max 2GB ram */
>>> -    if (ram_size > 0x80000000) {
>>> -        ram_size =3D 0x80000000;
>>> -    }
>>> -
>>>        /* DDR remapped to address zero.  */
>>>        memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ra=
m",
>>> -                                         ram_size);
>>> +                                         machine->ram_size);
>>>        memory_region_add_subregion(address_space_mem, 0, ext_ram);
>>>   =20
>>>        /* 256K of on-chip memory */
>>> @@ -300,7 +300,7 @@ static void zynq_init(MachineState *machine)
>>>        sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
>>>        sysbus_mmio_map(busdev, 0, 0xF8007000);
>>>   =20
>>> -    zynq_binfo.ram_size =3D ram_size;
>>> +    zynq_binfo.ram_size =3D machine->ram_size;
>>>        zynq_binfo.nb_cpus =3D 1;
>>>        zynq_binfo.board_id =3D 0xd32;
>>>        zynq_binfo.loader_start =3D 0;
>>>   =20
>>
>=20


