Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637D6206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLCJnRon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637D6206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqK3T-0005dM-Kt
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqK2d-0004wX-WC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:27:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqK2b-0005ax-5j
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593538047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oqaF53js116BFuwCtw9OPfpHPGSljyERaOiFUdX/2cY=;
 b=JLCJnRonvLSBEU+mhg/euJC4KbxMq+pI8SX2pkT+9LRUbRMnSFVX0Ry7b3vZdRcggnWSjw
 vojhap1ndNdJJFSEOIF3ukiNmLsj7SEOyvupW3iCHSMWealSF4QR12sspZRNSoktL744/a
 EIm075fJFJzBHT4bdDzSrf/QorVvEa0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-yt5sy562OTiDwIMs7YMh3g-1; Tue, 30 Jun 2020 13:27:25 -0400
X-MC-Unique: yt5sy562OTiDwIMs7YMh3g-1
Received: by mail-ed1-f69.google.com with SMTP id y92so13035008eda.12
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 10:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=oqaF53js116BFuwCtw9OPfpHPGSljyERaOiFUdX/2cY=;
 b=D80daQ4N/pGh78WT85V4K5Gb7gugo59o6ZiQYqCwiyARfig2qQCQDu2+Cetf9/S8Ow
 MJsvIaBjh2xuHVUMg0HZeVwFtAoFd7Kn7Ov5GHaNIF5aFWBfKU3x9Go3052ee50/xYLg
 V3yy2ibq/D9Cs8KyOEaDeDg79tvHam6vRxLNUSUwPnsudR/cbHr4QtE9R3r+DVKAMeWo
 n5HUgwomaNHPX0eqde1sRUEzd7ik3+BcuY0q8xwdjIVqvGkt5NwiCK2HJ1CXyBHliz1s
 ykTaUK7XJEE1pnpGde/rgA49z2oqPrLMEjTPzVmOD81trrErNplpZqy0YXGQfsNHYRc+
 lyqA==
X-Gm-Message-State: AOAM532e9swr0daWkaD6v2aptFczL91kkBLXGEtAnkbEbIYJne+ANNph
 9JagpWoP+szotWoUzBpyN1MoB6g7p3v64xHt3nSaS3Y9+5Ioh9y9lTNSy7ZFjcul/b7v0kZtf61
 t7PMkXJHzUgt2b7I=
X-Received: by 2002:a17:906:d9c4:: with SMTP id
 qk4mr20323095ejb.100.1593538044402; 
 Tue, 30 Jun 2020 10:27:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTRshH+tCbYqBRZoSrP2wOTHAhNfEEVSe9WoaeIdjWw3EP94byVU+BJoJjNvqHzssgxk8aLQ==
X-Received: by 2002:a17:906:d9c4:: with SMTP id
 qk4mr20323075ejb.100.1593538044167; 
 Tue, 30 Jun 2020 10:27:24 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g21sm3546337edu.2.2020.06.30.10.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 10:27:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
To: paul@xen.org, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <33e594dd-dbfa-7c57-1cf5-0852e8fc8e1d@redhat.com>
 <000701d64ef5$6568f660$303ae320$@xen.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
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
Message-ID: <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
Date: Tue, 30 Jun 2020 19:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <000701d64ef5$6568f660$303ae320$@xen.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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
Cc: 'Eduardo Habkost' <ehabkost@redhat.com>,
 'Jason Andryuk' <jandryuk@gmail.com>, 'Paul Durrant' <pdurrant@amazon.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>, 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Richard Henderson' <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 5:44 PM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Sent: 30 June 2020 16:26
>> To: Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
>> Cc: Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Paul Durrant
>> <pdurrant@amazon.com>; Jason Andryuk <jandryuk@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>;
>> Richard Henderson <rth@twiddle.net>
>> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>>
>> On 6/24/20 2:18 PM, Paul Durrant wrote:
>>> From: Paul Durrant <pdurrant@amazon.com>
>>>
>>> The generic pc_machine_initfn() calls pc_system_flash_create() which creates
>>> 'system.flash0' and 'system.flash1' devices. These devices are then realized
>>> by pc_system_flash_map() which is called from pc_system_firmware_init() which
>>> itself is called via pc_memory_init(). The latter however is not called when
>>> xen_enable() is true and hence the following assertion fails:
>>>
>>> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
>>> Assertion `dev->realized' failed
>>>
>>> These flash devices are unneeded when using Xen so this patch avoids the
>>> assertion by simply removing them using pc_system_flash_cleanup_unused().
>>>
>>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
>>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blockdev")
>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
>>> ---
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Richard Henderson <rth@twiddle.net>
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> ---
>>>  hw/i386/pc_piix.c    | 9 ++++++---
>>>  hw/i386/pc_sysfw.c   | 2 +-
>>>  include/hw/i386/pc.h | 1 +
>>>  3 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index 1497d0e4ae..977d40afb8 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
>>>      if (!xen_enabled()) {
>>>          pc_memory_init(pcms, system_memory,
>>>                         rom_memory, &ram_memory);
>>> -    } else if (machine->kernel_filename != NULL) {
>>> -        /* For xen HVM direct kernel boot, load linux here */
>>> -        xen_load_linux(pcms);
>>> +    } else {
>>> +        pc_system_flash_cleanup_unused(pcms);
>>
>> TIL pc_system_flash_cleanup_unused().
>>
>> What about restricting at the source?
>>
> 
> And leave the devices in place? They are not relevant for Xen, so why not clean up?

No, I meant to not create them in the first place, instead of
create+destroy.

Anyway what you did works, so I don't have any problem.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>   Paul
>  
>> -- >8 --
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1004,24 +1004,26 @@ void pc_memory_init(PCMachineState *pcms,
>>                                      &machine->device_memory->mr);
>>      }
>>
>> -    /* Initialize PC system firmware */
>> -    pc_system_firmware_init(pcms, rom_memory);
>> -
>> -    option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>> -                           &error_fatal);
>> -    if (pcmc->pci_enabled) {
>> -        memory_region_set_readonly(option_rom_mr, true);
>> -    }
>> -    memory_region_add_subregion_overlap(rom_memory,
>> -                                        PC_ROM_MIN_VGA,
>> -                                        option_rom_mr,
>> -                                        1);
>> -
>>      fw_cfg = fw_cfg_arch_create(machine,
>>                                  x86ms->boot_cpus, x86ms->apic_id_limit);
>>
>> -    rom_set_fw(fw_cfg);
>> +    /* Initialize PC system firmware */
>> +    if (!xen_enabled()) {
>> +        pc_system_firmware_init(pcms, rom_memory);
>> +
>> +        option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>> +        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>> +                               &error_fatal);
>> +        if (pcmc->pci_enabled) {
>> +            memory_region_set_readonly(option_rom_mr, true);
>> +        }
>> +        memory_region_add_subregion_overlap(rom_memory,
>> +                                            PC_ROM_MIN_VGA,
>> +                                            option_rom_mr,
>> +                                            1);
>> +
>> +        rom_set_fw(fw_cfg);
>> +    }
>>
>>      if (pcmc->has_reserved_memory && machine->device_memory->base) {
>>          uint64_t *val = g_malloc(sizeof(*val));
>> ---
>>
>>> +        if (machine->kernel_filename != NULL) {
>>> +            /* For xen HVM direct kernel boot, load linux here */
>>> +            xen_load_linux(pcms);
>>> +        }
>>>      }
>>>
>>>      gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
>>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>>> index ec2a3b3e7e..0ff47a4b59 100644
>>> --- a/hw/i386/pc_sysfw.c
>>> +++ b/hw/i386/pc_sysfw.c
>>> @@ -108,7 +108,7 @@ void pc_system_flash_create(PCMachineState *pcms)
>>>      }
>>>  }
>>>
>>> -static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>>> +void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>>>  {
>>>      char *prop_name;
>>>      int i;
>>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>> index e6135c34d6..497f2b7ab7 100644
>>> --- a/include/hw/i386/pc.h
>>> +++ b/include/hw/i386/pc.h
>>> @@ -187,6 +187,7 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);
>>>
>>>  /* pc_sysfw.c */
>>>  void pc_system_flash_create(PCMachineState *pcms);
>>> +void pc_system_flash_cleanup_unused(PCMachineState *pcms);
>>>  void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>>>
>>>  /* acpi-build.c */
>>>
> 
> 


