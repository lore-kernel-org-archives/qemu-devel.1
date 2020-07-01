Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C867C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4B620772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrVZ8Gz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4B620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcHL-0003k1-2w
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqcGk-0003Fw-NY
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:55:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqcGh-0004IY-CU
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593608114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rb7sOS8DHtRYUMEyNZNrLkoz4ICYvjE6JzCI6gwE2JU=;
 b=XrVZ8Gz5mW/4ZeAdurF01RPUe9wBqBVmHimT/NjZLFE98U6YSO5ZA79Z/FS0B1EPp9FMqX
 59FgGM4kwXoKsH97ke1Niptip1kyWF9JdwAYVESH/De5LUr1OVAgflRcFSyW3GtVMoIePZ
 HL0hjwZlV7o9kL4U6/FlQW2dNLFZ4fE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-UnSEr0DSPEyPaR3J--0_pA-1; Wed, 01 Jul 2020 08:55:13 -0400
X-MC-Unique: UnSEr0DSPEyPaR3J--0_pA-1
Received: by mail-ed1-f69.google.com with SMTP id v8so13208126edj.4
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rb7sOS8DHtRYUMEyNZNrLkoz4ICYvjE6JzCI6gwE2JU=;
 b=jXxM1SMyxl/G1YsIkDdjEviK9vUWDr1JSIurfVXSuLe5t0Ue2trtYoRx3VVBA6Fc91
 wdGKjS4FZmbmZNjQtUhqu1omX2nwC16KzeBOjaXw477bgzr9UtAd0LixJ6mJPBEGW9lt
 ZZaeS24xdTOC9zEVyPk6RNQA+H45Cmfni8sBtNcoRVF3TUdpWN3TVMtOxu+iQK0RReJo
 x92jCsQaIJeW8r2I5C/s9AbcfjKbo14GQXpxO7/Ku7bo+zJYu//ftRAOrUVbSGQr+WY+
 grE21cT/8He3u7MhwhK7uqKovAoCDRkJJ1gP0e7T0ijLCd9TbGTdnIg1otn15g5vQFL8
 dPRw==
X-Gm-Message-State: AOAM531d8YOzSdK5yaizhSJOUa3JGgBmVvKLlkTKiTrEf+b6w1uT2kKz
 Jc7f44sLC0fSqipuYSrrokOf6WGB4v+tDKpvl6hJoTCR+DK6VY7HYXFxuoaNBldY58jy6atjZMs
 P0odHqr1vhDCsUW0=
X-Received: by 2002:a17:907:10d4:: with SMTP id
 rv20mr7245234ejb.413.1593608111896; 
 Wed, 01 Jul 2020 05:55:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrc1UwT7LYqI3an2+MrXCSqjgz2hXWdCORsWQzGgQw9DUznzUkPYFx9mGHc/f9Mjb2DeNfiw==
X-Received: by 2002:a17:907:10d4:: with SMTP id
 rv20mr7245220ejb.413.1593608111658; 
 Wed, 01 Jul 2020 05:55:11 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l12sm7170357edj.6.2020.07.01.05.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 05:55:11 -0700 (PDT)
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Jason Andryuk <jandryuk@gmail.com>, Paul Durrant <paul@xen.org>
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <33e594dd-dbfa-7c57-1cf5-0852e8fc8e1d@redhat.com>
 <000701d64ef5$6568f660$303ae320$@xen.org>
 <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
 <000801d64f75$c604f570$520ee050$@xen.org>
 <CAKf6xpvNTVqK263pdSARyoWnzP8g9SRoSqvhnLLwyYadjR1ChQ@mail.gmail.com>
 <07cc67e9-aeaa-1947-43db-c00716bead01@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <5c00f6a5-3f86-258e-999f-956eef825d14@redhat.com>
Date: Wed, 1 Jul 2020 14:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <07cc67e9-aeaa-1947-43db-c00716bead01@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <pdurrant@amazon.com>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 2:40 PM, Philippe Mathieu-Daudé wrote:
> On 7/1/20 2:25 PM, Jason Andryuk wrote:
>> On Wed, Jul 1, 2020 at 3:03 AM Paul Durrant <xadimgnik@gmail.com> wrote:
>>>
>>>> -----Original Message-----
>>>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Sent: 30 June 2020 18:27
>>>> To: paul@xen.org; xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
>>>> Cc: 'Eduardo Habkost' <ehabkost@redhat.com>; 'Michael S. Tsirkin' <mst@redhat.com>; 'Paul Durrant'
>>>> <pdurrant@amazon.com>; 'Jason Andryuk' <jandryuk@gmail.com>; 'Paolo Bonzini' <pbonzini@redhat.com>;
>>>> 'Richard Henderson' <rth@twiddle.net>
>>>> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>>>>
>>>> On 6/30/20 5:44 PM, Paul Durrant wrote:
>>>>>> -----Original Message-----
>>>>>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>> Sent: 30 June 2020 16:26
>>>>>> To: Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
>>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Paul Durrant
>>>>>> <pdurrant@amazon.com>; Jason Andryuk <jandryuk@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>;
>>>>>> Richard Henderson <rth@twiddle.net>
>>>>>> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>>>>>>
>>>>>> On 6/24/20 2:18 PM, Paul Durrant wrote:
>>>>>>> From: Paul Durrant <pdurrant@amazon.com>
>>>>>>>
>>>>>>> The generic pc_machine_initfn() calls pc_system_flash_create() which creates
>>>>>>> 'system.flash0' and 'system.flash1' devices. These devices are then realized
>>>>>>> by pc_system_flash_map() which is called from pc_system_firmware_init() which
>>>>>>> itself is called via pc_memory_init(). The latter however is not called when
>>>>>>> xen_enable() is true and hence the following assertion fails:
>>>>>>>
>>>>>>> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
>>>>>>> Assertion `dev->realized' failed
>>>>>>>
>>>>>>> These flash devices are unneeded when using Xen so this patch avoids the
>>>>>>> assertion by simply removing them using pc_system_flash_cleanup_unused().
>>>>>>>
>>>>>>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
>>>>>>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blockdev")
>>>>>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>>>>>>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
>>>>>>> ---
>>>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>>>> ---
>>>>>>>  hw/i386/pc_piix.c    | 9 ++++++---
>>>>>>>  hw/i386/pc_sysfw.c   | 2 +-
>>>>>>>  include/hw/i386/pc.h | 1 +
>>>>>>>  3 files changed, 8 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>>>> index 1497d0e4ae..977d40afb8 100644
>>>>>>> --- a/hw/i386/pc_piix.c
>>>>>>> +++ b/hw/i386/pc_piix.c
>>>>>>> @@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
>>>>>>>      if (!xen_enabled()) {
>>>>>>>          pc_memory_init(pcms, system_memory,
>>>>>>>                         rom_memory, &ram_memory);
>>>>>>> -    } else if (machine->kernel_filename != NULL) {
>>>>>>> -        /* For xen HVM direct kernel boot, load linux here */
>>>>>>> -        xen_load_linux(pcms);
>>>>>>> +    } else {
>>>>>>> +        pc_system_flash_cleanup_unused(pcms);
>>>>>>
>>>>>> TIL pc_system_flash_cleanup_unused().
>>>>>>
>>>>>> What about restricting at the source?
>>>>>>
>>>>>
>>>>> And leave the devices in place? They are not relevant for Xen, so why not clean up?
>>>>
>>>> No, I meant to not create them in the first place, instead of
>>>> create+destroy.
>>>>
>>>> Anyway what you did works, so I don't have any problem.
>>>
>>> IIUC Jason originally tried restricting creation but encountered a problem because xen_enabled() would always return false at that point, because machine creation occurs before accelerators are initialized.
>>
>> Correct.  Quoting my previous email:
>> """
>> Removing the call to pc_system_flash_create() from pc_machine_initfn()
>> lets QEMU startup and run a Xen HVM again.  xen_enabled() doesn't work
>> there since accelerators have not been initialized yes, I guess?
> 
> Ah, I missed that. You pointed at the bug here :)
> 
> I think pc_system_flash_create() shouldn't be called in init() but
> realize().

Hmm this is a MachineClass, not qdev, so no realize().

In softmmu/vl.c we have:

4152     configure_accelerators(argv[0]);
....
4327     if (!xen_enabled()) { // so xen_enable() is working
4328         /* On 32-bit hosts, QEMU is limited by virtual address space */
4329         if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
4330             error_report("at most 2047 MB RAM can be simulated");
4331             exit(1);
4332         }
4333     }
....
4348     machine_run_board_init(current_machine);

which calls in hw/core/machine.c:

1089 void machine_run_board_init(MachineState *machine)
1090 {
1091     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
....
1138     machine_class->init(machine);
1139 }

         -> pc_machine_class_init()

This should come after:

         -> pc_machine_initfn()

            -> pc_system_flash_create(pcms)
> 
>> """
>>
>> If you want to remove the creation in the first place, then I have two
>> questions.  Why does pc_system_flash_create()/pc_pflash_create() get
>> called so early creating the pflash devices?  Why aren't they just
>> created as needed in pc_system_flash_map()?
>>
>> Regards,
>> Jason
>>
>>>   Paul
>>>
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>
>>>>>
>>>>>   Paul
>>>>>
>>>>>> -- >8 --
>>>>>> --- a/hw/i386/pc.c
>>>>>> +++ b/hw/i386/pc.c
>>>>>> @@ -1004,24 +1004,26 @@ void pc_memory_init(PCMachineState *pcms,
>>>>>>                                      &machine->device_memory->mr);
>>>>>>      }
>>>>>>
>>>>>> -    /* Initialize PC system firmware */
>>>>>> -    pc_system_firmware_init(pcms, rom_memory);
>>>>>> -
>>>>>> -    option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>>>>>> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>>>>>> -                           &error_fatal);
>>>>>> -    if (pcmc->pci_enabled) {
>>>>>> -        memory_region_set_readonly(option_rom_mr, true);
>>>>>> -    }
>>>>>> -    memory_region_add_subregion_overlap(rom_memory,
>>>>>> -                                        PC_ROM_MIN_VGA,
>>>>>> -                                        option_rom_mr,
>>>>>> -                                        1);
>>>>>> -
>>>>>>      fw_cfg = fw_cfg_arch_create(machine,
>>>>>>                                  x86ms->boot_cpus, x86ms->apic_id_limit);
>>>>>>
>>>>>> -    rom_set_fw(fw_cfg);
>>>>>> +    /* Initialize PC system firmware */
>>>>>> +    if (!xen_enabled()) {
>>>>>> +        pc_system_firmware_init(pcms, rom_memory);
>>>>>> +
>>>>>> +        option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>>>>>> +        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>>>>>> +                               &error_fatal);
>>>>>> +        if (pcmc->pci_enabled) {
>>>>>> +            memory_region_set_readonly(option_rom_mr, true);
>>>>>> +        }
>>>>>> +        memory_region_add_subregion_overlap(rom_memory,
>>>>>> +                                            PC_ROM_MIN_VGA,
>>>>>> +                                            option_rom_mr,
>>>>>> +                                            1);
>>>>>> +
>>>>>> +        rom_set_fw(fw_cfg);
>>>>>> +    }
>>>>>>
>>>>>>      if (pcmc->has_reserved_memory && machine->device_memory->base) {
>>>>>>          uint64_t *val = g_malloc(sizeof(*val));
>>>>>> ---
>>>>>>
>>>>>>> +        if (machine->kernel_filename != NULL) {
>>>>>>> +            /* For xen HVM direct kernel boot, load linux here */
>>>>>>> +            xen_load_linux(pcms);
>>>>>>> +        }
>>>>>>>      }
>>>>>>>
>>>>>>>      gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
>>>>>>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>>>>>>> index ec2a3b3e7e..0ff47a4b59 100644
>>>>>>> --- a/hw/i386/pc_sysfw.c
>>>>>>> +++ b/hw/i386/pc_sysfw.c
>>>>>>> @@ -108,7 +108,7 @@ void pc_system_flash_create(PCMachineState *pcms)
>>>>>>>      }
>>>>>>>  }
>>>>>>>
>>>>>>> -static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>>>>>>> +void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>>>>>>>  {
>>>>>>>      char *prop_name;
>>>>>>>      int i;
>>>>>>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>>>>>> index e6135c34d6..497f2b7ab7 100644
>>>>>>> --- a/include/hw/i386/pc.h
>>>>>>> +++ b/include/hw/i386/pc.h
>>>>>>> @@ -187,6 +187,7 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);
>>>>>>>
>>>>>>>  /* pc_sysfw.c */
>>>>>>>  void pc_system_flash_create(PCMachineState *pcms);
>>>>>>> +void pc_system_flash_cleanup_unused(PCMachineState *pcms);
>>>>>>>  void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>>>>>>>
>>>>>>>  /* acpi-build.c */
>>>>>>>
>>>>>
>>>>>
>>>
>>>
>>
> 


