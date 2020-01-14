Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A43AC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5982187F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF5aufht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5982187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47043 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irVKU-0000eG-JU
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 18:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1irVJd-0008EK-Az
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1irVJY-0001RK-HG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:09:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1irVJY-0001PP-7i
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:09:36 -0500
Received: by mail-ot1-x344.google.com with SMTP id r9so14362175otp.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=CbCN9BwW/hcDt1pe+cUtmQ56gh0Xzoy7qDXRUhOq3yk=;
 b=BF5aufht/YqgAQUIy89NTibbSQqaqYOsaQ7Erl5d1jtotRK2iKlO9FV3TVxuRwJZmT
 PMop9pVI3dvNNEQVO0KPjkBWOb/4ZcYjQpkQZBbB6SA2Lk/QprrxJ1GegYu8nYU8TadP
 oLV0jtF8OADP3+MXiGzpkFkug6Y+os2HtHKIP2OzDCSe79N4F5jR+zPFHpOOu7BJeKXp
 8Rw8hoJSIEBYID+c9v4dOGK7kVlqTMROzsUSLyekdPxkT0romOSWuyHXmcIANvT9ts7/
 wLpyBqPQ6n/GHe+ap6gBhoyl5YngmeeSdHzB8hMUeDcvRgVhN4c0gEpSv6AgPv9k0pbw
 huYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=CbCN9BwW/hcDt1pe+cUtmQ56gh0Xzoy7qDXRUhOq3yk=;
 b=GoeP8zAIfCEV5UCGRCNRz5LsCNVjKmGIHyVIZPOnBQcnp6nWDGRbh7zMv/kZ7atFu1
 JMcsyzPNLX71xIbs1OrrCah8pbQW0Y8ymy4RH4FI6ziBNSP+PZpIPzcNJnit+myWSDPx
 xrqKvvnrEND2F6ltldD3VP+sjxOrjgHZUUrVboIJv/v9XjITxroBqI5ZoqEFmH/Y2G1D
 km90/KGUgcaLC29aIOlgVVBSseHq7h1O+6SreNo0pRGns/64axp6NmxVPlqwkshEZ3vy
 2PUkPITeyZ2AAWhfYQI2pXZaiNSCTFd1Ru9+tRB5nDfGR0LobCjRzW5xAOn/l6TtuCbw
 lwCw==
X-Gm-Message-State: APjAAAVNCEPh1Kg0jGMjKaiKR/J9sA9t6n0QI0/U0WP1OvCTGxuJ9S1p
 ZKqtE1oHHt8NSbOy3Bcrooauz1VH+tHF/4YmyAw=
X-Google-Smtp-Source: APXvYqyp+ZyCAcjdLqQ9ByhHBqQCxV7uLbs0T1Dk0iWLlgd7A3cB1cxKv7g/ablqJ2KkIs9Ng7ewxE6fLVwmifFXLOw=
X-Received: by 2002:a9d:4c94:: with SMTP id m20mr615804otf.341.1579043374348; 
 Tue, 14 Jan 2020 15:09:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 14 Jan 2020 15:09:33 -0800 (PST)
In-Reply-To: <20200112124913.94959-18-ysato@users.sourceforge.jp>
References: <20200112124913.94959-1-ysato@users.sourceforge.jp>
 <20200112124913.94959-18-ysato@users.sourceforge.jp>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 15 Jan 2020 00:09:33 +0100
Message-ID: <CAL1e-=hgnr6C=SzUPGV0ZD-5PHXfsbUSVO0-LZ2kj=SgEca7iw@mail.gmail.com>
Subject: Re: [PATCH v28 17/22] hw/rx: RX Target hardware definition
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: multipart/alternative; boundary="00000000000069bd36059c21af8a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000069bd36059c21af8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, January 12, 2020, Yoshinori Sato <ysato@users.sourceforge.jp>
wrote:

> rx62n - RX62N cpu.
> rx-virt - RX QEMU virtual target.
>
> v23 changes.
> Add missing includes.
>
> v21 changes.
> rx_load_image move to rx-virt.c
>
>
Hello, Yoshinori.


These lines:


> v23 changes.
> Add missing includes.
>
> v21 changes.
> rx_load_image move to rx-virt.c
>
>

should be moved further down, to be just above a section describing v19
changes.

The reson for that is that line with three dashes:

---

tells git that anything after that line is not a part of a commut message,
and at is what we desire: history is useful during review, but shoil net be
stored permanently as a part of a commit message.

Yours, Aleksandar




> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> Message-Id: <20190616142836.10614-17-ysato@users.sourceforge.jp>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190607091116.49044-9-ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use TYPE_RX62N_CPU, use #define for RX62N_NR_TMR/CMT/SCI,
>  renamed CPU -> MCU, device -> microcontroller]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v19: Fixed typo (Peter Maydell)
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/rx.h    |   7 ++
>  include/hw/rx/rx62n.h |  91 ++++++++++++++++
>  hw/rx/rx-virt.c       | 127 ++++++++++++++++++++++
>  hw/rx/rx62n.c         | 239 ++++++++++++++++++++++++++++++++++++++++++
>  hw/rx/Kconfig         |  14 +++
>  hw/rx/Makefile.objs   |   2 +
>  6 files changed, 480 insertions(+)
>  create mode 100644 include/hw/rx/rx.h
>  create mode 100644 include/hw/rx/rx62n.h
>  create mode 100644 hw/rx/rx-virt.c
>  create mode 100644 hw/rx/rx62n.c
>  create mode 100644 hw/rx/Kconfig
>  create mode 100644 hw/rx/Makefile.objs
>
> diff --git a/include/hw/rx/rx.h b/include/hw/rx/rx.h
> new file mode 100644
> index 0000000000..ff5924b81f
> --- /dev/null
> +++ b/include/hw/rx/rx.h
> @@ -0,0 +1,7 @@
> +#ifndef QEMU_RX_H
> +#define QEMU_RX_H
> +/* Definitions for RX board emulation.  */
> +
> +#include "target/rx/cpu-qom.h"
> +
> +#endif
> diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
> new file mode 100644
> index 0000000000..97ea8ddb8e
> --- /dev/null
> +++ b/include/hw/rx/rx62n.h
> @@ -0,0 +1,91 @@
> +/*
> + * RX62N MCU Object
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RX_RX62N_H
> +#define HW_RX_RX62N_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/intc/rx_icu.h"
> +#include "hw/timer/renesas_tmr.h"
> +#include "hw/timer/renesas_cmt.h"
> +#include "hw/char/renesas_sci.h"
> +#include "target/rx/cpu.h"
> +#include "qemu/units.h"
> +
> +#define TYPE_RX62N "rx62n"
> +#define RX62N(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N)
> +
> +#define RX62N_NR_TMR    2
> +#define RX62N_NR_CMT    2
> +#define RX62N_NR_SCI    6
> +
> +typedef struct RX62NState {
> +    SysBusDevice parent_obj;
> +
> +    RXCPU cpu;
> +    RXICUState icu;
> +    RTMRState tmr[RX62N_NR_TMR];
> +    RCMTState cmt[RX62N_NR_CMT];
> +    RSCIState sci[RX62N_NR_SCI];
> +
> +    MemoryRegion *sysmem;
> +    bool kernel;
> +
> +    MemoryRegion iram;
> +    MemoryRegion iomem1;
> +    MemoryRegion d_flash;
> +    MemoryRegion iomem2;
> +    MemoryRegion iomem3;
> +    MemoryRegion c_flash;
> +    qemu_irq irq[NR_IRQS];
> +} RX62NState;
> +
> +/*
> + * RX62N Peripheral Address
> + * See users manual section 5
> + */
> +#define RX62N_ICUBASE 0x00087000
> +#define RX62N_TMRBASE 0x00088200
> +#define RX62N_CMTBASE 0x00088000
> +#define RX62N_SCIBASE 0x00088240
> +
> +/*
> + * RX62N Peripheral IRQ
> + * See users manual section 11
> + */
> +#define RX62N_TMR_IRQBASE 174
> +#define RX62N_CMT_IRQBASE 28
> +#define RX62N_SCI_IRQBASE 214
> +
> +/*
> + * RX62N Internal Memory
> + * It is the value of R5F562N8.
> + * Please change the size for R5F562N7.
> + */
> +#define RX62N_IRAM_BASE 0x00000000
> +#define RX62N_IRAM_SIZE (96 * KiB)
> +#define RX62N_DFLASH_BASE 0x00100000
> +#define RX62N_DFLASH_SIZE (32 * KiB)
> +#define RX62N_CFLASH_BASE 0xfff80000
> +#define RX62N_CFLASH_SIZE (512 * KiB)
> +
> +#define RX62N_PCLK (48 * 1000 * 1000)
> +#endif
> diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
> new file mode 100644
> index 0000000000..4cfe2e3123
> --- /dev/null
> +++ b/hw/rx/rx-virt.c
> @@ -0,0 +1,127 @@
> +/*
> + * RX QEMU virtual platform
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/loader.h"
> +#include "hw/rx/rx62n.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/device_tree.h"
> +#include "hw/boards.h"
> +
> +/* Same address of GDB integrated simulator */
> +#define SDRAM_BASE 0x01000000
> +
> +static void rx_load_image(RXCPU *cpu, const char *filename,
> +                          uint32_t start, uint32_t size)
> +{
> +    static uint32_t extable[32];
> +    long kernel_size;
> +    int i;
> +
> +    kernel_size =3D load_image_targphys(filename, start, size);
> +    if (kernel_size < 0) {
> +        fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
> +        exit(1);
> +    }
> +    cpu->env.pc =3D start;
> +
> +    /* setup exception trap trampoline */
> +    /* linux kernel only works little-endian mode */
> +    for (i =3D 0; i < ARRAY_SIZE(extable); i++) {
> +        extable[i] =3D cpu_to_le32(0x10 + i * 4);
> +    }
> +    rom_add_blob_fixed("extable", extable, sizeof(extable), 0xffffff80);
> +}
> +
> +static void rxvirt_init(MachineState *machine)
> +{
> +    RX62NState *s =3D g_new(RX62NState, 1);
> +    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
> +    const char *kernel_filename =3D machine->kernel_filename;
> +    const char *dtb_filename =3D machine->dtb;
> +    void *dtb =3D NULL;
> +    int dtb_size;
> +
> +    /* Allocate memory space */
> +    memory_region_init_ram(sdram, NULL, "sdram", 16 * MiB,
> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, SDRAM_BASE, sdram);
> +
> +    /* Initialize MCU */
> +    object_initialize_child(OBJECT(machine), "mcu", s,
> +                            sizeof(RX62NState), TYPE_RX62N,
> +                            &error_fatal, NULL);
> +    object_property_set_link(OBJECT(s), OBJECT(get_system_memory()),
> +                             "memory", &error_abort);
> +    object_property_set_bool(OBJECT(s), kernel_filename !=3D NULL,
> +                             "load-kernel", &error_abort);
> +    object_property_set_bool(OBJECT(s), true, "realized", &error_abort);
> +
> +    /* Load kernel and dtb */
> +    if (kernel_filename) {
> +        rx_load_image(RXCPU(first_cpu), kernel_filename,
> +                      SDRAM_BASE + 8 * MiB, 8 * MiB);
> +        if (dtb_filename) {
> +            dtb =3D load_device_tree(dtb_filename, &dtb_size);
> +            if (dtb =3D=3D NULL) {
> +                fprintf(stderr, "Couldn't open dtb file %s\n",
> dtb_filename);
> +                exit(1);
> +            }
> +            if (machine->kernel_cmdline &&
> +                qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
> +                                        machine->kernel_cmdline) < 0) {
> +                fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +                exit(1);
> +            }
> +            rom_add_blob_fixed("dtb", dtb, dtb_size,
> +                               SDRAM_BASE + 16 * MiB - dtb_size);
> +            /* Set dtb address to R1 */
> +            RXCPU(first_cpu)->env.regs[1] =3D 0x02000000 - dtb_size;
> +        }
> +    }
> +}
> +
> +static void rxvirt_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "RX QEMU Virtual Target";
> +    mc->init =3D rxvirt_init;
> +    mc->is_default =3D 1;
> +    mc->default_cpu_type =3D TYPE_RX62N_CPU;
> +}
> +
> +static const TypeInfo rxvirt_type =3D {
> +    .name =3D MACHINE_TYPE_NAME("rx-virt"),
> +    .parent =3D TYPE_MACHINE,
> +    .class_init =3D rxvirt_class_init,
> +};
> +
> +static void rxvirt_machine_init(void)
> +{
> +    type_register_static(&rxvirt_type);
> +}
> +
> +type_init(rxvirt_machine_init)
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> new file mode 100644
> index 0000000000..ac47f2a397
> --- /dev/null
> +++ b/hw/rx/rx62n.c
> @@ -0,0 +1,239 @@
> +/*
> + * RX62N Microcontroller
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "hw/rx/rx62n.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
> +#include "sysemu/sysemu.h"
> +#include "cpu.h"
> +
> +/*
> + * IRQ -> IPR mapping table
> + * 0x00 - 0x91: IPR no (IPR00 to IPR91)
> + * 0xff: IPR not assigned
> + * See "11.3.1 Interrupt Vector Table" in hardware manual.
> + */
> +static const int ipr_table[NR_IRQS] =3D {
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 15 */
> +    0x00, 0xff, 0xff, 0xff, 0xff, 0x01, 0xff, 0x02,
> +    0xff, 0xff, 0xff, 0x03, 0x04, 0x05, 0x06, 0x07, /* 31 */
> +    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +    0x10, 0x11, 0x12, 0x13, 0x14, 0x14, 0x14, 0x14, /* 47 */
> +    0x15, 0x15, 0x15, 0x15, 0xff, 0xff, 0xff, 0xff,
> +    0x18, 0x18, 0x18, 0x18, 0x18, 0x1d, 0x1e, 0x1f, /* 63 */
> +    0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
> +    0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 79 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0x3a, 0x3b, 0x3c, 0xff, 0xff, 0xff, /* 95 */
> +    0x40, 0xff, 0x44, 0x45, 0xff, 0xff, 0x48, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 111 */
> +    0xff, 0xff, 0x51, 0x51, 0x51, 0x51, 0x52, 0x52,
> +    0x52, 0x53, 0x53, 0x54, 0x54, 0x55, 0x55, 0x56, /* 127 */
> +    0x56, 0x57, 0x57, 0x57, 0x57, 0x58, 0x59, 0x59,
> +    0x59, 0x59, 0x5a, 0x5b, 0x5b, 0x5b, 0x5c, 0x5c, /* 143 */
> +    0x5c, 0x5c, 0x5d, 0x5d, 0x5d, 0x5e, 0x5e, 0x5f,
> +    0x5f, 0x60, 0x60, 0x61, 0x61, 0x62, 0x62, 0x62, /* 159 */
> +    0x62, 0x63, 0x64, 0x64, 0x64, 0x64, 0x65, 0x66,
> +    0x66, 0x66, 0x67, 0x67, 0x67, 0x67, 0x68, 0x68, /* 175 */
> +    0x68, 0x69, 0x69, 0x69, 0x6a, 0x6a, 0x6a, 0x6b,
> +    0x6b, 0x6b, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 191 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x70, 0x71,
> +    0x72, 0x73, 0x74, 0x75, 0xff, 0xff, 0xff, 0xff, /* 207 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x80, 0x80,
> +    0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x82, 0x82, /* 223 */
> +    0x82, 0x82, 0x83, 0x83, 0x83, 0x83, 0xff, 0xff,
> +    0xff, 0xff, 0x85, 0x85, 0x85, 0x85, 0x86, 0x86, /* 239 */
> +    0x86, 0x86, 0xff, 0xff, 0xff, 0xff, 0x88, 0x89,
> +    0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, /* 255 */
> +};
> +
> +/*
> + * Level triggerd IRQ list
> + * Not listed IRQ is Edge trigger.
> + * See "11.3.1 Interrupt Vector Table" in hardware manual.
> + */
> +static const uint32_t levelirq[] =3D {
> +     16,  21,  32,  44,  47,  48,  51,  64,  65,  66,
> +     67,  68,  69,  70,  71,  72,  73,  74,  75,  76,
> +     77,  78,  79,  90,  91, 170, 171, 172, 173, 214,
> +    217, 218, 221, 222, 225, 226, 229, 234, 237, 238,
> +    241, 246, 249, 250, 253,
> +};
> +
> +static void register_icu(RX62NState *s)
> +{
> +    int i;
> +    SysBusDevice *icu;
> +
> +    object_initialize_child(OBJECT(s), "icu", &s->icu,
> sizeof(RXICUState),
> +                            TYPE_RXICU, &error_abort, NULL);
> +
> +    icu =3D SYS_BUS_DEVICE(&s->icu);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(icu), 0, RX62N_ICUBASE);
> +    qdev_prop_set_uint32(DEVICE(icu), "len-ipr-map", NR_IRQS);
> +    for (i =3D 0; i < NR_IRQS; i++) {
> +        char propname[32];
> +        snprintf(propname, sizeof(propname), "ipr-map[%d]", i);
> +        qdev_prop_set_uint32(DEVICE(icu), propname, ipr_table[i]);
> +    }
> +    qdev_prop_set_uint32(DEVICE(icu), "len-trigger-level",
> +                         ARRAY_SIZE(levelirq));
> +    for (i =3D 0; i < ARRAY_SIZE(levelirq); i++) {
> +        char propname[32];
> +        snprintf(propname, sizeof(propname), "trigger-level[%d]", i);
> +        qdev_prop_set_uint32(DEVICE(icu), propname, levelirq[i]);
> +    }
> +
> +    for (i =3D 0; i < NR_IRQS; i++) {
> +        s->irq[i] =3D qdev_get_gpio_in(DEVICE(icu), i);
> +    }
> +
> +    qdev_init_nofail(DEVICE(icu));
> +    sysbus_connect_irq(icu, 0, qdev_get_gpio_in(DEVICE(&s->cpu),
> RX_CPU_IRQ));
> +    sysbus_connect_irq(icu, 1, qdev_get_gpio_in(DEVICE(&s->cpu),
> RX_CPU_FIR));
> +    sysbus_connect_irq(icu, 2, s->irq[SWI]);
> +
> +}
> +
> +static void register_tmr(RX62NState *s, int unit)
> +{
> +    SysBusDevice *tmr;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "tmr[*]", &s->tmr[unit],
> +                            sizeof(RTMRState), TYPE_RENESAS_TMR,
> +                            &error_abort, NULL);
> +
> +    tmr =3D SYS_BUS_DEVICE(&s->tmr[unit]);
> +    sysbus_mmio_map(tmr, 0, RX62N_TMRBASE + unit * 0x10);
> +    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", RX62N_PCLK);
> +
> +    qdev_init_nofail(DEVICE(tmr));
> +    irqbase =3D RX62N_TMR_IRQBASE + TMR_NR_IRQ * unit;
> +    for (i =3D 0; i < TMR_NR_IRQ; i++) {
> +        sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
> +    }
> +}
> +
> +static void register_cmt(RX62NState *s, int unit)
> +{
> +    SysBusDevice *cmt;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "cmt[*]", &s->cmt[unit],
> +                            sizeof(RCMTState), TYPE_RENESAS_CMT,
> +                            &error_abort, NULL);
> +
> +    cmt =3D SYS_BUS_DEVICE(&s->cmt[unit]);
> +    sysbus_mmio_map(cmt, 0, RX62N_CMTBASE + unit * 0x10);
> +    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", RX62N_PCLK);
> +
> +    qdev_init_nofail(DEVICE(cmt));
> +    irqbase =3D RX62N_CMT_IRQBASE + CMT_NR_IRQ * unit;
> +    for (i =3D 0; i < CMT_NR_IRQ; i++) {
> +        sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
> +    }
> +}
> +
> +static void register_sci(RX62NState *s, int unit)
> +{
> +    SysBusDevice *sci;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "sci[*]", &s->sci[unit],
> +                            sizeof(RSCIState), TYPE_RENESAS_SCI,
> +                            &error_abort, NULL);
> +
> +    sci =3D SYS_BUS_DEVICE(&s->sci[unit]);
> +    sysbus_mmio_map(sci, 0, RX62N_SCIBASE + unit * 0x08);
> +    qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
> +    qdev_prop_set_uint64(DEVICE(sci), "input-freq", RX62N_PCLK);
> +
> +    qdev_init_nofail(DEVICE(sci));
> +    irqbase =3D RX62N_SCI_IRQBASE + SCI_NR_IRQ * unit;
> +    for (i =3D 0; i < SCI_NR_IRQ; i++) {
> +        sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
> +    }
> +}
> +
> +static void rx62n_realize(DeviceState *dev, Error **errp)
> +{
> +    RX62NState *s =3D RX62N(dev);
> +
> +    memory_region_init_ram(&s->iram, NULL, "iram", RX62N_IRAM_SIZE,
> errp);
> +    memory_region_add_subregion(s->sysmem, RX62N_IRAM_BASE, &s->iram);
> +    memory_region_init_rom(&s->d_flash, NULL, "dataflash",
> +                           RX62N_DFLASH_SIZE, errp);
> +    memory_region_add_subregion(s->sysmem, RX62N_DFLASH_BASE,
> &s->d_flash);
> +    memory_region_init_rom(&s->c_flash, NULL, "codeflash",
> +                           RX62N_CFLASH_SIZE, errp);
> +    memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE,
> &s->c_flash);
> +    if (!s->kernel) {
> +        rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
> +    }
> +
> +    /* Initialize CPU */
> +    object_initialize_child(OBJECT(s), "cpu", &s->cpu, sizeof(RXCPU),
> +                            TYPE_RX62N_CPU, errp, NULL);
> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
> +
> +    register_icu(s);
> +    s->cpu.env.ack =3D qdev_get_gpio_in_named(DEVICE(&s->icu), "ack", 0)=
;
> +    register_tmr(s, 0);
> +    register_tmr(s, 1);
> +    register_cmt(s, 0);
> +    register_cmt(s, 1);
> +    register_sci(s, 0);
> +}
> +
> +static Property rx62n_properties[] =3D {
> +    DEFINE_PROP_LINK("memory", RX62NState, sysmem, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rx62n_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D rx62n_realize;
> +    dc->props =3D rx62n_properties;
> +}
> +
> +static const TypeInfo rx62n_info =3D {
> +    .name =3D TYPE_RX62N,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RX62NState),
> +    .class_init =3D rx62n_class_init,
> +};
> +
> +static void rx62n_register_types(void)
> +{
> +    type_register_static(&rx62n_info);
> +}
> +
> +type_init(rx62n_register_types)
> diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
> new file mode 100644
> index 0000000000..a07490a65e
> --- /dev/null
> +++ b/hw/rx/Kconfig
> @@ -0,0 +1,14 @@
> +config RX
> +    bool
> +
> +config RX62N
> +    bool
> +    select RX
> +    select RX_ICU
> +    select RENESAS_TMR8
> +    select RENESAS_CMT
> +    select RENESAS_SCI
> +
> +config RX_VIRT
> +    bool
> +    select RX62N
> diff --git a/hw/rx/Makefile.objs b/hw/rx/Makefile.objs
> new file mode 100644
> index 0000000000..63f8be0e82
> --- /dev/null
> +++ b/hw/rx/Makefile.objs
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_RX62N) +=3D rx62n.o
> +obj-$(CONFIG_RX_VIRT) +=3D rx-virt.o
> --
> 2.20.1
>
>
>

--00000000000069bd36059c21af8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, January 12, 2020, Yoshinori Sato &lt;<a href=3D"mailto:y=
sato@users.sourceforge.jp">ysato@users.sourceforge.jp</a>&gt; wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">rx62n - RX62N cpu.<br>
rx-virt - RX QEMU virtual target.<br>
<br>
v23 changes.<br>
Add missing includes.<br>
<br>
v21 changes.<br>
rx_load_image move to rx-virt.c<br>
<br></blockquote><div><br></div><div>Hello, Yoshinori.</div><div><br></div>=
<div><br></div><div>These lines:</div><div><br></div><div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
<br>v23 changes.<br>Add missing includes.<br><br>v21 changes.<br>rx_load_im=
age move to rx-virt.c<br><br></blockquote><div><br></div><div><br></div><di=
v>should be moved further down, to be just above a section describing v19 c=
hanges.</div><div><br></div><div>The reson for that is that line with three=
 dashes:</div><div><br></div><div>---</div><div><br></div><div>tells git th=
at anything after that line is not a part of a commut message, and at is wh=
at we desire: history is useful during review, but shoil net be stored perm=
anently as a part of a commit message.</div></div><div><br></div><div>Yours=
, Aleksandar</div><div><br></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
Signed-off-by: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge=
.jp">ysato@users.sourceforge.jp</a>&gt;<br>
<br>
Message-Id: &lt;<a href=3D"mailto:20190616142836.10614-17-ysato@users.sourc=
eforge.jp">20190616142836.10614-17-ysato@users.sourceforge.jp</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com">philmd@redhat.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20190607091116.49044-9-ysato@users.source=
forge.jp">20190607091116.49044-9-ysato@users.sourceforge.jp</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
[PMD: Use TYPE_RX62N_CPU, use #define for RX62N_NR_TMR/CMT/SCI,<br>
=C2=A0renamed CPU -&gt; MCU, device -&gt; microcontroller]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
v19: Fixed typo (Peter Maydell)<br>
Signed-off-by: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge=
.jp">ysato@users.sourceforge.jp</a>&gt;<br>
---<br>
=C2=A0include/hw/rx/rx.h=C2=A0 =C2=A0 |=C2=A0 =C2=A07 ++<br>
=C2=A0include/hw/rx/rx62n.h |=C2=A0 91 ++++++++++++++++<br>
=C2=A0hw/rx/rx-virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 127 +++++++++++++++++++++=
+<br>
=C2=A0hw/rx/rx62n.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 239 ++++++++++++++++=
++++++++++++++<wbr>++++++++++++<br>
=C2=A0hw/rx/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +++<br>
=C2=A0hw/rx/Makefile.objs=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A06 files changed, 480 insertions(+)<br>
=C2=A0create mode 100644 include/hw/rx/rx.h<br>
=C2=A0create mode 100644 include/hw/rx/rx62n.h<br>
=C2=A0create mode 100644 hw/rx/rx-virt.c<br>
=C2=A0create mode 100644 hw/rx/rx62n.c<br>
=C2=A0create mode 100644 hw/rx/Kconfig<br>
=C2=A0create mode 100644 hw/rx/Makefile.objs<br>
<br>
diff --git a/include/hw/rx/rx.h b/include/hw/rx/rx.h<br>
new file mode 100644<br>
index 0000000000..ff5924b81f<br>
--- /dev/null<br>
+++ b/include/hw/rx/rx.h<br>
@@ -0,0 +1,7 @@<br>
+#ifndef QEMU_RX_H<br>
+#define QEMU_RX_H<br>
+/* Definitions for RX board emulation.=C2=A0 */<br>
+<br>
+#include &quot;target/rx/cpu-qom.h&quot;<br>
+<br>
+#endif<br>
diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h<br>
new file mode 100644<br>
index 0000000000..97ea8ddb8e<br>
--- /dev/null<br>
+++ b/include/hw/rx/rx62n.h<br>
@@ -0,0 +1,91 @@<br>
+/*<br>
+ * RX62N MCU Object<br>
+ *<br>
+ * Datasheet: RX62N Group, RX621 Group User&#39;s Manual: Hardware<br>
+ * (Rev.1.40 R01UH0033EJ0140)<br>
+ *<br>
+ * Copyright (c) 2019 Yoshinori Sato<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+<br>
+#ifndef HW_RX_RX62N_H<br>
+#define HW_RX_RX62N_H<br>
+<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/intc/rx_icu.h&quot;<br>
+#include &quot;hw/timer/renesas_tmr.h&quot;<br>
+#include &quot;hw/timer/renesas_cmt.h&quot;<br>
+#include &quot;hw/char/renesas_sci.h&quot;<br>
+#include &quot;target/rx/cpu.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
+<br>
+#define TYPE_RX62N &quot;rx62n&quot;<br>
+#define RX62N(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N)<br>
+<br>
+#define RX62N_NR_TMR=C2=A0 =C2=A0 2<br>
+#define RX62N_NR_CMT=C2=A0 =C2=A0 2<br>
+#define RX62N_NR_SCI=C2=A0 =C2=A0 6<br>
+<br>
+typedef struct RX62NState {<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 RXCPU cpu;<br>
+=C2=A0 =C2=A0 RXICUState icu;<br>
+=C2=A0 =C2=A0 RTMRState tmr[RX62N_NR_TMR];<br>
+=C2=A0 =C2=A0 RCMTState cmt[RX62N_NR_CMT];<br>
+=C2=A0 =C2=A0 RSCIState sci[RX62N_NR_SCI];<br>
+<br>
+=C2=A0 =C2=A0 MemoryRegion *sysmem;<br>
+=C2=A0 =C2=A0 bool kernel;<br>
+<br>
+=C2=A0 =C2=A0 MemoryRegion iram;<br>
+=C2=A0 =C2=A0 MemoryRegion iomem1;<br>
+=C2=A0 =C2=A0 MemoryRegion d_flash;<br>
+=C2=A0 =C2=A0 MemoryRegion iomem2;<br>
+=C2=A0 =C2=A0 MemoryRegion iomem3;<br>
+=C2=A0 =C2=A0 MemoryRegion c_flash;<br>
+=C2=A0 =C2=A0 qemu_irq irq[NR_IRQS];<br>
+} RX62NState;<br>
+<br>
+/*<br>
+ * RX62N Peripheral Address<br>
+ * See users manual section 5<br>
+ */<br>
+#define RX62N_ICUBASE 0x00087000<br>
+#define RX62N_TMRBASE 0x00088200<br>
+#define RX62N_CMTBASE 0x00088000<br>
+#define RX62N_SCIBASE 0x00088240<br>
+<br>
+/*<br>
+ * RX62N Peripheral IRQ<br>
+ * See users manual section 11<br>
+ */<br>
+#define RX62N_TMR_IRQBASE 174<br>
+#define RX62N_CMT_IRQBASE 28<br>
+#define RX62N_SCI_IRQBASE 214<br>
+<br>
+/*<br>
+ * RX62N Internal Memory<br>
+ * It is the value of R5F562N8.<br>
+ * Please change the size for R5F562N7.<br>
+ */<br>
+#define RX62N_IRAM_BASE 0x00000000<br>
+#define RX62N_IRAM_SIZE (96 * KiB)<br>
+#define RX62N_DFLASH_BASE 0x00100000<br>
+#define RX62N_DFLASH_SIZE (32 * KiB)<br>
+#define RX62N_CFLASH_BASE 0xfff80000<br>
+#define RX62N_CFLASH_SIZE (512 * KiB)<br>
+<br>
+#define RX62N_PCLK (48 * 1000 * 1000)<br>
+#endif<br>
diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c<br>
new file mode 100644<br>
index 0000000000..4cfe2e3123<br>
--- /dev/null<br>
+++ b/hw/rx/rx-virt.c<br>
@@ -0,0 +1,127 @@<br>
+/*<br>
+ * RX QEMU virtual platform<br>
+ *<br>
+ * Copyright (c) 2019 Yoshinori Sato<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;hw/hw.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/loader.h&quot;<br>
+#include &quot;hw/rx/rx62n.h&quot;<br>
+#include &quot;sysemu/sysemu.h&quot;<br>
+#include &quot;sysemu/qtest.h&quot;<br>
+#include &quot;sysemu/device_tree.h&quot;<br>
+#include &quot;hw/boards.h&quot;<br>
+<br>
+/* Same address of GDB integrated simulator */<br>
+#define SDRAM_BASE 0x01000000<br>
+<br>
+static void rx_load_image(RXCPU *cpu, const char *filename,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t start, uint32_t size)<br>
+{<br>
+=C2=A0 =C2=A0 static uint32_t extable[32];<br>
+=C2=A0 =C2=A0 long kernel_size;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 kernel_size =3D load_image_targphys(filename, start, size);<=
br>
+=C2=A0 =C2=A0 if (kernel_size &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;qemu: could not load ker=
nel &#39;%s&#39;\n&quot;, filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 cpu-&gt;env.pc =3D start;<br>
+<br>
+=C2=A0 =C2=A0 /* setup exception trap trampoline */<br>
+=C2=A0 =C2=A0 /* linux kernel only works little-endian mode */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(extable); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extable[i] =3D cpu_to_le32(0x10 + i * 4);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 rom_add_blob_fixed(&quot;extable&quot;, extable, sizeof(exta=
ble), 0xffffff80);<br>
+}<br>
+<br>
+static void rxvirt_init(MachineState *machine)<br>
+{<br>
+=C2=A0 =C2=A0 RX62NState *s =3D g_new(RX62NState, 1);<br>
+=C2=A0 =C2=A0 MemoryRegion *sysmem =3D get_system_memory();<br>
+=C2=A0 =C2=A0 MemoryRegion *sdram =3D g_new(MemoryRegion, 1);<br>
+=C2=A0 =C2=A0 const char *kernel_filename =3D machine-&gt;kernel_filename;=
<br>
+=C2=A0 =C2=A0 const char *dtb_filename =3D machine-&gt;dtb;<br>
+=C2=A0 =C2=A0 void *dtb =3D NULL;<br>
+=C2=A0 =C2=A0 int dtb_size;<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate memory space */<br>
+=C2=A0 =C2=A0 memory_region_init_ram(sdram, NULL, &quot;sdram&quot;, 16 * =
MiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>sysmem, SDRAM_BASE, sdram);=
<br>
+<br>
+=C2=A0 =C2=A0 /* Initialize MCU */<br>
+=C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(machine), &quot;mcu&quot=
;, s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(RX62NState), TYPE_RX62N,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal, NULL);<br>
+=C2=A0 =C2=A0 object_property_set_link(<wbr>OBJECT(s), OBJECT(get_system_m=
emory()),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;memory&quot;, &amp;error_abort);<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(s), kernel_filename !=
=3D NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;load-kernel&quot;, &amp;error_abort);<=
br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(s), true, &quot;realize=
d&quot;, &amp;error_abort);<br>
+<br>
+=C2=A0 =C2=A0 /* Load kernel and dtb */<br>
+=C2=A0 =C2=A0 if (kernel_filename) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_load_image(RXCPU(first_cpu)<wbr>, kernel_fi=
lename,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SDRAM_BASE + 8 * MiB, 8 * MiB);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dtb_filename) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb =3D load_device_tree(dtb_fil=
ename, &amp;dtb_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dtb =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;Couldn&#39;t open dtb file %s\n&quot;, dtb_filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (machine-&gt;kernel_cmdline &=
amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_s=
tring(dtb, &quot;/chosen&quot;, &quot;bootargs&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine-=
&gt;kernel_cmdline) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &q=
uot;couldn&#39;t set /chosen/bootargs\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_add_blob_fixed(&quot;dtb&quo=
t;, dtb, dtb_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDRAM_BASE + 16 * MiB - dtb_size);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set dtb address to R1 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RXCPU(first_cpu)-&gt;env.regs[1]=
 =3D 0x02000000 - dtb_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void rxvirt_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;RX QEMU Virtual Target&quot;;<br>
+=C2=A0 =C2=A0 mc-&gt;init =3D rxvirt_init;<br>
+=C2=A0 =C2=A0 mc-&gt;is_default =3D 1;<br>
+=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D TYPE_RX62N_CPU;<br>
+}<br>
+<br>
+static const TypeInfo rxvirt_type =3D {<br>
+=C2=A0 =C2=A0 .name =3D MACHINE_TYPE_NAME(&quot;rx-virt&quot;),<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,<br>
+=C2=A0 =C2=A0 .class_init =3D rxvirt_class_init,<br>
+};<br>
+<br>
+static void rxvirt_machine_init(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;rxvirt_<wbr>type);<br>
+}<br>
+<br>
+type_init(rxvirt_machine_<wbr>init)<br>
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c<br>
new file mode 100644<br>
index 0000000000..ac47f2a397<br>
--- /dev/null<br>
+++ b/hw/rx/rx62n.c<br>
@@ -0,0 +1,239 @@<br>
+/*<br>
+ * RX62N Microcontroller<br>
+ *<br>
+ * Datasheet: RX62N Group, RX621 Group User&#39;s Manual: Hardware<br>
+ * (Rev.1.40 R01UH0033EJ0140)<br>
+ *<br>
+ * Copyright (c) 2019 Yoshinori Sato<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/hw.h&quot;<br>
+#include &quot;hw/rx/rx62n.h&quot;<br>
+#include &quot;hw/loader.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;sysemu/sysemu.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+<br>
+/*<br>
+ * IRQ -&gt; IPR mapping table<br>
+ * 0x00 - 0x91: IPR no (IPR00 to IPR91)<br>
+ * 0xff: IPR not assigned<br>
+ * See &quot;11.3.1 Interrupt Vector Table&quot; in hardware manual.<br>
+ */<br>
+static const int ipr_table[NR_IRQS] =3D {<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 15 */<br>
+=C2=A0 =C2=A0 0x00, 0xff, 0xff, 0xff, 0xff, 0x01, 0xff, 0x02,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0x03, 0x04, 0x05, 0x06, 0x07, /* 31 */<br>
+=C2=A0 =C2=A0 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,<br>
+=C2=A0 =C2=A0 0x10, 0x11, 0x12, 0x13, 0x14, 0x14, 0x14, 0x14, /* 47 */<br>
+=C2=A0 =C2=A0 0x15, 0x15, 0x15, 0x15, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0x18, 0x18, 0x18, 0x18, 0x18, 0x1d, 0x1e, 0x1f, /* 63 */<br>
+=C2=A0 =C2=A0 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,<br>
+=C2=A0 =C2=A0 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 79 */<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0x3a, 0x3b, 0x3c, 0xff, 0xff, 0xff, /* 95 */<br>
+=C2=A0 =C2=A0 0x40, 0xff, 0x44, 0x45, 0xff, 0xff, 0x48, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 111 */<br=
>
+=C2=A0 =C2=A0 0xff, 0xff, 0x51, 0x51, 0x51, 0x51, 0x52, 0x52,<br>
+=C2=A0 =C2=A0 0x52, 0x53, 0x53, 0x54, 0x54, 0x55, 0x55, 0x56, /* 127 */<br=
>
+=C2=A0 =C2=A0 0x56, 0x57, 0x57, 0x57, 0x57, 0x58, 0x59, 0x59,<br>
+=C2=A0 =C2=A0 0x59, 0x59, 0x5a, 0x5b, 0x5b, 0x5b, 0x5c, 0x5c, /* 143 */<br=
>
+=C2=A0 =C2=A0 0x5c, 0x5c, 0x5d, 0x5d, 0x5d, 0x5e, 0x5e, 0x5f,<br>
+=C2=A0 =C2=A0 0x5f, 0x60, 0x60, 0x61, 0x61, 0x62, 0x62, 0x62, /* 159 */<br=
>
+=C2=A0 =C2=A0 0x62, 0x63, 0x64, 0x64, 0x64, 0x64, 0x65, 0x66,<br>
+=C2=A0 =C2=A0 0x66, 0x66, 0x67, 0x67, 0x67, 0x67, 0x68, 0x68, /* 175 */<br=
>
+=C2=A0 =C2=A0 0x68, 0x69, 0x69, 0x69, 0x6a, 0x6a, 0x6a, 0x6b,<br>
+=C2=A0 =C2=A0 0x6b, 0x6b, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 191 */<br=
>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x70, 0x71,<br>
+=C2=A0 =C2=A0 0x72, 0x73, 0x74, 0x75, 0xff, 0xff, 0xff, 0xff, /* 207 */<br=
>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x80, 0x80,<br>
+=C2=A0 =C2=A0 0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x82, 0x82, /* 223 */<br=
>
+=C2=A0 =C2=A0 0x82, 0x82, 0x83, 0x83, 0x83, 0x83, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0x85, 0x85, 0x85, 0x85, 0x86, 0x86, /* 239 */<br=
>
+=C2=A0 =C2=A0 0x86, 0x86, 0xff, 0xff, 0xff, 0xff, 0x88, 0x89,<br>
+=C2=A0 =C2=A0 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, /* 255 */<br=
>
+};<br>
+<br>
+/*<br>
+ * Level triggerd IRQ list<br>
+ * Not listed IRQ is Edge trigger.<br>
+ * See &quot;11.3.1 Interrupt Vector Table&quot; in hardware manual.<br>
+ */<br>
+static const uint32_t levelirq[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A016,=C2=A0 21,=C2=A0 32,=C2=A0 44,=C2=A0 47,=C2=A0 48,=
=C2=A0 51,=C2=A0 64,=C2=A0 65,=C2=A0 66,<br>
+=C2=A0 =C2=A0 =C2=A067,=C2=A0 68,=C2=A0 69,=C2=A0 70,=C2=A0 71,=C2=A0 72,=
=C2=A0 73,=C2=A0 74,=C2=A0 75,=C2=A0 76,<br>
+=C2=A0 =C2=A0 =C2=A077,=C2=A0 78,=C2=A0 79,=C2=A0 90,=C2=A0 91, 170, 171, =
172, 173, 214,<br>
+=C2=A0 =C2=A0 217, 218, 221, 222, 225, 226, 229, 234, 237, 238,<br>
+=C2=A0 =C2=A0 241, 246, 249, 250, 253,<br>
+};<br>
+<br>
+static void register_icu(RX62NState *s)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 SysBusDevice *icu;<br>
+<br>
+=C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(s), &quot;icu&quot;, &am=
p;s-&gt;icu, sizeof(RXICUState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_RXICU, &amp;error_abort, NULL);<br>
+<br>
+=C2=A0 =C2=A0 icu =3D SYS_BUS_DEVICE(&amp;s-&gt;icu);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_<wbr>DEVICE(icu), 0, RX62N_ICUBASE);=
<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(<wbr>icu), &quot;len-ipr-map&quo=
t;, NR_IRQS);<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; NR_IRQS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char propname[32];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(propname, sizeof(propname), &quot;ipr=
-map[%d]&quot;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(<wbr>icu), propnam=
e, ipr_table[i]);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(<wbr>icu), &quot;len-trigger-lev=
el&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ARRAY_SIZE(levelirq));<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(levelirq); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char propname[32];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(propname, sizeof(propname), &quot;tri=
gger-level[%d]&quot;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(<wbr>icu), propnam=
e, levelirq[i]);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; NR_IRQS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq[i] =3D qdev_get_gpio_in(DEVICE(icu),=
 i);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(icu));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(icu, 0, qdev_get_gpio_in(DEVICE(&amp;s-&g=
t;<wbr>cpu), RX_CPU_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(icu, 1, qdev_get_gpio_in(DEVICE(&amp;s-&g=
t;<wbr>cpu), RX_CPU_FIR));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(icu, 2, s-&gt;irq[SWI]);<br>
+<br>
+}<br>
+<br>
+static void register_tmr(RX62NState *s, int unit)<br>
+{<br>
+=C2=A0 =C2=A0 SysBusDevice *tmr;<br>
+=C2=A0 =C2=A0 int i, irqbase;<br>
+<br>
+=C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(s), &quot;tmr[*]&quot;, =
&amp;s-&gt;tmr[unit],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(RTMRState), TYPE_RENESAS_TMR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort, NULL);<br>
+<br>
+=C2=A0 =C2=A0 tmr =3D SYS_BUS_DEVICE(&amp;s-&gt;tmr[unit]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(tmr, 0, RX62N_TMRBASE + unit * 0x10);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint64(DEVICE(<wbr>tmr), &quot;input-freq&quot=
;, RX62N_PCLK);<br>
+<br>
+=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(tmr));<br>
+=C2=A0 =C2=A0 irqbase =3D RX62N_TMR_IRQBASE + TMR_NR_IRQ * unit;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; TMR_NR_IRQ; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(tmr, i, s-&gt;irq[irqbase +=
 i]);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void register_cmt(RX62NState *s, int unit)<br>
+{<br>
+=C2=A0 =C2=A0 SysBusDevice *cmt;<br>
+=C2=A0 =C2=A0 int i, irqbase;<br>
+<br>
+=C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(s), &quot;cmt[*]&quot;, =
&amp;s-&gt;cmt[unit],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(RCMTState), TYPE_RENESAS_CMT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort, NULL);<br>
+<br>
+=C2=A0 =C2=A0 cmt =3D SYS_BUS_DEVICE(&amp;s-&gt;cmt[unit]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(cmt, 0, RX62N_CMTBASE + unit * 0x10);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint64(DEVICE(<wbr>cmt), &quot;input-freq&quot=
;, RX62N_PCLK);<br>
+<br>
+=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(cmt));<br>
+=C2=A0 =C2=A0 irqbase =3D RX62N_CMT_IRQBASE + CMT_NR_IRQ * unit;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; CMT_NR_IRQ; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(cmt, i, s-&gt;irq[irqbase +=
 i]);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void register_sci(RX62NState *s, int unit)<br>
+{<br>
+=C2=A0 =C2=A0 SysBusDevice *sci;<br>
+=C2=A0 =C2=A0 int i, irqbase;<br>
+<br>
+=C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(s), &quot;sci[*]&quot;, =
&amp;s-&gt;sci[unit],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(RSCIState), TYPE_RENESAS_SCI,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort, NULL);<br>
+<br>
+=C2=A0 =C2=A0 sci =3D SYS_BUS_DEVICE(&amp;s-&gt;sci[unit]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(sci, 0, RX62N_SCIBASE + unit * 0x08);<br>
+=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sci), &quot;chardev&quot;, serial_h=
d(unit));<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint64(DEVICE(<wbr>sci), &quot;input-freq&quot=
;, RX62N_PCLK);<br>
+<br>
+=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(sci));<br>
+=C2=A0 =C2=A0 irqbase =3D RX62N_SCI_IRQBASE + SCI_NR_IRQ * unit;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; SCI_NR_IRQ; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(sci, i, s-&gt;irq[irqbase +=
 i]);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void rx62n_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 RX62NState *s =3D RX62N(dev);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;<wbr>iram, NULL, &quot;ira=
m&quot;, RX62N_IRAM_SIZE, errp);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(s-<wbr>&gt;sysmem, RX62N_IRAM_BA=
SE, &amp;s-&gt;iram);<br>
+=C2=A0 =C2=A0 memory_region_init_rom(&amp;s-&gt;d_<wbr>flash, NULL, &quot;=
dataflash&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RX62N_DFLASH_SIZE, errp);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(s-<wbr>&gt;sysmem, RX62N_DFLASH_=
BASE, &amp;s-&gt;d_flash);<br>
+=C2=A0 =C2=A0 memory_region_init_rom(&amp;s-&gt;c_<wbr>flash, NULL, &quot;=
codeflash&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RX62N_CFLASH_SIZE, errp);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(s-<wbr>&gt;sysmem, RX62N_CFLASH_=
BASE, &amp;s-&gt;c_flash);<br>
+=C2=A0 =C2=A0 if (!s-&gt;kernel) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_add_file_fixed(bios_name, RX62N_CFLASH_BAS=
E, 0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Initialize CPU */<br>
+=C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(s), &quot;cpu&quot;, &am=
p;s-&gt;cpu, sizeof(RXCPU),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_RX62N_CPU, errp, NULL);<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&gt;cpu), true, =
&quot;realized&quot;, errp);<br>
+<br>
+=C2=A0 =C2=A0 register_icu(s);<br>
+=C2=A0 =C2=A0 s-&gt;cpu.env.ack =3D qdev_get_gpio_in_named(DEVICE(<wbr>&am=
p;s-&gt;icu), &quot;ack&quot;, 0);<br>
+=C2=A0 =C2=A0 register_tmr(s, 0);<br>
+=C2=A0 =C2=A0 register_tmr(s, 1);<br>
+=C2=A0 =C2=A0 register_cmt(s, 0);<br>
+=C2=A0 =C2=A0 register_cmt(s, 1);<br>
+=C2=A0 =C2=A0 register_sci(s, 0);<br>
+}<br>
+<br>
+static Property rx62n_properties[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_PROP_LINK(&quot;memory&quot;, RX62NState, sysmem, TYP=
E_MEMORY_REGION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0MemoryRegion *),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;load-kernel&quot;<wbr>, RX62NState, k=
ernel, false),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
+};<br>
+<br>
+static void rx62n_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D rx62n_realize;<br>
+=C2=A0 =C2=A0 dc-&gt;props =3D rx62n_properties;<br>
+}<br>
+<br>
+static const TypeInfo rx62n_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_RX62N,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(RX62NState),<br>
+=C2=A0 =C2=A0 .class_init =3D rx62n_class_init,<br>
+};<br>
+<br>
+static void rx62n_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;rx62n_<wbr>info);<br>
+}<br>
+<br>
+type_init(rx62n_register_<wbr>types)<br>
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig<br>
new file mode 100644<br>
index 0000000000..a07490a65e<br>
--- /dev/null<br>
+++ b/hw/rx/Kconfig<br>
@@ -0,0 +1,14 @@<br>
+config RX<br>
+=C2=A0 =C2=A0 bool<br>
+<br>
+config RX62N<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 select RX<br>
+=C2=A0 =C2=A0 select RX_ICU<br>
+=C2=A0 =C2=A0 select RENESAS_TMR8<br>
+=C2=A0 =C2=A0 select RENESAS_CMT<br>
+=C2=A0 =C2=A0 select RENESAS_SCI<br>
+<br>
+config RX_VIRT<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 select RX62N<br>
diff --git a/hw/rx/Makefile.objs b/hw/rx/Makefile.objs<br>
new file mode 100644<br>
index 0000000000..63f8be0e82<br>
--- /dev/null<br>
+++ b/hw/rx/Makefile.objs<br>
@@ -0,0 +1,2 @@<br>
+obj-$(CONFIG_RX62N) +=3D rx62n.o<br>
+obj-$(CONFIG_RX_VIRT) +=3D rx-virt.o<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--00000000000069bd36059c21af8a--

