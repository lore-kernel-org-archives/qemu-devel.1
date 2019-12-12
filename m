Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF652073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH7YZ6ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF652073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifQtF-0005VA-Ua
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ifQsU-00054w-4O
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ifQsQ-0004ZF-I1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:59:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ifQsQ-0004Wc-Bu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576166381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRlOFp20xUkLuk76KrKKV3ylrgilUaVxnDlVRZRTJOM=;
 b=FH7YZ6ublg31zJMkFiS1We5AMCYbceVllwCb/bzZOFdX0kJlGqK/SCl8WpUsBHCM/R5WO3
 cnhtnhL7jpKtAOr56rXXF2ZqcaP62D7whcSbgk1mgPaiZ/H2Ko4ofkPLzmO39Zo9srgiic
 Bo2eGJHplB2U4hXJCqF5ssXOiJ3RW70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-5LfiVTHHNRiXu4i4qnclYQ-1; Thu, 12 Dec 2019 10:59:40 -0500
X-MC-Unique: 5LfiVTHHNRiXu4i4qnclYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D686107ACC9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:59:39 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A67D25D9E2;
 Thu, 12 Dec 2019 15:59:35 +0000 (UTC)
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
 <1576161021-5359-4-git-send-email-pbonzini@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/5] x86: move more functions to X86MachineState and x86.c
In-reply-to: <1576161021-5359-4-git-send-email-pbonzini@redhat.com>
Date: Thu, 12 Dec 2019 16:59:32 +0100
Message-ID: <87y2vhbkm3.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> These are needed by microvm too, so move them outside of PC-specific file=
s.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/pc.c          |  99 --------------------------------------------=
-----
>  hw/i386/x86.c         | 101 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/i386/pc.h  |  12 ------
>  include/hw/i386/x86.h |  13 +++++++
>  4 files changed, 114 insertions(+), 111 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3d2c5d8..308248d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -342,17 +342,6 @@ GlobalProperty pc_compat_1_4[] =3D {
>  };
>  const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);
> =20
> -void gsi_handler(void *opaque, int n, int level)
> -{
> -    GSIState *s =3D opaque;
> -
> -    DPRINTF("pc: %s GSI %d\n", level ? "raising" : "lowering", n);
> -    if (n < ISA_NUM_IRQS) {
> -        qemu_set_irq(s->i8259_irq[n], level);
> -    }
> -    qemu_set_irq(s->ioapic_irq[n], level);
> -}
> -
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>  {
>      GSIState *s;
> @@ -392,55 +381,6 @@ static uint64_t ioportF0_read(void *opaque, hwaddr a=
ddr, unsigned size)
>      return 0xffffffffffffffffULL;
>  }
> =20
> -/* TSC handling */
> -uint64_t cpu_get_tsc(CPUX86State *env)
> -{
> -    return cpu_get_ticks();
> -}
> -
> -/* IRQ handling */
> -int cpu_get_pic_interrupt(CPUX86State *env)
> -{
> -    X86CPU *cpu =3D env_archcpu(env);
> -    int intno;
> -
> -    if (!kvm_irqchip_in_kernel()) {
> -        intno =3D apic_get_interrupt(cpu->apic_state);
> -        if (intno >=3D 0) {
> -            return intno;
> -        }
> -        /* read the irq from the PIC */
> -        if (!apic_accept_pic_intr(cpu->apic_state)) {
> -            return -1;
> -        }
> -    }
> -
> -    intno =3D pic_read_irq(isa_pic);
> -    return intno;
> -}
> -
> -static void pic_irq_request(void *opaque, int irq, int level)
> -{
> -    CPUState *cs =3D first_cpu;
> -    X86CPU *cpu =3D X86_CPU(cs);
> -
> -    DPRINTF("pic_irqs: %s irq %d\n", level? "raise" : "lower", irq);
> -    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
> -        CPU_FOREACH(cs) {
> -            cpu =3D X86_CPU(cs);
> -            if (apic_accept_pic_intr(cpu->apic_state)) {
> -                apic_deliver_pic_intr(cpu->apic_state, level);
> -            }
> -        }
> -    } else {
> -        if (level) {
> -            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> -        } else {
> -            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> -        }
> -    }
> -}
> -
>  /* PC cmos mappings */
> =20
>  #define REG_EQUIPMENT_BYTE          0x14
> @@ -884,16 +824,6 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd)
>      nb_ne2k++;
>  }
> =20
> -DeviceState *cpu_get_current_apic(void)
> -{
> -    if (current_cpu) {
> -        X86CPU *cpu =3D X86_CPU(current_cpu);
> -        return cpu->apic_state;
> -    } else {
> -        return NULL;
> -    }
> -}
> -
>  void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
>  {
>      X86CPU *cpu =3D opaque;
> @@ -1289,11 +1219,6 @@ uint64_t pc_pci_hole64_start(void)
>      return ROUND_UP(hole64_start, 1 * GiB);
>  }
> =20
> -qemu_irq pc_allocate_cpu_irq(void)
> -{
> -    return qemu_allocate_irq(pic_irq_request, NULL, 0);
> -}
> -
>  DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
>  {
>      DeviceState *dev =3D NULL;
> @@ -1480,30 +1405,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8=
259_irqs)
>      g_free(i8259);
>  }
> =20
> -void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *d;
> -    unsigned int i;
> -
> -    if (kvm_ioapic_in_kernel()) {
> -        dev =3D qdev_create(NULL, TYPE_KVM_IOAPIC);
> -    } else {
> -        dev =3D qdev_create(NULL, TYPE_IOAPIC);
> -    }
> -    if (parent_name) {
> -        object_property_add_child(object_resolve_path(parent_name, NULL)=
,
> -                                  "ioapic", OBJECT(dev), NULL);
> -    }
> -    qdev_init_nofail(dev);
> -    d =3D SYS_BUS_DEVICE(dev);
> -    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
> -
> -    for (i =3D 0; i < IOAPIC_NUM_PINS; i++) {
> -        gsi_state->ioapic_irq[i] =3D qdev_get_gpio_in(dev, i);
> -    }
> -}
> -
>  static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState =
*dev,
>                                 Error **errp)
>  {
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 394edc2..028bbf4 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -41,11 +41,15 @@
>  #include "hw/i386/fw_cfg.h"
> =20
>  #include "hw/acpi/cpu_hotplug.h"
> +#include "hw/i386/pc.h"

Including pc.h from x86.h looks a bit weird to me. I think it'd be nicer
moving the i8259 declarations to a separate header, and the all the
GSI-related stuff to x86.h. I have a couple patches doing that, in case
they can save you some time.

> +#include "hw/irq.h"
>  #include "hw/nmi.h"
>  #include "hw/loader.h"
>  #include "multiboot.h"
>  #include "elf.h"
>  #include "standard-headers/asm-x86/bootparam.h"
> +#include "config-devices.h"
> +#include "kvm_i386.h"
> =20
>  #define BIOS_FILENAME "bios.bin"
> =20
> @@ -220,6 +224,103 @@ static long get_file_size(FILE *f)
>      return size;
>  }
> =20
> +/* TSC handling */
> +uint64_t cpu_get_tsc(CPUX86State *env)
> +{
> +    return cpu_get_ticks();
> +}
> +
> +/* IRQ handling */
> +static void pic_irq_request(void *opaque, int irq, int level)
> +{
> +    CPUState *cs =3D first_cpu;
> +    X86CPU *cpu =3D X86_CPU(cs);
> +
> +    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
> +        CPU_FOREACH(cs) {
> +            cpu =3D X86_CPU(cs);
> +            if (apic_accept_pic_intr(cpu->apic_state)) {
> +                apic_deliver_pic_intr(cpu->apic_state, level);
> +            }
> +        }
> +    } else {
> +        if (level) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +        } else {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        }
> +    }
> +}
> +
> +qemu_irq pc_allocate_cpu_irq(void)
> +{
> +    return qemu_allocate_irq(pic_irq_request, NULL, 0);
> +}

Should we rename this one to "x86_allocate_cpu_irq(void)" ?

> +
> +int cpu_get_pic_interrupt(CPUX86State *env)
> +{
> +    X86CPU *cpu =3D env_archcpu(env);
> +    int intno;
> +
> +    if (!kvm_irqchip_in_kernel()) {
> +        intno =3D apic_get_interrupt(cpu->apic_state);
> +        if (intno >=3D 0) {
> +            return intno;
> +        }
> +        /* read the irq from the PIC */
> +        if (!apic_accept_pic_intr(cpu->apic_state)) {
> +            return -1;
> +        }
> +    }
> +
> +    intno =3D pic_read_irq(isa_pic);
> +    return intno;
> +}
> +
> +DeviceState *cpu_get_current_apic(void)
> +{
> +    if (current_cpu) {
> +        X86CPU *cpu =3D X86_CPU(current_cpu);
> +        return cpu->apic_state;
> +    } else {
> +        return NULL;
> +    }
> +}
> +
> +void gsi_handler(void *opaque, int n, int level)
> +{
> +    GSIState *s =3D opaque;
> +
> +    if (n < ISA_NUM_IRQS) {
> +        qemu_set_irq(s->i8259_irq[n], level);
> +    }
> +    qemu_set_irq(s->ioapic_irq[n], level);
> +}
> +
> +void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *d;
> +    unsigned int i;
> +
> +    if (kvm_ioapic_in_kernel()) {
> +        dev =3D qdev_create(NULL, TYPE_KVM_IOAPIC);
> +    } else {
> +        dev =3D qdev_create(NULL, TYPE_IOAPIC);
> +    }
> +    if (parent_name) {
> +        object_property_add_child(object_resolve_path(parent_name, NULL)=
,
> +                                  "ioapic", OBJECT(dev), NULL);
> +    }
> +    qdev_init_nofail(dev);
> +    d =3D SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
> +
> +    for (i =3D 0; i < IOAPIC_NUM_PINS; i++) {
> +        gsi_state->ioapic_irq[i] =3D qdev_get_gpio_in(dev, i);
> +    }
> +}
> +
>  struct setup_data {
>      uint64_t next;
>      uint32_t type;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 1f86eba..0ab4a2a 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -3,11 +3,9 @@
> =20
>  #include "exec/memory.h"
>  #include "hw/boards.h"
> -#include "hw/isa/isa.h"
>  #include "hw/block/fdc.h"
>  #include "hw/block/flash.h"
>  #include "net/net.h"
> -#include "hw/i386/ioapic.h"
>  #include "hw/i386/x86.h"
> =20
>  #include "qemu/range.h"
> @@ -144,15 +142,6 @@ int pic_get_output(DeviceState *d);
> =20
>  /* ioapic.c */
> =20
> -/* Global System Interrupts */
> -
> -#define GSI_NUM_PINS IOAPIC_NUM_PINS
> -
> -typedef struct GSIState {
> -    qemu_irq i8259_irq[ISA_NUM_IRQS];
> -    qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
> -} GSIState;
> -
>  void gsi_handler(void *opaque, int n, int level);
> =20
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
> @@ -217,7 +206,6 @@ void pc_pci_device_init(PCIBus *pci_bus);
>  typedef void (*cpu_set_smm_t)(int smm, void *arg);
> =20
>  void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
> -void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
> =20
>  ISADevice *pc_find_fdc0(void);
>  int cmos_get_fd_drive_type(FloppyDriveType fd0);
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 4b84917..a6c23ef 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -23,6 +23,8 @@
> =20
>  #include "hw/boards.h"
>  #include "hw/nmi.h"
> +#include "hw/isa/isa.h"
> +#include "hw/i386/ioapic.h"
> =20
>  typedef struct {
>      /*< private >*/
> @@ -95,4 +97,15 @@ void x86_load_linux(X86MachineState *x86ms,
>                      bool pvh_enabled,
>                      bool linuxboot_dma_enabled);
> =20
> +/* Global System Interrupts */
> +
> +#define GSI_NUM_PINS IOAPIC_NUM_PINS
> +
> +typedef struct GSIState {
> +    qemu_irq i8259_irq[ISA_NUM_IRQS];
> +    qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
> +} GSIState;
> +
> +void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
> +
>  #endif


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3yY+QACgkQ9GknjS8M
AjUMhQ/+MNLLJqhMrJcVRMYiuhjM9Np/o4dJQIAJi0lDoGJUa4oA/WLtJFqEDaLx
SrVHIhM2reLpeCxjCQkFdidL7M5oWLZhPVxTedEk+lnqghq27QYUp2TLdDcyO48o
CCXENXeydBkdqiwnWUSYsHz1ekLkhVPhZtnG1cdJCbCfQ6VZ/OE6KzojMbmuq9Vv
srA+z/igF12HhscLtCBFmwzH/hFlA19rGINSo90ehpll7tyAwUyU6s373AHhFlPI
4HBeIqx8Ofz3kJg4a1tXGSRWcZAYB001UDkPVqQRDFsiMIsrUFbsh3WL+vDpPZ1/
gD0yN7XpedN82cXxj3d0OIftuXK1oMhX6qIneX4fJA8kZJJ05KT5wLmPjXGMLNGe
HvGVYcBwAM9rXf31f4Q3vv3sO0IRuTVeqarIzpVNASuBxbk+vm849F4jWeNFt+HK
nRx8PxxLjpKojfTr9WnxiyBy8GVPrHlLlwH1UxhZRJxwA1yMquJOV+fHVarIHb79
5yyEudpF4KGWnSzcIw2aQoDHyKOKKa40VRfghpn6o4u8uquJ2NAZFP02mV+lXtk+
fGmwLTtTxqBSuJm/pazGR4LM95oQvLoBdFkRAuXhh1Z4SERn0crt8dzlVEZXX9ok
Lf6bhoSD3Y68olmtgodcztKPz0KlHOLecV+Chag5pg1roYJLRSA=
=Gn5I
-----END PGP SIGNATURE-----
--=-=-=--


