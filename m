Received: from eggs.gnu.org ([2001:4830:134:3::10]:39841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f1Phf-0005lg-QK
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 01:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f1Phb-0000wH-P2
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 01:02:23 -0400
Date: Thu, 29 Mar 2018 15:57:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180329045733.GL3510@umbus.fritz.box>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-10-david@gibson.dropbear.id.au>
	<67545c30-df9d-e498-cc31-eb30b7c63ba1@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Content-Disposition: inline
In-Reply-To: <67545c30-df9d-e498-cc31-eb30b7c63ba1@kaod.org>
Subject: Re: [Qemu-devel] [RFC for-2.13 09/12] target/ppc: Move 1T segment
 and AMR options to PPCHash64Options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, groug@kaod.org, agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com


--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 09:40:13AM +0200, C=E9dric Le Goater wrote:
> On 03/27/2018 06:37 AM, David Gibson wrote:
> > Currently env->mmu_model is a bit of an unholy mess of an enum of disti=
nct
> > MMU types, with various flag bits as well.  This makes which bits of the
> > field should be compared pretty confusing.
> >=20
> > Make a start on cleaning that up by moving two of the flags bits -
> > POWERPC_MMU_1TSEG and POWERPC_MMU_AMR - which are specific to the 64-bit
> > hash MMU into a new flags field in PPCHash64Options structure.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Maybe introduce a small helper :
>=20
> 	#define ppc_hash64_has(cpu, opt) ((cpu)->hash64_opts->flags &
> 	(opt))

Good idea, that makes things rather nicer.  I'll include it in the
next spin.


>=20
> Thanks,
>=20
> C.=20
>=20
> > ---
> >  hw/ppc/pnv.c            |  3 ++-
> >  hw/ppc/spapr.c          |  2 +-
> >  target/ppc/cpu-qom.h    | 11 +++--------
> >  target/ppc/kvm.c        |  4 ++--
> >  target/ppc/mmu-hash64.c |  6 ++++--
> >  target/ppc/mmu-hash64.h |  3 +++
> >  6 files changed, 15 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 5a79b24828..0aa878b771 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -36,6 +36,7 @@
> >  #include "monitor/monitor.h"
> >  #include "hw/intc/intc.h"
> >  #include "hw/ipmi/ipmi.h"
> > +#include "target/ppc/mmu-hash64.h"
> > =20
> >  #include "hw/ppc/xics.h"
> >  #include "hw/ppc/pnv_xscom.h"
> > @@ -187,7 +188,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
> >          _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
> >      }
> > =20
> > -    if (env->mmu_model & POWERPC_MMU_1TSEG) {
> > +    if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
> >          _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
> >                             segs, sizeof(segs))));
> >      }
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index a35bffd524..436ed39f7f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -557,7 +557,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, voi=
d *fdt, int offset,
> >          _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
> >      }
> > =20
> > -    if (env->mmu_model & POWERPC_MMU_1TSEG) {
> > +    if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
> >          _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
> >                            segs, sizeof(segs))));
> >      }
> > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > index 3e5ef7375f..2bd58b2a84 100644
> > --- a/target/ppc/cpu-qom.h
> > +++ b/target/ppc/cpu-qom.h
> > @@ -68,22 +68,17 @@ enum powerpc_mmu_t {
> >      /* PowerPC 601 MMU model (specific BATs format)            */
> >      POWERPC_MMU_601        =3D 0x0000000A,
> >  #define POWERPC_MMU_64       0x00010000
> > -#define POWERPC_MMU_1TSEG    0x00020000
> > -#define POWERPC_MMU_AMR      0x00040000
> >  #define POWERPC_MMU_V3       0x00100000 /* ISA V3.00 MMU Support */
> >      /* 64 bits PowerPC MMU                                     */
> >      POWERPC_MMU_64B        =3D POWERPC_MMU_64 | 0x00000001,
> >      /* Architecture 2.03 and later (has LPCR) */
> >      POWERPC_MMU_2_03       =3D POWERPC_MMU_64 | 0x00000002,
> >      /* Architecture 2.06 variant                               */
> > -    POWERPC_MMU_2_06       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> > -                             | POWERPC_MMU_AMR | 0x00000003,
> > +    POWERPC_MMU_2_06       =3D POWERPC_MMU_64 | 0x00000003,
> >      /* Architecture 2.07 variant                               */
> > -    POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> > -                             | POWERPC_MMU_AMR | 0x00000004,
> > +    POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | 0x00000004,
> >      /* Architecture 3.00 variant                               */
> > -    POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> > -                             | POWERPC_MMU_AMR | POWERPC_MMU_V3
> > +    POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_V3
> >                               | 0x00000005,
> >  };
> >  #define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 01947169c9..3424917381 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -302,7 +302,7 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *=
cpu,
> >          /* HV KVM has backing store size restrictions */
> >          info->flags =3D KVM_PPC_PAGE_SIZES_REAL;
> > =20
> > -        if (env->mmu_model & POWERPC_MMU_1TSEG) {
> > +        if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
> >              info->flags |=3D KVM_PPC_1T_SEGMENTS;
> >          }
> > =20
> > @@ -482,7 +482,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> >      }
> >      env->slb_nr =3D smmu_info.slb_size;
> >      if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> > -        env->mmu_model &=3D ~POWERPC_MMU_1TSEG;
> > +        cpu->hash64_opts->flags &=3D ~PPC_HASH64_1TSEG;
> >      }
> >  }
> > =20
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index d369b1bf86..1d785f50d7 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -160,7 +160,7 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slo=
t,
> >      if (vsid & (SLB_VSID_B & ~SLB_VSID_B_1T)) {
> >          return -1; /* Bad segment size */
> >      }
> > -    if ((vsid & SLB_VSID_B) && !(env->mmu_model & POWERPC_MMU_1TSEG)) {
> > +    if ((vsid & SLB_VSID_B) && !(cpu->hash64_opts->flags & PPC_HASH64_=
1TSEG)) {
> >          return -1; /* 1T segment on MMU that doesn't support it */
> >      }
> > =20
> > @@ -369,7 +369,7 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc=
_hash_pte64_t pte)
> >      int prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> > =20
> >      /* Only recent MMUs implement Virtual Page Class Key Protection */
> > -    if (!(env->mmu_model & POWERPC_MMU_AMR)) {
> > +    if (!(cpu->hash64_opts->flags & PPC_HASH64_AMR)) {
> >          return prot;
> >      }
> > =20
> > @@ -1114,6 +1114,7 @@ void ppc_hash64_finalize(PowerPCCPU *cpu)
> >  }
> > =20
> >  const PPCHash64Options ppc_hash64_opts_basic =3D {
> > +    .flags =3D 0,
> >      .sps =3D {
> >          { .page_shift =3D 12, /* 4K */
> >            .slb_enc =3D 0,
> > @@ -1127,6 +1128,7 @@ const PPCHash64Options ppc_hash64_opts_basic =3D {
> >  };
> > =20
> >  const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
> > +    .flags =3D PPC_HASH64_1TSEG | PPC_HASH64_AMR,
> >      .sps =3D {
> >          {
> >              .page_shift =3D 12, /* 4K */
> > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > index ff0c48af55..6cfca97a60 100644
> > --- a/target/ppc/mmu-hash64.h
> > +++ b/target/ppc/mmu-hash64.h
> > @@ -152,6 +152,9 @@ struct ppc_one_seg_page_size {
> >  };
> > =20
> >  struct PPCHash64Options {
> > +#define PPC_HASH64_1TSEG        0x00001
> > +#define PPC_HASH64_AMR          0x00002
> > +    unsigned flags;
> >      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
> >  };
> > =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq8cjsACgkQbDjKyiDZ
s5JNYRAAjyDkMtiz58zTKQcyELVnHnk3KXtJbNxk0M4QdRv/hi8joYYKgreQGvEi
QUiEzkoI1rzx0CSA8wHh0yejN45kxDm5nDHFHUFNAPvzd0gmsc5PTRH5400DS8CW
oPh8m13C/8+YIrUCJ49woPAK1XX3iJHp0FD8xN3f30RPM4MSW4Gotoci63RVrSGD
P1auVacnI6qjPwLyq2gEF7/SNy5T3ysyG5cNMo8Z3Zi7DpwCH38Twz8KLQfvnR2r
ocn6LKq7YeN0lwlVhHvj2tCij6/+MvWcpXS/2N4BP7D6K6OFtE/FJtac6muyCBUW
yj0QtIJnGszJfjsv7Qh1BwJ7GYjq7FRz4rixxBAaMZ+MgLxQLzqP0+pQqkBVNaKv
XbACIFICjRWoVKKTDOotxdXnjP8esLyAgHuV0JS0ZVFkjPjm85LCWG8ZCaw+gwfI
9AWxPu6z8cs9aZyhBROgHkkILDC1eTGtTunKFJjVEAndgZQxQqrX6cd/obDjczid
2mamiY+W682a7vX15RjcXNJdNJ037qgsBgv2M6Wx4LhoRN5F28SXZ6g4KbzH86vC
06Rp16NU/5qZ3wjOrNQrb5r+iqADLEnpe0D09gH28spXQd1o3NetaYQXG5UVoULL
nC65W58QCMk03lNOo4k6xh37SmG+xRNFMkIr35qYgVNLkWNoAMI=
=9uMu
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--
