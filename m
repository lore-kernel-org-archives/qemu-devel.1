Received: from eggs.gnu.org ([2001:4830:134:3::10]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzFD-0002Mn-2u
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF9-00067D-8j
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:23 -0500
Date: Fri, 10 Feb 2017 11:11:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210001154.GL27610@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-9-git-send-email-sjitindarsingh@gmail.com>
	<20170201040933.GN30639@umbus.fritz.box>
	<1486609108.2498.73.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
Content-Disposition: inline
In-Reply-To: <1486609108.2498.73.camel@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 08/17] target/ppc/POWER9: Add external
 partition table pointer to cpu state
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


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 01:58:28PM +1100, Suraj Jitindar Singh wrote:
> On Wed, 2017-02-01 at 15:09 +1100, David Gibson wrote:
> > On Fri, Jan 13, 2017 at 05:28:14PM +1100, Suraj Jitindar Singh wrote:
> > >=20
> > > Similarly to how we have an external hpt pointer in the cpu state,
> > > add
> > > an external partition table pointer and update it to point to the
> > > partition table entry in the machine state struct on cpu reset.
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > As with the previous patch, I don't quite follow what's going on
> > here.=A0=A0It seems to me that if the external HPT is set, that should
> > make the softmmu logic bypass *both* an HPT set by SDR1 (<=3D POWER8)
> > or
> > an HPT set by the partition table (POWER9).=A0=A0So I'm not sure why we
> > need the dummy partition table entry.
> >=20
> > To look at it another way, the external HPT is special because it
> > lies
> > outside the guest's address space, but we need its state because the
> > guest can manipulate it via hypercall.=A0=A0For the partition table
> > entry,
> > even if we're minimally modelling the HV parts of the POWER9 MMU,
> > isn't the partition table entry just fixed at startup?
> Similarly this patch will be dropped from the series.

Ok.

> >=20
> > >=20
> > > ---
> > > =A0hw/ppc/spapr_cpu_core.c | 12 ++++++++++--
> > > =A0target/ppc/cpu.h=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A03 +++
> > > =A0target/ppc/mmu.h=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A06 ++++++
> > > =A0target/ppc/mmu_helper.c | 12 ++++++++++++
> > > =A04 files changed, 31 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 8cc7058..72a7f90 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -17,6 +17,7 @@
> > > =A0#include "hw/ppc/ppc.h"
> > > =A0#include "target/ppc/mmu-hash64.h"
> > > =A0#include "sysemu/numa.h"
> > > +#include "mmu.h"
> > > =A0
> > > =A0static void spapr_cpu_reset(void *opaque)
> > > =A0{
> > > @@ -34,8 +35,15 @@ static void spapr_cpu_reset(void *opaque)
> > > =A0
> > > =A0=A0=A0=A0=A0env->spr[SPR_HIOR] =3D 0;
> > > =A0
> > > -=A0=A0=A0=A0ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr-
> > > >htab_shift,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&error_fatal);
> > > +=A0=A0=A0=A0switch (env->mmu_model) {
> > > +=A0=A0=A0=A0case POWERPC_MMU_3_00:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0ppc64_set_external_patb(cpu, spapr->patb, &e=
rror_fatal);
> > > +=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* We assume legacy until told otherwise, th=
us set HPT
> > > irrespective */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_set_external_hpt(cpu, spapr->htab=
, spapr-
> > > >htab_shift,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&error_fatal);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0}
> > > =A0}
> > > =A0
> > > =A0static void spapr_cpu_destroy(PowerPCCPU *cpu)
> > > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > > index 0ab49b3..e8b7c06 100644
> > > --- a/target/ppc/cpu.h
> > > +++ b/target/ppc/cpu.h
> > > @@ -77,6 +77,7 @@
> > > =A0#include "exec/cpu-defs.h"
> > > =A0#include "cpu-qom.h"
> > > =A0#include "fpu/softfloat.h"
> > > +#include "mmu.h"
> > > =A0
> > > =A0#if defined (TARGET_PPC64)
> > > =A0#define PPC_ELF_MACHINE=A0=A0=A0=A0=A0EM_PPC64
> > > @@ -1009,6 +1010,8 @@ struct CPUPPCState {
> > > =A0=A0=A0=A0=A0target_ulong sr[32];
> > > =A0=A0=A0=A0=A0/* externally stored hash table */
> > > =A0=A0=A0=A0=A0uint8_t *external_htab;
> > > +=A0=A0=A0=A0/* externally stored partition table entry */
> > > +=A0=A0=A0=A0struct patb_entry *external_patbe;
> > > =A0=A0=A0=A0=A0/* BATs */
> > > =A0=A0=A0=A0=A0uint32_t nb_BATs;
> > > =A0=A0=A0=A0=A0target_ulong DBAT[2][8];
> > > diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
> > > index 67b9707..c7967c3 100644
> > > --- a/target/ppc/mmu.h
> > > +++ b/target/ppc/mmu.h
> > > @@ -8,6 +8,12 @@ struct patb_entry {
> > > =A0=A0=A0=A0=A0uint64_t patbe0, patbe1;
> > > =A0};
> > > =A0
> > > +#ifdef TARGET_PPC64
> > > +
> > > +void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error
> > > **errp);
> > > +
> > > +#endif /* TARGET_PPC64 */
> > > +
> > > =A0#endif /* CONFIG_USER_ONLY */
> > > =A0
> > > =A0#endif /* MMU_H */
> > > diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> > > index 2ab4562..bc6c117 100644
> > > --- a/target/ppc/mmu_helper.c
> > > +++ b/target/ppc/mmu_helper.c
> > > @@ -28,6 +28,7 @@
> > > =A0#include "exec/cpu_ldst.h"
> > > =A0#include "exec/log.h"
> > > =A0#include "helper_regs.h"
> > > +#include "mmu.h"
> > > =A0
> > > =A0//#define DEBUG_MMU
> > > =A0//#define DEBUG_BATS
> > > @@ -2907,3 +2908,14 @@ void tlb_fill(CPUState *cs, target_ulong
> > > addr, MMUAccessType access_type,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0retaddr);
> > > =A0=A0=A0=A0=A0}
> > > =A0}
> > > +
> > > +/*****************************************************************
> > > *************/
> > > +
> > > +/* ISA v3.00 (POWER9) Generic MMU Helpers */
> > > +
> > > +void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error
> > > **errp)
> > > +{
> > > +=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > > +
> > > +=A0=A0=A0=A0env->external_patbe =3D (struct patb_entry *) patb;
> > > +}
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQVKAAoJEGw4ysog2bOSl3EQAKGoXv33mdiAoJR5P9zk9kFl
sKCp2HE2PoNGk2of0euMdKX0SKqMH+pB0gZA83yQuuut8PgcRQd/ahlVAwKcKIrR
xpPFEFnqy/mR4vAsvULqUZ+wnPjsjgz85D2cpJph+HhwjBn0K+E9s0e4mSVsxnts
vRRlLOTvYi2+Q3K73tT8nxow/KpeNWSHv8MNVNM8qQE4hAkw/RUysdfN3Ofl4SE3
iOmv5d7czHSI56Z4oySznQP/xTRyqxc7msS6Gfz4vA16AWKESpTgOWGzXQVBqMDT
xm0ZMXNzaTidW9kfalLXcIIoKpbhcwznWb1xNm5Jj6HalDNNPBM+zNeS2iveO80N
oH4Pn8H8Qx2sekkF4u2Yl6qftClzvNnpuRBskjUQCwfd08JXPcQYHDCoZDwh0WNK
VRXcMXSI5SEUAQxqZpjpLaC8CeRZCcnt8aMk5KwwR3GlyMkr5rbwSjjz6jQDzk5o
a55e+UqIIkLC2WAb+7P/14wZpy+VjwNbbzn5b6WCrUJhG2Vq6fXw1Q0xGyP3P+sq
iQseLce8WvKAC/ys1OXYMtN2XVIrVfGTIKen8lDKR3IaPfit5t8EzmGk3EpJlNVx
K5Qlq7dAQXV1AhNSeNDE/oO7153OcG7M3oC9ihESNomAPiyeJJJP4/6z3iOQN8lV
splpuBCFljfWnGU/ct4T
=dWLL
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--
