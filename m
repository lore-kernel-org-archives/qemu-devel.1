Received: from eggs.gnu.org ([2001:4830:134:3::10]:46950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF7-0002Jk-Sh
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF6-00065C-6Q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:17 -0500
Date: Fri, 10 Feb 2017 11:16:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210001645.GM27610@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-11-git-send-email-sjitindarsingh@gmail.com>
	<20170201042310.GP30639@umbus.fritz.box>
	<1486609492.2498.79.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RNRUMt0ZF5Yaq/Aq"
Content-Disposition: inline
In-Reply-To: <1486609492.2498.79.camel@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 10/17] target/ppc/POWER9: Add POWER9
 mmu fault handler
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


--RNRUMt0ZF5Yaq/Aq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 02:04:52PM +1100, Suraj Jitindar Singh wrote:
> On Wed, 2017-02-01 at 15:23 +1100, David Gibson wrote:
> > On Fri, Jan 13, 2017 at 05:28:16PM +1100, Suraj Jitindar Singh wrote:
> > >=20
> > > Add a new mmu fault handler for the POWER9 cpu and add it as the
> > > handler
> > > for the POWER9 cpu definition.
> > >=20
> > > This handler checks if the guest is radix or hash based on the
> > > value in the
> > > partition table entry and calls the correct fault handler
> > > accordingly.
> > >=20
> > > The hash fault handling code has also been updated to check if the
> > > partition is using segment tables.
> > >=20
> > > Currently only legacy hash (no segment tables) is supported.
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > ---
> > > =A0target/ppc/mmu-hash64.c=A0=A0=A0=A0=A0|=A0=A08 ++++++++
> > > =A0target/ppc/mmu.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A08 +++++=
+++
> > > =A0target/ppc/mmu_helper.c=A0=A0=A0=A0=A0| 47
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > > =A0target/ppc/translate_init.c |=A0=A02 +-
> > > =A04 files changed, 64 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > index b9d4f4e..b476b3f 100644
> > > --- a/target/ppc/mmu-hash64.c
> > > +++ b/target/ppc/mmu-hash64.c
> > > @@ -73,6 +73,14 @@ static ppc_slb_t *slb_lookup(PowerPCCPU *cpu,
> > > target_ulong eaddr)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > =A0=A0=A0=A0=A0}
> > > =A0
> > > +=A0=A0=A0=A0/* Check if in-memory segment tables are in use */
> > > +=A0=A0=A0=A0if (ppc64_use_proc_tbl(cpu)) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* TODO - Unsupported */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0qemu_log_mask(LOG_UNIMP, "%s: unimplemented =
- segment
> > > table support\n",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__=
func__);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* Not much we can do here, caller will gene=
rate a segment
> > > interrupt */
> > > +=A0=A0=A0=A0}
> > I think this logic would be better in the fault handler.=A0=A0For the
> > fault path in the segment table case, I don't think we want to even
> > model the SLB (in hardware the SLB is an important optimization, but
> > I
> > don't think the software SLB will be notably better than just looking
> > up the seg table directly).=A0=A0I think the other users of slb_lookup()
> > are in contexts that only make sense in the context of a software
> > managed SLB anyway.
> >=20
> The mmu looks up the slb before it looks in the segment tables, so we
> still need to model and search the slb before we search segment tables.

Well, it's not so much the fact that the hardware looks up the slb.
It's that it still permits the guest to software load SLB entries, so
we can have things in the SLB that can't also be discovered from the
segment tables.  I realized this after making the comment.

> We could call slb lookup and if that fails we can then call a
> search_seg_tbl() or something from the fault handler.

Yes, I think doing that in the caller would be clearer than doing the
segment table lookup within slb_lookup().

> > >=20
> > > =A0=A0=A0=A0=A0return NULL;
> > > =A0}
> > > =A0
> > > diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
> > > index c7967c3..e07b128 100644
> > > --- a/target/ppc/mmu.h
> > > +++ b/target/ppc/mmu.h
> > > @@ -3,6 +3,10 @@
> > > =A0
> > > =A0#ifndef CONFIG_USER_ONLY
> > > =A0
> > > +/* Common Partition Table Entry Fields */
> > > +#define PATBE0_HR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x8=
000000000000000
> > > +#define PATBE1_GR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x8=
000000000000000
> > > +
> > > =A0/* Partition Table Entry */
> > > =A0struct patb_entry {
> > > =A0=A0=A0=A0=A0uint64_t patbe0, patbe1;
> > > @@ -11,6 +15,10 @@ struct patb_entry {
> > > =A0#ifdef TARGET_PPC64
> > > =A0
> > > =A0void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error
> > > **errp);
> > > +bool ppc64_use_proc_tbl(PowerPCCPU *cpu);
> > > +bool ppc64_radix_guest(PowerPCCPU *cpu);
> > > +int ppc64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0int mmu_idx);
> > > =A0
> > > =A0#endif /* TARGET_PPC64 */
> > > =A0
> > > diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> > > index bc6c117..612f407 100644
> > > --- a/target/ppc/mmu_helper.c
> > > +++ b/target/ppc/mmu_helper.c
> > > @@ -28,6 +28,7 @@
> > > =A0#include "exec/cpu_ldst.h"
> > > =A0#include "exec/log.h"
> > > =A0#include "helper_regs.h"
> > > +#include "qemu/error-report.h"
> > > =A0#include "mmu.h"
> > > =A0
> > > =A0//#define DEBUG_MMU
> > > @@ -1281,6 +1282,17 @@ void dump_mmu(FILE *f, fprintf_function
> > > cpu_fprintf, CPUPPCState *env)
> > > =A0=A0=A0=A0=A0case POWERPC_MMU_2_07a:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0dump_slb(f, cpu_fprintf, ppc_env_get_cpu(e=
nv));
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0case POWERPC_MMU_3_00:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0if (ppc64_radix_guest(ppc_env_get_cpu(env)))=
 {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* TODO - Unsupported */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ppc64_use_proc_tbl(ppc_env_g=
et_cpu(env))) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* TODO - Unsupporte=
d */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dump_slb(f, cpu_fpri=
ntf, ppc_env_get_cpu(env));
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > > =A0#endif
> > > =A0=A0=A0=A0=A0default:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_log_mask(LOG_UNIMP, "%s: unimplemente=
d\n", __func__);
> > > @@ -1422,6 +1434,17 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState
> > > *cs, vaddr addr)
> > > =A0=A0=A0=A0=A0case POWERPC_MMU_2_07:
> > > =A0=A0=A0=A0=A0case POWERPC_MMU_2_07a:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0return ppc_hash64_get_phys_page_debug(cpu,=
 addr);
> > > +=A0=A0=A0=A0case POWERPC_MMU_3_00:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0if (ppc64_radix_guest(ppc_env_get_cpu(env)))=
 {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* TODO - Unsupported */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ppc64_use_proc_tbl(ppc_env_g=
et_cpu(env))) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* TODO - Unsupporte=
d */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ppc_hash64_ge=
t_phys_page_debug(cpu, addr);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > =A0#endif
> > > =A0
> > > =A0=A0=A0=A0=A0case POWERPC_MMU_32B:
> > > @@ -2919,3 +2942,27 @@ void ppc64_set_external_patb(PowerPCCPU
> > > *cpu, void *patb, Error **errp)
> > > =A0
> > > =A0=A0=A0=A0=A0env->external_patbe =3D (struct patb_entry *) patb;
> > > =A0}
> > > +
> > > +inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
> > There's basically no point putting an inline on functions that are in
> > a .c rather than a .h (it will only be inlined for callers in this
> > .o,
> > not elsewhere).=A0=A0These are simple enough that I think they do belong
> > in the .h instead.
> I'll move these into the .h
> >=20
> > >=20
> > > +{
> > > +=A0=A0=A0=A0return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
> > > +}
> > > +
> > > +inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> > > +{
> > > +=A0=A0=A0=A0struct patb_entry *patbe =3D cpu->env.external_patbe;
> > > +
> > > +=A0=A0=A0=A0return patbe && (patbe->patbe1 & PATBE1_GR);
> > > +}
> > > +
> > > +int ppc64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0int mmu_idx)
> > I think this name is too generic, since it's really only right for
> > POWER9 / MMU v3.
> Ok, how about ppc64_v3_handle_mmu_fault?
> >=20
> > >=20
> > > +{
> > > +=A0=A0=A0=A0if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* TODO - Unsupported */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0error_report("Guest Radix Support Unimplemen=
ted\n");
> > > +=A0=A0=A0=A0=A0=A0=A0=A0abort();
> > > +=A0=A0=A0=A0} else { /* Guest uses hash */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0return ppc_hash64_handle_mmu_fault(cpu, eadd=
r, rwx,
> > > mmu_idx);
> > > +=A0=A0=A0=A0}
> > > +}
> > > diff --git a/target/ppc/translate_init.c
> > > b/target/ppc/translate_init.c
> > > index c771ba3..87297a7 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -8850,7 +8850,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void
> > > *data)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull =
<< MSR_LE);
> > > =A0=A0=A0=A0=A0pcc->mmu_model =3D POWERPC_MMU_3_00;
> > > =A0#if defined(CONFIG_SOFTMMU)
> > > -=A0=A0=A0=A0pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> > > +=A0=A0=A0=A0pcc->handle_mmu_fault =3D ppc64_handle_mmu_fault;
> > > =A0=A0=A0=A0=A0/* segment page size remain the same */
> > > =A0=A0=A0=A0=A0pcc->sps =3D &POWER7_POWER8_sps;
> > > =A0#endif
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RNRUMt0ZF5Yaq/Aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQZtAAoJEGw4ysog2bOSyLYP/jmom2+z1gJ7WsEtyEvhk+44
DtCvt4J9yzX0uzu8dC4pUjC6jTh9UfAghwkO4tTMOTCGgOA1xLHSt18lIAeHOEvv
pJrwlA6CDBmgOVmFskJtTtG34vMnNGu9TftJuKZ3Y9km+7isEpnys+PwT/7Z2c5+
Mtxxa3PmgvJeC5QAkcVT6dfwNb0nKXkaY67jEnmoIgzY5yV9l0V3YRFRUDsxqQG1
2FDjkRMEfd4P210ptRv+cqbvb+1Ge8hPYPDa/U/88mDjUk5dQMsj+8kmscO35HLj
hZfHSty0TZwBvknSsdqUb+P6jQOQEY4F9HQhwcz2GQWHUNjIDORSu2RZVHAsLiAo
k0WNh15wrIsV2y2joUM4qb1ce3ruxe18TqKlBFE2K4HNbw32Fo+7uZuKGXAs6Duu
uIqwo1UtVt8V4qKWKVrHoC8c6NPdX6XMChIhnJ7b9vsAqiGeIzKjm155vBgslxnn
mp+ArpiDce5iCkTuNJ00IXxQBlQVi/zFlH1URIzA8zetAsBaZMnRk6LFZ2QRip0m
yUsOP3exuyewo+7wC5amGPCqsUHyZ5s62xEKFDrBL0osn9eO3vx7Y9OKh4ZQcHBO
MLdMTflg46mjo2TWts19tQswBewKg5A+x5wRZYP+1Ioozo7Ecxq+bXPQxiogbpbd
pm8t5bmsoUlH4oSzZv+a
=Jvxr
-----END PGP SIGNATURE-----

--RNRUMt0ZF5Yaq/Aq--
