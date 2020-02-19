Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D3C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CAC2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sx/eMQ13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CAC2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Q0e-0007kf-2A
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4Pyr-0004yu-Gj
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4Pyq-0003V9-Bl
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:05:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4Pyq-0003Uu-7j
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582121135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apzKWK5uZTf8M2StR4pijR0+yKU0Ny4AGHu8OqjuKiw=;
 b=Sx/eMQ13PaNxN6YxeCO7Qgb85fMKpv1OUkq4aU2fGKKb9Gw89Q6fieLvGjt0HMItY3D2TV
 qUpiIiOeeuoTWvs9WvRoGdZmWunsAvJR9bFP1gvipqR3o097XwQJ+ddx3hRpLWK30qYnwy
 MQF4nNp/g+3/pBn7sG/RKbY5af2Yxe0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-cNQZ-Df9Pxi4J4d3yF2lrQ-1; Wed, 19 Feb 2020 09:05:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id a12so90589wrn.19
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 06:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dgs8atEpt4g/fFXdHr6myLHPvbpWZRxcdEty+bYudg8=;
 b=KyvxFkTj2/oWDzHM/2RU/Kv131O9+fsxjVpC/JABNgZgmJRdOc50TGSTlL3GBK3VTs
 Z5K9dsIztkP3rMZcAQjCvisfr0+D0qDPXWQhyp9JW75EpgLX7uvR/y67Hm5NnDBJFfQt
 vsJGagozjcVS1sVcNn2Uk0sGJ7zwhCI0IxsLo0+bUyqyxVCB0VbVRcYW8VizYhaMBw3e
 mfuELxnJAPVhLkTEPjjJWVlbBQT98JkAcOPsXcYvWRLHmH8El4tnh7nAsj1A8EnpAZYg
 04daBYXBcuvQgtouDSHmb7oXUlg/A3qntplpBG9IIf0tbqs5rzg2nbhwBl6nX3KGTOPE
 XmcA==
X-Gm-Message-State: APjAAAVGUwn7udntDkEzLUc0sxsyGqiYJrehAQvfEU7C7ITnO4xfIbO2
 LA9QA/I48/k3e6naIQUAk8ZBmCYo3gLW9BEomXWRClX9RcKl2bAjuy4Ey9Tb+8BOGlBgigAzjak
 ddbfPepZEAnARZn0=
X-Received: by 2002:a5d:4651:: with SMTP id j17mr36738033wrs.237.1582121132506; 
 Wed, 19 Feb 2020 06:05:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxF5Wrf6wa9C5iMLAMiruf8bRNaG5Gt/t+Jlb4eZeN67CgSwjmg6usrab01EkgjbB5j2s+kMA==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr36738010wrs.237.1582121132274; 
 Wed, 19 Feb 2020 06:05:32 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id m21sm3134323wmi.27.2020.02.19.06.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 06:05:31 -0800 (PST)
Subject: Re: [PATCH v5 27/79] arm/palm: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-28-imammedo@redhat.com>
 <e9302ce2-2d10-f3c5-25b6-6b9eee291192@redhat.com>
 <20200219144430.5151535f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bdaf8937-3662-6988-2c1f-b0c1a257a075@redhat.com>
Date: Wed, 19 Feb 2020 15:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219144430.5151535f@redhat.com>
Content-Language: en-US
X-MC-Unique: cNQZ-Df9Pxi4J4d3yF2lrQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 2:44 PM, Igor Mammedov wrote:
> On Tue, 18 Feb 2020 18:22:06 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 2/17/20 6:34 PM, Igor Mammedov wrote:
>>> memory_region_allocate_system_memory() API is going away, so
>>> replace it with memdev allocated MemoryRegion. The later is
>>> initialized by generic code, so board only needs to opt in
>>> to memdev scheme by providing
>>>     MachineClass::default_ram_id
>>> and using MachineState::ram instead of manually initializing
>>> RAM memory region.
>>>
>>> PS:
>>>    while at it add check for user supplied RAM size and error
>>>    out if it mismatches board expected value.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>> ---
>>> v2:
>>>     * fix format string causing build failure on 32-bit host
>>>       (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
>>>
>>> CC: balrogg@gmail.com
>>> ---
>>>    hw/arm/palm.c | 20 ++++++++++++++------
>>>    1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
>>> index 72eca8cc55..388b2629a5 100644
>>> --- a/hw/arm/palm.c
>>> +++ b/hw/arm/palm.c
>>> @@ -31,6 +31,7 @@
>>>    #include "hw/loader.h"
>>>    #include "exec/address-spaces.h"
>>>    #include "cpu.h"
>>> +#include "qemu/cutils.h"
>>>   =20
>>>    static uint64_t static_read(void *opaque, hwaddr offset, unsigned si=
ze)
>>>    {
>>> @@ -181,7 +182,6 @@ static void palmte_gpio_setup(struct omap_mpu_state=
_s *cpu)
>>>   =20
>>>    static struct arm_boot_info palmte_binfo =3D {
>>>        .loader_start =3D OMAP_EMIFF_BASE,
>>> -    .ram_size =3D 0x02000000,
>>
>> Again, this is incorrect. Used by hw/arm/boot::do_cpu_reset().
> Thanks,
> fixed in v6

With the arm_boot_info ram_size unmodified, please add
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>>
>>>        .board_id =3D 0x331,
>>>    };
>>>   =20
>>> @@ -195,15 +195,21 @@ static void palmte_init(MachineState *machine)
>>>        static uint32_t cs2val =3D 0x0000e1a0;
>>>        static uint32_t cs3val =3D 0xe1a0e1a0;
>>>        int rom_size, rom_loaded =3D 0;
>>> -    MemoryRegion *dram =3D g_new(MemoryRegion, 1);
>>> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>>>        MemoryRegion *flash =3D g_new(MemoryRegion, 1);
>>>        MemoryRegion *cs =3D g_new(MemoryRegion, 4);
>>>   =20
>>> -    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
>>> -                                         palmte_binfo.ram_size);
>>> -    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE, dr=
am);
>>> +    if (machine->ram_size !=3D mc->default_ram_size) {
>>> +        char *sz =3D size_to_str(mc->default_ram_size);
>>> +        error_report("Invalid RAM size, should be %s", sz);
>>> +        g_free(sz);
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE,
>>> +                                machine->ram);
>>>   =20
>>> -    mpu =3D omap310_mpu_init(dram, machine->cpu_type);
>>> +    mpu =3D omap310_mpu_init(machine->ram, machine->cpu_type);
>>>   =20
>>>        /* External Flash (EMIFS) */
>>>        memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
>>> @@ -265,6 +271,8 @@ static void palmte_machine_init(MachineClass *mc)
>>>        mc->init =3D palmte_init;
>>>        mc->ignore_memory_transaction_failures =3D true;
>>>        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
>>> +    mc->default_ram_size =3D 0x02000000;
>>> +    mc->default_ram_id =3D "omap1.dram";
>>>    }
>>>   =20
>>>    DEFINE_MACHINE("cheetah", palmte_machine_init)
>>>   =20
>>
>=20


