Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F7C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E7F214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvlkopbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E7F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfgcb-0003Vd-GS
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48512)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfgag-0001we-Nj
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfgae-0000tf-3H
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:14:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfgad-0000s1-Kf
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:14:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so16685752wrw.13
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YBLs8OG60oShkdumH+V/Pk0KT1TyDVbEI+FgCCXj7EQ=;
 b=AvlkopbGWWjXbR6PamMEyvuAssmsw3e2lKI/WCroJJJTFHfWskECBMdThnWjyiEcqv
 6/BNg7UjyliBhGFzPKJ4K6/oBDMDDvkML7CO/V+vF//7RsQDDaREe8wHLXRetm/w2Sb2
 HrCUdiy3HwWZA1eXxBgzckTJZgFITNqVh0TplZ5fVoM0oUV8nqYLGhPD1ZWHwMyZsg4M
 yODPDmOj0KJUAsElAtcZuHml++UUDjUwJXJCJcbOu3nUS/OqELBxkrSmqGB/KCeNFd9S
 IcuqErE3+N2Tr0HMehjnDLoP92sZiPhAO2zlUpkmBR7LTUN/K1pC6+d5eFyd76dFCIDe
 PVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YBLs8OG60oShkdumH+V/Pk0KT1TyDVbEI+FgCCXj7EQ=;
 b=XtSgSEbYR3Qp06ZP8tSu3cg6J1kH6wwKY3NSX18gPSiGUU+AxSMD/haPyqZX72N1AX
 5rE/3iz3KWjbDb8Lqwb4xEbIk5M5P3334LWUIAKubn8+lWmMY0+VaTVeABK/lzYL33rk
 pWB81sm5Pe6J1fO1y/ZUfQYNet7yd9S4mt5tfOyunPsZQmLOlkOwTVHlzLoBupw6OthG
 FGMH4MHkSRqKuPN7qZtWRn2HZVR/s3T9HIfa2Mk9Km5oEb/LcjbITMhXJhvU4mfLpdab
 3JeG0fjjp7s55FB5KXur/7pWoyjGP/yRWO+95oEE5NxMIBhOISzXyfITWMTZ5sStfqiw
 Us5A==
X-Gm-Message-State: APjAAAWmmljAfTKPC/wW8LXknNbBrad9D6bUC3SL5I4dQ4jOeOSvTXWQ
 0PfgmDfomvDx10iG5u5JcyM=
X-Google-Smtp-Source: APXvYqxm8jpN11Vtkpz/HH1m/p4/96aNYBoJQZNXFaKWyoA+rpGjzn85IvottXbdlQB6Rc/27zp+gA==
X-Received: by 2002:adf:f582:: with SMTP id f2mr57497890wro.144.1561450446397; 
 Tue, 25 Jun 2019 01:14:06 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id 15sm1419142wmk.34.2019.06.25.01.14.05
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 01:14:05 -0700 (PDT)
To: Artyom Tarasenko <atar4qemu@gmail.com>
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-9-f4bug@amsat.org>
 <CACXAS8C=D+Jf9SPiW9SMTj6VMTcjeAQS+VXhpgUtKPPSfFrg5w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <de3bfeeb-16f7-2c88-e65e-575640a1974e@amsat.org>
Date: Tue, 25 Jun 2019 10:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACXAS8C=D+Jf9SPiW9SMTj6VMTcjeAQS+VXhpgUtKPPSfFrg5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/sparc/sun4m: Simplify the RAM
 creation
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 9:14 AM, Artyom Tarasenko wrote:
> On Tue, Jun 25, 2019 at 12:01 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Now than the empty_slot device can be overlapped, use it to cover
>> the maximum memory range.
> 
> Whilie this is true for SS-5, the SS-20 does trap on missing RAM, so
> empty_slot_init must be conditional.
> nack.

Oh, I totally forgot the 'if (!hwdef->ecc_base)'...

Thanks Artyom!

>> We can simplify now the main RAM is created.
>> The TYPE_SUN4M_MEMORY is not migratable, simply remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sparc/sun4m.c | 85 ++++++++----------------------------------------
>>  1 file changed, 13 insertions(+), 72 deletions(-)
>>
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 0df5a8edfc..d55753d5cb 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -767,71 +767,6 @@ static const TypeInfo prom_info = {
>>      .class_init    = prom_class_init,
>>  };
>>
>> -#define TYPE_SUN4M_MEMORY "memory"
>> -#define SUN4M_RAM(obj) OBJECT_CHECK(RamDevice, (obj), TYPE_SUN4M_MEMORY)
>> -
>> -typedef struct RamDevice {
>> -    SysBusDevice parent_obj;
>> -
>> -    MemoryRegion ram;
>> -    uint64_t size;
>> -} RamDevice;
>> -
>> -/* System RAM */
>> -static void ram_realize(DeviceState *dev, Error **errp)
>> -{
>> -    RamDevice *d = SUN4M_RAM(dev);
>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> -
>> -    memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ram",
>> -                                         d->size);
>> -    sysbus_init_mmio(sbd, &d->ram);
>> -}
>> -
>> -static void ram_init(hwaddr addr, ram_addr_t RAM_size,
>> -                     uint64_t max_mem)
>> -{
>> -    DeviceState *dev;
>> -    SysBusDevice *s;
>> -    RamDevice *d;
>> -
>> -    /* allocate RAM */
>> -    if ((uint64_t)RAM_size > max_mem) {
>> -        error_report("Too much memory for this machine: %" PRId64 ","
>> -                     " maximum %" PRId64,
>> -                     RAM_size / MiB, max_mem / MiB);
>> -        exit(1);
>> -    }
>> -    dev = qdev_create(NULL, "memory");
>> -    s = SYS_BUS_DEVICE(dev);
>> -
>> -    d = SUN4M_RAM(dev);
>> -    d->size = RAM_size;
>> -    qdev_init_nofail(dev);
>> -
>> -    sysbus_mmio_map(s, 0, addr);
>> -}
>> -
>> -static Property ram_properties[] = {
>> -    DEFINE_PROP_UINT64("size", RamDevice, size, 0),
>> -    DEFINE_PROP_END_OF_LIST(),
>> -};
>> -
>> -static void ram_class_init(ObjectClass *klass, void *data)
>> -{
>> -    DeviceClass *dc = DEVICE_CLASS(klass);
>> -
>> -    dc->realize = ram_realize;
>> -    dc->props = ram_properties;
>> -}
>> -
>> -static const TypeInfo ram_info = {
>> -    .name          = TYPE_SUN4M_MEMORY,
>> -    .parent        = TYPE_SYS_BUS_DEVICE,
>> -    .instance_size = sizeof(RamDevice),
>> -    .class_init    = ram_class_init,
>> -};
>> -
>>  static void cpu_devinit(const char *cpu_type, unsigned int id,
>>                          uint64_t prom_addr, qemu_irq **cpu_irqs)
>>  {
>> @@ -872,6 +807,19 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>      FWCfgState *fw_cfg;
>>      DeviceState *dev;
>>      SysBusDevice *s;
>> +    MemoryRegion ram;
>> +
>> +    if ((uint64_t)machine->ram_size > hwdef->max_mem) {
>> +        error_report("Too much memory for this machine: %" PRId64 ","
>> +                     " maximum %" PRId64,
>> +                     machine->ram_size / MiB, hwdef->max_mem / MiB);
>> +        exit(1);
>> +    }
>> +    memory_region_allocate_system_memory(&ram, OBJECT(machine), "sun4m.ram",
>> +                                         machine->ram_size);
>> +    memory_region_add_subregion(get_system_memory(), 0x00000000, &ram);
>> +    /* models without ECC don't trap when missing ram is accessed */
>> +    empty_slot_init(0x00000000, hwdef->max_mem);
>>
>>      /* init CPUs */
>>      for(i = 0; i < smp_cpus; i++) {
>> @@ -881,13 +829,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>      for (i = smp_cpus; i < MAX_CPUS; i++)
>>          cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
>>
>> -
>>      /* set up devices */
>> -    ram_init(0, machine->ram_size, hwdef->max_mem);
>> -    /* models without ECC don't trap when missing ram is accessed */
>> -    if (!hwdef->ecc_base) {
>> -        empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_size);
>> -    }
>>
>>      prom_init(hwdef->slavio_base, bios_name);
>>
>> @@ -1561,7 +1503,6 @@ static void sun4m_register_types(void)
>>      type_register_static(&idreg_info);
>>      type_register_static(&afx_info);
>>      type_register_static(&prom_info);
>> -    type_register_static(&ram_info);
>>
>>      type_register_static(&ss5_type);
>>      type_register_static(&ss10_type);
>> --
>> 2.19.1
>>
> 
> 

