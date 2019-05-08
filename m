Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9A5C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DAE2054F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DAE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKa3-0006VB-57
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:17:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKYO-0005L5-3Y
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKYM-0002bu-Pp
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:16:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKYM-0002bJ-Ig
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:16:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so2754108wmd.0
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=WcBPukSRlNYA5QzAfUbJkyk/58sz49Ga62vg2xigo04=;
	b=EH92FIYI0B1bCxXA1dzDDw3IFg8uJjPNVdrSIDyXTn2yCtfc9OhegtMgVK/scZQepM
	E0O0V3r2HvCa0bpZnpCdos0r71Fa/K24TJJsu1l/AAGrV0M/EbS/4vrYmLutJmXntv6Y
	xBUCTPPkZEPgx6wQRhqSX15574vexRZvOVkfq9bonChs6Jot9SMNxO7qKQwmIxfwGvuM
	6xvQQaygAz3A+jZwOy+gr2VSfJuwiXiTPlmYwugH95A1bb+9Ufz8Qz0MqUE0wok/lsbp
	GZfNn/LUReMGuXaZTxocoi5FvLKyUj75eY+AkB9WBRyjkfQxHZWVrXLRnzMdW6fnQQu/
	LBiw==
X-Gm-Message-State: APjAAAVzjbUckmJFOuQbXor2YGPcOYPNcsG8sJioMFNec+G8sGB5kAMR
	EZs/ttVfp5UdvgAsIpmn9kls2g==
X-Google-Smtp-Source: APXvYqynhKUDNpNw9efejEQRi6rVtUkVaMwsfEL2TDwesPI6Cw0fW6eficXqmVkS/xjfAupNatj43A==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr2604650wme.126.1557314161590; 
	Wed, 08 May 2019 04:16:01 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	f128sm3082970wme.28.2019.05.08.04.15.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:16:01 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-10-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f429133c-a991-2172-7170-53912f624689@redhat.com>
Date: Wed, 8 May 2019 13:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 09/16] hw/mips: Use object_initialize()
 on MIPSCPSState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/19 11:34, Philippe Mathieu-Daudé wrote:
> Initialize the MIPSCPSState with object_initialize() instead of
> object_new(). This will allow us to add it as children of the
> machine container.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/mips/boston.c     | 25 ++++++++++++-------------
>  hw/mips/mips_malta.c | 17 ++++++++---------
>  2 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index a8b29f62f5b..cb3ea85fdc1 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -49,7 +49,7 @@ typedef struct {
>      SysBusDevice parent_obj;
>  
>      MachineState *mach;
> -    MIPSCPSState *cps;
> +    MIPSCPSState cps;
>      SerialState *uart;
>  
>      CharBackend lcd_display;
> @@ -188,7 +188,7 @@ static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
>      case PLAT_DDR3_STATUS:
>          return PLAT_DDR3_STATUS_LOCKED | PLAT_DDR3_STATUS_CALIBRATED;
>      case PLAT_MMCM_DIV:
> -        gic_freq = mips_gictimer_get_freq(s->cps->gic.gic_timer) / 1000000;
> +        gic_freq = mips_gictimer_get_freq(s->cps.gic.gic_timer) / 1000000;
>          val = gic_freq << PLAT_MMCM_DIV_INPUT_SHIFT;
>          val |= 1 << PLAT_MMCM_DIV_MUL_SHIFT;
>          val |= 1 << PLAT_MMCM_DIV_CLK0DIV_SHIFT;
> @@ -455,20 +455,19 @@ static void boston_mach_init(MachineState *machine)
>  
>      is_64b = cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
>  
> -    s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
> -    qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
> -
> -    object_property_set_str(OBJECT(s->cps), machine->cpu_type, "cpu-type",
> +    object_initialize(&s->cps, sizeof(s->cps), TYPE_MIPS_CPS);
> +    qdev_set_parent_bus(DEVICE(&s->cps), sysbus_get_default());
> +    object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-type",
>                              &err);
> -    object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
> -    object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
> +    object_property_set_int(OBJECT(&s->cps), smp_cpus, "num-vp", &err);
> +    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
>  
>      if (err != NULL) {
>          error_report("%s", error_get_pretty(err));
>          exit(1);
>      }
>  
> -    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>  
>      flash =  g_new(MemoryRegion, 1);
>      memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err);
> @@ -487,17 +486,17 @@ static void boston_mach_init(MachineState *machine)
>      xilinx_pcie_init(sys_mem, 0,
>                       0x10000000, 32 * MiB,
>                       0x40000000, 1 * GiB,
> -                     get_cps_irq(s->cps, 2), false);
> +                     get_cps_irq(&s->cps, 2), false);
>  
>      xilinx_pcie_init(sys_mem, 1,
>                       0x12000000, 32 * MiB,
>                       0x20000000, 512 * MiB,
> -                     get_cps_irq(s->cps, 1), false);
> +                     get_cps_irq(&s->cps, 1), false);
>  
>      pcie2 = xilinx_pcie_init(sys_mem, 2,
>                               0x14000000, 32 * MiB,
>                               0x16000000, 1 * MiB,
> -                             get_cps_irq(s->cps, 0), true);
> +                             get_cps_irq(&s->cps, 0), true);
>  
>      platreg = g_new(MemoryRegion, 1);
>      memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
> @@ -505,7 +504,7 @@ static void boston_mach_init(MachineState *machine)
>      memory_region_add_subregion_overlap(sys_mem, 0x17ffd000, platreg, 0);
>  
>      s->uart = serial_mm_init(sys_mem, 0x17ffe000, 2,
> -                             get_cps_irq(s->cps, 3), 10000000,
> +                             get_cps_irq(&s->cps, 3), 10000000,
>                               serial_hd(0), DEVICE_NATIVE_ENDIAN);
>  
>      lcd = g_new(MemoryRegion, 1);
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 439665ab45e..04f2117d71e 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -94,7 +94,7 @@ typedef struct {
>  typedef struct {
>      SysBusDevice parent_obj;
>  
> -    MIPSCPSState *cps;
> +    MIPSCPSState cps;
>      qemu_irq *i8259;
>  } MaltaState;
>  
> @@ -1151,20 +1151,19 @@ static void create_cps(MaltaState *s, const char *cpu_type,
>  {
>      Error *err = NULL;
>  
> -    s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
> -    qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
> -
> -    object_property_set_str(OBJECT(s->cps), cpu_type, "cpu-type", &err);
> -    object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
> -    object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
> +    object_initialize(&s->cps, sizeof(s->cps), TYPE_MIPS_CPS);
> +    qdev_set_parent_bus(DEVICE(&s->cps), sysbus_get_default());
> +    object_property_set_str(OBJECT(&s->cps), cpu_type, "cpu-type", &err);
> +    object_property_set_int(OBJECT(&s->cps), smp_cpus, "num-vp", &err);
> +    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
>      if (err != NULL) {
>          error_report("%s", error_get_pretty(err));
>          exit(1);
>      }
>  
> -    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>  
> -    *i8259_irq = get_cps_irq(s->cps, 3);
> +    *i8259_irq = get_cps_irq(&s->cps, 3);
>      *cbus_irq = NULL;
>  }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

