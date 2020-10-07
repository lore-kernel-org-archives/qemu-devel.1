Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF567C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A09208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTKm21wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A09208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1Ib-0007Ff-9W
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ1HL-0005ZZ-4X
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:42:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ1HI-0001Oc-WB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:42:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so571405wrv.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 21:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zYvRhuGr+QimPc8ppghdIQ2KvtUCJC3ae9Ldcivt4Ls=;
 b=pTKm21wxvz+3BluoTPEuWtlCTtqDpQDu4JgQ4daPF7WeZ+rFEbnDcy+P0ZuUMdPqX+
 GzjJkl6dMFIwpCMP7jhO/tgtJOadR4K46fq5PUS+g8v8C0Ejd+BHedsUIpCM+YQtvM8+
 CQz078hnfsg1gutmnv4YBm4M+eY6qtePpzMZbnRXH7xoHrfgnDShrnHuCwuA7bXyB99r
 pordCt+vKn7OQgPduSYxyBA4lZJgKUqCHcrm2ITzp+J7C6YkteRHzdaayr6Hmm06PYmF
 FnJ5jTSP6SSdPf/ApaVS1L8RHgm+pClN05c0LaWyV2xA2KQ0MT6wQa6pmbzVBKKHXuw9
 v3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zYvRhuGr+QimPc8ppghdIQ2KvtUCJC3ae9Ldcivt4Ls=;
 b=NuW0GevTyMkAY47Csv5T0pV6n4Kx2tzLiEQrmTSuotioXi+mRiezorRfMgmWpEfVUG
 vNw6sxJhF6UrENPqWzE0qC5tVS2CJgzxqPqQTC48im5kdDKACE2q0lcha13B06XFCHHI
 1aH9fsyHH4IfTHCWVvN2ovBy9bxnH2fH/S27l+cqu8BX5qjT9vO57kLJyIyPe/f25yFj
 vlOJ9EfUtkgqeh1Sp0LkAJp2YAKCv8BdHRQJGV/I8/STBaFHzuKGgLBWbT48BgsUnNUr
 hcqFpbOCipsE/e5uNQ6vSKQipab4+/QIRmPRlcMJDlI+k5Ge+TJeYk1IKaAne4ceQnA/
 y4TQ==
X-Gm-Message-State: AOAM532C0fJqxPIals+vVW5wvqfXLjJCaDqYgshPu5D762yECPABHe++
 DrZgR7fSU9py20cEE5XovnA=
X-Google-Smtp-Source: ABdhPJxKINMHKDWEg+9DSwIf2L3CYvjp3jCR2ONY3+EZMz4hyOhc82kLeLPfVQot2Dyqvzpz1pS0BA==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr1155832wrq.381.1602045731245; 
 Tue, 06 Oct 2020 21:42:11 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w7sm871369wmc.43.2020.10.06.21.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 21:42:10 -0700 (PDT)
Subject: Re: [PATCH] Changes to support booting NetBSD/alpha
To: Jason Thorpe <thorpej@me.com>, qemu-devel@nongnu.org
References: <20201007032417.26044-1-thorpej@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f4d04e98-bd81-aba4-a8e7-5e818b13260c@amsat.org>
Date: Wed, 7 Oct 2020 06:42:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007032417.26044-1-thorpej@me.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

On 10/7/20 5:24 AM, Jason Thorpe wrote:
> Along with the previous patch set for qemu-palcode, these changes
> allow NetBSD/alpha to run in qemu-system-alpha.
> 
> - Allow a the minimum PCI device number to be passed to typhoon_init().
>   Use this to specify a minimum PCI device number of 1 in the Clipper
>   system emulation, since that's the lowest PCI device number with
>   valid interrupt mappings on that system.
> - Instead of passing just the CPU count in trap_arg2, also pass other
>   configuration information.  Define the first config bit (bit 6) to
>   reflect the "-nographic" option; PALcode will use this to initialize
>   the Console Terminal Block to specify serial console.
> - Attach a minimal i82378 SIO PCI node; some operating systems won't
>   scan for ISA devices unless a PCI-ISA bridge is detected.  Real hardware
>   would have had a Cypress or ALI bridge, but many Alpha models shipped
>   with a i82378, and most operating sytems are not picky about the specific
>   model.
> - Modify the mc146818rtc emulation to ensure the timer is started as soon
>   as the device is realized, and update the PF bit in REG_C even if it is
>   not going to result in raising an interrupt, as the real hardware does.
> 
> Signed-off-by: Jason Thorpe <thorpej@me.com>
> ---
>  hw/alpha/alpha_sys.h |   2 +-
>  hw/alpha/dp264.c     |  16 ++++++-
>  hw/alpha/typhoon.c   | 104 +++++++++++++++++++++++++++++++++++++++++--
>  hw/rtc/mc146818rtc.c |   7 +++
>  4 files changed, 123 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
> index e2c02e2bbe..4835b3d5ee 100644
> --- a/hw/alpha/alpha_sys.h
> +++ b/hw/alpha/alpha_sys.h
> @@ -11,7 +11,7 @@
>  
>  
>  PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4],
> -                     pci_map_irq_fn);
> +                     pci_map_irq_fn, uint8_t devfn_min);
>  
>  /* alpha_pci.c.  */
>  extern const MemoryRegionOps alpha_pci_ignore_ops;
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 4d24518d1d..de59ae78cb 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -72,13 +72,25 @@ static void clipper_init(MachineState *machine)
>          cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
>      }
>  
> +    /* arg0 -> memory size
> +       arg1 -> kernel entry point
> +       arg2 -> config word
> +
> +       Config word: bits 0-5 -> ncpus
> +		    bit  6   -> nographics option (for HWRPB CTB)
> +
> +       See init_hwrpb() in the PALcode.  */
> +
>      cpus[0]->env.trap_arg0 = ram_size;
>      cpus[0]->env.trap_arg1 = 0;
>      cpus[0]->env.trap_arg2 = smp_cpus;
> +    if (!machine->enable_graphics)
> +      cpus[0]->env.trap_arg2 |= (1 << 6);
>  
> -    /* Init the chipset.  */
> +    /* Init the chipset.  Because we're using CLIPPER IRQ mappings,
> +       the minimum PCI device IdSel is 1.  */
>      pci_bus = typhoon_init(machine->ram, &isa_bus, &rtc_irq, cpus,
> -                           clipper_pci_map_irq);
> +                           clipper_pci_map_irq, PCI_DEVFN(1, 0));
>  
>      /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
>      mc146818_rtc_init(isa_bus, 1900, rtc_irq);
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index a42b319812..cfe7fd5098 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -817,7 +817,8 @@ static void typhoon_alarm_timer(void *opaque)
>  }
>  
>  PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
> -                     AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq)
> +                     AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq,
> +                     uint8_t devfn_min)
>  {
>      MemoryRegion *addr_space = get_system_memory();
>      DeviceState *dev;
> @@ -887,7 +888,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
>      b = pci_register_root_bus(dev, "pci",
>                                typhoon_set_irq, sys_map_irq, s,
>                                &s->pchip.reg_mem, &s->pchip.reg_io,
> -                              0, 64, TYPE_PCI_BUS);
> +                              devfn_min, 64, TYPE_PCI_BUS);
>      phb->bus = b;
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>  
> @@ -921,10 +922,21 @@ PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
>      /* Pchip1 PCI configuration, 0x802.FE00.0000, 16MB.  */
>  
>      /* Init the ISA bus.  */
> -    /* ??? Technically there should be a cy82c693ub pci-isa bridge.  */
> +    /* Init the PCI-ISA bridge.  Technically, this would have been
> +       a cy82c693ub, but a i82378 SIO was also used on many Alpha
> +       systems and is close enough.
> +
> +       ??? We are using a private, stripped down implementation of i82378
> +       so that we can handle the way the ISA interrupts are wired up on
> +       Tsunami-type systems.  We're leaving that (and the rest of the board
> +       peripheral setup) untoucned; we merely need to instantiate the PCI
> +       device node for the bridge, so that operating systems that expect
> +       it to be there will see it.  */

Well, this is not the correct way to do that, so this patch
is unlikely to be accepted. We don't want Frankenstein models.

What is it you miss from the i82378? Why not implement the cy82c693ub?

The code you want to modify is in hw/alpha/dp264.c, see clipper_init().

>      {
>          qemu_irq *isa_irqs;
>  
> +        pci_create_simple(b, PCI_DEVFN(7, 0), "i82378-typhoon");
> +
>          *isa_bus = isa_bus_new(NULL, get_system_memory(), &s->pchip.reg_io,
>                                 &error_abort);
>          isa_irqs = i8259_init(*isa_bus,
> @@ -955,10 +967,96 @@ static const TypeInfo typhoon_iommu_memory_region_info = {
>      .class_init = typhoon_iommu_memory_region_class_init,
>  };
>  
> +/* The following was copied from hw/isa/i82378.c and modified to provide
> +   only the minimal PCI device node.  */
> +
> +/*                            
> + * QEMU Intel i82378 emulation (PCI to ISA bridge) 
> + *                            
> + * Copyright (c) 2010-2011 Herv\xc3\xa9 Poussineau
> + *  
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *  
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *     
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */    
> +
> +#include "migration/vmstate.h"
> +
> +#define TYPE_I82378 "i82378-typhoon"
> +#define I82378(obj) \
> +    OBJECT_CHECK(I82378State, (obj), TYPE_I82378)
> +
> +typedef struct I82378State {
> +    PCIDevice parent_obj;
> +} I82378State;
> +
> +static const VMStateDescription vmstate_i82378 = {
> +    .name = "pci-i82378-typhoon",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj, I82378State), 
> +        VMSTATE_END_OF_LIST()
> +    },                        
> +};                            
> +
> +static void i82378_realize(PCIDevice *pci, Error **errp)
> +{
> +    uint8_t *pci_conf;
> + 
> +    pci_conf = pci->config;
> +    pci_set_word(pci_conf + PCI_COMMAND,
> +                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> +    pci_set_word(pci_conf + PCI_STATUS,
> +                 PCI_STATUS_DEVSEL_MEDIUM);
> + 
> +    pci_config_set_interrupt_pin(pci_conf, 1); /* interrupt pin 0 */
> +}
> +
> +static void i82378_init(Object *obj)
> +{
> +}      
> +
> +static void i82378_class_init(ObjectClass *klass, void *data)
> +{   
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    k->realize = i82378_realize; 
> +    k->vendor_id = PCI_VENDOR_ID_INTEL;
> +    k->device_id = PCI_DEVICE_ID_INTEL_82378;
> +    k->revision = 0x03;
> +    k->class_id = PCI_CLASS_BRIDGE_ISA;
> +    dc->vmsd = &vmstate_i82378;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +}                             
> +
> +static const TypeInfo i82378_typhoon_type_info = {
> +    .name = TYPE_I82378,
> +    .parent = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(I82378State),
> +    .instance_init = i82378_init,
> +    .class_init = i82378_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },     
> +    },
> +};  
> +
>  static void typhoon_register_types(void)
>  {
>      type_register_static(&typhoon_pcihost_info);
>      type_register_static(&typhoon_iommu_memory_region_info);
> +    type_register_static(&i82378_typhoon_type_info);
>  }
>  
>  type_init(typhoon_register_types)
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 7a38540cb9..596876cb43 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -155,9 +155,15 @@ static uint32_t rtc_periodic_clock_ticks(RTCState *s)
>  {
>      int period_code;
>  
> +#if 0
> +    /*
> +     * Real hardware sets the PF bit rergardless if it actually
> +     * raises an interrupt.
> +     */
>      if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
>          return 0;
>       }
> +#endif
>  
>      period_code = s->cmos_data[RTC_REG_A] & 0x0f;
>  
> @@ -944,6 +950,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
>      }
>  
>      s->periodic_timer = timer_new_ns(rtc_clock, rtc_periodic_timer, s);
> +    periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0, true);
>      s->update_timer = timer_new_ns(rtc_clock, rtc_update_timer, s);
>      check_update_timer(s);
>  
> 


