Received: from eggs.gnu.org ([2001:4830:134:3::10]:32781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dXgCC-0003X8-P3
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dXgC8-0001Fr-0V
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:02:44 -0400
Message-ID: <1500436938.3350.11.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 19 Jul 2017 14:02:18 +1000
In-Reply-To: <20170719030849.GQ3140@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2017-07-19 at 13:08 +1000, David Gibson wrote:
> 
> I'm somewhat uncomfortable with an irq allocater here in the intc
> code.  As a rule, irq allocation is the responsibility of the machine,
> not any sub-component.  Furthermore, it should allocate in a way which
> is repeatable, since they need to stay stable across reboots and
> migrations.
> 
> And, yes, we have an allocator of sorts in XICS - it has caused a
> number of problems in the past.

So....

For a bare metal model (which we don't have yet) of XIVE, the IRQ
numbering is entirely an artifact of how the HW is configured. There
should thus be no interrupt numbers visible to qemu.

For a PAPR model things are a bit different, but if we want to
maximize code re-use between the two, we probably need to make sure
the interrupts "allocated" by the machine for XIVE can be represented
by the HW model.

That means:

 - Each chip has a range (high bits are the block ID, which maps to a
chip, low bits, around 512K to 1M interrupts is the per-chip space).

 - Interrupts 0...N of that range (N depends on how much backing
memory and MMIO space is provisioned for each chip) are "generic IPIs"
which are somewhat generic interrupt source that can be triggered with
an MMIO store and routed to any target. Those are used in PAPR for
things like IPIs and some type of accelerator interrupts.

 - Portions of that range (which may or may not overlap the 0...N
above, if they do they "shadow" the generic interrupts) can be
configured to be the HW sources from the various PCIe bridges and
the PSI controller.

Cheers,
Ben.

> > +}
> > +
> > +static Property xive_properties[] = {
> > +    DEFINE_PROP_UINT32("nr-targets", XIVE, nr_targets, 0),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void xive_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->realize = xive_realize;
> > +    dc->props = xive_properties;
> > +    dc->desc = "XIVE";
> > +}
> > +
> > +static const TypeInfo xive_info = {
> > +    .name = TYPE_XIVE,
> > +    .parent = TYPE_SYS_BUS_DEVICE,
> > +    .instance_init = xive_init,
> > +    .instance_size = sizeof(XIVE),
> > +    .class_init = xive_class_init,
> > +};
> > +
> > +static void xive_register_types(void)
> > +{
> > +    type_register_static(&xive_info);
> > +}
> > +
> > +type_init(xive_register_types)
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > new file mode 100644
> > index 000000000000..863f5a9c6b5f
> > --- /dev/null
> > +++ b/include/hw/ppc/xive.h
> > @@ -0,0 +1,27 @@
> > +/*
> > + * QEMU PowerPC XIVE model
> > + *
> > + * Copyright (c) 2017, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef PPC_XIVE_H
> > +#define PPC_XIVE_H
> > +
> > +typedef struct XIVE XIVE;
> > +
> > +#define TYPE_XIVE "xive"
> > +#define XIVE(obj) OBJECT_CHECK(XIVE, (obj), TYPE_XIVE)
> > +
> > +#endif /* PPC_XIVE_H */
> 
