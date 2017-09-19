Received: from eggs.gnu.org ([2001:4830:134:3::10]:51330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFta-0001J0-Pj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtW-0002xh-NC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:50 -0400
Date: Tue, 19 Sep 2017 18:20:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919082020.GT27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bxF9Dep5HzwGj9mC"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/21] Guest exploitation of the
 XIVE interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--bxF9Dep5HzwGj9mC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:14PM +0200, C=E9dric Le Goater wrote:
> On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
> negotiation process determines whether the guest operates with an
> interrupt controller using the XICS legacy model, as found on POWER8,
> or in XIVE exploitation mode, the newer POWER9 interrupt model. This
> patchset is a proposal to add XIVE support in POWER9 sPAPR machine.
>=20
> Follows a model for the XIVE interrupt controller and support for the
> Hypervisor's calls which are used to configure the interrupt sources
> and the event/notification queues of the guest. The last patch
> integrates XIVE in the sPAPR machine.
>=20
> Code is here:


An overall comment:

I note in several replies here that I think the way XICS objects are
re-used for XIVE is really ugly, and I think it will make future
maintenance pretty painful.

I'm thinking maybe trying to support the CAS negotiation of interrupt
controller from day 1 is warping the design.  A better approach might
be first to implement XIVE only when given a specific machine option -
guest gets one or the other and can't negotiate.

That should allow a more natural XIVE design to emerge, *then* we can
look at what's necessary to make boot-time negotiation possible.
>=20
>   https://github.com/legoater/qemu/commits/xive
>=20
> Caveats :
>=20
>  - IRQ allocator : making progress
>=20
>    The sPAPR machine make uses of the interrupt controller very early
>    in the initialization sequence to allocate IRQ numbers and populate
>    the device tree. CAS requires XIVE to be able to switch interrupt
>    model and consequently have the models share a common IRQ allocator.  =
=20
>=20
>    I have chosen to link the sPAPR XICS interrupt source into XIVE to
>    share the ICSIRQState array which acts as an IRQ allocator. This
>    can be improved.
>=20
>  - Interrupt presenter :
>=20
>    The register data is directly stored under the ICPState structure
>    which is shared with all other sPAPR interrupt controller models.
>=20
>  - KVM support : not addressed yet
>=20
>    The guest needs to be run with kernel_irqchip=3Doff on a POWER9 system.
>=20
>  - LSI : lightly tested.
>   =20
> Thanks,
>=20
> C.
>=20
> Changes since RFC v1:
>=20
>  - removed initial complexity due to a tentative try to support
>    PowerNV. This will come later.
>  - removed specific XIVE interrupt source and presenter models
>  - renamed files and typedefs
>  - removed print_info() handler
>  - introduced a CAS reset to rebuild the device tree
>  - linked the XIVE model with the sPAPR XICS interrupt source to share
>    the IRQ allocator  =20
>  - improved hcall support (still some missing but they are not used
>    under Linux)
>  - improved device tree
>  - should have addressed comments in first RFC
>  - and much more ... Next version should have a better changelog.
> =20
>=20
> C=E9dric Le Goater (21):
>   ppc/xive: introduce a skeleton for the sPAPR XIVE interrupt controller
>   migration: add VMSTATE_STRUCT_VARRAY_UINT32_ALLOC
>   ppc/xive: define the XIVE internal tables
>   ppc/xive: provide a link to the sPAPR ICS object under XIVE
>   ppc/xive: allocate IRQ numbers for the IPIs
>   ppc/xive: introduce handlers for interrupt sources
>   ppc/xive: add MMIO handlers for the XIVE interrupt sources
>   ppc/xive: describe the XIVE interrupt source flags
>   ppc/xive: extend the interrupt presenter model for XIVE
>   ppc/xive: add MMIO handlers for the XIVE TIMA
>   ppc/xive: push the EQ data in OS event queue
>   ppc/xive: notify the CPU when interrupt priority is more privileged
>   ppc/xive: handle interrupt acknowledgment by the O/S
>   ppc/xive: add support for the SET_OS_PENDING command
>   spapr: modify spapr_populate_pci_dt() to use a 'nr_irqs' argument
>   spapr: add a XIVE object to the sPAPR machine
>   ppc/xive: add hcalls support
>   ppc/xive: add device tree support
>   ppc/xive: introduce a helper to map the XIVE memory regions
>   ppc/xics: introduce a qirq_get() helper in the XICSFabric
>   spapr: activate XIVE exploitation mode
>=20
>  default-configs/ppc64-softmmu.mak |   1 +
>  hw/intc/Makefile.objs             |   1 +
>  hw/intc/spapr_xive.c              | 821 +++++++++++++++++++++++++++++++++
>  hw/intc/spapr_xive_hcall.c        | 930 ++++++++++++++++++++++++++++++++=
++++++
>  hw/intc/xics.c                    |  11 +-
>  hw/intc/xive-internal.h           | 189 ++++++++
>  hw/ppc/spapr.c                    | 110 ++++-
>  hw/ppc/spapr_hcall.c              |   6 +
>  hw/ppc/spapr_pci.c                |   4 +-
>  include/hw/pci-host/spapr.h       |   2 +-
>  include/hw/ppc/spapr.h            |  17 +-
>  include/hw/ppc/spapr_xive.h       |  75 +++
>  include/hw/ppc/xics.h             |   7 +
>  include/migration/vmstate.h       |  10 +
>  14 files changed, 2169 insertions(+), 15 deletions(-)
>  create mode 100644 hw/intc/spapr_xive.c
>  create mode 100644 hw/intc/spapr_xive_hcall.c
>  create mode 100644 hw/intc/xive-internal.h
>  create mode 100644 include/hw/ppc/spapr_xive.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bxF9Dep5HzwGj9mC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnA00IACgkQbDjKyiDZ
s5LgPg//eX7Ja7L5TG+V8DJsemjJirg9owjCN2XzZ8UwDz8EM4qKomiyqTV7Meh3
hnwix1l4AL/7Ym3BCG/3h9Y1DfAZqS5ZDKcLFs41G8xWk+fKCVbVVGn5yGzthoEc
Cbgsc6nKWWgsoYDEvU6tXr5eotOs4HBbs7IUtQvosW7oxnDY78wVqqfQz7UXTmFI
L6p0WEaNK9U9/QDQ3FGn6qZecNkwvt+vM1b2raGIGrx+ofwG6XP4MkucZvR1iR17
/a0t3+/ehEDFnY6dmhGBllFvA0c7+9t/lKNoZwt/WORxTcNdmeVXe4V3d4RPtDhZ
Fr1DrMCEIzh7VOuNIaL9GE+NFX078Z2uk7rgRnCnMa71vXQBBbhmDfgyNPPwfYC6
PO9y/32TvDNrvzALZeruy+OvpWZhrQulQ3XcH119nBc5v/Qq9OmlJFVqUdOw9S3G
iCF0dQFmeP6q8SxHkoQRpCDCCGVwGU0dgXmOb6tEcVkRKku3EEaW9ERfX75go3Hk
8CBp59j2RHo3qY8FkA2qphGr9BRUug4BrLD03qaXG75Saj5nOWqftE4GV11Cq7hV
I4TifuQCXQpeuxpwttZoKQXM1JEDda9Dny1t74NN8iidGFS4N0ekmHYngTCXgaWO
ggIP+s/4h7F5GkAOW0+zLqVdZxl8bTO/vVtNfkcDuTrqamuU5mo=
=rBWt
-----END PGP SIGNATURE-----

--bxF9Dep5HzwGj9mC--
