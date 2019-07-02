Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77002C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CDD205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CDD205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiESn-000285-Fq
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiERa-0001cc-SN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiERW-000635-8c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:47:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiERU-00062f-UN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:47:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so21478wma.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 01:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=FhVC4Ru+qMI7MRqs0EltvFibZyGhjAefc+SuxYh1y+g=;
 b=Bkapr57wLbzRkDYdBoK/neZJIND06MTry2n9GpT5qHM1o0nhIFoJaTxVt/Tyv+0BoD
 huGxeaPy5lPaWY0cSYm39r2Es30Yh6EfHGBI/d3wktVxvkEz24jkE7vXkIydgZbh7siX
 c9UMrmpLPhO73KT7vF2djt7EUog1lX58+T85qwtYtBuGJc4PHcvn5nZt+A0SkQ2ggUvI
 R92SFB3ai+b1bVrbN+p2qG0E9QkhaX1xYPPiWQ8V23QyyDcNEauVQZBWPKr7Xh94+ic5
 2s0rPShUJZY0WrjdxIcfCukCS2R8wzpr7YZXgcH7fA0eL2TQOash3wFoFkCWj3p8eYW9
 FnyA==
X-Gm-Message-State: APjAAAXvlNB50K4aqd7jiYd2rBxVz5Cl3wMkMYj0gNZgvhpA+acEvIbU
 eD46nL2eFpbJZyYSleAFde82wn0UD1Ma+A==
X-Google-Smtp-Source: APXvYqxaKlfr45uosKvwXLnWHD0137/vh4K9HNO0VB0xlKWujUmYUE/7G4x/tF/RAr4mAWElmUBHnw==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr2533149wmb.17.1562057231524; 
 Tue, 02 Jul 2019 01:47:11 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id f10sm10081884wru.31.2019.07.02.01.47.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 01:47:10 -0700 (PDT)
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081914.ulccsaokivd6epgv@steredhat>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
In-reply-to: <20190702081914.ulccsaokivd6epgv@steredhat>
Date: Tue, 02 Jul 2019 10:47:08 +0200
Message-ID: <877e90ygab.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Stefano Garzarella <sgarzare@redhat.com> writes:

> On Mon, Jul 01, 2019 at 04:47:05PM +0200, Sergio Lopez wrote:
>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> constructed after the machine model implemented by the latter.
>>=20
>> It's main purpose is providing users a KVM-only machine type with fast
>> boot times, minimal attack surface (measured as the number of IO ports
>> and MMIO regions exposed to the Guest) and small footprint (specially
>> when combined with the ongoing QEMU modularization effort).
>>=20
>> Normally, other than the device support provided by KVM itself,
>> microvm only supports virtio-mmio devices. Microvm also includes a
>> legacy mode, which adds an ISA bus with a 16550A serial port, useful
>> for being able to see the early boot kernel messages.
>>=20
>> Microvm only supports booting PVH-enabled Linux ELF images. Booting
>> other PVH-enabled kernels may be possible, but due to the lack of ACPI
>> and firmware, we're relying on the command line for specifying the
>> location of the virtio-mmio transports. If there's an interest on
>> using this machine type with other kernels, we'll try to find some
>> kind of middle ground solution.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  default-configs/i386-softmmu.mak |   1 +
>>  hw/i386/Kconfig                  |   4 +
>>  hw/i386/Makefile.objs            |   1 +
>>  hw/i386/microvm.c                | 500 +++++++++++++++++++++++++++++++
>>  include/hw/i386/microvm.h        |  77 +++++
>>  5 files changed, 583 insertions(+)
>>  create mode 100644 hw/i386/microvm.c
>>  create mode 100644 include/hw/i386/microvm.h
>>=20
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-sof=
tmmu.mak
>> index cd5ea391e8..338f07420f 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -26,3 +26,4 @@ CONFIG_ISAPC=3Dy
>>  CONFIG_I440FX=3Dy
>>  CONFIG_Q35=3Dy
>>  CONFIG_ACPI_PCI=3Dy
>> +CONFIG_MICROVM=3Dy
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index 9817888216..94c565d8db 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -87,6 +87,10 @@ config Q35
>>      select VMMOUSE
>>      select FW_CFG_DMA
>>=20=20
>> +config MICROVM
>> +    bool
>> +    select VIRTIO_MMIO
>> +
>>  config VTD
>>      bool
>>=20=20
>> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
>> index c5f20bbd72..7bffca413e 100644
>> --- a/hw/i386/Makefile.objs
>> +++ b/hw/i386/Makefile.objs
>> @@ -4,6 +4,7 @@ obj-y +=3D pvh.o
>>  obj-y +=3D pc.o
>>  obj-$(CONFIG_I440FX) +=3D pc_piix.o
>>  obj-$(CONFIG_Q35) +=3D pc_q35.o
>> +obj-$(CONFIG_MICROVM) +=3D mptable.o microvm.o
>>  obj-y +=3D fw_cfg.o pc_sysfw.o
>>  obj-y +=3D x86-iommu.o
>>  obj-$(CONFIG_VTD) +=3D intel_iommu.o
>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
>> new file mode 100644
>> index 0000000000..8b5efe9e45
>> --- /dev/null
>> +++ b/hw/i386/microvm.c
>> @@ -0,0 +1,500 @@
>> +/*
>> + * Copyright (c) 2018 Intel Corporation
>> + * Copyright (c) 2019 Red Hat, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify=
 it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2 or later, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHO=
UT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licens=
e for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License al=
ong with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/cutils.h"
>> +#include "qapi/error.h"
>> +#include "qapi/visitor.h"
>> +#include "sysemu/sysemu.h"
>> +#include "sysemu/cpus.h"
>> +#include "sysemu/numa.h"
>> +
>> +#include "hw/loader.h"
>> +#include "hw/nmi.h"
>> +#include "hw/kvm/clock.h"
>> +#include "hw/i386/microvm.h"
>> +#include "hw/i386/pc.h"
>> +#include "target/i386/cpu.h"
>> +#include "hw/timer/i8254.h"
>> +#include "hw/char/serial.h"
>> +#include "hw/i386/topology.h"
>> +#include "hw/virtio/virtio-mmio.h"
>> +#include "hw/i386/mptable.h"
>> +
>> +#include "cpu.h"
>> +#include "elf.h"
>> +#include "pvh.h"
>> +#include "kvm_i386.h"
>> +#include "hw/xen/start_info.h"
>> +
>> +static void microvm_gsi_handler(void *opaque, int n, int level)
>> +{
>> +    qemu_irq *ioapic_irq =3D opaque;
>> +
>> +    qemu_set_irq(ioapic_irq[n], level);
>> +}
>> +
>> +static void microvm_legacy_init(MicrovmMachineState *mms)
>> +{
>> +    ISABus *isa_bus;
>> +    GSIState *gsi_state;
>> +    qemu_irq *i8259;
>> +    int i;
>> +
>> +    assert(kvm_irqchip_in_kernel());
>> +    gsi_state =3D g_malloc0(sizeof(*gsi_state));
>> +    mms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PIN=
S);
>> +
>> +    isa_bus =3D isa_bus_new(NULL, get_system_memory(), get_system_io(),
>> +                          &error_abort);
>> +    isa_bus_irqs(isa_bus, mms->gsi);
>> +
>> +    assert(kvm_pic_in_kernel());
>> +    i8259 =3D kvm_i8259_init(isa_bus);
>> +
>> +    for (i =3D 0; i < ISA_NUM_IRQS; i++) {
>> +        gsi_state->i8259_irq[i] =3D i8259[i];
>> +    }
>> +
>> +    kvm_pit_init(isa_bus, 0x40);
>> +
>> +    for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>> +        int nirq =3D VIRTIO_IRQ_BASE + i;
>> +        ISADevice *isadev =3D isa_create(isa_bus, TYPE_ISA_SERIAL);
>> +        qemu_irq mmio_irq;
>> +
>> +        isa_init_irq(isadev, &mmio_irq, nirq);
>> +        sysbus_create_simple("virtio-mmio",
>> +                             VIRTIO_MMIO_BASE + i * 512,
>> +                             mms->gsi[VIRTIO_IRQ_BASE + i]);
>> +    }
>> +
>> +    g_free(i8259);
>> +
>> +    serial_hds_isa_init(isa_bus, 0, 1);
>> +}
>> +
>> +static void microvm_ioapic_init(MicrovmMachineState *mms)
>> +{
>> +    qemu_irq *ioapic_irq;
>> +    DeviceState *ioapic_dev;
>> +    SysBusDevice *d;
>> +    int i;
>> +
>> +    assert(kvm_irqchip_in_kernel());
>> +    ioapic_irq =3D g_new0(qemu_irq, IOAPIC_NUM_PINS);
>> +    kvm_pc_setup_irq_routing(true);
>> +
>> +    assert(kvm_ioapic_in_kernel());
>> +    ioapic_dev =3D qdev_create(NULL, "kvm-ioapic");
>> +
>> +    object_property_add_child(qdev_get_machine(),
>> +                              "ioapic", OBJECT(ioapic_dev), NULL);
>> +
>> +    qdev_init_nofail(ioapic_dev);
>> +    d =3D SYS_BUS_DEVICE(ioapic_dev);
>> +    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
>> +
>> +    for (i =3D 0; i < IOAPIC_NUM_PINS; i++) {
>> +        ioapic_irq[i] =3D qdev_get_gpio_in(ioapic_dev, i);
>> +    }
>> +
>> +    mms->gsi =3D qemu_allocate_irqs(microvm_gsi_handler,
>> +                                  ioapic_irq, IOAPIC_NUM_PINS);
>> +
>> +    for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>> +        sysbus_create_simple("virtio-mmio",
>> +                             VIRTIO_MMIO_BASE + i * 512,
>> +                             mms->gsi[VIRTIO_IRQ_BASE + i]);
>> +    }
>> +}
>> +
>> +static void microvm_memory_init(MicrovmMachineState *mms)
>> +{
>> +    MachineState *machine =3D MACHINE(mms);
>> +    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
>> +    MemoryRegion *system_memory =3D get_system_memory();
>> +
>> +    if (machine->ram_size > MICROVM_MAX_BELOW_4G) {
>> +        mms->above_4g_mem_size =3D machine->ram_size - MICROVM_MAX_BELO=
W_4G;
>> +        mms->below_4g_mem_size =3D MICROVM_MAX_BELOW_4G;
>> +    } else {
>> +        mms->above_4g_mem_size =3D 0;
>> +        mms->below_4g_mem_size =3D machine->ram_size;
>> +    }
>> +
>> +    ram =3D g_malloc(sizeof(*ram));
>> +    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
>> +                                         machine->ram_size);
>> +
>> +    ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
>> +    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
>> +                             0, mms->below_4g_mem_size);
>> +    memory_region_add_subregion(system_memory, 0, ram_below_4g);
>> +
>> +    e820_add_entry(0, mms->below_4g_mem_size, E820_RAM);
>> +
>> +    if (mms->above_4g_mem_size > 0) {
>> +        ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
>> +        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ra=
m,
>> +                                 mms->below_4g_mem_size,
>> +                                 mms->above_4g_mem_size);
>> +        memory_region_add_subregion(system_memory, 0x100000000ULL,
>> +                                    ram_above_4g);
>> +        e820_add_entry(0x100000000ULL, mms->above_4g_mem_size, E820_RAM=
);
>> +    }
>> +}
>> +
>> +static void microvm_cpus_init(const char *typename, Error **errp)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < smp_cpus; i++) {
>> +        Object *cpu =3D NULL;
>> +        Error *local_err =3D NULL;
>> +
>> +        cpu =3D object_new(typename);
>> +
>> +        object_property_set_uint(cpu, i, "apic-id", &local_err);
>> +        object_property_set_bool(cpu, true, "realized", &local_err);
>> +
>> +        object_unref(cpu);
>> +        error_propagate(errp, local_err);
>> +    }
>> +}
>> +
>> +static void microvm_machine_state_init(MachineState *machine)
>> +{
>> +    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
>> +    Error *local_err =3D NULL;
>> +
>> +    if (machine->kernel_filename =3D=3D NULL) {
>> +        error_report("missing kernel image file name, required by micro=
vm");
>> +        exit(1);
>> +    }
>
> Could it be useful to support initrd as well?
>
> I'm thinking a possibility to a microvm to use only the initrd without a
> block device.

I agree, thanks for the suggestion. I'll add support for it.

Sergio.

> In this case, Linux expects the initrd address and size in the first
> element of the modlist in the 'struct hvm_start_info'.
>
> See pc-bios/optionrom/pvh_main.c
>
> Cheers,
> Stefano


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0bGgwACgkQ9GknjS8M
AjWzoxAAitVbNGPUbrSVmLB18N8nbiFmtWhQd0FCAzdZ3riXzwwan0Dyf/Kbser8
zM5v5WvUssNc+eN51G0dgO1JKOnBLeeWOPh40tbKBWDayzxxjMy5DmZoBOwljSqO
uBW7t560l+XnfZ3bco6ZL5P09v5jK1xCwa7fI5bM9HfBvJpv6KL7i6n3KVSTaQ5U
ih5cxHGf/TBT0K89+6VNl4IHx7wue9vq1AQAqiR6Wp63WOoPhZpxtnEflY1+Ags5
b6rpHQ6Wd9o6+snIVdH3il06U4cpQq+AXIwhO4vSlQ8JJbGDQKPXWhzft3q/nj6B
TVX0IFZMHgepqGDATy/322jionuU42QItGeiMDhbluwiZhzlRza2rwOnG17Aakci
v5IKe0B6Mtz8S/JxC5ti02+SzNOcXIXHbVMco8US84K+ws5GjOtgrLlA7fiKvo2p
GsuErFFDu+2Vow2DqdU6AunkixGs/YjUzhaIICmunHVl8udPE9G7Q+yGljtgy41o
iDlLACmhUsynv6GZJ1JkQS25vsosUOA+eSAYu3AWHgEz3CJrrMyJUt3mCz5TXNsk
fRYERDhHdUk7q9PRh6SIvkxTGTMV3TQPHdT9axnmVTnydV/+BwthHXqkubhrOPbz
KkdErsiDoXSHto1QC1BfTjtm5wj+9YzrGYo8/Qm/CEzJkRslCh0=
=ZeRt
-----END PGP SIGNATURE-----
--=-=-=--

