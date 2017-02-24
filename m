Received: from eggs.gnu.org ([2001:4830:134:3::10]:40152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1chBHx-0000ox-8C
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1chBHu-0000Px-DY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:31:41 -0500
Date: Fri, 24 Feb 2017 16:30:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224053026.GC17615@umbus.fritz.box>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-6-david@gibson.dropbear.id.au>
	<c7a43a61-3e0a-e3be-bcab-fa1fe04ef40c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6dGMKdYe2Ft9UtxE"
Content-Disposition: inline
In-Reply-To: <c7a43a61-3e0a-e3be-bcab-fa1fe04ef40c@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org


--6dGMKdYe2Ft9UtxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 04:43:05PM +1100, Alexey Kardashevskiy wrote:
> On 23/02/17 13:09, David Gibson wrote:
> > CPUPPCState includes fields htab_base and htab_mask which store the base
> > address (GPA) and size (as a mask) of the guest's hashed page table (HP=
T).
> > These are set when the SDR1 register is updated.
> >=20
> > Keeping these in sync with the SDR1 is actually a little bit fiddly, and
> > probably not useful for performance, since keeping them expands the siz=
e of
> > CPUPPCState.  It also makes some upcoming changes harder to implement.
> >=20
> > This patch removes these fields, in favour of calculating them directly
> > from the SDR1 contents when necessary.
> >=20
> > This does make a change to the behaviour of attempting to write a bad v=
alue
> > (invalid HPT size) to the SDR1 with an mtspr instruction.  Previously, =
the
> > bad value would be stored in SDR1 and could be retrieved with a later
> > mfspr, but the HPT size as used by the softmmu would be, clamped to the
> > allowed values.  Now, writing a bad value is treated as a no-op.  An er=
ror
> > message is printed in both new and old versions.
> >=20
> > I'm not sure which behaviour, if either, matches real hardware.  I don't
> > think it matters that much, since it's pretty clear that if an OS writes
> > a bad value to SDR1, it's not going to boot.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_hcall.c    |  4 ++--
> >  target/ppc/cpu.h        |  8 --------
> >  target/ppc/machine.c    |  1 -
> >  target/ppc/mmu-hash32.c | 14 +++++++-------
> >  target/ppc/mmu-hash32.h | 24 ++++++++++++++++++------
> >  target/ppc/mmu-hash64.c | 37 ++++++++++++++++---------------------
> >  target/ppc/mmu-hash64.h | 13 +++++++++++++
> >  target/ppc/mmu_helper.c | 31 ++++++++++++++++---------------
> >  8 files changed, 72 insertions(+), 60 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index fd961b5..85d96f6 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -50,9 +50,9 @@ static bool has_spr(PowerPCCPU *cpu, int spr)
> >  static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
> >  {
> >      /*
> > -     * hash value/pteg group index is normalized by htab_mask
> > +     * hash value/pteg group index is normalized by HPT mask
> >       */
> > -    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~cpu->env.htab_mask) {
> > +    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~ppc_hash64_hpt_mask(cpu)=
) {
> >          return false;
> >      }
> >      return true;
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index c89973e..c6cd9ab 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -309,11 +309,6 @@ union ppc_tlb_t {
> >  #define SDR_32_HTABORG         0xFFFF0000UL
> >  #define SDR_32_HTABMASK        0x000001FFUL
>=20
>=20
> You could move these to target/ppc/mmu-hash32.h as well.

Good idea, done.

> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
>=20
>=20
>=20
> > =20
> > -#if defined(TARGET_PPC64)
> > -#define SDR_64_HTABORG         0xFFFFFFFFFFFC0000ULL
> > -#define SDR_64_HTABSIZE        0x000000000000001FULL
> > -#endif /* defined(TARGET_PPC64 */
> > -
> >  typedef struct ppc_slb_t ppc_slb_t;
> >  struct ppc_slb_t {
> >      uint64_t esid;
> > @@ -1006,9 +1001,6 @@ struct CPUPPCState {
> >      /* tcg TLB needs flush (deferred slb inval instruction typically) =
*/
> >  #endif
> >      /* segment registers */
> > -    hwaddr htab_base;
> > -    /* mask used to normalize hash value to PTEG index */
> > -    hwaddr htab_mask;
> >      target_ulong sr[32];
> >      /* externally stored hash table */
> >      uint8_t *external_htab;
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index df9f7a4..1ccbc8a 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -229,7 +229,6 @@ static int cpu_post_load(void *opaque, int version_=
id)
> >      }
> > =20
> >      if (!env->external_htab) {
> > -        /* Restore htab_base and htab_mask variables */
> >          ppc_store_sdr1(env, env->spr[SPR_SDR1]);
> >      }
> > =20
> > diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> > index 29bace6..03ae3c1 100644
> > --- a/target/ppc/mmu-hash32.c
> > +++ b/target/ppc/mmu-hash32.c
> > @@ -304,9 +304,9 @@ static int ppc_hash32_direct_store(PowerPCCPU *cpu,=
 target_ulong sr,
> > =20
> >  hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
> >  {
> > -    CPUPPCState *env =3D &cpu->env;
> > +    target_ulong mask =3D ppc_hash32_hpt_mask(cpu);
> > =20
> > -    return (hash * HASH_PTEG_SIZE_32) & env->htab_mask;
> > +    return (hash * HASH_PTEG_SIZE_32) & mask;
> >  }
> > =20
> >  static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
> > @@ -339,7 +339,6 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cp=
u,
> >                                       target_ulong sr, target_ulong ead=
dr,
> >                                       ppc_hash_pte32_t *pte)
> >  {
> > -    CPUPPCState *env =3D &cpu->env;
> >      hwaddr pteg_off, pte_offset;
> >      hwaddr hash;
> >      uint32_t vsid, pgidx, ptem;
> > @@ -353,21 +352,22 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *=
cpu,
> >      qemu_log_mask(CPU_LOG_MMU, "htab_base " TARGET_FMT_plx
> >              " htab_mask " TARGET_FMT_plx
> >              " hash " TARGET_FMT_plx "\n",
> > -            env->htab_base, env->htab_mask, hash);
> > +            ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
> > =20
> >      /* Primary PTEG lookup */
> >      qemu_log_mask(CPU_LOG_MMU, "0 htab=3D" TARGET_FMT_plx "/" TARGET_F=
MT_plx
> >              " vsid=3D%" PRIx32 " ptem=3D%" PRIx32
> >              " hash=3D" TARGET_FMT_plx "\n",
> > -            env->htab_base, env->htab_mask, vsid, ptem, hash);
> > +            ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu),
> > +            vsid, ptem, hash);
> >      pteg_off =3D get_pteg_offset32(cpu, hash);
> >      pte_offset =3D ppc_hash32_pteg_search(cpu, pteg_off, 0, ptem, pte);
> >      if (pte_offset =3D=3D -1) {
> >          /* Secondary PTEG lookup */
> >          qemu_log_mask(CPU_LOG_MMU, "1 htab=3D" TARGET_FMT_plx "/" TARG=
ET_FMT_plx
> >                  " vsid=3D%" PRIx32 " api=3D%" PRIx32
> > -                " hash=3D" TARGET_FMT_plx "\n", env->htab_base,
> > -                env->htab_mask, vsid, ptem, ~hash);
> > +                " hash=3D" TARGET_FMT_plx "\n", ppc_hash32_hpt_base(cp=
u),
> > +                ppc_hash32_hpt_mask(cpu), vsid, ptem, ~hash);
> >          pteg_off =3D get_pteg_offset32(cpu, ~hash);
> >          pte_offset =3D ppc_hash32_pteg_search(cpu, pteg_off, 1, ptem, =
pte);
> >      }
> > diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> > index 5b9fb08..054be65 100644
> > --- a/target/ppc/mmu-hash32.h
> > +++ b/target/ppc/mmu-hash32.h
> > @@ -65,42 +65,54 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr address, int rw,
> >  #define HPTE32_R_WIMG           0x00000078
> >  #define HPTE32_R_PP             0x00000003
> > =20
> > +static inline hwaddr ppc_hash32_hpt_base(PowerPCCPU *cpu)
> > +{
> > +    return cpu->env.spr[SPR_SDR1] & SDR_32_HTABORG;
> > +}
> > +
> > +static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
> > +{
> > +    return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
> > +}
> > +
> >  static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
> >                                                   hwaddr pte_offset)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> > +    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> > =20
> >      assert(!env->external_htab); /* Not supported on 32-bit for now */
> > -    return ldl_phys(CPU(cpu)->as, env->htab_base + pte_offset);
> > +    return ldl_phys(CPU(cpu)->as, base + pte_offset);
> >  }
> > =20
> >  static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
> >                                                   hwaddr pte_offset)
> >  {
> > +    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> >      CPUPPCState *env =3D &cpu->env;
> > =20
> >      assert(!env->external_htab); /* Not supported on 32-bit for now */
> > -    return ldl_phys(CPU(cpu)->as,
> > -                    env->htab_base + pte_offset + HASH_PTE_SIZE_32 / 2=
);
> > +    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32=
 / 2);
> >  }
> > =20
> >  static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
> >                                            hwaddr pte_offset, target_ul=
ong pte0)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> > +    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> > =20
> >      assert(!env->external_htab); /* Not supported on 32-bit for now */
> > -    stl_phys(CPU(cpu)->as, env->htab_base + pte_offset, pte0);
> > +    stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
> >  }
> > =20
> >  static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
> >                                            hwaddr pte_offset, target_ul=
ong pte1)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> > +    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> > =20
> >      assert(!env->external_htab); /* Not supported on 32-bit for now */
> > -    stl_phys(CPU(cpu)->as,
> > -             env->htab_base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
> > +    stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, p=
te1);
> >  }
> > =20
> >  typedef struct {
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index c59db47..bb87777 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -304,15 +304,13 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_=
ulong value,
> >      CPUPPCState *env =3D &cpu->env;
> >      target_ulong htabsize =3D value & SDR_64_HTABSIZE;
> > =20
> > -    env->spr[SPR_SDR1] =3D value;
> >      if (htabsize > 28) {
> >          error_setg(errp,
> >                     "Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1=
",
> >                     htabsize);
> > -        htabsize =3D 28;
> > +        return;
> >      }
> > -    env->htab_mask =3D (1ULL << (htabsize + 18 - 7)) - 1;
> > -    env->htab_base =3D value & SDR_64_HTABORG;
> > +    env->spr[SPR_SDR1] =3D value;
> >  }
> > =20
> >  void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
> > @@ -333,10 +331,6 @@ void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, =
void *hpt, int shift,
> >          return;
> >      }
> > =20
> > -    /* Not strictly necessary, but makes it clearer that an external
> > -     * htab is in use when debugging */
> > -    env->htab_base =3D -1;
> > -
> >      if (kvm_enabled()) {
> >          if (kvmppc_put_books_sregs(cpu) < 0) {
> >              error_setg(errp, "Unable to update SDR1 in KVM");
> > @@ -448,11 +442,12 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(Powe=
rPCCPU *cpu,
> >           * HTAB is controlled by QEMU. Just point to the internally
> >           * accessible PTEG.
> >           */
> > -        hptes =3D (ppc_hash_pte64_t *)(cpu->env.external_htab + pte_of=
fset);
> > -    } else if (cpu->env.htab_base) {
> > +        hptes =3D (const ppc_hash_pte64_t *)(cpu->env.external_htab + =
pte_offset);
> > +    } else if (ppc_hash64_hpt_base(cpu)) {
> > +        hwaddr base =3D ppc_hash64_hpt_base(cpu);
> >          hwaddr plen =3D n * HASH_PTE_SIZE_64;
> > -        hptes =3D address_space_map(CPU(cpu)->as, cpu->env.htab_base +=
 pte_offset,
> > -                                 &plen, false);
> > +        hptes =3D address_space_map(CPU(cpu)->as, base + pte_offset,
> > +                                  &plen, false);
> >          if (plen < (n * HASH_PTE_SIZE_64)) {
> >              hw_error("%s: Unable to map all requested HPTEs\n", __FUNC=
TION__);
> >          }
> > @@ -513,13 +508,12 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *=
cpu, hwaddr hash,
> >                                       target_ulong ptem,
> >                                       ppc_hash_pte64_t *pte, unsigned *=
pshift)
> >  {
> > -    CPUPPCState *env =3D &cpu->env;
> >      int i;
> >      const ppc_hash_pte64_t *pteg;
> >      target_ulong pte0, pte1;
> >      target_ulong ptex;
> > =20
> > -    ptex =3D (hash & env->htab_mask) * HPTES_PER_GROUP;
> > +    ptex =3D (hash & ppc_hash64_hpt_mask(cpu)) * HPTES_PER_GROUP;
> >      pteg =3D ppc_hash64_map_hptes(cpu, ptex, HPTES_PER_GROUP);
> >      if (!pteg) {
> >          return -1;
> > @@ -597,14 +591,15 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *=
cpu,
> >      qemu_log_mask(CPU_LOG_MMU,
> >              "htab_base " TARGET_FMT_plx " htab_mask " TARGET_FMT_plx
> >              " hash " TARGET_FMT_plx "\n",
> > -            env->htab_base, env->htab_mask, hash);
> > +            ppc_hash64_hpt_base(cpu), ppc_hash64_hpt_mask(cpu), hash);
> > =20
> >      /* Primary PTEG lookup */
> >      qemu_log_mask(CPU_LOG_MMU,
> >              "0 htab=3D" TARGET_FMT_plx "/" TARGET_FMT_plx
> >              " vsid=3D" TARGET_FMT_lx " ptem=3D" TARGET_FMT_lx
> >              " hash=3D" TARGET_FMT_plx "\n",
> > -            env->htab_base, env->htab_mask, vsid, ptem,  hash);
> > +            ppc_hash64_hpt_base(cpu), ppc_hash64_hpt_mask(cpu),
> > +            vsid, ptem,  hash);
> >      ptex =3D ppc_hash64_pteg_search(cpu, hash, sps, ptem, pte, pshift);
> > =20
> >      if (ptex =3D=3D -1) {
> > @@ -613,8 +608,8 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *cp=
u,
> >          qemu_log_mask(CPU_LOG_MMU,
> >                  "1 htab=3D" TARGET_FMT_plx "/" TARGET_FMT_plx
> >                  " vsid=3D" TARGET_FMT_lx " api=3D" TARGET_FMT_lx
> > -                " hash=3D" TARGET_FMT_plx "\n", env->htab_base,
> > -                env->htab_mask, vsid, ptem, ~hash);
> > +                " hash=3D" TARGET_FMT_plx "\n", ppc_hash64_hpt_base(cp=
u),
> > +                ppc_hash64_hpt_mask(cpu), vsid, ptem, ~hash);
> > =20
> >          ptex =3D ppc_hash64_pteg_search(cpu, ~hash, sps, ptem, pte, ps=
hift);
> >      }
> > @@ -932,9 +927,9 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr =
ptex,
> >          stq_p(env->external_htab + offset, pte0);
> >          stq_p(env->external_htab + offset + HASH_PTE_SIZE_64 / 2, pte1=
);
> >      } else {
> > -        stq_phys(CPU(cpu)->as, env->htab_base + offset, pte0);
> > -        stq_phys(CPU(cpu)->as,
> > -                 env->htab_base + offset + HASH_PTE_SIZE_64 / 2, pte1);
> > +        hwaddr base =3D ppc_hash64_hpt_base(cpu);
> > +        stq_phys(CPU(cpu)->as, base + offset, pte0);
> > +        stq_phys(CPU(cpu)->as, base + offset + HASH_PTE_SIZE_64 / 2, p=
te1);
> >      }
> >  }
> > =20
> > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > index 8637fe4..dc0bc99 100644
> > --- a/target/ppc/mmu-hash64.h
> > +++ b/target/ppc/mmu-hash64.h
> > @@ -56,6 +56,9 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> >   * Hash page table definitions
> >   */
> > =20
> > +#define SDR_64_HTABORG         0xFFFFFFFFFFFC0000ULL
> > +#define SDR_64_HTABSIZE        0x000000000000001FULL
> > +
> >  #define HPTES_PER_GROUP         8
> >  #define HASH_PTE_SIZE_64        16
> >  #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)
> > @@ -91,6 +94,16 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> >  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
> >  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
> > =20
> > +static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
> > +{
> > +    return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
> > +}
> > +
> > +static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
> > +{
> > +    return (1ULL << ((cpu->env.spr[SPR_SDR1] & SDR_64_HTABSIZE) + 18 -=
 7)) - 1;
> > +}
> > +
> >  void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
> >                           Error **errp);
> >  void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
> > diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> > index eb2d482..1381635 100644
> > --- a/target/ppc/mmu_helper.c
> > +++ b/target/ppc/mmu_helper.c
> > @@ -466,6 +466,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
> >  static inline int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
> >                                        target_ulong eaddr, int rw, int =
type)
> >  {
> > +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> >      hwaddr hash;
> >      target_ulong vsid;
> >      int ds, pr, target_page_bits;
> > @@ -503,7 +504,7 @@ static inline int get_segment_6xx_tlb(CPUPPCState *=
env, mmu_ctx_t *ctx,
> >              qemu_log_mask(CPU_LOG_MMU, "htab_base " TARGET_FMT_plx
> >                      " htab_mask " TARGET_FMT_plx
> >                      " hash " TARGET_FMT_plx "\n",
> > -                    env->htab_base, env->htab_mask, hash);
> > +                    ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu)=
, hash);
> >              ctx->hash[0] =3D hash;
> >              ctx->hash[1] =3D ~hash;
> > =20
> > @@ -518,9 +519,11 @@ static inline int get_segment_6xx_tlb(CPUPPCState =
*env, mmu_ctx_t *ctx,
> >                  uint32_t a0, a1, a2, a3;
> > =20
> >                  qemu_log("Page table: " TARGET_FMT_plx " len " TARGET_=
FMT_plx
> > -                         "\n", env->htab_base, env->htab_mask + 0x80);
> > -                for (curaddr =3D env->htab_base;
> > -                     curaddr < (env->htab_base + env->htab_mask + 0x80=
);
> > +                         "\n", ppc_hash32_hpt_base(cpu),
> > +                         ppc_hash32_hpt_mask(env) + 0x80);
> > +                for (curaddr =3D ppc_hash32_hpt_base(cpu);
> > +                     curaddr < (ppc_hash32_hpt_base(cpu)
> > +                                + ppc_hash32_hpt_mask(cpu) + 0x80);
> >                       curaddr +=3D 16) {
> >                      a0 =3D ldl_phys(cs->as, curaddr);
> >                      a1 =3D ldl_phys(cs->as, curaddr + 4);
> > @@ -1205,12 +1208,13 @@ static void mmu6xx_dump_BATs(FILE *f, fprintf_f=
unction cpu_fprintf,
> >  static void mmu6xx_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
> >                              CPUPPCState *env)
> >  {
> > +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> >      ppc6xx_tlb_t *tlb;
> >      target_ulong sr;
> >      int type, way, entry, i;
> > =20
> > -    cpu_fprintf(f, "HTAB base =3D 0x%"HWADDR_PRIx"\n", env->htab_base);
> > -    cpu_fprintf(f, "HTAB mask =3D 0x%"HWADDR_PRIx"\n", env->htab_mask);
> > +    cpu_fprintf(f, "HTAB base =3D 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_=
base(cpu));
> > +    cpu_fprintf(f, "HTAB mask =3D 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_=
mask(cpu));
> > =20
> >      cpu_fprintf(f, "\nSegment registers:\n");
> >      for (i =3D 0; i < 32; i++) {
> > @@ -1592,9 +1596,9 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *=
env, target_ulong address,
> >                      env->spr[SPR_DCMP] =3D 0x80000000 | ctx.ptem;
> >                  tlb_miss:
> >                      env->error_code |=3D ctx.key << 19;
> > -                    env->spr[SPR_HASH1] =3D env->htab_base +
> > +                    env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
> >                          get_pteg_offset32(cpu, ctx.hash[0]);
> > -                    env->spr[SPR_HASH2] =3D env->htab_base +
> > +                    env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(cpu) +
> >                          get_pteg_offset32(cpu, ctx.hash[1]);
> >                      break;
> >                  case POWERPC_MMU_SOFT_74xx:
> > @@ -1999,7 +2003,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulon=
g value)
> >  {
> >      qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, va=
lue);
> >      assert(!env->external_htab);
> > -    env->spr[SPR_SDR1] =3D value;
> >  #if defined(TARGET_PPC64)
> >      if (env->mmu_model & POWERPC_MMU_64) {
> >          PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > @@ -2009,14 +2012,12 @@ void ppc_store_sdr1(CPUPPCState *env, target_ul=
ong value)
> >          if (local_err) {
> >              error_report_err(local_err);
> >              error_free(local_err);
> > +            return;
> >          }
> > -    } else
> > -#endif /* defined(TARGET_PPC64) */
> > -    {
> > -        /* FIXME: Should check for valid HTABMASK values */
> > -        env->htab_mask =3D ((value & SDR_32_HTABMASK) << 16) | 0xFFFF;
> > -        env->htab_base =3D value & SDR_32_HTABORG;
> >      }
> > +#endif /* defined(TARGET_PPC64) */
> > +    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
> > +    env->spr[SPR_SDR1] =3D value;
> >  }
> > =20
> >  /* Segment registers load and store */
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6dGMKdYe2Ft9UtxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr8TyAAoJEGw4ysog2bOSoIMP/0h926ZPbkyoy8lbA1t/dkKD
UmPRCFl0DMTAIZ18dSxuQPNfcKLvkBWZjfd8NC5CJglaOChpTZY/mu2c1KOhBi0c
xb9h6UeNJg8Ao7MfSQ4XIZMEM+d88Lr913X9OKcx3/Aqg942+r0A8aWtfTSicnYv
5VewPiVnXROnQDPQLXxroT+WagO9rqViX68Akjd+5zFthVQFquxbCIGRl4qmQPug
HDyM9Y1AFuA/DmjGU5ixdgyPwrnYaA7CtEQOdFadVn4sJyZSmF8AdRgCVxPaKbn7
UHYdxHTfVgyBHz3gbj1qD02E/TfbPD++MAWTGEq2wnxs4BxOGN+APkFULfktEQyw
XJU0yzssc6axt18obloXPwaOBabhj3JKSFLfekTonQ+s5qRxqhqAsDmO4TPji1rw
xri4iIBAW//Aj3D8UFMZeKjhotS+r6QJivtu2bnqPrV+gpfEuKK+1pegywugWUCT
Gl1tL0e9xiHxR18CklvInpvATBlcGFbgI2h3neLB9vR+42WDSz33xwvAR8z+3YsH
e4LBzpmJQ3i1xApnC933YvaDwYVoY0RzvK/hF7W3hj3f6H/Nnhj+E3mNAVvFetdi
SfG7QbYgqFd8LuVFLYKYZ4qdjT7/aV9Vr8U3sK1z562cSlRjb7TWymv7Wc2VJc5q
AnmgCxWUE2koZ93Yie8M
=AQ+P
-----END PGP SIGNATURE-----

--6dGMKdYe2Ft9UtxE--
