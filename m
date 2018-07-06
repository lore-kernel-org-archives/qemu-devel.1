Received: from eggs.gnu.org ([2001:4830:134:3::10]:43842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fbRQY-0008FO-9j
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fbRQV-00077T-1z
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:09:38 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:43496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fbRQU-000760-PC
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:09:34 -0400
Received: from player770.ha.ovh.net (unknown [10.109.122.50])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2227EB6BBC
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 16:09:33 +0200 (CEST)
Date: Fri, 6 Jul 2018 16:09:26 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180706160926.471a1930@bahia.lan>
In-Reply-To: <20180706153624.77494d28@bahia.lan>
References: <20180706090713.15712-1-clg@kaod.org>
	<20180706090713.15712-2-clg@kaod.org>
	<20180706153624.77494d28@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 1/3] spapr: introduce a fixed
 IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Fri, 6 Jul 2018 15:36:24 +0200
Greg Kurz <groug@kaod.org> wrote:

[...]

> Hmm... if you put a VIO net and two VIO vty in the domain XML, libvirt
> will generate reg == 0x1000 for the VIO net and reg == 0x30001000 for the
> second VIO vty... this will necessarily collide, won't it ?
> 
> With a 256 VIO devices limit, libvirt can only add 255 devices since
> the nvram is created by QEMU by default (libvirt can only change its
> reg using -global).
> 
> As David mentioned in another mail:
> 
> 	VIO net devices start at reg=0x1000
> 	VIO scsi devices start at reg=0x2000
> 	VIO nvram devices start at reg=0x3000
> 	VIO vty devices start at reg=0x30000000
> 	    and increment by 0x1000 each type
> 
> 
> The values for net, scsi and nvram overlap... which makes me wonder why
> do we even care to have per-type base value !?! Anyway, I don't think
> it's important for what you're trying to achieve.
> 
> Basically libvirt can generate regs in two distinct ranges:
> 
> - one for scsi/net/nvram:
> 
> smallest possible reg: 0x1000
> largest possible reg: 0x2000 + 254 * 0x1000 = 0x100000
> 
> ie, 254 scsi devices starting at 0x2000 and 1 nvram
> 

Oops, it is 255 scsi devices plus 1 nvram so the largest
reg in this range is 0x101000

> - one for vty 
> 
> smallest possible reg: 0x30000000
> largest possible reg: 0x30000000 + 253 * 0x1000 = 0x300fd000
> 
> ie, 254 vty devices
> 

and 255 vty devices, ie, largest reg is 0x300fe000.

> Thinking about the bit shifting magic that is needed to convert
> reg into a usable index makes my brain hurt, but I'll happily
> review anything you propose :)
> 
> > +    }
> > +}
> > +
> >  static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
> >  {
> >      sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> > @@ -485,10 +512,18 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
> >      }
> >  
> >      if (!dev->irq) {
> > -        dev->irq = spapr_irq_findone(spapr, &local_err);
> > -        if (local_err) {
> > -            error_propagate(errp, local_err);
> > -            return;
> > +        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> > +            dev->irq = spapr_irq_findone(spapr, &local_err);
> > +            if (local_err) {
> > +                error_propagate(errp, local_err);
> > +                return;
> > +            }
> > +        } else {
> > +            dev->irq = spapr_vio_reg_to_irq(dev->reg);
> > +            if (dev->irq == SPAPR_IRQ_PCI_LSI) {
> > +                error_setg(errp, "Too many VIO devices");
> > +                return;
> > +            }
> >          }
> >      }
> >  
> > @@ -557,7 +592,7 @@ VIOsPAPRBus *spapr_vio_bus_init(void)
> >      /* Create bus on bridge device */
> >      qbus = qbus_create(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
> >      bus = SPAPR_VIO_BUS(qbus);
> > -    bus->next_reg = 0x71000000;
> > +    bus->next_reg = SPAPR_VIO_REG_BASE;
> >  
> >      /* hcall-vio */
> >      spapr_register_hypercall(H_VIO_SIGNAL, h_vio_signal);
> > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > index bcab6323b7ed..4ab556467289 100644
> > --- a/hw/ppc/Makefile.objs
> > +++ b/hw/ppc/Makefile.objs
> > @@ -4,7 +4,7 @@ obj-y += ppc.o ppc_booke.o fdt.o
> >  obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
> >  obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
> >  obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng.o
> > -obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o
> > +obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> >  # IBM PowerNV
> >  obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
> >  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)  
> 
> 
