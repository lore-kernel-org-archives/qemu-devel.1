Received: from eggs.gnu.org ([2001:4830:134:3::10]:50381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRIJ-0000d6-CT
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRII-0007X2-2t
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:48:19 -0400
Date: Wed, 20 Jun 2018 10:17:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620001713.GD3546@umbus.fritz.box>
References: <20180618173402.23405-1-clg@kaod.org>
	<20180618173402.23405-4-clg@kaod.org>
	<20180619010244.GN25461@umbus.fritz.box>
	<2f26dfab-5aca-8a61-ed83-fc56145d5bc3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <2f26dfab-5aca-8a61-ed83-fc56145d5bc3@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 07:00:18AM +0200, C=E9dric Le Goater wrote:
> On 06/19/2018 03:02 AM, David Gibson wrote:
> > On Mon, Jun 18, 2018 at 07:34:02PM +0200, C=E9dric Le Goater wrote:
> >> This proposal introduces a new IRQ number space layout using static
> >> numbers for all devices and a bitmap allocator for the MSI numbers
> >> which are negotiated by the guest at runtime.
> >>
> >> The previous layout is kept in machines raising the 'xics_legacy'
> >> flag.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/spapr.h     |  4 ++++
> >>  include/hw/ppc/spapr_irq.h | 30 +++++++++++++++++++++++++
> >>  hw/ppc/spapr.c             | 31 +++++++++++++++++++++++++
> >>  hw/ppc/spapr_events.c      | 12 ++++++++--
> >>  hw/ppc/spapr_irq.c         | 56 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  hw/ppc/spapr_pci.c         | 28 ++++++++++++++++++-----
> >>  hw/ppc/spapr_vio.c         | 19 ++++++++++++----
> >>  hw/ppc/Makefile.objs       |  2 +-
> >>  8 files changed, 169 insertions(+), 13 deletions(-)
> >>  create mode 100644 include/hw/ppc/spapr_irq.h
> >>  create mode 100644 hw/ppc/spapr_irq.c
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 9decc66a1915..4c63b1fac13b 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -7,6 +7,7 @@
> >>  #include "hw/ppc/spapr_drc.h"
> >>  #include "hw/mem/pc-dimm.h"
> >>  #include "hw/ppc/spapr_ovec.h"
> >> +#include "hw/ppc/spapr_irq.h"
> >> =20
> >>  struct VIOsPAPRBus;
> >>  struct sPAPRPHBState;
> >> @@ -164,6 +165,9 @@ struct sPAPRMachineState {
> >>      char *kvm_type;
> >> =20
> >>      const char *icp_type;
> >> +    bool xics_legacy;
> >=20
> > This flag can go in the class, rather than the instance.
> >=20
> > And maybe call it 'legacy_irq_allocation'.  It assumes XICS, but
> > otherwise isn't strongly tied to it.
>=20
> OK.
>=20
> >> +    int32_t irq_map_nr;
> >> +    unsigned long *irq_map;
> >=20
> > So, I don't love the fact that the new bitmap duplicates information
> > that's also in the intc backend (e.g. via ICS_IRQ_FREE()). =20
>=20
> Yes. I agree. new devices using MSI like interrupts will follow the
> same pattern for allocation.=20
>=20
> we have two layers of IRQ routines, one for the IRQ numbers and one=20
> for the controller backend. May be we could call the backend handling=20
> routing from the msi one ?=20
>=20
> > However
> > leaving the authoritative info in the backend also causes problems
> > when we have dynamic switching.  Not entirely sure what to do about
> > that.
>=20
> yes, if we put it in the IRQ backend (the current IRQ controller model
> in use) we will have to synchronize the number spaces when the machine=20
> switches interrupt mode.=20
> =20
> >>      bool cmd_line_caps[SPAPR_CAP_NUM];
> >>      sPAPRCapabilities def, eff, mig;
> >> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >> new file mode 100644
> >> index 000000000000..345a42efd366
> >> --- /dev/null
> >> +++ b/include/hw/ppc/spapr_irq.h
> >> @@ -0,0 +1,30 @@
> >> +/*
> >> + * QEMU PowerPC sPAPR IRQ backend definitions
> >> + *
> >> + * Copyright (c) 2018, IBM Corporation.
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#ifndef HW_SPAPR_IRQ_H
> >> +#define HW_SPAPR_IRQ_H
> >> +
> >> +/*
> >> + * IRQ range offsets per device type
> >> + */
> >> +#define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
> >> +#define SPAPR_IRQ_HOTPLUG    0x1001
> >> +#define SPAPR_IRQ_VIO        0x1100  /* 256 VIO devices */
> >> +#define SPAPR_IRQ_PCI_LSI    0x1200  /* 32+ PHBs devices */
> >> +
> >> +#define SPAPR_IRQ_MSI        0x1300  /* Offset of the dynamic range c=
overed
> >> +                                      * by the bitmap allocator */
> >=20
> > I'm a little confused by the MSI stuff.  It looks like you're going
> > for the option of one big pool for all dynamic irqs.  Except that I
> > thought in our discussion the other day you said each PHB advertised
> > its own separate MSI range, so we'd actually need to split this up
> > into ranges for each PHB.
>=20
> Yes we can also, but we don't really need to and it might be too much
> constrained in fact.

Ok.

> As the IRQs are allocated dynamically, there is not a strong relation=20
> between the device doing so and the IRQ numbers. The need for a well
> defined IRQ number range is weak. We should provision a certain number=20
> of IRQs of course to size our IRQ number space but even that could be=20
> done dynamically. We can resize the bitmap and allocate new source=20
> blocks under the KVM XICS/XIVE device if needed. The resulting code=20
> is quite simple and the IRQ number space is also less fragmented.=20
>=20
> I think we have all the requirements in hand, the current ones and the=20
> new ones for hotplug PHBs, XIVE interrupt model, CAPI (which should be
> like the PHBs), XIVE user IRQs (like MSIs). The new ones are all=20
> dynamic IRQ models.
>=20
>=20
> So I am more in favor of a single big bunch of dynamic IRQs.

Ok, sounds reasonable.

[snip]
> >> @@ -4093,7 +4121,10 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
> >> =20
> >>  static void spapr_machine_2_12_instance_options(MachineState *machine)
> >>  {
> >> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> >> +
> >>      spapr_machine_3_0_instance_options(machine);
> >> +    spapr->xics_legacy =3D true;
> >>  }
> >> =20
> >>  static void spapr_machine_2_12_class_options(MachineClass *mc)
> >> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >> index e4f5946a2188..c82dc40be0d5 100644
> >> --- a/hw/ppc/spapr_events.c
> >> +++ b/hw/ppc/spapr_events.c
> >> @@ -709,7 +709,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
> >>  {
> >>      int epow_irq;
> >> =20
> >> -    epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
> >> +    if (spapr->xics_legacy) {
> >> +        epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
> >> +    } else {
> >> +        epow_irq =3D SPAPR_IRQ_EPOW;
> >=20
> > Can slightly improve brevity by just initializing epow_irq to this,
> > then overwriting it in the legacy case.
>=20
> yes. I will do that. It will ease removal because we want to deprecate
> the legacy mode one day.=20
>=20
> That might in a long time though. We have to wait for the QEMU machine=20
> number to no longer be in a maintained distro. correct?

Pretty much, yes.  And, yes, that will be a long ways off.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlspnQkACgkQbDjKyiDZ
s5JY2w/+O0SXXUEkBQVMC9v+IlCxi9A/PCiwgvQVdB6TMpRwabV4Fj7gCLTqH3PN
1TlYxS6WsuiAy1zSWLGR3h0djy1EEK28F/l3sx4bbuTW9djiQzl4qlEYfUv+ZxVX
WuY0dEUR/oIKe12tx54SwCvrhisYleMBy0EqvHIaLqHFWHXYhE25bNzU8iVxbMHr
Yq6gPihohA0gXCA35RUWL8e73y7oTcW9DUj2BEoYb02yWoSkAe9AA5IEBuI0zqN1
cro5ZSsJ5z9Rxdqg3ju7VIFaFnVOWOngt4TUv7wRVFkKuOaVLvLoPDlIqATt0xDu
3pd4aEXEIak1zfuzmGVN5bJPnTHcX2qqwguVUDGBq4oqpLILgAaC70/A5uEOzFx2
LsJ6gkp4bYZiu0a1QBsuDWSPEF/3HlFfL/HhvQxbs+U1O7TP9qK2rDk2GFLSBT6c
4JRykYL5rKNmtuAG1GJdGnS3+emVYmf817z214ptPlExfgUijtSW+BnTYcxtvqZe
hdCPMLvFBXp+wNdLsY5UfFl1KHbftDfotTM7BWtac22HOk23DAIm8u1/ue5Mqdbf
8dDwT9c5wGJe7P/9bNxsrNnKRhaSRvVcMl38D/KV2ky1LkZJc2r8B0BSrQN6hQ6g
dfYEApQzDFzS99J8Helyn4QMOT8mWLSNvwYyi38YyGuBabNwRfY=
=kP3A
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
