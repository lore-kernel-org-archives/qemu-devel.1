Received: from eggs.gnu.org ([2001:4830:134:3::10]:57657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch8Cn-0006I0-Pw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch8Ck-0004js-Nn
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:14:09 -0500
Date: Fri, 24 Feb 2017 14:45:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224034554.GR17615@umbus.fritz.box>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-6-david@gibson.dropbear.id.au>
	<1487829179.23895.23.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wlFCko3yyTbBmKK8"
Content-Disposition: inline
In-Reply-To: <1487829179.23895.23.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] target/ppc: Eliminate htab_base and
 htab_mask variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, aik@ozlabs.ru, qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org


--wlFCko3yyTbBmKK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 04:52:59PM +1100, Suraj Jitindar Singh wrote:
> On Thu, 2017-02-23 at 13:09 +1100, David Gibson wrote:
> > CPUPPCState includes fields htab_base and htab_mask which store the
> > base
> > address (GPA) and size (as a mask) of the guest's hashed page table
> > (HPT).
> > These are set when the SDR1 register is updated.
> >=20
> > Keeping these in sync with the SDR1 is actually a little bit fiddly,
> > and
> > probably not useful for performance, since keeping them expands the
> > size of
> > CPUPPCState.=A0=A0It also makes some upcoming changes harder to
> > implement.
> >=20
> > This patch removes these fields, in favour of calculating them
> > directly
> > from the SDR1 contents when necessary.
> >=20
> > This does make a change to the behaviour of attempting to write a bad
> > value
> > (invalid HPT size) to the SDR1 with an mtspr
> > instruction.=A0=A0Previously, the
> > bad value would be stored in SDR1 and could be retrieved with a later
> > mfspr, but the HPT size as used by the softmmu would be, clamped to
> > the
> > allowed values.=A0=A0Now, writing a bad value is treated as a no-op.=A0=
=A0An
> > error
> > message is printed in both new and old versions.
> >=20
> > I'm not sure which behaviour, if either, matches real hardware.=A0=A0I
> > don't
> > think it matters that much, since it's pretty clear that if an OS
> > writes
> > a bad value to SDR1, it's not going to boot.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Comments Below.
>=20
> > ---
> > =A0hw/ppc/spapr_hcall.c=A0=A0=A0=A0|=A0=A04 ++--
> > =A0target/ppc/cpu.h=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A08 --------
> > =A0target/ppc/machine.c=A0=A0=A0=A0|=A0=A01 -
> > =A0target/ppc/mmu-hash32.c | 14 +++++++-------
> > =A0target/ppc/mmu-hash32.h | 24 ++++++++++++++++++------
> > =A0target/ppc/mmu-hash64.c | 37 ++++++++++++++++---------------------
> > =A0target/ppc/mmu-hash64.h | 13 +++++++++++++
> > =A0target/ppc/mmu_helper.c | 31 ++++++++++++++++---------------
> > =A08 files changed, 72 insertions(+), 60 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index fd961b5..85d96f6 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -50,9 +50,9 @@ static bool has_spr(PowerPCCPU *cpu, int spr)
> > =A0static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
> > =A0{
> > =A0=A0=A0=A0=A0/*
> > -=A0=A0=A0=A0=A0* hash value/pteg group index is normalized by htab_mask
> > +=A0=A0=A0=A0=A0* hash value/pteg group index is normalized by HPT mask
> > =A0=A0=A0=A0=A0=A0*/
> > -=A0=A0=A0=A0if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~cpu->env.htab_ma=
sk) {
> > +=A0=A0=A0=A0if (((ptex & ~7ULL) / HPTES_PER_GROUP) &
> > ~ppc_hash64_hpt_mask(cpu)) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return false;
> > =A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0return true;
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index c89973e..c6cd9ab 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -309,11 +309,6 @@ union ppc_tlb_t {
> > =A0#define SDR_32_HTABORG=A0=A0=A0=A0=A0=A0=A0=A0=A00xFFFF0000UL
> > =A0#define SDR_32_HTABMASK=A0=A0=A0=A0=A0=A0=A0=A00x000001FFUL
> > =A0
> > -#if defined(TARGET_PPC64)
> > -#define SDR_64_HTABORG=A0=A0=A0=A0=A0=A0=A0=A0=A00xFFFFFFFFFFFC0000ULL
> > -#define SDR_64_HTABSIZE=A0=A0=A0=A0=A0=A0=A0=A00x000000000000001FULL
> > -#endif /* defined(TARGET_PPC64 */
> > -
> > =A0typedef struct ppc_slb_t ppc_slb_t;
> > =A0struct ppc_slb_t {
> > =A0=A0=A0=A0=A0uint64_t esid;
> > @@ -1006,9 +1001,6 @@ struct CPUPPCState {
> > =A0=A0=A0=A0=A0/* tcg TLB needs flush (deferred slb inval instruction
> > typically) */
> > =A0#endif
> > =A0=A0=A0=A0=A0/* segment registers */
> > -=A0=A0=A0=A0hwaddr htab_base;
> > -=A0=A0=A0=A0/* mask used to normalize hash value to PTEG index */
> > -=A0=A0=A0=A0hwaddr htab_mask;
> > =A0=A0=A0=A0=A0target_ulong sr[32];
> > =A0=A0=A0=A0=A0/* externally stored hash table */
> > =A0=A0=A0=A0=A0uint8_t *external_htab;
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index df9f7a4..1ccbc8a 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -229,7 +229,6 @@ static int cpu_post_load(void *opaque, int
> > version_id)
> > =A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0if (!env->external_htab) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0/* Restore htab_base and htab_mask variables */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_store_sdr1(env, env->spr[SPR_SDR1]);
>=20
> Do we still need to do this? As far as I can tell it pretty much does:
> env->spr[SPR_SDR1] =3D=A0env->spr[SPR_SDR1]
> and checks the htab_size, which would have been done when we set SDR1
> in the first place anyway?

I'd prefer to recheck it here: if we had a bug in the verification,
then fixed it, I wouldn't want the bugfix to be bypassed by migrating
in from an older version.

> > =A0=A0=A0=A0=A0}
> > =A0
> > diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> > index 29bace6..03ae3c1 100644
> > --- a/target/ppc/mmu-hash32.c
> > +++ b/target/ppc/mmu-hash32.c
> > @@ -304,9 +304,9 @@ static int ppc_hash32_direct_store(PowerPCCPU
> > *cpu, target_ulong sr,
> > =A0
> > =A0hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
> > =A0{
> > -=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > +=A0=A0=A0=A0target_ulong mask =3D ppc_hash32_hpt_mask(cpu);
> > =A0
> > -=A0=A0=A0=A0return (hash * HASH_PTEG_SIZE_32) & env->htab_mask;
> > +=A0=A0=A0=A0return (hash * HASH_PTEG_SIZE_32) & mask;
> > =A0}
> > =A0
> > =A0static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr
> > pteg_off,
> > @@ -339,7 +339,6 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU
> > *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong sr, target_ulong
> > eaddr,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash_pte32_t *pte)
> > =A0{
> > -=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > =A0=A0=A0=A0=A0hwaddr pteg_off, pte_offset;
> > =A0=A0=A0=A0=A0hwaddr hash;
> > =A0=A0=A0=A0=A0uint32_t vsid, pgidx, ptem;
> > @@ -353,21 +352,22 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU
> > *cpu,
> > =A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU, "htab_base " TARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" htab_mask " TARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash " TARGET_FMT_plx "\n",
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base, env->htab_mask, ha=
sh);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash32_hpt_base(cpu), ppc_hash=
32_hpt_mask(cpu),
> > hash);
> > =A0
> > =A0=A0=A0=A0=A0/* Primary PTEG lookup */
> > =A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU, "0 htab=3D" TARGET_FMT_plx "/"
> > TARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" vsid=3D%" PRIx32 " ptem=3D%" P=
RIx32
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash=3D" TARGET_FMT_plx "\n",
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base, env->htab_mask, vs=
id, ptem, hash);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash32_hpt_base(cpu), ppc_hash=
32_hpt_mask(cpu),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0vsid, ptem, hash);
> > =A0=A0=A0=A0=A0pteg_off =3D get_pteg_offset32(cpu, hash);
> > =A0=A0=A0=A0=A0pte_offset =3D ppc_hash32_pteg_search(cpu, pteg_off, 0, =
ptem,
> > pte);
> > =A0=A0=A0=A0=A0if (pte_offset =3D=3D -1) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0/* Secondary PTEG lookup */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU, "1 htab=3D" TARGE=
T_FMT_plx "/"
> > TARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" vsid=3D%" PRIx32 "=
 api=3D%" PRIx32
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash=3D" TARGET_FMT_=
plx "\n", env->htab_base,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_mask, vsid, =
ptem, ~hash);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash=3D" TARGET_FMT_=
plx "\n",
> > ppc_hash32_hpt_base(cpu),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash32_hpt_mask(cp=
u), vsid, ptem, ~hash);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0pteg_off =3D get_pteg_offset32(cpu, ~hash);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0pte_offset =3D ppc_hash32_pteg_search(cpu, p=
teg_off, 1, ptem,
> > pte);
> > =A0=A0=A0=A0=A0}
> > diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> > index 5b9fb08..054be65 100644
> > --- a/target/ppc/mmu-hash32.h
> > +++ b/target/ppc/mmu-hash32.h
> > @@ -65,42 +65,54 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu,
> > vaddr address, int rw,
> > =A0#define HPTE32_R_WIMG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00000078
> > =A0#define HPTE32_R_PP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00000003
> > =A0
> > +static inline hwaddr ppc_hash32_hpt_base(PowerPCCPU *cpu)
> > +{
> > +=A0=A0=A0=A0return cpu->env.spr[SPR_SDR1] & SDR_32_HTABORG;
> > +}
> > +
> > +static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
> > +{
> > +=A0=A0=A0=A0return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) |
> > 0xFFFF;
> > +}
> > +
> > =A0static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0hwaddr pte_offset)
> > =A0{
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > +=A0=A0=A0=A0target_ulong base =3D ppc_hash32_hpt_base(cpu);
> > =A0
> > =A0=A0=A0=A0=A0assert(!env->external_htab); /* Not supported on 32-bit =
for now
> > */
> > -=A0=A0=A0=A0return ldl_phys(CPU(cpu)->as, env->htab_base + pte_offset);
> > +=A0=A0=A0=A0return ldl_phys(CPU(cpu)->as, base + pte_offset);
> > =A0}
> > =A0
> > =A0static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0hwaddr pte_offset)
> > =A0{
> > +=A0=A0=A0=A0target_ulong base =3D ppc_hash32_hpt_base(cpu);
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > =A0
> > =A0=A0=A0=A0=A0assert(!env->external_htab); /* Not supported on 32-bit =
for now
> > */
> > -=A0=A0=A0=A0return ldl_phys(CPU(cpu)->as,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_=
base + pte_offset + HASH_PTE_SIZE_32 /
> > 2);
> > +=A0=A0=A0=A0return ldl_phys(CPU(cpu)->as, base + pte_offset +
> > HASH_PTE_SIZE_32 / 2);
> > =A0}
> > =A0
> > =A0static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hwaddr pte_offs=
et,
> > target_ulong pte0)
> > =A0{
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > +=A0=A0=A0=A0target_ulong base =3D ppc_hash32_hpt_base(cpu);
> > =A0
> > =A0=A0=A0=A0=A0assert(!env->external_htab); /* Not supported on 32-bit =
for now
> > */
> > -=A0=A0=A0=A0stl_phys(CPU(cpu)->as, env->htab_base + pte_offset, pte0);
> > +=A0=A0=A0=A0stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
> > =A0}
> > =A0
> > =A0static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hwaddr pte_offs=
et,
> > target_ulong pte1)
> > =A0{
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > +=A0=A0=A0=A0target_ulong base =3D ppc_hash32_hpt_base(cpu);
> > =A0
> > =A0=A0=A0=A0=A0assert(!env->external_htab); /* Not supported on 32-bit =
for now
> > */
> > -=A0=A0=A0=A0stl_phys(CPU(cpu)->as,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base + pte_offset + H=
ASH_PTE_SIZE_32 / 2,
> > pte1);
> > +=A0=A0=A0=A0stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_3=
2 / 2,
> > pte1);
> > =A0}
> > =A0
> > =A0typedef struct {
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index c59db47..bb87777 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -304,15 +304,13 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu,
> > target_ulong value,
> > =A0=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > =A0=A0=A0=A0=A0target_ulong htabsize =3D value & SDR_64_HTABSIZE;
> > =A0
> > -=A0=A0=A0=A0env->spr[SPR_SDR1] =3D value;
> > =A0=A0=A0=A0=A0if (htabsize > 28) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0error_setg(errp,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"Invalid HT=
ABSIZE 0x" TARGET_FMT_lx" stored in
> > SDR1",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0htabsize);
> > -=A0=A0=A0=A0=A0=A0=A0=A0htabsize =3D 28;
> > +=A0=A0=A0=A0=A0=A0=A0=A0return;
> > =A0=A0=A0=A0=A0}
> > -=A0=A0=A0=A0env->htab_mask =3D (1ULL << (htabsize + 18 - 7)) - 1;
> > -=A0=A0=A0=A0env->htab_base =3D value & SDR_64_HTABORG;
> > +=A0=A0=A0=A0env->spr[SPR_SDR1] =3D value;
> > =A0}
> > =A0
> > =A0void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int
> > shift,
> > @@ -333,10 +331,6 @@ void ppc_hash64_set_external_hpt(PowerPCCPU
> > *cpu, void *hpt, int shift,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > =A0=A0=A0=A0=A0}
> > =A0
> > -=A0=A0=A0=A0/* Not strictly necessary, but makes it clearer that an ex=
ternal
> > -=A0=A0=A0=A0=A0* htab is in use when debugging */
> > -=A0=A0=A0=A0env->htab_base =3D -1;
> > -
> > =A0=A0=A0=A0=A0if (kvm_enabled()) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0if (kvmppc_put_books_sregs(cpu) < 0) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_setg(errp, "Unable to upda=
te SDR1 in KVM");
> > @@ -448,11 +442,12 @@ const ppc_hash_pte64_t
> > *ppc_hash64_map_hptes(PowerPCCPU *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* HTAB is controlled by QEMU. Just point =
to the internally
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* accessible PTEG.
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > -=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D (ppc_hash_pte64_t *)(cpu->env.extern=
al_htab +
> > pte_offset);
> > -=A0=A0=A0=A0} else if (cpu->env.htab_base) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D (const ppc_hash_pte64_t *)(cpu->env.=
external_htab +
> > pte_offset);
> ^^^ Does this particular line belong in the previous patch?
> > +=A0=A0=A0=A0} else if (ppc_hash64_hpt_base(cpu)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0hwaddr base =3D ppc_hash64_hpt_base(cpu);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0hwaddr plen =3D n * HASH_PTE_SIZE_64;
> > -=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D address_space_map(CPU(cpu)->as, cpu-=
>env.htab_base +
> > pte_offset,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&plen, false);
> > +=A0=A0=A0=A0=A0=A0=A0=A0hptes =3D address_space_map(CPU(cpu)->as, base=
 + pte_offset,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&plen, false);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0if (plen < (n * HASH_PTE_SIZE_64)) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hw_error("%s: Unable to map all =
requested HPTEs\n",
> > __FUNCTION__);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > @@ -513,13 +508,12 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU
> > *cpu, hwaddr hash,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong ptem,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash_pte64_t *pte, unsigned
> > *pshift)
> > =A0{
> > -=A0=A0=A0=A0CPUPPCState *env =3D &cpu->env;
> > =A0=A0=A0=A0=A0int i;
> > =A0=A0=A0=A0=A0const ppc_hash_pte64_t *pteg;
> > =A0=A0=A0=A0=A0target_ulong pte0, pte1;
> > =A0=A0=A0=A0=A0target_ulong ptex;
> > =A0
> > -=A0=A0=A0=A0ptex =3D (hash & env->htab_mask) * HPTES_PER_GROUP;
> > +=A0=A0=A0=A0ptex =3D (hash & ppc_hash64_hpt_mask(cpu)) * HPTES_PER_GRO=
UP;
> > =A0=A0=A0=A0=A0pteg =3D ppc_hash64_map_hptes(cpu, ptex, HPTES_PER_GROUP=
);
> > =A0=A0=A0=A0=A0if (!pteg) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> > @@ -597,14 +591,15 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU
> > *cpu,
> > =A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"htab_base " TARGET_FMT_plx " ht=
ab_mask " TARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash " TARGET_FMT_plx "\n",
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base, env->htab_mask, ha=
sh);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_hpt_base(cpu), ppc_hash=
64_hpt_mask(cpu),
> > hash);
> > =A0
> > =A0=A0=A0=A0=A0/* Primary PTEG lookup */
> > =A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"0 htab=3D" TARGET_FMT_plx "/" T=
ARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" vsid=3D" TARGET_FMT_lx " ptem=
=3D" TARGET_FMT_lx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash=3D" TARGET_FMT_plx "\n",
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base, env->htab_mask, vs=
id, ptem,=A0=A0hash);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_hpt_base(cpu), ppc_hash=
64_hpt_mask(cpu),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0vsid, ptem,=A0=A0hash);
> > =A0=A0=A0=A0=A0ptex =3D ppc_hash64_pteg_search(cpu, hash, sps, ptem, pt=
e,
> > pshift);
> > =A0
> > =A0=A0=A0=A0=A0if (ptex =3D=3D -1) {
> > @@ -613,8 +608,8 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU
> > *cpu,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"1 htab=3D" TARGET_F=
MT_plx "/" TARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" vsid=3D" TARGET_FM=
T_lx " api=3D" TARGET_FMT_lx
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash=3D" TARGET_FMT_=
plx "\n", env->htab_base,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_mask, vsid, =
ptem, ~hash);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash=3D" TARGET_FMT_=
plx "\n",
> > ppc_hash64_hpt_base(cpu),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash64_hpt_mask(cp=
u), vsid, ptem, ~hash);
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0ptex =3D ppc_hash64_pteg_search(cpu, ~hash, =
sps, ptem, pte,
> > pshift);
> > =A0=A0=A0=A0=A0}
> > @@ -932,9 +927,9 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu,
> > hwaddr ptex,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0stq_p(env->external_htab + offset, pte0);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0stq_p(env->external_htab + offset + HASH_PTE=
_SIZE_64 / 2,
> > pte1);
> > =A0=A0=A0=A0=A0} else {
> > -=A0=A0=A0=A0=A0=A0=A0=A0stq_phys(CPU(cpu)->as, env->htab_base + offset=
, pte0);
> > -=A0=A0=A0=A0=A0=A0=A0=A0stq_phys(CPU(cpu)->as,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base + of=
fset + HASH_PTE_SIZE_64 / 2,
> > pte1);
> > +=A0=A0=A0=A0=A0=A0=A0=A0hwaddr base =3D ppc_hash64_hpt_base(cpu);
> > +=A0=A0=A0=A0=A0=A0=A0=A0stq_phys(CPU(cpu)->as, base + offset, pte0);
> > +=A0=A0=A0=A0=A0=A0=A0=A0stq_phys(CPU(cpu)->as, base + offset + HASH_PT=
E_SIZE_64 / 2,
> > pte1);
> > =A0=A0=A0=A0=A0}
> > =A0}
> > =A0
> > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > index 8637fe4..dc0bc99 100644
> > --- a/target/ppc/mmu-hash64.h
> > +++ b/target/ppc/mmu-hash64.h
> > @@ -56,6 +56,9 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> > =A0 * Hash page table definitions
> > =A0 */
> > =A0
> > +#define=A0SDR_64_HTABORG=A0=A0=A0=A0=A0=A0=A0=A0=A00xFFFFFFFFFFFC0000U=
LL
>=20
> I think this was just always wrong, but it should be
> 0x0FFFFFFFFFFC0000ULL
> =A0 ^

Ah, good point.  I'll prepend a bugfix for that.

> > +#define SDR_64_HTABSIZE=A0=A0=A0=A0=A0=A0=A0=A00x000000000000001FULL
> > +
> > =A0#define HPTES_PER_GROUP=A0=A0=A0=A0=A0=A0=A0=A0=A08
> > =A0#define HASH_PTE_SIZE_64=A0=A0=A0=A0=A0=A0=A0=A016
> > =A0#define HASH_PTEG_SIZE_64=A0=A0=A0=A0=A0=A0=A0(HASH_PTE_SIZE_64 * HP=
TES_PER_GROUP)
> > @@ -91,6 +94,16 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> > =A0#define HPTE64_V_1TB_SEG=A0=A0=A0=A0=A0=A0=A0=A00x4000000000000000ULL
> > =A0#define HPTE64_V_VRMA_MASK=A0=A0=A0=A0=A0=A00x4001ffffff000000ULL
> > =A0
> > +static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
> > +{
> > +=A0=A0=A0=A0return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
> > +}
> > +
> > +static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
> > +{
> > +=A0=A0=A0=A0return (1ULL << ((cpu->env.spr[SPR_SDR1] & SDR_64_HTABSIZE=
) + 18
> > - 7)) - 1;
> > +}
> > +
> > =A0void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0Error **errp);
> > =A0void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int
> > shift,
> > diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> > index eb2d482..1381635 100644
> > --- a/target/ppc/mmu_helper.c
> > +++ b/target/ppc/mmu_helper.c
> > @@ -466,6 +466,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env,
> > mmu_ctx_t *ctx,
> > =A0static inline int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t
> > *ctx,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong eaddr, int rw,
> > int type)
> > =A0{
> > +=A0=A0=A0=A0PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > =A0=A0=A0=A0=A0hwaddr hash;
> > =A0=A0=A0=A0=A0target_ulong vsid;
> > =A0=A0=A0=A0=A0int ds, pr, target_page_bits;
> > @@ -503,7 +504,7 @@ static inline int get_segment_6xx_tlb(CPUPPCState
> > *env, mmu_ctx_t *ctx,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU, "htab=
_base " TARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" htab_m=
ask " TARGET_FMT_plx
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" hash "=
 TARGET_FMT_plx "\n",
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->htab_=
base, env->htab_mask, hash);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_hash32=
_hpt_base(cpu),
> > ppc_hash32_hpt_mask(cpu), hash);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ctx->hash[0] =3D hash;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ctx->hash[1] =3D ~hash;
> > =A0
> > @@ -518,9 +519,11 @@ static inline int
> > get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0uint32_t a0, a1, a2,=
 a3;
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_log("Page table=
: " TARGET_FMT_plx " len "
> > TARGET_FMT_plx
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0"\n", env->htab_base, env->htab_mask +
> > 0x80);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for (curaddr =3D env->=
htab_base;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0curaddr=
 < (env->htab_base + env->htab_mask +
> > 0x80);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0"\n", ppc_hash32_hpt_base(cpu),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0ppc_hash32_hpt_mask(env) + 0x80);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for (curaddr =3D ppc_h=
ash32_hpt_base(cpu);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0curaddr=
 < (ppc_hash32_hpt_base(cpu)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0+ ppc_hash32_hpt_mask(cpu) + 0x80);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0curad=
dr +=3D 16) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0a0 =3D l=
dl_phys(cs->as, curaddr);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0a1 =3D l=
dl_phys(cs->as, curaddr + 4);
> > @@ -1205,12 +1208,13 @@ static void mmu6xx_dump_BATs(FILE *f,
> > fprintf_function cpu_fprintf,
> > =A0static void mmu6xx_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0CPUPPCState *env)
> > =A0{
> > +=A0=A0=A0=A0PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > =A0=A0=A0=A0=A0ppc6xx_tlb_t *tlb;
> > =A0=A0=A0=A0=A0target_ulong sr;
> > =A0=A0=A0=A0=A0int type, way, entry, i;
> > =A0
> > -=A0=A0=A0=A0cpu_fprintf(f, "HTAB base =3D 0x%"HWADDR_PRIx"\n", env-
> > >htab_base);
> > -=A0=A0=A0=A0cpu_fprintf(f, "HTAB mask =3D 0x%"HWADDR_PRIx"\n", env-
> > >htab_mask);
> > +=A0=A0=A0=A0cpu_fprintf(f, "HTAB base =3D 0x%"HWADDR_PRIx"\n",
> > ppc_hash32_hpt_base(cpu));
> > +=A0=A0=A0=A0cpu_fprintf(f, "HTAB mask =3D 0x%"HWADDR_PRIx"\n",
> > ppc_hash32_hpt_mask(cpu));
> > =A0
> > =A0=A0=A0=A0=A0cpu_fprintf(f, "\nSegment registers:\n");
> > =A0=A0=A0=A0=A0for (i =3D 0; i < 32; i++) {
> > @@ -1592,9 +1596,9 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState
> > *env, target_ulong address,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->spr=
[SPR_DCMP] =3D 0x80000000 | ctx.ptem;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tlb_miss:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->err=
or_code |=3D ctx.key << 19;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->spr[S=
PR_HASH1] =3D env->htab_base +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->spr[S=
PR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0get_pteg_offset32(cpu, ctx.hash[0]);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->spr[S=
PR_HASH2] =3D env->htab_base +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0env->spr[S=
PR_HASH2] =3D ppc_hash32_hpt_base(cpu) +
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0get_pteg_offset32(cpu, ctx.hash[1]);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case POWERPC_MMU_SOF=
T_74xx:
> > @@ -1999,7 +2003,6 @@ void ppc_store_sdr1(CPUPPCState *env,
> > target_ulong value)
> > =A0{
> > =A0=A0=A0=A0=A0qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __=
func__,
> > value);
> > =A0=A0=A0=A0=A0assert(!env->external_htab);
> > -=A0=A0=A0=A0env->spr[SPR_SDR1] =3D value;
> > =A0#if defined(TARGET_PPC64)
> > =A0=A0=A0=A0=A0if (env->mmu_model & POWERPC_MMU_64) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > @@ -2009,14 +2012,12 @@ void ppc_store_sdr1(CPUPPCState *env,
> > target_ulong value)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0if (local_err) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_report_err(local_err);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_free(local_err);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > -=A0=A0=A0=A0} else
> > -#endif /* defined(TARGET_PPC64) */
> > -=A0=A0=A0=A0{
> > -=A0=A0=A0=A0=A0=A0=A0=A0/* FIXME: Should check for valid HTABMASK valu=
es */
> > -=A0=A0=A0=A0=A0=A0=A0=A0env->htab_mask =3D ((value & SDR_32_HTABMASK) =
<< 16) | 0xFFFF;
> > -=A0=A0=A0=A0=A0=A0=A0=A0env->htab_base =3D value & SDR_32_HTABORG;
> > =A0=A0=A0=A0=A0}
> > +#endif /* defined(TARGET_PPC64) */
> > +=A0=A0=A0=A0/* FIXME: Should check for valid HTABMASK values in 32-bit=
 case
> > */
> > +=A0=A0=A0=A0env->spr[SPR_SDR1] =3D value;
> > =A0}
> > =A0
> > =A0/* Segment registers load and store */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wlFCko3yyTbBmKK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr6xyAAoJEGw4ysog2bOSF44QAOTbnPETe0Xdu1+dnIeSx66U
TnV9YjUI2XLAMxIkG9Bsjs/pYGLffU3wyjKwt2fV8JhBaIOBB9mv67nN3yo7acSw
t+nuMa3FLDvVx6mdG3WfOvatfIp6fnr1/K8QyVtVDuHQnP5NKt6u/wawA1H7mwlp
V/ZqZiUnYqGsAV8f5szFNsUi20nhv+CNNKxvVd07AmDoku0/NAWUOZerTrWSQppv
i2qpRb/TZb6G4mGrFPjyKE3HwzTrEzzTjsG6zOc5pZ7Z6mP/DIrtqTaJwG1+GcXR
noG9tbMDKRBgDXriXCw22Idn3vUNCRxEnDq2ueu1kddLPscTDaC+HFuEUic8zV5I
Gz+0uNakVO0WVBLppRVyXmuAIgAie9IJWylH1jwty8SyyTeVu27htbYGLopIC+Ay
3qy8Cw5K0dMSxgEVf7SFMfuzxdmY/WhSTLOIE2jf6xlXCLxDUX6gOE2N7blFcntE
H/EWoq5OF8gcDQTm8ALdkSNUri2gqqKaHutEXdN2lJPm6qTO1I9vghWPdbqAeuyz
Cc4FB5WRqLgRiQxsMt+pI4NTan5U/a6MU41Q2UxWef0biYkeMeF6x/+8/HpoCgzC
nJIzqD1SeK8I13Q9FfjP7ga1RuFa5yZNlsw+SF8XNBNjKehNdvB0WpL6/er69ZGH
GfIecZeJQ2zTVyu6GMTA
=AyUC
-----END PGP SIGNATURE-----

--wlFCko3yyTbBmKK8--
