Received: from eggs.gnu.org ([209.51.188.92]:37358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvxZO-0007T3-Dc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvxZL-0007EC-ST
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:03:49 -0500
Date: Tue, 19 Feb 2019 15:39:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219043952.GY9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-8-clg@kaod.org>
	<20190219040529.GW9345@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iRaAnoDFBoP0sW/E"
Content-Disposition: inline
In-Reply-To: <20190219040529.GW9345@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 07/12] target/ppc: Add basic support for
 "new format" HPTE as found on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--iRaAnoDFBoP0sW/E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 03:05:29PM +1100, David Gibson wrote:
> On Fri, Feb 15, 2019 at 06:00:24PM +0100, C=E9dric Le Goater wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > POWER9 (arch v3) slightly changes the HPTE format. The B bits move
> > from the first to the second half of the HPTE, and the AVPN/ARPN
> > are slightly shorter.
> >=20
> > However, under SPAPR, the hypercalls still take the old format
> > (and probably will for the foreseable future).
> >=20
> > The simplest way to support this is thus to convert the HPTEs from
> > new to old format when reading them if the MMU model is v3 and there
> > is no virtual hypervisor, leaving the rest of the code unchanged.
> >=20
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Kinda hacky, but definitely the easiest way in the short to medium
> term.

So, this doesn't compile as-is without the include rearrangement I
objected to earlier in the series.

But.. I'm not actually seeing any reason (here or later in the series)
that ppc64_v3_new_to_old_hpte() really needs to be in the header.  So
I'm applying this with it moved into mmu-hash64.c.

>=20
> > ---
> >  target/ppc/mmu-book3s-v3.h | 12 ++++++++++++
> >  target/ppc/mmu-hash64.h    |  5 +++++
> >  target/ppc/mmu-hash64.c    |  5 +++++
> >  3 files changed, 22 insertions(+)
> >=20
> > diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> > index 4e59742d7eac..216ff296c088 100644
> > --- a/target/ppc/mmu-book3s-v3.h
> > +++ b/target/ppc/mmu-book3s-v3.h
> > @@ -56,6 +56,18 @@ static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
> >      return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
> >  }
> > =20
> > +static inline void ppc64_v3_new_to_old_hpte(target_ulong *pte0,
> > +                                            target_ulong *pte1)
> > +{
> > +    /* Insert B into pte0 */
> > +    *pte0 =3D (*pte0 & HPTE64_V_COMMON_BITS) |
> > +            ((*pte1 & HPTE64_R_3_0_SSIZE_MASK) <<
> > +             (HPTE64_V_SSIZE_SHIFT - HPTE64_R_3_0_SSIZE_SHIFT));
> > +
> > +    /* Remove B from pte1 */
> > +    *pte1 =3D *pte1 & ~HPTE64_R_3_0_SSIZE_MASK;
> > +}
> > +
> >  hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr);
> > =20
> >  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > index f11efc9cbc1f..016d6b44ee75 100644
> > --- a/target/ppc/mmu-hash64.h
> > +++ b/target/ppc/mmu-hash64.h
> > @@ -102,6 +102,11 @@ void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
> >  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
> >  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
> > =20
> > +/* Format changes for ARCH v3 */
> > +#define HPTE64_V_COMMON_BITS    0x000fffffffffffffULL
> > +#define HPTE64_R_3_0_SSIZE_SHIFT 58
> > +#define HPTE64_R_3_0_SSIZE_MASK (3ULL << HPTE64_R_3_0_SSIZE_SHIFT)
> > +
> >  static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
> >  {
> >      if (cpu->vhyp) {
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index b3c4d33faa55..9afaab8a177c 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -514,6 +514,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *c=
pu, hwaddr hash,
> >          smp_rmb();
> >          pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
> > =20
> > +        /* Convert format if necessary */
> > +        if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00 && !cpu->vhyp) {
> > +            ppc64_v3_new_to_old_hpte(&pte0, &pte1);
> > +        }
> > +
> >          /* This compares V, B, H (secondary) and the AVPN */
> >          if (HPTE64_V_COMPARE(pte0, ptem)) {
> >              *pshift =3D hpte_page_shift(sps, pte0, pte1);
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iRaAnoDFBoP0sW/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxriJYACgkQbDjKyiDZ
s5KCBw//Rr6EFIsMxe0qsVqsjypL1n40O6rm9O1iKQdhGyislX3wDWU6nYHjNLB7
S1cnD/NoyE4elDGHc+lhFhh09NCW1SKYFOiVHKo+yjcjVtqgsO9GuSETfxfnnjkM
h3ZQx11mVf9uArb92ucaErI7H7Pa3n9/xIysrxRjwwqyDCX7JzP/zzYQhEwSID2I
91iCU9z7ektBgiGUWQM+rMFdnHJHRXq8grrXlVNbDlgvg+trcCIeygCHHJBvfXFV
E0HnXc1Zpy8p5pVZ3P3ZmaTNezU2ItAShOk3fVztRB0HhTY/Cf9e+eDw/h5sMTXw
htIlTUp1dxa5dDWL1kyHy2QjMnR5zcB+AuQ0Ny5xVX3j34s1u4QQTYRgH3XF4yPG
JVmkJfDrIfKXJ1UEgPqBHvU1euukF4qfkLetW/3wNABDA9y65uT+koL2OrLn2ZJ5
pdCtoXcRYCn7hPp1NJ8+Cl1LDZNLeLv01HADmCzH4eyknfLYsn5DbG9Ja5/wy5hA
zGQYpdtBR9PXxluFmEK8cxU3Dx3IEdBBg78b0F2qfn0Yb1PKkmqbalvQDDQ9hDsb
uyz1vbKYhvFhV6B7WdT7YKEMnREHuW1hI0SpxYlKuuLNBKJAXfs0v0EhTOG1lnDT
PXLZ0VwdnMk8rpxIWFbB14qFua1N0D5xsoRIOvj4WjbQb82jU5U=
=o56O
-----END PGP SIGNATURE-----

--iRaAnoDFBoP0sW/E--
