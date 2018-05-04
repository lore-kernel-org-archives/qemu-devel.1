Received: from eggs.gnu.org ([2001:4830:134:3::10]:58376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEShT-0004W8-Iu
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEShQ-0002dQ-C6
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:52:07 -0400
Date: Fri, 4 May 2018 14:51:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504045149.GT13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<9273a240-6518-155f-ed78-79abe53761e3@kaod.org>
	<20180503053532.GR13229@umbus.fritz.box>
	<9c6d62fe-40e7-0bb9-678e-ed8246373e98@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8c7vHYlrYOebzgj6"
Content-Disposition: inline
In-Reply-To: <9c6d62fe-40e7-0bb9-678e-ed8246373e98@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 06/35] spapr/xive: introduce a XIVE
 interrupt presenter model
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


--8c7vHYlrYOebzgj6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 06:06:14PM +0200, C=E9dric Le Goater wrote:
> On 05/03/2018 07:35 AM, David Gibson wrote:
> > On Thu, Apr 26, 2018 at 11:27:21AM +0200, C=E9dric Le Goater wrote:
> >> On 04/26/2018 09:11 AM, David Gibson wrote:
> >>> On Thu, Apr 19, 2018 at 02:43:02PM +0200, C=E9dric Le Goater wrote:
> >>>> The XIVE presenter engine uses a set of registers to handle priority
> >>>> management and interrupt acknowledgment among other things. The most
> >>>> important ones being :
> >>>>
> >>>>   - Interrupt Priority Register (PIPR)
> >>>>   - Interrupt Pending Buffer (IPB)
> >>>>   - Current Processor Priority (CPPR)
> >>>>   - Notification Source Register (NSR)
> >>>>
> >>>> There is one set of registers per level of privilege, four in all :
> >>>> HW, HV pool, OS and User. These are called rings. All registers are
> >>>> accessible through a specific MMIO region called the Thread Interrupt
> >>>> Management Areas (TIMA) but, depending on the privilege level of the
> >>>> CPU, the view of the TIMA is filtered. The sPAPR machine runs at the
> >>>> OS privilege and therefore can only accesses the OS and the User
> >>>> rings. The others are for hypervisor levels.
> >>>>
> >>>> The CPU interrupt state is modeled with a XiveNVT object which stores
> >>>> the values of the different registers. The different TIMA views are
> >>>> mapped at the same address for each CPU and 'current_cpu' is used to
> >>>> retrieve the XiveNVT holding the ring registers.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>
> >>>>  Changes since v2 :
> >>>>
> >>>>  - introduced the XiveFabric interface
> >>>>
> >>>>  hw/intc/spapr_xive.c        |  25 ++++
> >>>>  hw/intc/xive.c              | 279 +++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  include/hw/ppc/spapr_xive.h |   5 +
> >>>>  include/hw/ppc/xive.h       |  31 +++++
> >>>>  include/hw/ppc/xive_regs.h  |  84 +++++++++++++
> >>>>  5 files changed, 424 insertions(+)
> >>>>
> >>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >>>> index 90cde8a4082d..f07832bf0a00 100644
> >>>> --- a/hw/intc/spapr_xive.c
> >>>> +++ b/hw/intc/spapr_xive.c
> >>>> @@ -13,6 +13,7 @@
> >>>>  #include "target/ppc/cpu.h"
> >>>>  #include "sysemu/cpus.h"
> >>>>  #include "monitor/monitor.h"
> >>>> +#include "hw/ppc/spapr.h"
> >>>>  #include "hw/ppc/spapr_xive.h"
> >>>>  #include "hw/ppc/xive.h"
> >>>>  #include "hw/ppc/xive_regs.h"
> >>>> @@ -95,6 +96,22 @@ static void spapr_xive_realize(DeviceState *dev, =
Error **errp)
> >>>> =20
> >>>>      /* Allocate the Interrupt Virtualization Table */
> >>>>      xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
> >>>> +
> >>>> +    /* The Thread Interrupt Management Area has the same address for
> >>>> +     * each chip. On sPAPR, we only need to expose the User and OS
> >>>> +     * level views of the TIMA.
> >>>> +     */
> >>>> +    xive->tm_base =3D XIVE_TM_BASE;
> >>>
> >>> The constant should probably have PAPR in the name somewhere, since
> >>> it's just for PAPR machines (same for the ESB mappings, actually).
> >>
> >> ok.=20
> >>
> >> I have also made 'tm_base' a property, like 'vc_base' for ESBs, in=20
> >> case we want to change the value when the guest is instantiated.=20
> >> I doubt it but this is an address in the global address space, so=20
> >> letting the machine have control is better I think.
> >=20
> > I agree.
> >=20
> >>>> +
> >>>> +    memory_region_init_io(&xive->tm_mmio_user, OBJECT(xive),
> >>>> +                          &xive_tm_user_ops, xive, "xive.tima.user",
> >>>> +                          1ull << TM_SHIFT);
> >>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio_user);
> >>>> +
> >>>> +    memory_region_init_io(&xive->tm_mmio_os, OBJECT(xive),
> >>>> +                          &xive_tm_os_ops, xive, "xive.tima.os",
> >>>> +                          1ull << TM_SHIFT);
> >>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio_os);
> >>>>  }
> >>>> =20
> >>>>  static XiveIVE *spapr_xive_get_ive(XiveFabric *xf, uint32_t lisn)
> >>>> @@ -104,6 +121,13 @@ static XiveIVE *spapr_xive_get_ive(XiveFabric *=
xf, uint32_t lisn)
> >>>>      return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
> >>>>  }
> >>>> =20
> >>>> +static XiveNVT *spapr_xive_get_nvt(XiveFabric *xf, uint32_t server)
> >>>> +{
> >>>> +    PowerPCCPU *cpu =3D spapr_find_cpu(server);
> >>>> +
> >>>> +    return cpu ? XIVE_NVT(cpu->intc) : NULL;
> >>>> +}
> >>>
> >>> So this is a bit of a tangent, but I've been thinking of implementing
> >>> a scheme where there's an opaque pointer in the cpu structure for the
> >>> use of the machine.  I'm planning for that to replace the intc pointer
> >>> (which isn't really used directly by the cpu). That would allow us to
> >>> have spapr put a structure there and have both xics and xive pointers
> >>> which could be useful later on.
> >>
> >> ok. That should simplify the patchset at the end, in which we need to=
=20
> >> switch the 'intc' pointer.=20
> >>
> >>> I think we'd need something similar to correctly handle migration of
> >>> the VPA state, which is currently horribly broken.
> >>>
> >>>> +
> >>>>  static const VMStateDescription vmstate_spapr_xive_ive =3D {
> >>>>      .name =3D TYPE_SPAPR_XIVE "/ive",
> >>>>      .version_id =3D 1,
> >>>> @@ -143,6 +167,7 @@ static void spapr_xive_class_init(ObjectClass *k=
lass, void *data)
> >>>>      dc->vmsd =3D &vmstate_spapr_xive;
> >>>> =20
> >>>>      xfc->get_ive =3D spapr_xive_get_ive;
> >>>> +    xfc->get_nvt =3D spapr_xive_get_nvt;
> >>>>  }
> >>>> =20
> >>>>  static const TypeInfo spapr_xive_info =3D {
> >>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >>>> index dccad0318834..5691bb9474e4 100644
> >>>> --- a/hw/intc/xive.c
> >>>> +++ b/hw/intc/xive.c
> >>>> @@ -14,7 +14,278 @@
> >>>>  #include "sysemu/cpus.h"
> >>>>  #include "sysemu/dma.h"
> >>>>  #include "monitor/monitor.h"
> >>>> +#include "hw/ppc/xics.h" /* for ICP_PROP_CPU */
> >>>>  #include "hw/ppc/xive.h"
> >>>> +#include "hw/ppc/xive_regs.h"
> >>>> +
> >>>> +/*
> >>>> + * XIVE Interrupt Presenter
> >>>> + */
> >>>> +
> >>>> +static uint64_t xive_nvt_accept(XiveNVT *nvt)
> >>>> +{
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +static void xive_nvt_set_cppr(XiveNVT *nvt, uint8_t cppr)
> >>>> +{
> >>>> +    if (cppr > XIVE_PRIORITY_MAX) {
> >>>> +        cppr =3D 0xff;
> >>>> +    }
> >>>> +
> >>>> +    nvt->ring_os[TM_CPPR] =3D cppr;
> >>>
> >>> Surely this needs to recheck if we should be interrupting the cpu?
> >>
> >> yes. In patch 9, when we introduce the nvt notify routine.
> >=20
> > Ok.
> >=20
> >>>> +}
> >>>> +
> >>>> +/*
> >>>> + * OS Thread Interrupt Management Area MMIO
> >>>> + */
> >>>> +static uint64_t xive_tm_read_special(XiveNVT *nvt, hwaddr offset,
> >>>> +                                           unsigned size)
> >>>> +{
> >>>> +    uint64_t ret =3D -1;
> >>>> +
> >>>> +    if (offset =3D=3D TM_SPC_ACK_OS_REG && size =3D=3D 2) {
> >>>> +        ret =3D xive_nvt_accept(nvt);
> >>>> +    } else {
> >>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA read @%"
> >>>> +                      HWADDR_PRIx" size %d\n", offset, size);
> >>>> +    }
> >>>> +
> >>>> +    return ret;
> >>>> +}
> >>>> +
> >>>> +#define TM_RING(offset) ((offset) & 0xf0)
> >>>> +
> >>>> +static uint64_t xive_tm_os_read(void *opaque, hwaddr offset,
> >>>> +                                      unsigned size)
> >>>> +{
> >>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> >>>
> >>> So, as I said on a previous version of this, we can actually correctly
> >>> represent different mappings in different cpu spaces, by exploiting
> >>> cpu->as and not just having them all point to &address_space_memory.
> >>
> >> Yes, you did and I haven't studied the question yet. For the next vers=
ion.
> >=20
> > So, it's possible that using the cpu->as thing will be more trouble
> > that it's worth.=20
>=20
> One of the trouble is the number of memory regions to use, one per cpu,=
=20

Well, we're already going to have an NVT object for each cpu, yes?  So
a memory region per-cpu doesn't seem like a big stretch.

> and the KVM support.

And I really don't see how the memory regions impacts KVM.

> Having a single region is much easier.=20
>=20
> > I am a little concerned about using current_cpu though. =20
> > First, will it work with KVM with kernel_irqchip=3Doff - the
> > cpus are running truly concurrently,
>=20
> FWIW, I didn't see any issue yet while stressing.=20

Ok.

> > but we still need to work out who's poking at the TIMA. =20
>=20
> I understand. The registers are accessed by the current cpu to set the=20
> CPPR and to ack an interrupt. But when we route an event, we also access=
=20
> and modify the registers. Do you suggest some locking ? I am not sure
> how are protected the TIMA region accesses vs. the routing, which is=20
> necessarily initiated by an ESB MMIO though.

Locking isn't really the issue.  I mean, we do need locking, but the
BQL should provide that.  The issue is what exactly does "current"
mean in the context of multiple concurrently running cpus.  Does it
always mean what we need it to mean in every context we might call
this from.

> > Second, are there any cases where we might
> > need to trip this "on behalf of" a specific cpu that's not the current
> > one.
>=20
> ah. yes. sort of :) only in powernv, when the xive is reseted (and when=
=20
> dumping the state for debug).
>=20
> The IC has a way to access indirectly the registers of a HW thread.=20
> It, first, sets the PC_TCTXT_INDIR_THRDID register with the PIR of=20
> the targeted thread and then loads on the indirect TIMA can be done=20
> as if it was the current thread. The indirect TIMA is mapped 4 pages=20
> after the  IC BAR.
>=20
> The resulting memory region op is a little ugly and might need=20
> some rework :=20
>=20
> static uint64_t xive_tm_hv_read(void *opaque, hwaddr offset,
>                                  unsigned size)
> {
>     PowerPCCPU **cpuptr =3D opaque;
>     PowerPCCPU *cpu =3D *cpuptr ? *cpuptr : POWERPC_CPU(current_cpu);
>     ...
>=20
>=20
> >>>> +    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
> >>>> +    uint64_t ret =3D -1;
> >>>> +    int i;
> >>>> +
> >>>> +    if (offset >=3D TM_SPC_ACK_EBB) {
> >>>> +        return xive_tm_read_special(nvt, offset, size);
> >>>> +    }
> >>>> +
> >>>> +    if (TM_RING(offset) !=3D TM_QW1_OS) {
> >>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid access to non=
-OS ring @%"
> >>>> +                      HWADDR_PRIx"\n", offset);
> >>>> +        return ret;
> >>>
> >>> Just return -1 would be clearer here;
> >>
> >> ok.
> >>
> >>>
> >>>> +    }
> >>>> +
> >>>> +    ret =3D 0;
> >>>> +    for (i =3D 0; i < size; i++) {
> >>>> +        ret |=3D (uint64_t) nvt->regs[offset + i] << (8 * (size - i=
 - 1));
> >>>> +    }
> >>>> +
> >>>> +    return ret;
> >>>> +}
> >>>> +
> >>>> +static bool xive_tm_is_readonly(uint8_t offset)
> >>>> +{
> >>>> +    return offset !=3D TM_QW1_OS + TM_CPPR;
> >>>> +}
> >>>> +
> >>>> +static void xive_tm_write_special(XiveNVT *nvt, hwaddr offset,
> >>>> +                                        uint64_t value, unsigned si=
ze)
> >>>> +{
> >>>> +    /* TODO: support TM_SPC_SET_OS_PENDING */
> >>>> +
> >>>> +    /* TODO: support TM_SPC_ACK_OS_EL */
> >>>> +}
> >>>> +
> >>>> +static void xive_tm_os_write(void *opaque, hwaddr offset,
> >>>> +                                   uint64_t value, unsigned size)
> >>>> +{
> >>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> >>>> +    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
> >>>> +    int i;
> >>>> +
> >>>> +    if (offset >=3D TM_SPC_ACK_EBB) {
> >>>> +        xive_tm_write_special(nvt, offset, value, size);
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    if (TM_RING(offset) !=3D TM_QW1_OS) {
> >>>
> >>> Why have this if you have separate OS and user regions as you appear
> >>> to do below?
> >>
> >> This is another problem we are trying to solve.=20
> >>
> >> The registers a CPU can access depends on the TIMA view it is using.=
=20
> >> The OS TIMA view only sees the OS ring registers. The HV view sees all=
=2E=20
> >>
> >>> Or to look at it another way, shouldn't it be possible to make the
> >>> read/write accessors the same for the OS and user rings?
> >>
> >> For some parts yes, but the special load/store addresses are different
> >> for each view, the read-only register also. It seemed easier to duplic=
ate.
> >>
> >> I think the problem will become clearer (or worse) with pnv which uses=
=20
> >> the HV mode.
> >=20
> > Oh.  I had the impression that each ring had a basically identical set
> > of registers and you just had access to the region for your ring and
> > the ones below.  Are you saying instead it's basically a single block
> > of registers with various different privilege levels for each of them?
>=20
> yes. I think I answered this question more clearly in a previous email.
>=20
> > [snip]
> >>>> +}
> >>>> +
> >>>> +static void xive_nvt_unrealize(DeviceState *dev, Error **errp)
> >>>> +{
> >>>> +    qemu_unregister_reset(xive_nvt_reset, dev);
> >>>> +}
> >>>> +
> >>>> +static void xive_nvt_init(Object *obj)
> >>>> +{
> >>>> +    XiveNVT *nvt =3D XIVE_NVT(obj);
> >>>> +
> >>>> +    nvt->ring_os =3D &nvt->regs[TM_QW1_OS];
> >>>
> >>> The ring_os field is basically pointless, being just an offset into a
> >>> structure you already have.  A macro or inline would be a better idea.
> >>
> >> ok. I liked the idea but I agree it's overkill to have an init routine
> >> just for this. I will find something.
> >=20
> > That too, but it's also something that looks like an optimization but
> > isn't, which is bad practice.  On modern cpus math is cheap (and this
> > is just a trivial offset), memory accesses are expensive.  You're
> > essentially caching this offset - raising all the usual invalidation
> > questions for a cache - when caching it is *more* expensive than just
> > computing it every time.
>=20
> ok. removing this offset was a good opportunity to generalize the=20
> routing algorithm and use a 'ring' parameter in all routines. Same=20
> for the accept path.=20
>=20
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8c7vHYlrYOebzgj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr5uUACgkQbDjKyiDZ
s5KryA/+M+PfehncqDs0DepELcMB1T3ZKs0f3m1ezBhdUlt7Mru+fJ6Db+ByA7d+
Msb9y+e4IzO6Wl1w+oHXNjNIAemZekWWdG20ICB/Sjm6zb8K7fo2A4nWeJ72Lbf4
OhJE2rrY/7FYIUv0zZjpsuegr04bBs31AsLVE/QksFEnG78FDFdog322I9QZzrNQ
FzHfnA4CmRlhiViY9UfbA6Aj+zDIV1c5FPNdZuwFXy9y62FHsFbMmn7bRgNj4szA
fmFmzkMUJ6GjRrh51X38nDbi5aUs5VEoGFAb9PjP2d2hctMRfQxkFODgtJE2lyGz
oU7LaH5scihBU/1Qlbmzd1Fls3nuy0jNGlu7UDeNHZbh54kQQ2JvhvATn4USBhe2
YjFwkMQwOjXnd02rMTN6fSws/RDZjV8REnawMOIQ7fdRQzFo3pq9M2Bi0vcIidan
ZAW2IIgQftv8khtxfw3BW4s3PSim1oEAkEGCBHJWXS/2u3s2eTNduFJO3MDoKSl/
S/vsfSEO4uK9yZwriLtJqfGWYhLcUla8YSY46affEpHqXhLzxTzLWcIwmvYNMkpt
h/IFYkG1pvHn99e4koUwVZ4oyNfiDlZj6I4DlK0afiv19q1UOm2AWri7rX2tf6Hb
6AUlgaxX2FooTrJZoWASZWmra/TbVeqqWVwl8mDGLMj7uj84WF4=
=MRo+
-----END PGP SIGNATURE-----

--8c7vHYlrYOebzgj6--
