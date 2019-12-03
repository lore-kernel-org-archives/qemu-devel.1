Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB87C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C95205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5EgvIqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C95205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic4MO-0007yj-DS
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 04:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic4Ju-0005yQ-OA
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic4Js-0002fq-HQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:18:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic4Js-0002dw-5Y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575364685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+wFDPvF/zPv5j2vgY/iKVd0+CqIFpL1Y/L/YNDsulc=;
 b=R5EgvIqrmwwoB8QxvXHNmpxPDkzNFLr0ZD5GO8kTxnf9oHGmbBsS45CxBqtPq/s5Ka8uor
 bamq8TCv4f8XZlmyeLQy0ruCJAkjKkpP4/7h7IjUn3wXFLtXeBN9dKZ3W0tOr9/SLF5Cfy
 o/g1L73+4H6GfTxO8W4q/oOksE7yVQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-Wp20XKXwPYiIaA_PR6gSHw-1; Tue, 03 Dec 2019 04:18:02 -0500
Received: by mail-wr1-f70.google.com with SMTP id 92so1444342wro.14
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 01:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6+wFDPvF/zPv5j2vgY/iKVd0+CqIFpL1Y/L/YNDsulc=;
 b=HN1r3EF/I7pR1TCeh9Mm9iCVCp95MA0AqJI0HPIxGAPLTVKCxQoHItVCnqlcvsFUio
 F4SJe/rc7TBsCNXODGIF1MqdrT87xQ4fNPLVZzEMJuJ/RqaCuB+4VGJgxBjMevI9RJGJ
 olMbTaGp+lbC6cF1f1nP0DQfM+NLyzf0+hNfN7zhlpMVZB8GyM6uQ9FI4pdB3qDZ4yKU
 tHqHMf8KLRF1sWiT4MStUrz5IXEgwJl2whi9Em1tv3rB5c+2fhDhaUD/XCa5sbkzfhnZ
 7DhxEWO86AGhS9PLtrxJO4YkqE7TMnhoWkZ0aMLndz3xovuhqZAtiqTyHHocFKUE1AXX
 xDoA==
X-Gm-Message-State: APjAAAWWgS3ABPrlqU7NRxvyd8FDC+BWM1McHiDnzVKx54oh4mmlfrkY
 WMdEYpEIp8H6kdotmDC4a8WBCVkrbQ3C6M6mJScZgkg9dCmaUl71qCh34rxNQEKuafJYx9KrJH6
 xXStTGm+Jrj7Dnjw=
X-Received: by 2002:a1c:7d93:: with SMTP id
 y141mr23811194wmc.111.1575364681210; 
 Tue, 03 Dec 2019 01:18:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1kY36edrrvAl6WCw2WZn8/1ez9u2EvRYGsaxgdH++oxKgAUAC17ujahiaODE0gTG5Bbx8KA==
X-Received: by 2002:a1c:7d93:: with SMTP id
 y141mr23811171wmc.111.1575364680943; 
 Tue, 03 Dec 2019 01:18:00 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id w188sm2354874wmg.32.2019.12.03.01.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 01:18:00 -0800 (PST)
Subject: Re: [PATCH 02/10] hw: arm: add Xunlong Orange Pi PC machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-3-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b14e5a75-ebe3-311e-60a8-3f71b0874a10@redhat.com>
Date: Tue, 3 Dec 2019 10:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-3-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: Wp20XKXwPYiIaA_PR6gSHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> based embedded computer with mainline support in both U-Boot
> and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> various other I/O. This commit add support for the Xunlong
> Orange Pi PC machine.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   MAINTAINERS          |  1 +
>   hw/arm/Makefile.objs |  2 +-
>   hw/arm/orangepi.c    | 90 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 92 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/orangepi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29c9936037..42c913d6cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -485,6 +485,7 @@ L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/*/allwinner-h3*
>   F: include/hw/*/allwinner-h3*
> +F: hw/arm/orangepi.c
>   
>   ARM PrimeCell and CMSDK devices
>   M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 956e496052..8d5ea453d5 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -34,7 +34,7 @@ obj-$(CONFIG_DIGIC) += digic.o
>   obj-$(CONFIG_OMAP) += omap1.o omap2.o
>   obj-$(CONFIG_STRONGARM) += strongarm.o
>   obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
> -obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o
> +obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o orangepi.o
>   obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
>   obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
>   obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> new file mode 100644
> index 0000000000..5ef2735f81
> --- /dev/null
> +++ b/hw/arm/orangepi.c
> @@ -0,0 +1,90 @@
> +/*
> + * Orange Pi emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/address-spaces.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/sysbus.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/arm/allwinner-h3.h"
> +
> +static struct arm_boot_info orangepi_binfo = {
> +    .loader_start = AW_H3_SDRAM_BASE,
> +    .board_id = -1,
> +};
> +
> +typedef struct OrangePiState {
> +    AwH3State *h3;
> +    MemoryRegion sdram;
> +} OrangePiState;
> +
> +static void orangepi_init(MachineState *machine)
> +{
> +    OrangePiState *s = g_new(OrangePiState, 1);
> +    Error *err = NULL;
> +

Here I'd add:

       if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) != 0) {
           error_report("This board can only be used with cortex-a7 CPU");
           exit(1);
       }

> +    s->h3 = AW_H3(object_new(TYPE_AW_H3));
> +
> +    /* Setup timer properties */
> +    object_property_set_int(OBJECT(&s->h3->timer), 32768, "clk0-freq", &err);
> +    if (err != NULL) {
> +        error_reportf_err(err, "Couldn't set clk0 frequency: ");
> +        exit(1);
> +    }
> +
> +    object_property_set_int(OBJECT(&s->h3->timer), 24000000, "clk1-freq",
> +                            &err);
> +    if (err != NULL) {
> +        error_reportf_err(err, "Couldn't set clk1 frequency: ");
> +        exit(1);
> +    }
> +
> +    /* Mark H3 object realized */
> +    object_property_set_bool(OBJECT(s->h3), true, "realized", &err);

I'm not sure if that's correct but I'd simply use &error_abort here.

> +    if (err != NULL) {
> +        error_reportf_err(err, "Couldn't realize Allwinner H3: ");
> +        exit(1);
> +    }
> +
> +    /* RAM */
> +    memory_region_allocate_system_memory(&s->sdram, NULL, "orangepi.ram",
> +                                         machine->ram_size);

I'd only allow machine->ram_size == 1 * GiB here, since the onboard DRAM 
is not upgradable.

> +    memory_region_add_subregion(get_system_memory(), AW_H3_SDRAM_BASE,
> +                                &s->sdram);
> +
> +    /* Load target kernel */
> +    orangepi_binfo.ram_size = machine->ram_size;
> +    orangepi_binfo.nb_cpus  = AW_H3_NUM_CPUS;
> +    arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
> +}
> +
> +static void orangepi_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Orange Pi PC";
> +    mc->init = orangepi_init;
> +    mc->units_per_default_bus = 1;
> +    mc->min_cpus = AW_H3_NUM_CPUS;
> +    mc->max_cpus = AW_H3_NUM_CPUS;
> +    mc->default_cpus = AW_H3_NUM_CPUS;

        mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");

> +    mc->ignore_memory_transaction_failures = true;

You should not use this flag in new design. See the documentation in 
include/hw/boards.h:

  * @ignore_memory_transaction_failures:
  *    [...] New board models
  *    should instead use "unimplemented-device" for all memory ranges where
  *    the guest will attempt to probe for a device that QEMU doesn't
  *    implement and a stub device is required.

You already use the "unimplemented-device".

> +}
> +
> +DEFINE_MACHINE("orangepi", orangepi_machine_init)

Can you name it 'orangepi-pc'? So we can add other orangepi models.

Thanks,

Phil.


