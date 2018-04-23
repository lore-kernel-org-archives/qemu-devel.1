Received: from eggs.gnu.org ([2001:4830:134:3::10]:53212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fASxs-0001tR-Js
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fASxp-0002Cg-QU
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:20:32 -0400
Date: Mon, 23 Apr 2018 13:59:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180423035915.GE19804@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-2-clg@kaod.org>
	<20180420071042.GO2434@umbus.fritz.box>
	<d2a521aa-a574-0bf8-332d-9521f2f59895@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <d2a521aa-a574-0bf8-332d-9521f2f59895@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 01/35] ppc/xive: introduce a XIVE
 interrupt source model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 10:27:21AM +0200, C=E9dric Le Goater wrote:
> On 04/20/2018 09:10 AM, David Gibson wrote:
> > On Thu, Apr 19, 2018 at 02:42:57PM +0200, C=E9dric Le Goater wrote:
> >> Each XIVE interrupt source is associated with a two bit state machine
> >> called an Event State Buffer (ESB) : the first bit "P" means that an
> >> interrupt is "pending" and waiting for an EOI and the bit "Q" (queued)
> >> means a new interrupt was triggered while another was still pending.
> >>
> >> When an event is triggered, the associated interrupt state bits are
> >> fetched and modified and forwarded to the virtualization engine of the
> >> controller doing the routing. These can also be controlled by MMIO, to
> >> trigger events or turn off the sources for instance. See code for more
> >> details on the states and transitions.
> >>
> >> On a sPAPR machine, the OS will obtain the address of the MMIO page of
> >> the ESB entry associated with a source and its characteristic using
> >> the H_INT_GET_SOURCE_INFO hcall. On PowerNV, a similar OPAL call is
> >> used.
> >>
> >> The xive_source_notify() routine is in charge forwarding the source
> >> event notification to the routing engine. It will be filled later on.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  Changes since v2:
> >>
> >>  - added support for Store EOI
> >>  - added support for two page MMIO setting like on KVM
> >=20
> > Looks generally sane to me, though I have a few queries.
> >=20
> >>
> >>  default-configs/ppc64-softmmu.mak |   1 +
> >>  hw/intc/Makefile.objs             |   1 +
> >>  hw/intc/xive.c                    | 335 +++++++++++++++++++++++++++++=
+++++++++
> >>  include/hw/ppc/xive.h             | 130 +++++++++++++++
> >>  4 files changed, 467 insertions(+)
> >>  create mode 100644 hw/intc/xive.c
> >>  create mode 100644 include/hw/ppc/xive.h
> >>
> >> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64=
-softmmu.mak
> >> index b94af6c7c62a..c6d13e757977 100644
> >> --- a/default-configs/ppc64-softmmu.mak
> >> +++ b/default-configs/ppc64-softmmu.mak
> >> @@ -16,4 +16,5 @@ CONFIG_VIRTIO_VGA=3Dy
> >>  CONFIG_XICS=3D$(CONFIG_PSERIES)
> >>  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
> >>  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
> >> +CONFIG_XIVE=3D$(CONFIG_PSERIES)
> >>  CONFIG_MEM_HOTPLUG=3Dy
> >> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> >> index 0e9963f5eecc..72a46ed91c31 100644
> >> --- a/hw/intc/Makefile.objs
> >> +++ b/hw/intc/Makefile.objs
> >> @@ -37,6 +37,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
> >>  obj-$(CONFIG_XICS) +=3D xics.o
> >>  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
> >>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
> >> +obj-$(CONFIG_XIVE) +=3D xive.o
> >>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
> >>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
> >>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
> >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >> new file mode 100644
> >> index 000000000000..c70578759d02
> >> --- /dev/null
> >> +++ b/hw/intc/xive.c
> >> @@ -0,0 +1,335 @@
> >> +/*
> >> + * QEMU PowerPC XIVE interrupt controller model
> >> + *
> >> + * Copyright (c) 2017-2018, IBM Corporation.
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/log.h"
> >> +#include "qapi/error.h"
> >> +#include "target/ppc/cpu.h"
> >> +#include "sysemu/cpus.h"
> >> +#include "sysemu/dma.h"
> >> +#include "monitor/monitor.h"
> >> +#include "hw/ppc/xive.h"
> >> +
> >> +/*
> >> + * XIVE Interrupt Source
> >> + */
> >> +
> >> +uint8_t xive_source_pq_get(XiveSource *xsrc, uint32_t srcno)
> >> +{
> >> +    uint32_t byte =3D srcno / 4;
> >> +    uint32_t bit  =3D (srcno % 4) * 2;
> >> +
> >> +    assert(byte < xsrc->sbe_size);
> >> +
> >> +    return (xsrc->sbe[byte] >> bit) & 0x3;
> >> +}
> >> +
> >> +uint8_t xive_source_pq_set(XiveSource *xsrc, uint32_t srcno, uint8_t =
pq)
> >> +{
> >> +    uint32_t byte =3D srcno / 4;
> >> +    uint32_t bit  =3D (srcno % 4) * 2;
> >> +    uint8_t old, new;
> >> +
> >> +    assert(byte < xsrc->sbe_size);
> >> +
> >> +    old =3D xsrc->sbe[byte];
> >> +
> >> +    new =3D xsrc->sbe[byte] & ~(0x3 << bit);
> >> +    new |=3D (pq & 0x3) << bit;
> >> +
> >> +    xsrc->sbe[byte] =3D new;
> >> +
> >> +    return (old >> bit) & 0x3;
> >> +}
> >> +
> >> +static bool xive_source_pq_eoi(XiveSource *xsrc, uint32_t srcno)
> >> +{
> >> +    uint8_t old_pq =3D xive_source_pq_get(xsrc, srcno);
> >> +
> >> +    switch (old_pq) {
> >> +    case XIVE_ESB_RESET:
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_RESET);
> >> +        return false;
> >> +    case XIVE_ESB_PENDING:
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_RESET);
> >> +        return false;
> >> +    case XIVE_ESB_QUEUED:
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_PENDING);
> >> +        return true;
> >> +    case XIVE_ESB_OFF:
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_OFF);
> >> +        return false;
> >> +    default:
> >> +         g_assert_not_reached();
> >> +    }
> >> +}
> >> +
> >> +/*
> >> + * Returns whether the event notification should be forwarded.
> >> + */
> >> +static bool xive_source_pq_trigger(XiveSource *xsrc, uint32_t srcno)
> >> +{
> >> +    uint8_t old_pq =3D xive_source_pq_get(xsrc, srcno);
> >> +
> >> +    switch (old_pq) {
> >> +    case XIVE_ESB_RESET:
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_PENDING);
> >> +        return true;
> >> +    case XIVE_ESB_PENDING:
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_QUEUED);
> >> +        return false;
> >> +    case XIVE_ESB_QUEUED:
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_QUEUED);
> >> +        return false;
> >> +    case XIVE_ESB_OFF:
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_OFF);
> >> +        return false;
> >> +    default:
> >> +         g_assert_not_reached();
> >> +    }
> >> +}
> >> +
> >> +/*
> >> + * Forward the source event notification to the associated XiveFabric,
> >> + * the device owning the sources.
> >> + */
> >> +static void xive_source_notify(XiveSource *xsrc, int srcno)
> >> +{
> >> +
> >> +}
> >> +
> >> +/* In a two pages ESB MMIO setting, even page is the trigger page, odd
> >> + * page is for management */
> >=20
> > Can I understand from this that the result from this function is only
> > meaningful in 2-pages mode?
>=20
> yes. May be I should rename it to xive_source_is_even_page() ?

Seems very long winded.  Maybe keep the name but have it check both
whether it's an even page and also whether you're in 2pages mode.

> >> +static inline bool xive_source_is_trigger_page(hwaddr addr)
> >> +{
> >> +    return !((addr >> 16) & 1);
> >=20
> > Later on you seem to have both 4k and 64k variants list, but here you
> > hardcode 64k.  Is that a problem?
> =09
> oups. This should be  :
>=20
> 	(addr >> (xsrc->esb_shift - 1))
>=20
> I did the tests with the spapr guest which uses 64k ESB MMIO pages.=20
> The check is only significant in a 2 pages setting.

Ok.

> >> +}
> >> +
> >> +static uint64_t xive_source_esb_read(void *opaque, hwaddr addr, unsig=
ned size)
> >> +{
> >> +    XiveSource *xsrc =3D XIVE_SOURCE(opaque);
> >> +    uint32_t offset =3D addr & 0xF00;
> >=20
> > You ignore the low bits of the address entirely, so effective you have
> > a 256 byte range that's all aliases of the same register.  Is that
> > intentional?
>=20
> yes but it's not entirely correct. The exact ranges are :
>=20
> 			Load			Store
>=20
> 0x000 .. 0x3FF		EOI and return 0|1	Trigger
> 0x400 .. 0x7FF		EOI and return 0|1	EOI
> 0x800 .. 0xBFF  	return PQ		undefined
> 0xC00 .. 0xCFF		return PQ and PQ=3D00	PQ=3D00
> 0xD00 .. 0xDFF		return PQ and PQ=3D01	PQ=3D01
> 0xE00 .. 0xDFF		return PQ and PQ=3D10	PQ=3D10
> 0xF00 .. 0xDFF		return PQ and PQ=3D11	PQ=3D11
>=20
> There is room for some improvements.
>=20
> The trigger page in a two pages ESB MMIO settings only triggers on stores.

Ok.

> >> +    uint32_t srcno =3D addr >> xsrc->esb_shift;
> >> +    uint64_t ret =3D -1;
> >> +
> >> +    if (xive_source_esb_2page(xsrc) && xive_source_is_trigger_page(ad=
dr)) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR,
> >> +                      "XIVE: invalid load on IRQ %d trigger page at "
> >> +                      "0x%"HWADDR_PRIx"\n", srcno, addr);
> >> +        return -1;
> >> +    }
> >> +
> >> +    switch (offset) {
> >> +    case XIVE_ESB_LOAD_EOI:
> >> +        /*
> >> +         * Load EOI is not the default source setting under QEMU, but
> >> +         * this is what HW uses currently.
> >> +         */
> >> +        ret =3D xive_source_pq_eoi(xsrc, srcno);
> >=20
> > You're implicitly casting a bool return value into a u64 here, is that
> > intentional?
>=20
> yes. is that bad ? This is what the load is supposed to return in the tra=
nsition=20
> algo.=20

No, that's fine, as long as just using the LSB in your return is
correct.  Just making sure I understood.

> >> +
> >> +        break;
> >> +
> >> +    case XIVE_ESB_GET:
> >> +        ret =3D xive_source_pq_get(xsrc, srcno);
> >> +        break;
> >> +
> >> +    case XIVE_ESB_SET_PQ_00:
> >> +    case XIVE_ESB_SET_PQ_01:
> >> +    case XIVE_ESB_SET_PQ_10:
> >> +    case XIVE_ESB_SET_PQ_11:
> >> +        ret =3D xive_source_pq_set(xsrc, srcno, (offset >> 8) & 0x3);
> >> +        break;
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB addr %d\n",=
 offset);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static void xive_source_esb_write(void *opaque, hwaddr addr,
> >> +                                 uint64_t value, unsigned size)
> >> +{
> >> +    XiveSource *xsrc =3D XIVE_SOURCE(opaque);
> >> +    uint32_t offset =3D addr & 0xF00;
> >> +    uint32_t srcno =3D addr >> xsrc->esb_shift;
> >> +    bool notify =3D false;
> >> +
> >> +    switch (offset) {
> >> +    case 0:
> >> +        notify =3D xive_source_pq_trigger(xsrc, srcno);
> >> +        break;
> >> +
> >> +    case XIVE_ESB_STORE_EOI:
> >> +        if (xive_source_is_trigger_page(addr)) {
> >> +            qemu_log_mask(LOG_GUEST_ERROR,
> >> +                          "XIVE: invalid store on IRQ %d trigger page=
 at "
> >> +                          "0x%"HWADDR_PRIx"\n", srcno, addr);
> >> +            return;
> >> +        }
> >> +
> >> +        if (!(xsrc->esb_flags & XIVE_SRC_STORE_EOI)) {
> >> +            qemu_log_mask(LOG_GUEST_ERROR,
> >> +                          "XIVE: invalid Store EOI for IRQ %d\n", src=
no);
> >> +            return;
> >> +        }
> >> +
> >> +        /* If the Q bit is set, we should forward a new source event
> >> +         * notification
> >> +         */
> >> +        notify =3D xive_source_pq_eoi(xsrc, srcno);
> >> +        break;
> >> +
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr =
%d\n",
> >> +                      offset);
> >> +        return;
> >> +    }
> >> +
> >> +    /* Forward the source event notification for routing */
> >> +    if (notify) {
> >> +        xive_source_notify(xsrc, srcno);
> >> +    }
> >=20
> > EOI via this path calls notify, but the one via the read path
> > doesn't.  Is that correct?
>=20
> No. I have given attention to the one page ESB MMIO setting + Store EOI=
=20
> in the emulated mode and not enough to the two pages ESB MMIO setting.=20
> This is a late change to be compatible with KVM. I will fix.

Ok.

> >=20
> >> +}
> >> +
> >> +static const MemoryRegionOps xive_source_esb_ops =3D {
> >> +    .read =3D xive_source_esb_read,
> >> +    .write =3D xive_source_esb_write,
> >> +    .endianness =3D DEVICE_BIG_ENDIAN,
> >> +    .valid =3D {
> >> +        .min_access_size =3D 8,
> >> +        .max_access_size =3D 8,
> >> +    },
> >> +    .impl =3D {
> >> +        .min_access_size =3D 8,
> >> +        .max_access_size =3D 8,
> >> +    },
> >> +};
> >> +
> >> +static void xive_source_set_irq(void *opaque, int srcno, int val)
> >> +{
> >> +    XiveSource *xsrc =3D XIVE_SOURCE(opaque);
> >> +    bool notify =3D false;
> >> +
> >> +    if (val) {
> >> +        notify =3D xive_source_pq_trigger(xsrc, srcno);
> >> +    }
> >> +
> >> +    /* Forward the source event notification for routing */
> >> +    if (notify) {
> >> +        xive_source_notify(xsrc, srcno);
> >> +    }
> >> +}
> >> +
> >> +void xive_source_pic_print_info(XiveSource *xsrc, Monitor *mon)
> >> +{
> >> +    int i;
> >> +
> >> +    monitor_printf(mon, "XIVE Source %6x ..%6x\n",
> >> +                   xsrc->offset, xsrc->offset + xsrc->nr_irqs - 1);
> >> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> >> +        uint8_t pq =3D xive_source_pq_get(xsrc, i);
> >> +        uint32_t lisn =3D i  + xsrc->offset;
> >> +
> >> +        if (pq =3D=3D XIVE_ESB_OFF) {
> >> +            continue;
> >> +        }
> >> +
> >> +        monitor_printf(mon, "  %4x %c%c\n", lisn,
> >> +                       pq & XIVE_ESB_VAL_P ? 'P' : '-',
> >> +                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
> >> +    }
> >> +}
> >> +
> >> +static void xive_source_reset(DeviceState *dev)
> >> +{
> >> +    XiveSource *xsrc =3D XIVE_SOURCE(dev);
> >> +
> >> +    /* SBEs are initialized to 0b01 which corresponds to "ints off" */
> >> +    memset(xsrc->sbe, 0x55, xsrc->sbe_size);
> >> +}
> >> +
> >> +static void xive_source_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    XiveSource *xsrc =3D XIVE_SOURCE(dev);
> >> +
> >> +    if (!xsrc->nr_irqs) {
> >> +        error_setg(errp, "Number of interrupt needs to be greater tha=
n 0");
> >> +        return;
> >> +    }
> >> +
> >> +    if (xsrc->esb_shift !=3D XIVE_ESB_4K &&
> >> +        xsrc->esb_shift !=3D XIVE_ESB_4K_2PAGE &&
> >> +        xsrc->esb_shift !=3D XIVE_ESB_64K &&
> >> +        xsrc->esb_shift !=3D XIVE_ESB_64K_2PAGE) {
> >> +        error_setg(errp, "Invalid ESB shift setting");
> >> +        return;
> >> +    }
> >> +
> >> +    xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
> >> +                                     xsrc->nr_irqs);
> >> +
> >> +    /* Allocate the SBEs (State Bit Entry). 2 bits, so 4 entries per =
byte */
> >> +    xsrc->sbe_size =3D DIV_ROUND_UP(xsrc->nr_irqs, 4);
> >> +    xsrc->sbe =3D g_malloc0(xsrc->sbe_size);
> >> +
> >> +    /* TODO: H_INT_ESB support, which removing the ESB MMIOs */
> >> +
> >> +    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> >> +                          &xive_source_esb_ops, xsrc, "xive.esb",
> >> +                          (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
> >> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xsrc->esb_mmio);
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_xive_source =3D {
> >> +    .name =3D TYPE_XIVE_SOURCE,
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_UINT32_EQUAL(nr_irqs, XiveSource, NULL),
> >> +        VMSTATE_VBUFFER_UINT32(sbe, XiveSource, 1, NULL, sbe_size),
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >> +/*
> >> + * The default XIVE interrupt source setting for ESB MMIO is two 64k
> >> + * pages without Store EOI. This is in sync with KVM.
> >> + */
> >> +static Property xive_source_properties[] =3D {
> >> +    DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
> >> +    DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
> >> +    DEFINE_PROP_UINT64("bar", XiveSource, esb_base, 0),
> >=20
> > Isn't this redundant with however the base address is handled through
> > the SysBusDevice stuff (I forget the details)?
>=20
> Storing the ESB MMIO base address under the XiveSource object is=20
> convenient later on in the h_int_get_source_info hcall which make
> use of the helpers :=20
>=20
> 	hwaddr xive_source_esb_trigger(XiveSource *xsrc, uint32_t srcno)
> 	hwaddr xive_source_esb_mgmt(XiveSource *xsrc, int srcno)
>=20
> But it is only used in that place. So we could just store the ESB=20
> MMIO base address under the sPAPRXive controller. This makes some
> sense in the design, as we have to inform KVM of this address with
> a KVM device ioctl.

Well.. I really dislike the idea that you could change the actual MMIO
mapping address in one place, but other bits of code would still think
it was mapped somewhere else.

> >> +    DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2=
PAGE),
> >> +    DEFINE_PROP_END_OF_LIST(),
> >> +};
> >> +
> >> +static void xive_source_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +
> >> +    dc->realize =3D xive_source_realize;
> >> +    dc->reset =3D xive_source_reset;
> >> +    dc->props =3D xive_source_properties;
> >> +    dc->desc =3D "XIVE interrupt source";
> >> +    dc->vmsd =3D &vmstate_xive_source;
> >> +}
> >> +
> >> +static const TypeInfo xive_source_info =3D {
> >> +    .name          =3D TYPE_XIVE_SOURCE,
> >> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >> +    .instance_size =3D sizeof(XiveSource),
> >> +    .class_init    =3D xive_source_class_init,
> >> +};
> >> +
> >> +static void xive_register_types(void)
> >> +{
> >> +    type_register_static(&xive_source_info);
> >> +}
> >> +
> >> +type_init(xive_register_types)
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> new file mode 100644
> >> index 000000000000..d92a50519edf
> >> --- /dev/null
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -0,0 +1,130 @@
> >> +/*
> >> + * QEMU PowerPC XIVE interrupt controller model
> >> + *
> >> + * Copyright (c) 2017-2018, IBM Corporation.
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#ifndef PPC_XIVE_H
> >> +#define PPC_XIVE_H
> >> +
> >> +#include "hw/sysbus.h"
> >> +
> >> +/*
> >> + * XIVE Interrupt Source
> >> + */
> >> +
> >> +#define TYPE_XIVE_SOURCE "xive-source"
> >> +#define XIVE_SOURCE(obj) OBJECT_CHECK(XiveSource, (obj), TYPE_XIVE_SO=
URCE)
> >> +
> >> +/*
> >> + * XIVE Source Interrupt source characteristics, which define how the
> >> + * ESB are controlled.
> >> + */
> >> +#define XIVE_SRC_H_INT_ESB     0x1 /* ESB managed with hcall H_INT_ES=
B */
> >> +#define XIVE_SRC_STORE_EOI     0x4 /* Store EOI supported */
> >> +
> >> +typedef struct XiveSource {
> >> +    SysBusDevice parent;
> >> +
> >> +    /* IRQs */
> >> +    uint32_t     nr_irqs;
> >> +    uint32_t     offset;
> >> +    qemu_irq     *qirqs;
> >> +
> >> +    /* PQ bits */
> >> +    uint8_t      *sbe;
> >> +    uint32_t     sbe_size;
> >> +
> >> +    /* ESB memory region */
> >> +    uint64_t     esb_flags;
> >> +    hwaddr       esb_base;
> >> +    uint32_t     esb_shift;
> >> +    MemoryRegion esb_mmio;
> >> +} XiveSource;
> >> +
> >> +/*
> >> + * ESB MMIO setting. Can be one page, for both source triggering and
> >> + * source management, or two different pages. See below for magic
> >> + * values.
> >> + */
> >> +#define XIVE_ESB_4K          12 /* PSI HB */
> >> +#define XIVE_ESB_4K_2PAGE    17
> >=20
> > Should this be 13 instead of 17?
>=20
> oups. obviously this is not used.
>=20
> >> +#define XIVE_ESB_64K         16
> >> +#define XIVE_ESB_64K_2PAGE   17
> >=20
> > (Also, who the hell comes up with a brand new PIC and decides to have
> > *4* different interface variants.  But that's not your problem, I
> > realise).
>=20
> HW constraints on the different controllers which need to expose
> sources : PSI, PHB4. The internal sources of the XIVE interrupt=20
> controller can be configured to use 4K or 64K but I doubt the 4k
> will be ever used.

Sure, the hardware is different, but *why* is it different.  This is a
brand new design, you'd think they could come up with one variant that
works for all the cases.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrdWhEACgkQbDjKyiDZ
s5KUkhAA3sW3MGSKvEDu9U6Mc1pkvLrcZiPK0chz+NqT18RhFlwqIL69Ddhxf/oK
DXRtRvCFADe0VpXfmU9eil/4Wvu3AP622j6U5cThPmfiYvhTDGtv4GYulV9DJ3yF
9GZJjKZjEH3aKjVYhYbwpz3x5Bmiet+E8bANAWJNo9AG3CXWrMiip0/5R6WLzgFD
0s0ubVMJvm9Gyh/F1HgD6lOBoWOLswR/8HtywsYIojRyOQeZSYKN5Wt3ZSJaAaZL
J6RouvRwYNd/muL0b+Ln1cDx+vYFFiRiuYqy54n8WXyRo/paXbztlxhJqD63+zQL
B2AmwB98xC70j8UdPpznUx5/uIOzjR0tku3qhbU+VpDKauheEgfcMSTkoOLKWspH
jnF6l+hZMpekQ/RcgbN/StgRXk3dNpCsfHG5fnCdOfob3v+JGQxIv/wcHgbGTsi4
OhaFTrV4/M7fCJTzKUIZowdC/sQb/BLI+ZGx5rR5jKUwz5K53eHejXSnhti9jmty
nnEy1fLlI6hO25CIX1PwHaGduemRwRxvcLVpkOL+i2BZh22GBN2PLVcPewCKabmi
5KCpbyJ2ESqyTTGtWVT7wSJKqDovQL0ZiS6/mfw7a9nIECvQgIjJZPmVVfwOkxOV
ZqktHwlszs+FXnBfxsrXMuZkuS2f7xDBPu3sfySu9ZSCOEmXNLI=
=U40z
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
