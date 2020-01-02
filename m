Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810D4C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C18C20866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEhvVvG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C18C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in44H-0005O6-0i
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 12:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1in43U-0004ky-RN
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1in43S-0006H4-Ul
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:14:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1in43S-0006GU-Qw
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577985277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//DGNZM6iU+CEEr9OcIl5z2bDOi14SjP34WdXqHi0WA=;
 b=KEhvVvG1A9Qam6t7jg9mrseLTzRNUabh1432xZmSUpIeyMu3nWKcP8l0yHsKxkSip2nDR0
 yxs+V+pn5wvKDqPucNxLmwiFFiO4OHW3Rl6nv2noBTos4p6Dw1Xn4IdnA8JIEUrgjefYDz
 02k5Sxx7ZtxVM9oDInx0d8UbWuvJ/eg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-4prm2uxwMT6A0SU-4vusSA-1; Thu, 02 Jan 2020 12:14:35 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so15413755wrq.12
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 09:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tQE6i/rc101dnat3hF0XvyoYfJA+8tQJlTRZN0K4JR0=;
 b=AueXNxYNd/4op/pnFkrjInckknSoppkuuKAoEkCMtT2HMUGpHcAoNdjhz9aarxj7ru
 jlEsfGvdKleceXvNQhXd8R5Zd2WdzoJ81o9CM6AM2ikNL96B8WHoRGb6xfkV9imj/ZK2
 x1e2er9do4gC9Pua4HAXrUs1Tu/8qRiubt/4lLK+YzEZi9QmU6tv3+UGnX8i9BOMkgw2
 0uBPCoRuhHc/6aQTFVwV/zaAwIPdni2KR8dCKkS4+ysNAqbZzHmQEgq9/T/xsXyavi66
 rBOBzTIAgHSK3CgdKGDmCeLHqL1A50I9EZs9oroCwbZe1qCioY59bL9OXArcv4VOhlhy
 RXPQ==
X-Gm-Message-State: APjAAAVaAEJOI7vj8ux6qbmlvdvG0KEfrJnYbJI32vdiSu2USPQ3YsN/
 R+Q4/9tt7vs96xidOaAfunUTEPTiZn6kBrQXqj+9yu9cm/h7CXSkfDsRy1U4bSO7lGLcRCo+Bdy
 TiGsejQIL0hSDkJ8=
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr87631539wrs.287.1577985274583; 
 Thu, 02 Jan 2020 09:14:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqybJbi1pY9It0pGjYmXY8j2+tu86QThpmq9uzlyYBHVIpregvDcvYWauBxhN0pZLOYVqxLx6w==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr87631524wrs.287.1577985274332; 
 Thu, 02 Jan 2020 09:14:34 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u18sm56201865wrt.26.2020.01.02.09.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 09:14:33 -0800 (PST)
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
 <20200102151223.73e1448b@redhat.com>
 <a3017f38-b32b-de32-9896-b287253d0fa2@redhat.com>
 <20200102160827.790b8ed2@redhat.com>
 <f073e703-5caf-e63c-ef1b-04fa7ab51716@redhat.com>
 <20200102175021.35b07b0d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c20c891f-aa17-27f2-66c2-45025b921ca8@redhat.com>
Date: Thu, 2 Jan 2020 18:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102175021.35b07b0d@redhat.com>
Content-Language: en-US
X-MC-Unique: 4prm2uxwMT6A0SU-4vusSA-1
X-Mimecast-Spam-Score: 0
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 5:50 PM, Igor Mammedov wrote:
> On Thu, 2 Jan 2020 16:49:00 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/2/20 4:08 PM, Igor Mammedov wrote:
>>> On Thu, 2 Jan 2020 15:17:14 +0100
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>   =20
>>>> On 1/2/20 3:12 PM, Igor Mammedov wrote:
>>>>> On Thu, 2 Jan 2020 13:06:33 +0100
>>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>>>      =20
>>>>>> On 1/2/20 12:31 PM, Helge Deller wrote:
>>>>>>> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>> On 12/31/19 2:03 PM, Igor Mammedov wrote:
>>>>>>>>> If user provided non-sense RAM size, board will complain and
>>>>>>>>> continue running with max RAM size supported.
>>>>>>>>> Also RAM is going to be allocated by generic code, so it won't be
>>>>>>>>> possible for board to fix things up for user.
>>>>>>>>>
>>>>>>>>> Make it error message and exit to force user fix CLI,
>>>>>>>>> instead of accepting non-sense CLI values.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>>>>> ---
>>>>>>>>>     =C2=A0 hw/hppa/machine.c | 3 ++-
>>>>>>>>>     =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>>>>>> index 5d0de26..25f5afc 100644
>>>>>>>>> --- a/hw/hppa/machine.c
>>>>>>>>> +++ b/hw/hppa/machine.c
>>>>>>>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *mac=
hine)
>>>>>>>>>     =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. *=
/
>>>>>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START)=
 {
>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D=
 ram_size =3D FIRMWARE_START;
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM siz=
e more than %d is not supported", FIRMWARE_START);
>>>>>>>>> +        exit(EXIT_FAILURE);
>>>>>>>>
>>>>>>>> $ qemu-system-hppa -m 3841m
>>>>>>>> qemu-system-hppa: invalid accelerator kvm
>>>>>>>> qemu-system-hppa: falling back to tcg
>>>>>>>> qemu-system-hppa: RAM size more than -268435456 is not supported
>>>>>>>>
>>>>>>>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned fo=
rmat, we can simply use "RAM size more than 3840m is not supported". Is tha=
t OK with you?
>>>>>>>
>>>>>>> I don't really like that change.
>>>>>>>
>>>>>>> We currently only emulate a 32-bit system, and for those 4GB is the=
 maximum.
>>>>>>> So, if I start my machine with "qemu-system-hppa -m 4G", the curren=
t code
>>>>>>> then automatically uses the maximum possible of 3841MB (which is li=
mited by
>>>>>>> firmware start address).
>>>>>>> I don't expect users to know the excact 3841MB number.
>>>>>>> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB=
 or 4GB,
>>>>>>> but not "3841MB".
>>>>>>
>>>>>> Thanks for the explanation. This deserves a comment in the source fi=
le
>>>>>> IMHO (and displaying a warning to the user that the behavior is chan=
ged).
>>>>>>
>>>>>> I understand the CPU can't access this DRAM area because the ROM is
>>>>>> mapped there. What about other devices, can they do DMA access to it=
?
>>>>>>
>>>>>> Igor: If this complicates your series too much, I think we can direc=
tly
>>>>>> allocate up-to 4GiB and not worry about the 256MiB lost.
>>>>>
>>>>> Do you mean
>>>>> s/"RAM size more than %d is not supported"/"RAM size more than 4Gb is=
 not supported"/
>>>>
>>>> Works for me! You can keep my R-b with this change, thanks.
>>>
>>> Well, it's not that simple.
>>> Do we map whole 4G in address space, if yes then we have to "unbreak"
>>> firmware mapping and use overlap mapping or do we map only portion of i=
t?
>>> Both would make code more confusing and all for the sake of user conven=
ience
>>> so they won't have to change their CLI?
>>
>> I was thinking about this patch:
> it probably should be a bit more complicated.
>=20
>>
>> -- >8 --
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 5d0de26140..fa0b6a9536 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -91,15 +91,16 @@ static void machine_hppa_init(MachineState *machine)
>>        }
>>
>>        /* Limit main memory. */
>> -    if (ram_size > FIRMWARE_START) {
>> -        machine->ram_size =3D ram_size =3D FIRMWARE_START;
>> +    if (ram_size > 4 * GiB) {
>> +        error_report("Can not model more than 4GB of RAM");
>> +        exit(EXIT_FAILURE);
>>        }
>>
>>        /* Main memory region. */
>>        ram_region =3D g_new(MemoryRegion, 1);
>>        memory_region_allocate_system_memory(ram_region, OBJECT(machine),
>>                                             "ram", ram_size);
>> -    memory_region_add_subregion(addr_space, 0, ram_region);
>> +    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
>>
>>        /* Init Dino (PCI host bus chip).  */
>>        pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
>=20
> Ok, I give up on trying to convince you to avoid relaxing error check
> but I'd make it an extra patch on top of "[PATCH 43/86] hppa: drop RAM si=
ze fixup"
> as it's a separate change.

I am simply not understanding what you are suggesting...
Can you share a diff snippet of what you would prefer?


