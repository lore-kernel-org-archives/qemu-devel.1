Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B29C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704B2208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOraigqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704B2208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1Tm-0000ce-F4
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ16Z-0003WG-CE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:31:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ16W-0005us-VI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:31:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id f21so865122wml.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 21:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zao67fvGO7W5SJnpkzXhUx4O6BNW4V9xBw1R/53cnEU=;
 b=bOraigqMOD4uSVsJLWek3xfCwTU9AIyyC1kFolYU5o3eoQVkeNniEi7qlbsu0TrDAz
 fP/CL+XOt+k0ZDzkDVcldRxj00cePAuB74oGbHqx6Jjx8IVhE4irwZxpAA6cnUSdzDlW
 +Vvjs/lP7N5gnevz0GbairEsOiAS/DxDZblA7jQgkGOURYzYefkc6zRampvUNHN3RHjG
 Xmfk226LJZ6zP31wXTPj7D4qlGNbq8m1t2U0XtvDbZBMnK6UKZXVJ71Ip2I+5PLaY6e1
 LvyvJpHpk6ZrQFXJ+iMRPeCFIHmRt+TYeOnRD+4y9Lu5ibUn89SVQ6dV5K0Ed/Sc3MVy
 rQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Zao67fvGO7W5SJnpkzXhUx4O6BNW4V9xBw1R/53cnEU=;
 b=ayRR1tOerpusbdcOdMUfpQmYoHKnaq6oN9c1nldRJRuEHqfkfX6601nSCmGouhGGjy
 a5845dXYb0ZTDdlh4BYiyKwcZskNmXN4CWldzERkt83w9sqqEadqYF9ashAnTeTcdpWd
 p/lvjXlUyEWvkRGflUTOG71c81tVWnYc9d1HG2EkoBjkq6riScyWGaw1h4mh+3cN5xJs
 S7X5elwNgxCUiRveXiyBe2Z24YqBYpGDftEkjLmLHVo7inT5kJDTvVvoSeyr4MPOPIj/
 HzXuPM37VFNas4KHOavP6RfxRDFp8T+4toYBKQn2JDol3dOU8ONO/o5VEcT3/Qy7a9ui
 bNrw==
X-Gm-Message-State: AOAM533LEv56VC2V6vi1mtRDH4CbdVHjV5ELvdFWjo/m4Ls9AD0+Vri0
 EtwCwcWY3iCxY2m46qkzLUPla1YEt+E=
X-Google-Smtp-Source: ABdhPJwBba0Acm0TgayQwzqyNTQQaj/sgGz7UeGAsQ6GPcyPqXma2JmzET+D3QUQEs/tXmJ7gpwjWw==
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr1150806wmm.38.1602045063072; 
 Tue, 06 Oct 2020 21:31:03 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s17sm909367wmj.1.2020.10.06.21.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 21:31:02 -0700 (PDT)
Subject: Re: [PATCH 12/14] arc: Add Synopsys ARC emulation boards
To: cupertinomiranda@gmail.com, qemu-devel@nongnu.org
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
 <20200930204604.20663-13-cupertinomiranda@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
Message-ID: <5c3b582c-f596-4866-3bca-da4235ec95fc@amsat.org>
Date: Wed, 7 Oct 2020 06:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930204604.20663-13-cupertinomiranda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cupertino, Claudiu,

On 9/30/20 10:46 PM, cupertinomiranda@gmail.com wrote:
> From: Claudiu Zissulescu <claziss@synopsys.com>
> 
> Add the Synopsys ARC boards, arc_sim for testing, sim-hs main emulation
> board using standard UART and nsim which includes a Synopsys ARC specific
> UART implementation.
> 
> Signed-off-by: Claudiu Zissulescu <claziss@synopsys.com>
> ---
>  hw/arc/Makefile.objs      |  21 +++
>  hw/arc/arc_sim.c          | 143 ++++++++++++++++++++
>  hw/arc/arc_uart.c         | 267 ++++++++++++++++++++++++++++++++++++++
>  hw/arc/board-hsdk.c       | 107 +++++++++++++++
>  hw/arc/boot.c             |  95 ++++++++++++++
>  hw/arc/boot.h             |  21 +++
>  hw/arc/meson.build        |  13 ++
>  hw/arc/nsim.c             |  86 ++++++++++++
>  hw/arc/pic_cpu.c          | 111 ++++++++++++++++
>  hw/arc/sample.c           |  77 +++++++++++
>  hw/arc/sim-hs.c           | 107 +++++++++++++++
>  include/hw/arc/arc_uart.h |  43 ++++++
>  include/hw/arc/cpudevs.h  |  10 ++
>  13 files changed, 1101 insertions(+)
>  create mode 100644 hw/arc/Makefile.objs
>  create mode 100644 hw/arc/arc_sim.c
>  create mode 100644 hw/arc/arc_uart.c
>  create mode 100644 hw/arc/board-hsdk.c
>  create mode 100644 hw/arc/boot.c
>  create mode 100644 hw/arc/boot.h
>  create mode 100644 hw/arc/meson.build
>  create mode 100644 hw/arc/nsim.c
>  create mode 100644 hw/arc/pic_cpu.c
>  create mode 100644 hw/arc/sample.c
>  create mode 100644 hw/arc/sim-hs.c
>  create mode 100644 include/hw/arc/arc_uart.h
>  create mode 100644 include/hw/arc/cpudevs.h

Please split in various commits:

- hw/char/arc_uart
- hw/intc/synopsys_pic or something
- hw/arc/boot
- hw/arc/*sim*
- hw/arc/*hsdk*

(Also it would simplify differentiating the architectural
part of your patches from the hardware ones if you use the
target/arc/ prefix in your previous patches).

> 
> diff --git a/hw/arc/Makefile.objs b/hw/arc/Makefile.objs
> new file mode 100644
> index 0000000000..28d7766cd9
> --- /dev/null
> +++ b/hw/arc/Makefile.objs
> @@ -0,0 +1,21 @@
> +#
> +#  QEMU ARC CPU
> +#
> +#  Copyright (c) 2019
> +#
> +#  This library is free software; you can redistribute it and/or
> +#  modify it under the terms of the GNU Lesser General Public
> +#  License as published by the Free Software Foundation; either
> +#  version 2.1 of the License, or (at your option) any later version.
> +#
> +#  This library is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +#  Lesser General Public License for more details.
> +#
> +#  You should have received a copy of the GNU Lesser General Public
> +#  License along with this library; if not, see
> +#  http://www.gnu.org/licenses/lgpl-2.1.html
> +#
> +
> +obj-y   = arc_sim.o arc_uart.o sample.o pic_cpu.o boot.o board-hsdk.o sim-hs.o nsim.o

We don't use Makefile anymore.

> diff --git a/hw/arc/arc_sim.c b/hw/arc/arc_sim.c
> new file mode 100644
> index 0000000000..8020a03d85
> --- /dev/null
> +++ b/hw/arc/arc_sim.c
> @@ -0,0 +1,143 @@
> +/*
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
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/boards.h"
> +#include "elf.h"
> +#include "hw/char/serial.h"
> +#include "net/net.h"
> +#include "hw/loader.h"
> +#include "exec/memory.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/reset.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/sysbus.h"
> +#include "hw/arc/cpudevs.h"
> +#include "boot.h"
> +
> +static void arc_sim_net_init(MemoryRegion *address_space,
> +                             hwaddr base,
> +                             hwaddr descriptors,
> +                             qemu_irq irq, NICInfo *nd)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +
> +    dev = qdev_new("open_eth");
> +    qdev_set_nic_properties(dev, nd);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    s = SYS_BUS_DEVICE(dev);
> +    sysbus_connect_irq(s, 0, irq);
> +    memory_region_add_subregion(address_space, base,
> +                                sysbus_mmio_get_region(s, 0));
> +    memory_region_add_subregion(address_space, descriptors,
> +                                sysbus_mmio_get_region(s, 1));
> +}
> +
> +static uint64_t arc_io_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void arc_io_write(void *opaque, hwaddr addr,
> +                         uint64_t val, unsigned size)
> +{
> +    switch (addr) {
> +    case 0x08: /* board reset. */
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps arc_io_ops = {
> +    .read = arc_io_read,
> +    .write = arc_io_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void arc_sim_init(MachineState *machine)
> +{
> +    static struct arc_boot_info boot_info;
> +    unsigned int smp_cpus = machine->smp.cpus;
> +    ram_addr_t ram_base = 0;
> +    ram_addr_t ram_size = machine->ram_size;
> +    ARCCPU *cpu = NULL;
> +    MemoryRegion *ram, *system_io;
> +    int n;
> +
> +    boot_info.ram_start = ram_base;
> +    boot_info.ram_size = ram_size;
> +    boot_info.kernel_filename = machine->kernel_filename;
> +
> +    for (n = 0; n < smp_cpus; n++) {
> +        cpu = ARC_CPU(object_new(machine->cpu_type));
> +        if (cpu == NULL) {
> +            fprintf(stderr, "Unable to find CPU definition!\n");
> +            exit(1);
> +        }
> +
> +        /* Set the initial CPU properties. */
> +        object_property_set_uint(OBJECT(cpu), "freq_hz", 1000000, &error_fatal);
> +        object_property_set_bool(OBJECT(cpu), "rtc-opt", true, &error_fatal);
> +        object_property_set_bool(OBJECT(cpu), "realized", true, &error_fatal);
> +
> +        /* Initialize internal devices. */
> +        cpu_arc_pic_init(cpu);
> +        cpu_arc_clock_init(cpu);
> +
> +        qemu_register_reset(arc_cpu_reset, cpu);
> +    }
> +
> +    ram = g_new(MemoryRegion, 1);
> +    memory_region_init_ram(ram, NULL, "arc.ram", ram_size, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), ram_base, ram);
> +
> +    system_io = g_new(MemoryRegion, 1);
> +    memory_region_init_io(system_io, NULL, &arc_io_ops, NULL, "arc.io",
> +                           1024);
> +    memory_region_add_subregion(get_system_memory(), 0xf0000000, system_io);
> +
> +    serial_mm_init(get_system_memory(), 0x90000000, 2, cpu->env.irq[20],
> +                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
> +
> +    if (nd_table[0].used) {
> +        arc_sim_net_init(get_system_memory(), 0x92000000,
> +                         0x92000400, cpu->env.irq[4], nd_table);
> +    }
> +
> +    arc_load_kernel(cpu, &boot_info);
> +}
> +
> +static void arc_sim_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "ARCxx simulation";
> +    mc->init = arc_sim_init;
> +    mc->max_cpus = 1;
> +    mc->is_default = false;
> +    mc->default_cpu_type = ARC_CPU_TYPE_NAME("archs");
> +}
> +
> +DEFINE_MACHINE("arc-sim", arc_sim_machine_init)

Can you share the link to the documentation of this simulator please?
I couldn't find it on the link you provided in the cover
(https://www.synopsys.com/designware-ip/processor-solutions.html)
and https://www.synopsys.com/dw/ipdir.php?ds=sim_nSIM doesn't
seem relevant.

> diff --git a/hw/arc/sample.c b/hw/arc/sample.c
> new file mode 100644
> index 0000000000..0ecc11cf15
> --- /dev/null
> +++ b/hw/arc/sample.c
> @@ -0,0 +1,77 @@
> +/*
> + * QEMU ARC CPU
> + *
> + * Copyright (c) 2016 Michael Rolnik
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * http://www.gnu.org/licenses/lgpl-2.1.html
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
> +#include "ui/console.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "qemu/error-report.h"
> +#include "exec/address-spaces.h"
> +#include "include/hw/sysbus.h"
> +
> +#define SIZE_RAM 0x00020000
> +
> +static void sample_init(MachineState *machine)
> +{
> +    MemoryRegion *ram;
> +
> +    ARCCPU *cpu_arc ATTRIBUTE_UNUSED;
> +
> +    ram = g_new(MemoryRegion, 1);
> +
> +    cpu_arc = ARC_CPU(cpu_create("archs-" TYPE_ARC_CPU));
> +
> +    memory_region_init_ram(ram, NULL, "ram", SIZE_RAM, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), PHYS_BASE_RAM, ram);
> +
> +    char const *firmware = NULL;
> +    char const *filename;
> +
> +    if (machine->firmware) {
> +        firmware = machine->firmware;
> +    }
> +
> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> +    if (!filename) {
> +        error_report("Could not find flash image file '%s'", firmware);
> +        exit(1);
> +    }
> +
> +    load_image_targphys(filename, PHYS_BASE_RAM + 0x100, SIZE_RAM);
> +}
> +
> +static void sample_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "ARC sample/example board";
> +    mc->init = sample_init;
> +    mc->is_default = false;
> +}
> +
> +DEFINE_MACHINE("sample", sample_machine_init)

You don't need a "sample" board, you can use the "none" machine instead.

Regards,

Phil.

