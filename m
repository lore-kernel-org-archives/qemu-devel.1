Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA082C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C51A20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyNkEB7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C51A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioQCx-0002uB-GS
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 06:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioQC7-0001py-Ui
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioQC2-0004Fo-0K
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:05:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioQC1-0004Ec-Hl
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578308704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2rUIS+9fKa0FGMOx/xKx+jgNM24KQropCDUORwtmag=;
 b=WyNkEB7Khr7hL+NpLyULHHCReSTNZWt8w8b6+BuwKVaogdOiI/tpMD8lnYajAfeeT2WUzu
 yJgJKrib06Tz+fXdqYCtuvYI4ubPkBscQNJjHa0VHpRVmo1CA935Eb2jNS2G1ZPFkTE+aR
 nIMRuEnAOa/EyoksfYhsSw3WEAGS84Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-UJqPMq3xNYutq3SZkhainQ-1; Mon, 06 Jan 2020 06:05:03 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so22747843wrt.21
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 03:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZK+p81cs3pcfTovjwOqN6TQFk/oXg6W506BM03C4/j4=;
 b=FSjTvtetcaIS1uK80nRk7EAUjdjtKd+TxNGsmMVXaBp6YunUiyhw7cO833z/SSWx27
 p+TMtRDeQV0u+C/o1C8IfPI0DLdM+T50GG+/aLn3HUWEYQr+yASbTRhc01EBMglAr4Mf
 qoa34wAGH2uy1YQXSi7LELsDm1eF8lzezLuZWFU2qAfWjWtPIq8hrJnXomHpfZ6fGvd+
 UygEwkC1xIgoSpzGVEL8m6/wQ44Rdx4JHTw3YJ3jnC8eqABCy9tjEJ0ewl8VcS0WdbPY
 MyjNSwFgCPGx2tjSAyX7M3NlwI3EwAFozy7DNIEePV8oxgigXzZs4CmrQvRUsTDAJYhc
 U/Zw==
X-Gm-Message-State: APjAAAUm1g/gdxegf6UOcC4WooQ729b4fhTdGcNHMNI2EhmykR1RK8Is
 Oea8znqcS/PLQq8Kw2bLXmkd7FlmHIt8qnUhOsJx22lVYMxKCUkxLK9u8JtIpIS8p/or5hVQH/O
 UFiQU2F0gnbW3zgQ=
X-Received: by 2002:a05:600c:305:: with SMTP id
 q5mr34822781wmd.167.1578308702153; 
 Mon, 06 Jan 2020 03:05:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0qtMx490swKP5x83fP6RYoQNGYvFdQ1FMx13UFkZJ1KuelZxIN4iwa00Czz5Fx35/tJSEQw==
X-Received: by 2002:a05:600c:305:: with SMTP id
 q5mr34822764wmd.167.1578308701850; 
 Mon, 06 Jan 2020 03:05:01 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c195sm23876280wmd.45.2020.01.06.03.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 03:05:01 -0800 (PST)
Subject: Re: [PATCH v2] hppa: allow max ram size upto 4Gb
To: Igor Mammedov <imammedo@redhat.com>
References: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
 <1577987162-150529-1-git-send-email-imammedo@redhat.com>
 <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
 <20200103105434.050d28ea@redhat.com>
 <6fa7bcd3-ee67-cc84-fd4e-d3677e3ae51a@redhat.com>
 <20200106114828.6bc96b23@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a57efff5-954f-a323-5efa-236a912dbaf1@redhat.com>
Date: Mon, 6 Jan 2020 12:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106114828.6bc96b23@redhat.com>
Content-Language: en-US
X-MC-Unique: UJqPMq3xNYutq3SZkhainQ-1
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 11:48 AM, Igor Mammedov wrote:
> On Sat, 4 Jan 2020 16:00:19 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/3/20 10:54 AM, Igor Mammedov wrote:
>>> On Thu, 2 Jan 2020 21:22:12 +0100
>>> Helge Deller <deller@gmx.de> wrote:
>>>   =20
>>>> On 02.01.20 18:46, Igor Mammedov wrote:
>>>>> Previous patch drops silent ram_size fixup and makes
>>>>> QEMU error out with:
>>>>>
>>>>>    "RAM size more than 3840m is not supported"
>>>>>
>>>>> when user specified -m X more than supported value.
>>>>>
>>>>> User shouldn't be bothered with starting QEMU with valid CLI,
>>>>> so for the sake of user convenience allow using -m 4G vs -m 3840M.
>>>>>
>>>>> Requested-by: Helge Deller <deller@gmx.de>
>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>> ---
>>>>> v2:
>>>>>     - make main ram -1 prio, so it wouldn't conflict with other regio=
ns
>>>>>       starting from 0xf9000000
>>>>>
>>>>> I dislike it but if you feel it's really necessary feel free to ack i=
t.
>>
>> Hard to find the v2 buried in the other series with my email client.
>>
>>>>>
>>>>> should be applied on top of:
>>>>>     "hppa: drop RAM size fixup"
>>>>
>>>> Hello Igor,
>>>> I appreciate that you are trying to make it more cleaner.
>>>> But, can't you merge both of your patches to one patch?
>>>> Right now you have one patch "hppa: drop RAM size fixup", which is
>>>> what I think is wrong. Then you add another one which somehow
>>>> fixes it up again and adds other stuff.
>>> 1st patch bring it in line with other boards adding
>>> proper error check but without changing RAM size.
>>> While 2nd is changing device model (mapped RAM size) and
>>> clearly documents that it's a hack for user convenience,
>>> Hence I'd prefer to keep both separated.
>>>   =20
>>>> Having everything in one single patch makes your full change more
>>>> understandable.
>>>>
>>>> Is it necessary to introduce clamped_ram_size and not continue with
>>>> ram_size (even if you would add it as static local variable)?
>>> it's necessary since ram_size is global which should be kept =3D=3D Mac=
hineState::ram_size.
>>> Later on I plan to remove the former altogether and maybe
>>> MachineState::ram_size aa well, since it could be read with
>>> memory_region_size(MachineState::ram).
>>
>> Why insist on clamping the ram? We recommend to model what the hardware
>> does, and the hardware uses a full DIMM of DRAM, so 4GB, not less.
> I'm not adding 4Gb support here (it's out of scope of this series),
> all this patch does is making pre-existing global ram_size fixup,
> this board only business and naming it clamped_ram_size to match
> its current usage (along with explicitly documenting the deviation from
> other boards why it was requested to keep fixup 'for user convenience'
> instead of going for correct and simpler error message telling
> how much RAM user could specify on CLI).
>=20
>> What are the new problem introduced by using 4GB? I only see advantages
>> doing so. This doesn't break your series. This doesn't break the CLI.
>> Am I missing something?
>=20
> Well, board was fixing up global ram_size and then used it to
>   - pass clamped value to guest via register
>   - pass it to load load_image_targphys()
>   - perform various checks
>   - affects reset sequence

You are correct. 'clamped_ram_size' is a good name.

> This patch keeps all of that in the same state
> (I'd suspect changing above points, would break guest)

It makes sense.

> If you have an alternative patch that enables to use full 4Gb,
> I'd include on respin as far as it doesn't change user supplied
> global ram_size && ms->ram_size && uses generic ms->ram &&
> preferably on top of
>   "[PATCH 44/86] hppa: use memdev for RAM"
> so it would be easier to drop it if there would opposition to it
> without affecting series.

No, now than I understood your explication:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks for insisting :)

>>>>> ---
>>>>>    hw/hppa/machine.c | 21 +++++++++++----------
>>>>>    1 file changed, 11 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>> index ebbf44f..0302983 100644
>>>>> --- a/hw/hppa/machine.c
>>>>> +++ b/hw/hppa/machine.c
>>>>> @@ -54,6 +54,7 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint=
64_t addr)
>>>>>
>>>>>    static HPPACPU *cpu[HPPA_MAX_CPUS];
>>>>>    static uint64_t firmware_entry;
>>>>> +static ram_addr_t clamped_ram_size;
>>>>>
>>>>>    static void machine_hppa_init(MachineState *machine)
>>>>>    {
>>>>> @@ -74,8 +75,6 @@ static void machine_hppa_init(MachineState *machine=
)
>>>>>        long i;
>>>>>        unsigned int smp_cpus =3D machine->smp.cpus;
>>>>>
>>>>> -    ram_size =3D machine->ram_size;
>>>>> -
>>>>>        /* Create CPUs.  */
>>>>>        for (i =3D 0; i < smp_cpus; i++) {
>>>>>            char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
>>>>> @@ -90,12 +89,14 @@ static void machine_hppa_init(MachineState *machi=
ne)
>>>>>        }
>>>>>
>>>>>        /* Limit main memory. */
>>>>> -    if (ram_size > FIRMWARE_START) {
>>>>> -        error_report("RAM size more than %d is not supported", FIRMW=
ARE_START);
>>>>> +    if (machine->ram_size > 4 * GiB) {
>>>>> +        error_report("RAM size more than 4Gb is not supported");
>>>>>            exit(EXIT_FAILURE);
>>>>>        }
>>>>> +    clamped_ram_size =3D machine->ram_size > FIRMWARE_START ?
>>>>> +        FIRMWARE_START : machine->ram_size;
>>>>>
>>>>> -    memory_region_add_subregion(addr_space, 0, machine->ram);
>>>>> +    memory_region_add_subregion_overlap(addr_space, 0, machine->ram,=
 -1);
>>>>>
>>>>>        /* Init Dino (PCI host bus chip).  */
>>>>>        pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
>>>>> @@ -151,7 +152,7 @@ static void machine_hppa_init(MachineState *machi=
ne)
>>>>>        qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
>>>>>                      "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
>>>>>                      firmware_low, firmware_high, firmware_entry);
>>>>> -    if (firmware_low < ram_size || firmware_high >=3D FIRMWARE_END) =
{
>>>>> +    if (firmware_low < clamped_ram_size || firmware_high >=3D FIRMWA=
RE_END) {
>>>>>            error_report("Firmware overlaps with memory or IO space");
>>>>>            exit(1);
>>>>>        }
>>>>> @@ -204,7 +205,7 @@ static void machine_hppa_init(MachineState *machi=
ne)
>>>>>                   (1) Due to sign-extension problems and PDC,
>>>>>                   put the initrd no higher than 1G.
>>>>>                   (2) Reserve 64k for stack.  */
>>>>> -            initrd_base =3D MIN(ram_size, 1 * GiB);
>>>>> +            initrd_base =3D MIN(clamped_ram_size, 1 * GiB);
>>>>>                initrd_base =3D initrd_base - 64 * KiB;
>>>>>                initrd_base =3D (initrd_base - initrd_size) & TARGET_P=
AGE_MASK;
>>>>>
>>>>> @@ -232,7 +233,7 @@ static void machine_hppa_init(MachineState *machi=
ne)
>>>>>         * various parameters in registers. After firmware initializat=
ion,
>>>>>         * firmware will start the Linux kernel with ramdisk and cmdli=
ne.
>>>>>         */
>>>>> -    cpu[0]->env.gr[26] =3D ram_size;
>>>>> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
>>
>> Helge, is this the code using this register?
>>
>> https://github.com/hdeller/seabios-hppa/blob/parisc-qemu-5.0/src/parisc/=
head.S#L139
>>
>>>>>        cpu[0]->env.gr[25] =3D kernel_entry;
>>>>>
>>>>>        /* tell firmware how many SMP CPUs to present in inventory tab=
le */
>>>>> @@ -255,11 +256,11 @@ static void hppa_machine_reset(MachineState *ms=
)
>>>>>        }
>>>>>
>>>>>        /* already initialized by machine_hppa_init()? */
>>>>> -    if (cpu[0]->env.gr[26] =3D=3D ram_size) {
>>>>> +    if (cpu[0]->env.gr[26] =3D=3D clamped_ram_size) {
>>>>>            return;
>>>>>        }
>>>>>
>>>>> -    cpu[0]->env.gr[26] =3D ram_size;
>>>>> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
>>>>>        cpu[0]->env.gr[25] =3D 0; /* no firmware boot menu */
>>>>>        cpu[0]->env.gr[24] =3D 'c';
>>>>>        /* gr22/gr23 unused, no initrd while reboot. */
>>>>>     =20
>>>>  =20
>>>   =20
>>
>=20


