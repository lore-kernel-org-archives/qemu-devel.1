Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED60CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB8420640
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmwfVrja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB8420640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNMWQ-0006AQ-CZ
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iNLpG-0007ZO-Nq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iNLpE-0003qU-UU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:57:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iNLpE-0003qH-Nv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:57:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id q13so100760wmj.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=aUW72m0Aw9+y1poB5YAVfOls37OgVKcS9ObfoMrhw6U=;
 b=RmwfVrjaioiOHyXaYn/y0iA4HZY0//9abxaoKejPq1tVG/4ZU6Bo2Xz6V23OmK/aMx
 4p437iHx1jds80i9RXerIvC5SEGz9pR46ldkWcWbu8RstAsTMkwWhLohCJufqzMljENk
 M/m3eRPEHzA22USsysyXDuvQSf1dm5qN9AcC42zPo+CHKJdGfzq2m8eVRMhXkNBLyxvJ
 UhAo1Gfny+hDj3PKGJYtY1BgArm+IJbPiVsEwr8k64Rl/DaqreO5jWecxr39ownXmSY9
 GgmcW+Rn2ErTCblo6b63QCT9bX7PtZLRI2uXcIySXqnbiRzsCr8QfhEKTsXZ2SNZmPUe
 j1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=aUW72m0Aw9+y1poB5YAVfOls37OgVKcS9ObfoMrhw6U=;
 b=Uq0Ptt5jM9mCHOvafIKrmQmQ25aqu97bf+yKFwYzEiWHS3gGBVYBUBeAsFFLd7Ep5y
 sZ76gan9vihSGWDOIZoQmqPAUQhsjg4rSk4FPv/UmHoWsgql/njgaNJL2ls7MKhD7l0j
 lFfFJZaymHehYE7nfkjNDoTPquoF01Wc/RyKNFk8+pYq33LqwuUpGle/jgg5BednzCxT
 KdmVdBfD8+wOcHH7O2+lzSYvnZ+/MXxFGSUhZtO6mNsdR+lbPThV2TIWNWsYxuWe4PkR
 YF7aBfboCigvI0APkEGwl99NvHUP71C+twiyhPstgjsIMKaX9sfvxUy5NxusJ++zuh3V
 TeiQ==
X-Gm-Message-State: APjAAAUg2Nfyl3aeus1l0McOOPAlRCXhONHiqGkFEadD/h9WSDedec+p
 CpS7DG/Ncf0yZRhBzvDRfIdHCkQuU+Rv9Q==
X-Google-Smtp-Source: APXvYqxv0X4RzC8YWXkAJgsGHd8r6oJtE94aO8YgMYPLjVUOy8HScWYj4NglyGddtWZzhCHSrGP/pg==
X-Received: by 2002:a1c:67d7:: with SMTP id b206mr1246767wmc.68.1571857059368; 
 Wed, 23 Oct 2019 11:57:39 -0700 (PDT)
Received: from ?IPv6:2a01:c23:6030:5100:7e6a:c70f:e991:63a?
 ([2a01:c23:6030:5100:7e6a:c70f:e991:63a])
 by smtp.gmail.com with ESMTPSA id y13sm33454892wrg.8.2019.10.23.11.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 11:57:38 -0700 (PDT)
Message-ID: <22e7c663b6bb6576b0e75051cd9b35d3defa485c.camel@gmail.com>
Subject: Re: [PATCH v2 03/20] piix4: Add a i8259 Interrupt Controller as
 specified in datasheet
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org
Date: Wed, 23 Oct 2019 20:53:30 +0200
In-Reply-To: <2e3e8cd0-8dbf-46c8-b1d1-e9e3d20f6336@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-4-philmd@redhat.com>
 <27c31440fdab11eff969e656a8ad7063c5e7234c.camel@gmail.com>
 <2e3e8cd0-8dbf-46c8-b1d1-e9e3d20f6336@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mar, 22-10-2019 a las 11:35 +0200, Philippe Mathieu-Daudé escribió:
> On 10/22/19 10:44 AM, Esteban Bosse wrote:
> > El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daudé
> > escribió:
> > > From: Hervé Poussineau <hpoussin@reactos.org>
> > > 
> > > Add ISA irqs as piix4 gpio in, and CPU interrupt request as piix4
> > > gpio out.
> > > Remove i8259 instanciated in malta board, to not have it twice.
> > > 
> > > We can also remove the now unused piix4_init() function.
> > > 
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> > > Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> > > Message-Id: <20171216090228.28505-8-hpoussin@reactos.org>
> > > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > [PMD: rebased, updated includes, use ISA_NUM_IRQS in for loop]
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > > ---
> > >   hw/isa/piix4.c       | 43 ++++++++++++++++++++++++++++++++-----
> > > ---
> > > ---
> > >   hw/mips/mips_malta.c | 32 +++++++++++++-------------------
> > >   include/hw/i386/pc.h |  1 -
> > >   3 files changed, 45 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> > > index d0b18e0586..9c37c85ae2 100644
> > > --- a/hw/isa/piix4.c
> > > +++ b/hw/isa/piix4.c
> > > @@ -24,6 +24,7 @@
> > >    */
> > >   
> > >   #include "qemu/osdep.h"
> > > +#include "hw/irq.h"
> > >   #include "hw/i386/pc.h"
> > >   #include "hw/pci/pci.h"
> > >   #include "hw/isa/isa.h"
> > > @@ -36,6 +37,8 @@ PCIDevice *piix4_dev;
> > >   
> > >   typedef struct PIIX4State {
> > >       PCIDevice dev;
> > > +    qemu_irq cpu_intr;
> > > +    qemu_irq *isa;
> > >   
> > >       /* Reset Control Register */
> > >       MemoryRegion rcr_mem;
> > > @@ -94,6 +97,18 @@ static const VMStateDescription vmstate_piix4
> > > = {
> > >       }
> > >   };
> > >   
> > > +static void piix4_request_i8259_irq(void *opaque, int irq, int
> > > level)
> > > +{
> > > +    PIIX4State *s = opaque;
> > > +    qemu_set_irq(s->cpu_intr, level);
> > > +}
> > > +
> > > +static void piix4_set_i8259_irq(void *opaque, int irq, int
> > > level)
> > > +{
> > > +    PIIX4State *s = opaque;
> > > +    qemu_set_irq(s->isa[irq], level);
> > > +}
> > > +
> > >   static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t
> > > val,
> > >                               unsigned int len)
> > >   {
> > > @@ -127,29 +142,35 @@ static const MemoryRegionOps piix4_rcr_ops
> > > = {
> > >   static void piix4_realize(PCIDevice *dev, Error **errp)
> > >   {
> > >       PIIX4State *s = PIIX4_PCI_DEVICE(dev);
> > > +    ISABus *isa_bus;
> > > +    qemu_irq *i8259_out_irq;
> > >   
> > > -    if (!isa_bus_new(DEVICE(dev), pci_address_space(dev),
> > > -                     pci_address_space_io(dev), errp)) {
> > > +    isa_bus = isa_bus_new(DEVICE(dev), pci_address_space(dev),
> > > +                          pci_address_space_io(dev), errp);
> > > +    if (!isa_bus) {
> > >           return;
> > >       }
> > >   
> > > +    qdev_init_gpio_in_named(DEVICE(dev), piix4_set_i8259_irq,
> > > +                            "isa", ISA_NUM_IRQS);
> > > +    qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
> > > +                             "intr", 1);
> > My question is not about this patch:
> > 
> > The function name is "qdev_init_gpio_out_named" but support more
> > than 1
> > gpio, right? in this case, the name shouldn't be something like
> > "qdev_init_gpios_out_named"?
> 
> Indeed devices can have various IRQ output lines.
> 
> Note, QEMU does not intend to model full devices, but only the
> part required to run a guest. If a guest doesn't use some part
> of a device, QEMU will likely not model it.
> 
> For example, sometimes a device can have N output IRQ to signal
> various error conditions, which are usually used by specific
> firmwares in embedded devices. QEMU might not model embedded
> boards using this device but we can find it in a generic machine
> which runs a full operating system. So far these OS don't care
> about handling these errors, so QEMU will only model the IRQ
> line required to run the OS, no more. This is on purpose.
> 
> Now about the naming, I have no preference which form is better.
> 
> > > +
> > >       memory_region_init_io(&s->rcr_mem, OBJECT(dev),
> > > &piix4_rcr_ops,
> > > s,
> > >                             "reset-control", 1);
> > >       memory_region_add_subregion_overlap(pci_address_space_io(de
> > > v),
> > > 0xcf9,
> > >                                           &s->rcr_mem, 1);
> > Why do you use the priority 1 in this case?
> > >   
> > > +    /* initialize i8259 pic */
> > > +    i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq,
> > > s,
> > > 1);
> > > +    s->isa = i8259_init(isa_bus, *i8259_out_irq);
> > > +
> > > +    /* initialize ISA irqs */
> > > +    isa_bus_irqs(isa_bus, s->isa);
> > > +
> > >       piix4_dev = dev;
> > >   }
> > >   
> > > -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
> > > -{
> > > -    PCIDevice *d;
> > > -
> > > -    d = pci_create_simple_multifunction(bus, devfn, true,
> > > "PIIX4");
> > > -    *isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(d), "isa.0"));
> > > -    return d->devfn;
> > > -}
> > > -
> > >   static void piix4_class_init(ObjectClass *klass, void *data)
> > >   {
> > >       DeviceClass *dc = DEVICE_CLASS(klass);
> > > diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> > > index 4d9c64b36a..7d25ab6c23 100644
> > > --- a/hw/mips/mips_malta.c
> > > +++ b/hw/mips/mips_malta.c
> > > @@ -97,7 +97,7 @@ typedef struct {
> > >       SysBusDevice parent_obj;
> > >   
> > >       MIPSCPSState cps;
> > > -    qemu_irq *i8259;
> > > +    qemu_irq i8259[16];
> 
> 16 -> ISA_NUM_IRQS
> 
> > >   } MaltaState;
> > >   
> > >   static ISADevice *pit;
> > > @@ -1235,8 +1235,8 @@ void mips_malta_init(MachineState *machine)
> > >       int64_t kernel_entry, bootloader_run_addr;
> > >       PCIBus *pci_bus;
> > >       ISABus *isa_bus;
> > > -    qemu_irq *isa_irq;
> > >       qemu_irq cbus_irq, i8259_irq;
> > > +    PCIDevice *pci;
> > >       int piix4_devfn;
> > >       I2CBus *smbus;
> > >       DriveInfo *dinfo;
> > > @@ -1407,30 +1407,24 @@ void mips_malta_init(MachineState
> > > *machine)
> > >       /* Board ID = 0x420 (Malta Board with CoreLV) */
> > >       stl_p(memory_region_get_ram_ptr(bios_copy) + 0x10,
> > > 0x00000420);
> > >   
> > > -    /*
> > > -     * We have a circular dependency problem: pci_bus depends on
> > > isa_irq,
> > > -     * isa_irq is provided by i8259, i8259 depends on ISA, ISA
> > > depends
> > > -     * on piix4, and piix4 depends on pci_bus.  To stop the
> > > cycle we
> > > have
> > > -     * qemu_irq_proxy() adds an extra bit of indirection,
> > > allowing
> > > us
> > > -     * to resolve the isa_irq -> i8259 dependency after i8259 is
> > > initialized.
> > > -     */
> > > -    isa_irq = qemu_irq_proxy(&s->i8259, 16);
> > > -
> > >       /* Northbridge */
> > > -    pci_bus = gt64120_register(isa_irq);
> > > +    pci_bus = gt64120_register(s->i8259);
> > >   
> > >       /* Southbridge */
> > >       ide_drive_get(hd, ARRAY_SIZE(hd));
> > >   
> > > -    piix4_devfn = piix4_init(pci_bus, &isa_bus, 80);
> > > +    pci = pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10,
> > > 0),
> > > +                                          true, "PIIX4");
> > > +    dev = DEVICE(pci);
> > > +    isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> > > +    piix4_devfn = pci->devfn;
> > >   
> > > -    /*
> > > -     * Interrupt controller
> > > -     * The 8259 is attached to the MIPS CPU INT0 pin, ie
> > > interrupt 2
> > > -     */
> > > -    s->i8259 = i8259_init(isa_bus, i8259_irq);
> > > +    /* Interrupt controller */
> > > +    qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
> > > +    for (int i = 0; i < ISA_NUM_IRQS; i++) {
> > > +        s->i8259[i] = qdev_get_gpio_in_named(dev, "isa", i);
> > > +    }
> > >   
> > > -    isa_bus_irqs(isa_bus, s->i8259);
> > >       pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
> > >       pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-
> > > uhci");
> > >       smbus = piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index 37bfd95113..374f3e8835 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -286,7 +286,6 @@ PCIBus *i440fx_init(const char *host_type,
> > > const
> > > char *pci_type,
> > >   PCIBus *find_i440fx(void);
> > >   /* piix4.c */
> > >   extern PCIDevice *piix4_dev;
> > > -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
> > >   
> > >   /* pc_sysfw.c */
> > >   void pc_system_flash_create(PCMachineState *pcms);

Thank you very much for your explanation :).


