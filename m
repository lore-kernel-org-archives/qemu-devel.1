Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC4C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B9A207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJTqkbEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B9A207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY26C-0003JQ-H3
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY25L-0002Nm-9e
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:38:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY25I-0007Ep-5g
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:38:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id x17so9389128wrt.5
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 23:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RjA1OGrzmBvLe4SyqiQCZB6ibae7BUB+jsL0x5u40Ew=;
 b=vJTqkbEu7bD9ClSc7opr9fqGP0A5MkQ9sI0olhkJYZUzyxJJ4loTfOgd7x7w1fCHQm
 CzN65UDEaekPobYZCEpf9nLtWMBZyv76oBoFzv0r5QO14/AMxerdZkhRFX5TTlGayvyj
 Wxl/Ev9Q4zdzgK2xYCm/pBT3huzWz6eq6xJ5UFpArgX928+9r1J3O21ao1an91UkaAON
 ySM90NzgyhnTlmFjHMaNi/9ncZxpuSt8OL/hWd1h7j/bBW4KfHh56uXMgqilK1Cxjrbv
 8xiYgBlY3bLONZTPOPcgR+gDg/JSvmiaRlDrQsczqNW3lj0wI7VL79JHEY3DjZ2HlJLm
 NV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RjA1OGrzmBvLe4SyqiQCZB6ibae7BUB+jsL0x5u40Ew=;
 b=k9HfuywrIK86cQEyumPhGSYj2J2nTMtzoKnp9UD+dcwSdJ2RVN/ZypV3SL3gtAgamB
 ddH5n3yU1ollWCVkNEM9YxE013HHv3yoKvT75BieGWbDlRVXuwz8V0BF3X+8IpiNTtOt
 U0I3fjkYkCJ0jQavfrjV/WCEGzTePqjsLbcqKVaP9UY0sI+DNxPNcLtBhbffq2Su4ODn
 QLE2Z+JQsSdZzdyY9u3iFOf68weC9mcAqvSoa9Gs9Gc7OYbfoPoRsRKDEzqMckSgTLn7
 X9KTmDwz5L2/yBpM9bd7uR0MXvftPJkIXTH2ULN0uILuW4tbsJIFHHbm5A302YwcbbKY
 c3kg==
X-Gm-Message-State: AGi0PuY3oOhrAjoJFl8wPODbi/UIYFxX27+tmSCE47PfduG745ieQws8
 15FDHh1on5WgSDSFd1NnvZ4=
X-Google-Smtp-Source: APiQypIrSZlrwFbYPk7QQDnCvUU/kdz0Kij1MHqXn1k4W7SR9zXEdYfmOH8RyiTWeGYHYxwUFtxAIQ==
X-Received: by 2002:adf:a297:: with SMTP id s23mr17356851wra.54.1589179118515; 
 Sun, 10 May 2020 23:38:38 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n9sm3318985wmj.5.2020.05.10.23.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2020 23:38:37 -0700 (PDT)
Subject: Re: [PATCH 04/12] hw/mips/fuloong2e: Fix typo in Fuloong machine name
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 chen huacai <zltjiangshi@gmail.com>
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-5-f4bug@amsat.org>
 <CABDp7VoD-ieFO+ijrKyCpKWQkLknD3Z+CzmvrkLPfmY7pedOzA@mail.gmail.com>
 <CAHiYmc59K25gXM29R9PiyPgW1n9xO-O4PGMumAz13vCQHZyujw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b6a1017a-c20d-66df-2a4d-1d453ca14259@amsat.org>
Date: Mon, 11 May 2020 08:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc59K25gXM29R9PiyPgW1n9xO-O4PGMumAz13vCQHZyujw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 8:21 AM, Aleksandar Markovic wrote:
> пон, 11. мај 2020. у 03:11 chen huacai <zltjiangshi@gmail.com> је написао/ла:
>>
>> Hi, Philippe,
>>
>> On Mon, May 11, 2020 at 5:06 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>
>>> We always miswrote the Fuloong machine... Fix its name.
>>> Add an machine alias to the previous name for backward
>>> compatibility.
>>>
>>> Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   docs/system/target-mips.rst              |  2 +-
>>>   default-configs/mips64el-softmmu.mak     |  2 +-
>>>   hw/isa/vt82c686.c                        |  2 +-
>>>   hw/mips/{mips_fulong2e.c => fuloong2e.c} | 46 ++++++++++++------------
>> Use mips_fuloong2e.c instead of fuloong2e.c? Other machine file names
>> also have a "mips_" prefix.
>>
> 
> I would leave mips_ prefix for Fuloong, and actually add it to Boston
> source file, so that we are finally consistent across all MIPS
> machines.
> 
> What do you think?

These names were used years ago when all hardware was in the same hw/ 
directory, not sorted per target. Now new machines don't use the target 
as prefix name. I'd clean the other way around, and dropping the 'mips_' 
prefix. The positive side is we can 5 more characters to better describe 
a patch while limited by the 72 chars in the subject :)

> 
> Aleksandar
> 
>> Huacai
>>>   hw/pci-host/bonito.c                     |  8 ++---
>>>   tests/qtest/endianness-test.c            |  2 +-
>>>   MAINTAINERS                              |  4 +--
>>>   hw/mips/Kconfig                          |  2 +-
>>>   hw/mips/Makefile.objs                    |  2 +-
>>>   9 files changed, 36 insertions(+), 34 deletions(-)
>>>   rename hw/mips/{mips_fulong2e.c => fuloong2e.c} (91%)
>>>
>>> diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
>>> index 2736fd0509..cd2a931edf 100644
>>> --- a/docs/system/target-mips.rst
>>> +++ b/docs/system/target-mips.rst
>>> @@ -74,7 +74,7 @@ The MIPS Magnum R4000 emulation supports:
>>>
>>>   -  G364 framebuffer
>>>
>>> -The Fulong 2E emulation supports:
>>> +The Fuloong 2E emulation supports:
>>>
>>>   -  Loongson 2E CPU
>>>
>>> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
>>> index 8b0c9b1e15..9f8a3ef156 100644
>>> --- a/default-configs/mips64el-softmmu.mak
>>> +++ b/default-configs/mips64el-softmmu.mak
>>> @@ -2,7 +2,7 @@
>>>
>>>   include mips-softmmu-common.mak
>>>   CONFIG_IDE_VIA=y
>>> -CONFIG_FULONG=y
>>> +CONFIG_FULOONG=y
>>>   CONFIG_ATI_VGA=y
>>>   CONFIG_RTL8139_PCI=y
>>>   CONFIG_JAZZ=y
>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>> index d9b51fce8d..fac4e56b7d 100644
>>> --- a/hw/isa/vt82c686.c
>>> +++ b/hw/isa/vt82c686.c
>>> @@ -503,7 +503,7 @@ static void via_class_init(ObjectClass *klass, void *data)
>>>       dc->vmsd = &vmstate_via;
>>>       /*
>>>        * Reason: part of VIA VT82C686 southbridge, needs to be wired up,
>>> -     * e.g. by mips_fulong2e_init()
>>> +     * e.g. by mips_fuloong2e_init()
>>>        */
>>>       dc->user_creatable = false;
>>>   }
>>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/fuloong2e.c
>>> similarity index 91%
>>> rename from hw/mips/mips_fulong2e.c
>>> rename to hw/mips/fuloong2e.c
>>> index 4e1a3646af..624c46a4fd 100644
>>> --- a/hw/mips/mips_fulong2e.c
>>> +++ b/hw/mips/fuloong2e.c
>>> @@ -1,5 +1,5 @@
>>>   /*
>>> - * QEMU fulong 2e mini pc support
>>> + * QEMU fuloong 2e mini pc support
>>>    *
>>>    * Copyright (c) 2008 yajin (yajin@vm-kernel.org)
>>>    * Copyright (c) 2009 chenming (chenming@rdc.faw.com.cn)
>>> @@ -11,8 +11,8 @@
>>>    */
>>>
>>>   /*
>>> - * Fulong 2e mini pc is based on ICT/ST Loongson 2e CPU (MIPS III like, 800MHz)
>>> - * http://www.linux-mips.org/wiki/Fulong
>>> + * Fuloong 2e mini pc is based on ICT/ST Loongson 2e CPU (MIPS III like, 800MHz)
>>> + * https://www.linux-mips.org/wiki/Fuloong_2E
>>>    *
>>>    * Loongson 2e user manual:
>>>    * http://www.loongsondeveloper.com/doc/Loongson2EUserGuide.pdf
>>> @@ -46,13 +46,13 @@
>>>   #include "sysemu/reset.h"
>>>   #include "qemu/error-report.h"
>>>
>>> -#define DEBUG_FULONG2E_INIT
>>> +#define DEBUG_FULOONG2E_INIT
>>>
>>>   #define ENVP_ADDR               0x80002000l
>>>   #define ENVP_NB_ENTRIES         16
>>>   #define ENVP_ENTRY_SIZE         256
>>>
>>> -/* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
>>> +/* Fuloong 2e has a 512k flash: Winbond W39L040AP70Z */
>>>   #define BIOS_SIZE               (512 * KiB)
>>>   #define MAX_IDE_BUS             2
>>>
>>> @@ -69,12 +69,12 @@
>>>    * 2, use "Bonito2edev" to replace "dir_corresponding_to_your_target_hardware"
>>>    * in the "Compile Guide".
>>>    */
>>> -#define FULONG_BIOSNAME "pmon_2e.bin"
>>> +#define FULOONG_BIOSNAME "pmon_2e.bin"
>>>
>>> -/* PCI SLOT in fulong 2e */
>>> -#define FULONG2E_VIA_SLOT        5
>>> -#define FULONG2E_ATI_SLOT        6
>>> -#define FULONG2E_RTL8139_SLOT    7
>>> +/* PCI SLOT in Fuloong 2e */
>>> +#define FULOONG2E_VIA_SLOT        5
>>> +#define FULOONG2E_ATI_SLOT        6
>>> +#define FULOONG2E_RTL8139_SLOT    7
>>>
>>>   static struct _loaderparams {
>>>       int ram_size;
>>> @@ -279,7 +279,7 @@ static void network_init(PCIBus *pci_bus)
>>>           const char *default_devaddr = NULL;
>>>
>>>           if (i == 0 && (!nd->model || strcmp(nd->model, "rtl8139") == 0)) {
>>> -            /* The fulong board has a RTL8139 card using PCI SLOT 7 */
>>> +            /* The Fuloong board has a RTL8139 card using PCI SLOT 7 */
>>>               default_devaddr = "07";
>>>           }
>>>
>>> @@ -287,7 +287,7 @@ static void network_init(PCIBus *pci_bus)
>>>       }
>>>   }
>>>
>>> -static void mips_fulong2e_init(MachineState *machine)
>>> +static void mips_fuloong2e_init(MachineState *machine)
>>>   {
>>>       const char *kernel_filename = machine->kernel_filename;
>>>       const char *kernel_cmdline = machine->kernel_cmdline;
>>> @@ -316,11 +316,12 @@ static void mips_fulong2e_init(MachineState *machine)
>>>           error_report("Invalid RAM size, should be 256MB");
>>>           exit(EXIT_FAILURE);
>>>       }
>>> -    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>>>
>>> -    /* Boot ROM */
>>> -    memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
>>> +    /* allocate RAM */
>>> +    memory_region_init_rom(bios, NULL, "fuloong2e.bios", BIOS_SIZE,
>>>                              &error_fatal);
>>> +
>>> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>>>       memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
>>>
>>>       /*
>>> @@ -337,7 +338,7 @@ static void mips_fulong2e_init(MachineState *machine)
>>>           write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_entry);
>>>       } else {
>>>           if (bios_name == NULL) {
>>> -                bios_name = FULONG_BIOSNAME;
>>> +                bios_name = FULOONG_BIOSNAME;
>>>           }
>>>           filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>>           if (filename) {
>>> @@ -363,7 +364,7 @@ static void mips_fulong2e_init(MachineState *machine)
>>>       pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
>>>
>>>       /* South bridge -> IP5 */
>>> -    vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
>>> +    vt82c686b_southbridge_init(pci_bus, FULOONG2E_VIA_SLOT, env->irq[5],
>>>                                  &smbus, &isa_bus);
>>>
>>>       /* GPU */
>>> @@ -384,14 +385,15 @@ static void mips_fulong2e_init(MachineState *machine)
>>>       network_init(pci_bus);
>>>   }
>>>
>>> -static void mips_fulong2e_machine_init(MachineClass *mc)
>>> +static void mips_fuloong2e_machine_init(MachineClass *mc)
>>>   {
>>> -    mc->desc = "Fulong 2e mini pc";
>>> -    mc->init = mips_fulong2e_init;
>>> +    mc->desc = "Fuloong 2e mini pc";
>>> +    mc->alias = "fulong2e";             /* Incorrect name used up to QEMU 4.2 */
>>> +    mc->init = mips_fuloong2e_init;
>>>       mc->block_default_type = IF_IDE;
>>>       mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
>>>       mc->default_ram_size = 256 * MiB;
>>> -    mc->default_ram_id = "fulong2e.ram";
>>> +    mc->default_ram_id = "fuloong2e.ram";
>>>   }
>>>
>>> -DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
>>> +DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
>>> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
>>> index cc6545c8a8..b9bfe3c417 100644
>>> --- a/hw/pci-host/bonito.c
>>> +++ b/hw/pci-host/bonito.c
>>> @@ -11,7 +11,7 @@
>>>    */
>>>
>>>   /*
>>> - * fulong 2e mini pc has a bonito north bridge.
>>> + * fuloong 2e mini pc has a bonito north bridge.
>>>    */
>>>
>>>   /*
>>> @@ -559,11 +559,11 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
>>>       slot = (pci_dev->devfn >> 3);
>>>
>>>       switch (slot) {
>>> -    case 5:   /* FULONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, MC97 */
>>> +    case 5:   /* FULOONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, MC97 */
>>>           return irq_num % 4 + BONITO_IRQ_BASE;
>>> -    case 6:   /* FULONG2E_ATI_SLOT, VGA */
>>> +    case 6:   /* FULOONG2E_ATI_SLOT, VGA */
>>>           return 4 + BONITO_IRQ_BASE;
>>> -    case 7:   /* FULONG2E_RTL_SLOT, RTL8139 */
>>> +    case 7:   /* FULOONG2E_RTL_SLOT, RTL8139 */
>>>           return 5 + BONITO_IRQ_BASE;
>>>       case 8 ... 12: /* PCI slot 1 to 4 */
>>>           return (slot - 8 + irq_num) + 6 + BONITO_IRQ_BASE;
>>> diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-test.c
>>> index 2798802c63..cc088ac01a 100644
>>> --- a/tests/qtest/endianness-test.c
>>> +++ b/tests/qtest/endianness-test.c
>>> @@ -33,7 +33,7 @@ static const TestCase test_cases[] = {
>>>       { "mips64", "pica61", 0x90000000, .bswap = true },
>>>       { "mips64", "mips", 0x14000000, .bswap = true },
>>>       { "mips64", "malta", 0x10000000, .bswap = true },
>>> -    { "mips64el", "fulong2e", 0x1fd00000 },
>>> +    { "mips64el", "fuloong2e", 0x1fd00000 },
>>>       { "ppc", "g3beige", 0xfe000000, .bswap = true, .superio = "i82378" },
>>>       { "ppc", "40p", 0x80000000, .bswap = true },
>>>       { "ppc", "bamboo", 0xe8000000, .bswap = true, .superio = "i82378" },
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index aa5c54c75a..50f6a5f1bb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1074,13 +1074,13 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>>   S: Obsolete
>>>   F: hw/mips/mips_r4k.c
>>>
>>> -Fulong 2E
>>> +Fuloong 2E
>>>   M: Huacai Chen <chenhc@lemote.com>
>>>   M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>   S: Odd Fixes
>>> -F: hw/mips/mips_fulong2e.c
>>> +F: hw/mips/fuloong2e.c
>>>   F: hw/isa/vt82c686.c
>>>   F: hw/pci-host/bonito.c
>>>   F: include/hw/isa/vt82c686.h
>>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>>> index 2c2adbc42a..cd38546689 100644
>>> --- a/hw/mips/Kconfig
>>> +++ b/hw/mips/Kconfig
>>> @@ -41,7 +41,7 @@ config JAZZ
>>>       select DS1225Y
>>>       select JAZZ_LED
>>>
>>> -config FULONG
>>> +config FULOONG
>>>       bool
>>>
>>>   config MIPS_CPS
>>> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
>>> index 525809af07..8ab41edc3f 100644
>>> --- a/hw/mips/Makefile.objs
>>> +++ b/hw/mips/Makefile.objs
>>> @@ -3,6 +3,6 @@ obj-$(CONFIG_R4K) += mips_r4k.o
>>>   obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
>>>   obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
>>>   obj-$(CONFIG_JAZZ) += mips_jazz.o
>>> -obj-$(CONFIG_FULONG) += mips_fulong2e.o
>>> +obj-$(CONFIG_FULOONG) += fuloong2e.o
>>>   obj-$(CONFIG_MIPS_CPS) += cps.o
>>>   obj-$(CONFIG_MIPS_BOSTON) += boston.o
>>> --
>>> 2.21.3
>>>
>>>
>>
>>
>> --
>> Huacai Chen
> 

