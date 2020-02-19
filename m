Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B157C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD092176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX61hH6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD092176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PzQ-0005UP-3J
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4Pyd-0004fS-B4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4Pyb-0003KS-Lw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:05:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4Pyb-0003KH-IL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582121121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VURb56jSJeSSmuXiINylfn0O8PsQqqdPT+PX9QVfuqQ=;
 b=PX61hH6Pt3YrY/55mhTZkKd7Vea7d4iXoRQVaOZZIIyZO1RpxZemFwln77+H6cxEYuoupe
 0rkcvUrqyPIj1S3+UVVYZPyQOx4QtneqvqFONHyr06EfX5ovizRVBwaMI+ylAAPzDZfZbJ
 foIdRLyslNuE9/Iem3oV0ZTuibu3b1U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-joF5ZoBpNb6aKvw3zekpmQ-1; Wed, 19 Feb 2020 09:05:17 -0500
Received: by mail-wr1-f72.google.com with SMTP id n23so87788wra.20
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 06:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eXdCP/nSuu0LJSAq2sejrTsWe8arPQYhzjIsG/eOX3o=;
 b=mbpon+k4rV0tVg1A5iGzQ4AbDA/jVoFUOjRu0Pw/n85JjhTcoIGWVAXdztuS5dxc+I
 n4JOZ2k6k3rSk2vVeGB0TRHA7c+QPIhKXH57msOUNMfRyHMvHdjmp0n24QOdTdYUJtVi
 tS450/k9pbQ/toLsI2JZkMr67bLwaTARyryAsneVeSuokt6miXGHNHn7ksf7dBpFr5JN
 otH/MBrnRRvXFb1np8wHcTeA2eVO0TMaT2r5x1jqv+KbDxPLcd5jFIWOFagWZhZtskNz
 P7WOBTcUTq0vX1Ygdml9BcbGUQOvGN0XQlZ39gGpLwyRSOagMKyLtRdV4vtj9diPVIyX
 IHnA==
X-Gm-Message-State: APjAAAU8pBoWgSWAzrOPdIFe46I4iq5BwOkCOO96z4sU5hoxSQUa5f+F
 JSVkH5W9exBsO8GdfOebDizgjZLzpz1/K1iVJ0sf6TPHQMDC6wJAX9MLlQ5Gykm2EEUr8e4P1i9
 70CCp1i894eN1NB4=
X-Received: by 2002:a1c:44d:: with SMTP id 74mr10700022wme.53.1582121116228;
 Wed, 19 Feb 2020 06:05:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1124rfTdGMfK4dxx36eaeUe0oiG/peucZMarD5jZnIMDmVr14lIdpbO+H2FKsgdcrCGkaDw==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr10699997wme.53.1582121115919;
 Wed, 19 Feb 2020 06:05:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id q130sm3397812wme.19.2020.02.19.06.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 06:05:14 -0800 (PST)
Subject: Re: [PATCH v5 11/79] arm/collie: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-12-imammedo@redhat.com>
 <6ab7280b-cc57-e714-6908-163bab7c898c@redhat.com>
 <20200219144402.51cf1213@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <312e18b0-3b77-245e-bfd5-0045b6748ec0@redhat.com>
Date: Wed, 19 Feb 2020 15:05:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219144402.51cf1213@redhat.com>
Content-Language: en-US
X-MC-Unique: joF5ZoBpNb6aKvw3zekpmQ-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 2:44 PM, Igor Mammedov wrote:
> On Tue, 18 Feb 2020 18:16:14 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Hi Igor,
>>
>> On 2/17/20 6:33 PM, Igor Mammedov wrote:
>>> memory_region_allocate_system_memory() API is going away, so
>>> replace it with memdev allocated MemoryRegion. The later is
>>> initialized by generic code, so board only needs to opt in
>>> to memdev scheme by providing
>>>     MachineClass::default_ram_id
>>> and using MachineState::ram instead of manually initializing
>>> RAM memory region.
>>>
>>> PS:
>>>    - while at it add check for user supplied RAM size and error
>>>      out if it mismatches board expected value.
>>>    - introduce RAM_ADDR_UFMT to avoid build errors on 32-bit hosts
>>>      when specifying format string for ram_addr_t type
>>
>> Since v3 the 2nd comment is not valid anymore (also in other patches
>> from this series).
>=20
> I looks like the last remnant of RAM_ADDR_UFMT
> I'll remove it in v6

Thanks.

>=20
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>> ---
>>> v2:
>>>     * fix format string causing build failure on 32-bit host
>>>       (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
>>> v3:
>>>     * instead of RAM_ADDR_UFMT adding use size_to_str()
>>>        Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>    hw/arm/collie.c | 17 ++++++++++++-----
>>>    1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/arm/collie.c b/hw/arm/collie.c
>>> index 970a4405cc..024893fc9e 100644
>>> --- a/hw/arm/collie.c
>>> +++ b/hw/arm/collie.c
>>> @@ -10,6 +10,7 @@
>>>     */
>>>    #include "qemu/osdep.h"
>>>    #include "qemu/units.h"
>>> +#include "qemu/cutils.h"
>>>    #include "hw/sysbus.h"
>>>    #include "hw/boards.h"
>>>    #include "strongarm.h"
>>> @@ -20,20 +21,24 @@
>>>   =20
>>>    static struct arm_boot_info collie_binfo =3D {
>>>        .loader_start =3D SA_SDCS0,
>>> -    .ram_size =3D 0x20000000,
>>
>> This doesn't seem correct, this field is used do_cpu_reset() ->
>> set_kernel_args() (see hw/arm/boot.c).
>=20
> Thanks,
> fixed in v6.
>=20
> I'll respin series as already several amended patches accumulated by this=
 time.

With the arm_boot_info ram_size unmodified, please add
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>>
>>>    };
>>>   =20
>>>    static void collie_init(MachineState *machine)
>>>    {
>>>        StrongARMState *s;
>>>        DriveInfo *dinfo;
>>> -    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
>>> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>>> +
>>> +    if (machine->ram_size !=3D mc->default_ram_size) {
>>> +        char *sz =3D size_to_str(mc->default_ram_size);
>>> +        error_report("Invalid RAM size, should be %s", sz);
>>> +        g_free(sz);
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>>   =20
>>>        s =3D sa1110_init(machine->cpu_type);
>>>   =20
>>> -    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram=
",
>>> -                                         collie_binfo.ram_size);
>>> -    memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
>>> +    memory_region_add_subregion(get_system_memory(), SA_SDCS0, machine=
->ram);
>>>   =20
>>>        dinfo =3D drive_get(IF_PFLASH, 0, 0);
>>>        pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
>>> @@ -57,6 +62,8 @@ static void collie_machine_init(MachineClass *mc)
>>>        mc->init =3D collie_init;
>>>        mc->ignore_memory_transaction_failures =3D true;
>>>        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("sa1110");
>>> +    mc->default_ram_size =3D 0x20000000;
>>> +    mc->default_ram_id =3D "strongarm.sdram";
>>>    }
>>>   =20
>>>    DEFINE_MACHINE("collie", collie_machine_init)
>>>   =20
>>
>>
>=20


