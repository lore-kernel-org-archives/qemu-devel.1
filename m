Received: from eggs.gnu.org ([2001:4830:134:3::10]:46945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF7-0002Jj-ND
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF6-00065F-7B
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:17 -0500
Date: Fri, 10 Feb 2017 11:11:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210001142.GK27610@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-8-git-send-email-sjitindarsingh@gmail.com>
	<20170201040404.GM30639@umbus.fritz.box>
	<1486609078.2498.72.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
In-Reply-To: <1486609078.2498.72.camel@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 07/17] target/ppc/POWER9: Add partition
 table pointer to sPAPRMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--2feizKym29CxAecD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 01:57:58PM +1100, Suraj Jitindar Singh wrote:
> On Wed, 2017-02-01 at 15:04 +1100, David Gibson wrote:
> > On Fri, Jan 13, 2017 at 05:28:13PM +1100, Suraj Jitindar Singh wrote:
> > >=20
> > > POWER9 uses a partition table to store information relating to how
> > > address translation is performed on a per partition basis.
> > >=20
> > > Add a data area for this to the sPAPRMachineState struct and
> > > (re)allocate
> > > it on machine reset.
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > Hm.=A0=A0I'm having trouble understanding this one.
> >=20
> > IIUC, for the "pseries" machine type this partition table entry is
> > essentially a dummy one, since there's actually only one partition.
> > For KVM the machine would be represented by one of many partition
> > table entries on the real host - so the entry here isn't really
> > relevant.=A0=A0For TCG, I'm not sure what would be looking at it.=A0=A0=
We
> > haven't implemented the partition->host level translation in TCG
> > anyway, and in any case pseries (rather than powernv) should be
> > bypassing that - in which case I'd expect it to bypass looking at the
> > dummy partition table entry as well.
> As discussed elsewhere it seems having a whole partition table entry is
> unnecessary. This will be replaced by a single process table pointer to
> be accessed via the vhyp.
>=20
> In fact this won't be necessary for the legacy case at all and so will
> drop this patch from the series in favour of moving it into the radix
> enablement series.

Ok, makes sense.

> >=20
> > >=20
> > > ---
> > > =A0hw/ppc/spapr.c=A0=A0=A0=A0=A0=A0=A0=A0=A0| 38 ++++++++++++++++++++=
++++++++++++------
> > > =A0include/hw/ppc/spapr.h |=A0=A01 +
> > > =A0target/ppc/mmu.h=A0=A0=A0=A0=A0=A0=A0| 13 +++++++++++++
> > > =A03 files changed, 46 insertions(+), 6 deletions(-)
> > > =A0create mode 100644 target/ppc/mmu.h
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 208ef7b..45bd2de 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -41,6 +41,7 @@
> > > =A0#include "migration/migration.h"
> > > =A0#include "mmu-hash64.h"
> > > =A0#include "qom/cpu.h"
> > > +#include "mmu.h"
> > > =A0
> > > =A0#include "hw/boards.h"
> > > =A0#include "hw/ppc/ppc.h"
> > > @@ -1115,6 +1116,26 @@ static void
> > > spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> > > =A0=A0=A0=A0=A0}
> > > =A0}
> > > =A0
> > > +static void spapr_reallocate_patb(sPAPRMachineState *spapr, Error
> > > **errp)
> > > +{
> > > +=A0=A0=A0=A0g_free(spapr->patb);
> > > +=A0=A0=A0=A0spapr->patb =3D NULL;
> > > +
> > > +=A0=A0=A0=A0if (!kvm_enabled()) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* We need to allocate a partition table ent=
ry */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0size_t size =3D sizeof(struct patb_entry);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0spapr->patb =3D qemu_memalign(size, size);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0if (!spapr->patb) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_setg_errno(errp, errno, "C=
ould not allocate
> > > memory for "
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"partition table
> > > entry");
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0memset(spapr->patb, 0, size);
> > > +=A0=A0=A0=A0}
> > > +}
> > > +
> > > =A0static void find_unknown_sysbus_device(SysBusDevice *sbdev, void
> > > *opaque)
> > > =A0{
> > > =A0=A0=A0=A0=A0bool matched =3D false;
> > > @@ -1134,7 +1155,7 @@ static void ppc_spapr_reset(void)
> > > =A0{
> > > =A0=A0=A0=A0=A0MachineState *machine =3D MACHINE(qdev_get_machine());
> > > =A0=A0=A0=A0=A0sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> > > -=A0=A0=A0=A0PowerPCCPU *first_ppc_cpu;
> > > +=A0=A0=A0=A0PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> > > =A0=A0=A0=A0=A0uint32_t rtas_limit;
> > > =A0=A0=A0=A0=A0hwaddr rtas_addr, fdt_addr;
> > > =A0=A0=A0=A0=A0void *fdt;
> > > @@ -1143,10 +1164,16 @@ static void ppc_spapr_reset(void)
> > > =A0=A0=A0=A0=A0/* Check for unknown sysbus devices */
> > > =A0=A0=A0=A0=A0foreach_dynamic_sysbus_device(find_unknown_sysbus_devi=
ce,
> > > NULL);
> > > =A0
> > > -=A0=A0=A0=A0/* Allocate and/or reset the hash page table */
> > > -=A0=A0=A0=A0spapr_reallocate_hpt(spapr,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0spapr_hpt_shift_for_ramsize(machine-
> > > >maxram_size),
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0&error_fatal);
> > > +=A0=A0=A0=A0switch (first_ppc_cpu->env.mmu_model) {
> > > +=A0=A0=A0=A0case POWERPC_MMU_3_00:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* Allocate the partition table */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0spapr_reallocate_patb(spapr, &error_fatal);
> > > +=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* Allocate and/or reset the hash page table=
 */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0spapr_reallocate_hpt(spapr,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0spapr_hpt_shift_for_ramsize(machine-
> > > >maxram_size),
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0&error_fatal);
> > > +=A0=A0=A0=A0}
> > > =A0
> > > =A0=A0=A0=A0=A0/* Update the RMA size if necessary */
> > > =A0=A0=A0=A0=A0if (spapr->vrma_adjust) {
> > > @@ -1193,7 +1220,6 @@ static void ppc_spapr_reset(void)
> > > =A0=A0=A0=A0=A0g_free(fdt);
> > > =A0
> > > =A0=A0=A0=A0=A0/* Set up the entry state */
> > > -=A0=A0=A0=A0first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> > > =A0=A0=A0=A0=A0first_ppc_cpu->env.gpr[3] =3D fdt_addr;
> > > =A0=A0=A0=A0=A0first_ppc_cpu->env.gpr[5] =3D 0;
> > > =A0=A0=A0=A0=A0first_cpu->halted =3D 0;
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index bd5bcf7..b654773 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -63,6 +63,7 @@ struct sPAPRMachineState {
> > > =A0
> > > =A0=A0=A0=A0=A0void *htab;
> > > =A0=A0=A0=A0=A0uint32_t htab_shift;
> > > +=A0=A0=A0=A0void *patb;
> > > =A0=A0=A0=A0=A0hwaddr rma_size;
> > > =A0=A0=A0=A0=A0int vrma_adjust;
> > > =A0=A0=A0=A0=A0ssize_t rtas_size;
> > > diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
> > > new file mode 100644
> > > index 0000000..67b9707
> > > --- /dev/null
> > > +++ b/target/ppc/mmu.h
> > > @@ -0,0 +1,13 @@
> > > +#ifndef MMU_H
> > > +#define MMU_H
> > > +
> > > +#ifndef CONFIG_USER_ONLY
> > > +
> > > +/* Partition Table Entry */
> > > +struct patb_entry {
> > > +=A0=A0=A0=A0uint64_t patbe0, patbe1;
> > > +};
> > > +
> > > +#endif /* CONFIG_USER_ONLY */
> > > +
> > > +#endif /* MMU_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQU+AAoJEGw4ysog2bOSSBgP/172O0Poeiu9fxVwS+fCRuAe
rnw/d2GWHgDWvWKjsFvMC3Z35eCJDMmqEvIleyvFOP73QTSMtrFu1AUSPES7ewhS
oRafAxfvlTeMnPp7FyRDgclNU98gwrxHDYATJn343eCymefjRLLhfd2gEX7gyFje
kR5lByuC8i68lCvZXc/a2cmS2nczpiYerswbESeik3m6M5MwzTCuYLfB/WGpgfIJ
njxKSzsSY5/Ad4z+jc2i8YGOr69Nj+QFet0nVKK07KslCuDqiaCCKRjVhtdE4Baz
mG4APQSF7Uxwboz5MFBxQydfbosTVaLlsIjDs3+GBSoXevCN96x9fU/kRnHwUK68
06rh9DEbdbvsVWy0nYhnMd1PX8ZQNTLiEiWTA2bBQ9EpkR+99SfjyZ9oCrnOhE6t
a5eZ1s1MugK6hW6NYOYL0sVg0HmsQ3gEEcM34EUoOG142YH4XFMJ0FbSV9/ezh2v
xBk+PrFJNX/6D0vbl+YW56QgKQv3hLQWyvOUS7DRcTw9Tw2tpXyf1kzPFVwKqnO3
gSBpE0iHUSaJeSqws9NOVRFp/aIiK46Msx6IuU1aCr+QuFZZVhwvpud5zcr78shL
x1ATVKcXh5HpD9LTHJzh2YlwW3UUBuHTBnUOLVt7XC31IjpjrdAF96gbobCnrGSB
NdmkfqqhZ5tKffhvFww4
=uqaN
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
