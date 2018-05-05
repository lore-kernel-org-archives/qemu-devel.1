Received: from eggs.gnu.org ([2001:4830:134:3::10]:35130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEosZ-0002FC-8s
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEosX-0002XK-Mj
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:33:03 -0400
Date: Sat, 5 May 2018 14:27:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180505042702.GK13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<9273a240-6518-155f-ed78-79abe53761e3@kaod.org>
	<20180503053532.GR13229@umbus.fritz.box>
	<9c6d62fe-40e7-0bb9-678e-ed8246373e98@kaod.org>
	<20180504045149.GT13229@umbus.fritz.box>
	<d1ba980e-8739-bf54-a52a-8e747944e2db@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8YDLdOu/DaKXZo9W"
Content-Disposition: inline
In-Reply-To: <d1ba980e-8739-bf54-a52a-8e747944e2db@kaod.org>
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


--8YDLdOu/DaKXZo9W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 03:11:57PM +0200, C=E9dric Le Goater wrote:
> On 05/04/2018 06:51 AM, David Gibson wrote:
> > On Thu, May 03, 2018 at 06:06:14PM +0200, C=E9dric Le Goater wrote:
> >> On 05/03/2018 07:35 AM, David Gibson wrote:
> >>> On Thu, Apr 26, 2018 at 11:27:21AM +0200, C=E9dric Le Goater wrote:
> >>>> On 04/26/2018 09:11 AM, David Gibson wrote:
> >>>>> On Thu, Apr 19, 2018 at 02:43:02PM +0200, C=E9dric Le Goater wrote:
> >>>>>> The XIVE presenter engine uses a set of registers to handle priori=
ty
> >>>>>> management and interrupt acknowledgment among other things. The mo=
st
> >>>>>> important ones being :
> >>>>>>
> >>>>>>   - Interrupt Priority Register (PIPR)
> >>>>>>   - Interrupt Pending Buffer (IPB)
> >>>>>>   - Current Processor Priority (CPPR)
> >>>>>>   - Notification Source Register (NSR)
> >>>>>>
> >>>>>> There is one set of registers per level of privilege, four in all :
> >>>>>> HW, HV pool, OS and User. These are called rings. All registers are
> >>>>>> accessible through a specific MMIO region called the Thread Interr=
upt
> >>>>>> Management Areas (TIMA) but, depending on the privilege level of t=
he
> >>>>>> CPU, the view of the TIMA is filtered. The sPAPR machine runs at t=
he
> >>>>>> OS privilege and therefore can only accesses the OS and the User
> >>>>>> rings. The others are for hypervisor levels.
> >>>>>>
> >>>>>> The CPU interrupt state is modeled with a XiveNVT object which sto=
res
> >>>>>> the values of the different registers. The different TIMA views are
> >>>>>> mapped at the same address for each CPU and 'current_cpu' is used =
to
> >>>>>> retrieve the XiveNVT holding the ring registers.
> >>>>>>
> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>> ---
> >>>>>>
> >>>>>>  Changes since v2 :
> >>>>>>
> >>>>>>  - introduced the XiveFabric interface
> >>>>>>
> >>>>>>  hw/intc/spapr_xive.c        |  25 ++++
> >>>>>>  hw/intc/xive.c              | 279 +++++++++++++++++++++++++++++++=
+++++++++++++
> >>>>>>  include/hw/ppc/spapr_xive.h |   5 +
> >>>>>>  include/hw/ppc/xive.h       |  31 +++++
> >>>>>>  include/hw/ppc/xive_regs.h  |  84 +++++++++++++
> >>>>>>  5 files changed, 424 insertions(+)
> >>>>>>
> >>>>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >>>>>> index 90cde8a4082d..f07832bf0a00 100644
> >>>>>> --- a/hw/intc/spapr_xive.c
> >>>>>> +++ b/hw/intc/spapr_xive.c
> >>>>>> @@ -13,6 +13,7 @@
> >>>>>>  #include "target/ppc/cpu.h"
> >>>>>>  #include "sysemu/cpus.h"
> >>>>>>  #include "monitor/monitor.h"
> >>>>>> +#include "hw/ppc/spapr.h"
> >>>>>>  #include "hw/ppc/spapr_xive.h"
> >>>>>>  #include "hw/ppc/xive.h"
> >>>>>>  #include "hw/ppc/xive_regs.h"
> >>>>>> @@ -95,6 +96,22 @@ static void spapr_xive_realize(DeviceState *dev=
, Error **errp)
> >>>>>> =20
> >>>>>>      /* Allocate the Interrupt Virtualization Table */
> >>>>>>      xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
> >>>>>> +
> >>>>>> +    /* The Thread Interrupt Management Area has the same address =
for
> >>>>>> +     * each chip. On sPAPR, we only need to expose the User and OS
> >>>>>> +     * level views of the TIMA.
> >>>>>> +     */
> >>>>>> +    xive->tm_base =3D XIVE_TM_BASE;
> >>>>>
> >>>>> The constant should probably have PAPR in the name somewhere, since
> >>>>> it's just for PAPR machines (same for the ESB mappings, actually).
> >>>>
> >>>> ok.=20
> >>>>
> >>>> I have also made 'tm_base' a property, like 'vc_base' for ESBs, in=
=20
> >>>> case we want to change the value when the guest is instantiated.=20
> >>>> I doubt it but this is an address in the global address space, so=20
> >>>> letting the machine have control is better I think.
> >>>
> >>> I agree.
> >>>
> >>>>>> +
> >>>>>> +    memory_region_init_io(&xive->tm_mmio_user, OBJECT(xive),
> >>>>>> +                          &xive_tm_user_ops, xive, "xive.tima.use=
r",
> >>>>>> +                          1ull << TM_SHIFT);
> >>>>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio_user);
> >>>>>> +
> >>>>>> +    memory_region_init_io(&xive->tm_mmio_os, OBJECT(xive),
> >>>>>> +                          &xive_tm_os_ops, xive, "xive.tima.os",
> >>>>>> +                          1ull << TM_SHIFT);
> >>>>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio_os);
> >>>>>>  }
> >>>>>> =20
> >>>>>>  static XiveIVE *spapr_xive_get_ive(XiveFabric *xf, uint32_t lisn)
> >>>>>> @@ -104,6 +121,13 @@ static XiveIVE *spapr_xive_get_ive(XiveFabric=
 *xf, uint32_t lisn)
> >>>>>>      return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
> >>>>>>  }
> >>>>>> =20
> >>>>>> +static XiveNVT *spapr_xive_get_nvt(XiveFabric *xf, uint32_t serve=
r)
> >>>>>> +{
> >>>>>> +    PowerPCCPU *cpu =3D spapr_find_cpu(server);
> >>>>>> +
> >>>>>> +    return cpu ? XIVE_NVT(cpu->intc) : NULL;
> >>>>>> +}
> >>>>>
> >>>>> So this is a bit of a tangent, but I've been thinking of implementi=
ng
> >>>>> a scheme where there's an opaque pointer in the cpu structure for t=
he
> >>>>> use of the machine.  I'm planning for that to replace the intc poin=
ter
> >>>>> (which isn't really used directly by the cpu). That would allow us =
to
> >>>>> have spapr put a structure there and have both xics and xive pointe=
rs
> >>>>> which could be useful later on.
> >>>>
> >>>> ok. That should simplify the patchset at the end, in which we need t=
o=20
> >>>> switch the 'intc' pointer.=20
> >>>>
> >>>>> I think we'd need something similar to correctly handle migration of
> >>>>> the VPA state, which is currently horribly broken.
> >>>>>
> >>>>>> +
> >>>>>>  static const VMStateDescription vmstate_spapr_xive_ive =3D {
> >>>>>>      .name =3D TYPE_SPAPR_XIVE "/ive",
> >>>>>>      .version_id =3D 1,
> >>>>>> @@ -143,6 +167,7 @@ static void spapr_xive_class_init(ObjectClass =
*klass, void *data)
> >>>>>>      dc->vmsd =3D &vmstate_spapr_xive;
> >>>>>> =20
> >>>>>>      xfc->get_ive =3D spapr_xive_get_ive;
> >>>>>> +    xfc->get_nvt =3D spapr_xive_get_nvt;
> >>>>>>  }
> >>>>>> =20
> >>>>>>  static const TypeInfo spapr_xive_info =3D {
> >>>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >>>>>> index dccad0318834..5691bb9474e4 100644
> >>>>>> --- a/hw/intc/xive.c
> >>>>>> +++ b/hw/intc/xive.c
> >>>>>> @@ -14,7 +14,278 @@
> >>>>>>  #include "sysemu/cpus.h"
> >>>>>>  #include "sysemu/dma.h"
> >>>>>>  #include "monitor/monitor.h"
> >>>>>> +#include "hw/ppc/xics.h" /* for ICP_PROP_CPU */
> >>>>>>  #include "hw/ppc/xive.h"
> >>>>>> +#include "hw/ppc/xive_regs.h"
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * XIVE Interrupt Presenter
> >>>>>> + */
> >>>>>> +
> >>>>>> +static uint64_t xive_nvt_accept(XiveNVT *nvt)
> >>>>>> +{
> >>>>>> +    return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void xive_nvt_set_cppr(XiveNVT *nvt, uint8_t cppr)
> >>>>>> +{
> >>>>>> +    if (cppr > XIVE_PRIORITY_MAX) {
> >>>>>> +        cppr =3D 0xff;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    nvt->ring_os[TM_CPPR] =3D cppr;
> >>>>>
> >>>>> Surely this needs to recheck if we should be interrupting the cpu?
> >>>>
> >>>> yes. In patch 9, when we introduce the nvt notify routine.
> >>>
> >>> Ok.
> >>>
> >>>>>> +}
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * OS Thread Interrupt Management Area MMIO
> >>>>>> + */
> >>>>>> +static uint64_t xive_tm_read_special(XiveNVT *nvt, hwaddr offset,
> >>>>>> +                                           unsigned size)
> >>>>>> +{
> >>>>>> +    uint64_t ret =3D -1;
> >>>>>> +
> >>>>>> +    if (offset =3D=3D TM_SPC_ACK_OS_REG && size =3D=3D 2) {
> >>>>>> +        ret =3D xive_nvt_accept(nvt);
> >>>>>> +    } else {
> >>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA read @=
%"
> >>>>>> +                      HWADDR_PRIx" size %d\n", offset, size);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +#define TM_RING(offset) ((offset) & 0xf0)
> >>>>>> +
> >>>>>> +static uint64_t xive_tm_os_read(void *opaque, hwaddr offset,
> >>>>>> +                                      unsigned size)
> >>>>>> +{
> >>>>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> >>>>>
> >>>>> So, as I said on a previous version of this, we can actually correc=
tly
> >>>>> represent different mappings in different cpu spaces, by exploiting
> >>>>> cpu->as and not just having them all point to &address_space_memory.
> >>>>
> >>>> Yes, you did and I haven't studied the question yet. For the next ve=
rsion.
> >>>
> >>> So, it's possible that using the cpu->as thing will be more trouble
> >>> that it's worth.=20
> >>
> >> One of the trouble is the number of memory regions to use, one per cpu=
,=20
> >=20
> > Well, we're already going to have an NVT object for each cpu, yes?  So
> > a memory region per-cpu doesn't seem like a big stretch.
> >=20
> >> and the KVM support.
> >=20
> > And I really don't see how the memory regions impacts KVM.
>=20
> The TIMA is setup when the KVM device is initialized using some specific=
=20
> ioctl to get an fd on a MMIO region from the host. It is then passed to=
=20
> the guest as a 'ram_device', same for the ESBs.=20

Ah, good point.

> This is not a common region.

I'm not sure what you mean by that.

> >> Having a single region is much easier.=20
> >>
> >>> I am a little concerned about using current_cpu though. =20
> >>> First, will it work with KVM with kernel_irqchip=3Doff - the
> >>> cpus are running truly concurrently,
> >>
> >> FWIW, I didn't see any issue yet while stressing.=20
> >=20
> > Ok.
> >=20
> >>> but we still need to work out who's poking at the TIMA. =20
> >>
> >> I understand. The registers are accessed by the current cpu to set the=
=20
> >> CPPR and to ack an interrupt. But when we route an event, we also acce=
ss=20
> >> and modify the registers. Do you suggest some locking ? I am not sure
> >> how are protected the TIMA region accesses vs. the routing, which is=
=20
> >> necessarily initiated by an ESB MMIO though.
> >=20
> > Locking isn't really the issue.  I mean, we do need locking, but the
> > BQL should provide that.  The issue is what exactly does "current"
> > mean in the context of multiple concurrently running cpus.  Does it
> > always mean what we need it to mean in every context we might call
> > this from.
>=20
> I would say so.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8YDLdOu/DaKXZo9W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrtMpYACgkQbDjKyiDZ
s5LxWhAA1pfa0DQBOu1BJZcL6clB29FG9jxDtljX6ZDEAgOkZbg9AuDtPkgI8yDE
VaF3ojRoQQeXz4b0IvBiv4s7ADcO6K08u6TPfxM/QQA+u8OyDGk8VjSq1AUYV9hQ
0s8HMQaZApX1UF1XU40goKqqUmiEaFXAbAxTboCwWQqVlrWEVBCJknigDJWNNWVV
laGMeESPw6rOsHKO7ZVbQy9zqyVnBGm4HxNG5YNFl1pTFB31dDfdjUWr/fsRNABX
IllS2VGJMaY1Zw7Q+iYdcOJrMSLW/sPSKS50APKr0YxPcxU9sHAej17Fcs7j1enx
YdwZ1kriH0kI4/nKOvqUxnflA7kNrzic+kDD05tgv7UIE9W2Em4oT9heWFmFNc+0
QE7DQAUFu7ANkEhNs/98PzWuUnOCIig1T8QPbQRmVKKIcQYFJ/b50eBZqcbwCU/P
J3iIdDAm4CMcViB60Nj1rt5pCbHA3zEazOoYq56PgglNpAchYDeWK9hiw1+TntPK
gGMjuA040a/DLDLS0TY3MHgJ7ZT3uXXCHbeTlplMtTb1Ki/fUZZR8JWlnMi5AomU
O/loPl1zdfZy/xCDWaxilJCg7gv/4dzZ44+z8aZ0ng1UCEGmYD6i2cOszMlMnNBp
nnPbGLzxFEA8GhbNO7UfubzpmA2yIxvzFACBcxBGlbvPapOQ37M=
=JfWi
-----END PGP SIGNATURE-----

--8YDLdOu/DaKXZo9W--
