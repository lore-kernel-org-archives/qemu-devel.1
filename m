Received: from eggs.gnu.org ([2001:4830:134:3::10]:60273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4Fr5-0004Xj-F4
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4Fr3-0005Co-7Z
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:07:51 -0400
Date: Fri, 6 Apr 2018 10:49:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180406004904.GA3212@umbus.fritz.box>
References: <20180405021437.16761-1-david@gibson.dropbear.id.au>
	<20180405021437.16761-14-david@gibson.dropbear.id.au>
	<20180405151255.63da677e@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20180405151255.63da677e@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.13 13/13] target/ppc: Fold slb_nr
 into PPCHash64Options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 03:12:55PM +0200, Greg Kurz wrote:
> On Thu,  5 Apr 2018 12:14:37 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > The env->slb_nr field gives the size of the SLB (Segment Lookaside Buff=
er).
> > This is another static-after-initialization parameter of the specific
> > version of the 64-bit hash MMU in the CPU.  So, this patch folds the fi=
eld
> > into PPCHash64Options with the other hash MMU options.
> >=20
> > This is a bit more complicated that the things previously put in there,
> > because slb_nr was foolishly included in the migration stream.  So we n=
eed
> > some of the usual dance to handle backwards compatible migration.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/pnv.c                |  2 +-
> >  hw/ppc/spapr.c              | 11 ++++++++---
> >  target/ppc/cpu.h            |  3 ++-
> >  target/ppc/kvm.c            |  2 +-
> >  target/ppc/machine.c        | 23 ++++++++++++++++++++---
> >  target/ppc/mmu-hash64.c     | 15 +++++++++------
> >  target/ppc/mmu-hash64.h     |  1 +
> >  target/ppc/translate_init.c | 15 ---------------
> >  8 files changed, 42 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 5905be3f71..53f672afa8 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -180,7 +180,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
> > =20
> >      _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq))=
);
> >      _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
> > -    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", env->slb_nr)));
> > +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_op=
ts->slb_size)));
> >      _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
> >      _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> > =20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 60bc8417b6..6021631722 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -547,8 +547,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, voi=
d *fdt, int offset,
> > =20
> >      _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq))=
);
> >      _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
> > -    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", env->slb_nr)));
> > -    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", env->slb_nr)));
> > +    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", cpu->hash64_opts->=
slb_size)));
> > +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_op=
ts->slb_size)));
> >      _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
> >      _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> > =20
> > @@ -4000,7 +4000,12 @@ DEFINE_SPAPR_MACHINE(2_13, "2.13", true);
> >   * pseries-2.12
> >   */
> >  #define SPAPR_COMPAT_2_12                                             =
 \
> > -    HW_COMPAT_2_12
>=20
> This hunk doesn't apply on master, nor on your ppc-for-2.13 branch...

Uh.. I think you need to pull the ppc-for-2.13 brnch again, then..

> It looks like a patch to introduce the 2.13 machine type is missing.

=2E.since I added a patch to do exactly that.

> FWIW, Connie has already queued a patch to do so for s390x, that also
> introduces HW_COMPAT_2_12.
>=20
> https://github.com/cohuck/qemu/commit/b54cde7350b6681b4349b904e0f9a8a8d58=
c0951
>=20
> Maybe the HW_COMPAT_ macros should be added in a standalone patch ?
>=20
> Cc'ing Connie for insights.
>=20
> > +    HW_COMPAT_2_12                                                    =
 \
> > +    {                                                                 =
 \
> > +        .driver =3D TYPE_POWERPC_CPU,                                 =
   \
> > +            .property =3D "pre-2.13-migration",                       =
   \
> > +            .value    =3D "on",                                       =
   \
>=20
> indentation ?

Oops, adjusted.

>=20
> Also, this property must be added to the TYPE_POWERPC_CPU class.
>=20
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10471,6 +10471,8 @@ static Property ppc_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration,=
 false),
>      DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migratio=
n,
>                       false),
> +    DEFINE_PROP_BOOL("pre-2.13-migration", PowerPCCPU, pre_2_13_migratio=
n,
> +                     false),
>      DEFINE_PROP_END_OF_LIST(),
>  };

Oops again, adjusted.

> Appart from that, the patch looks good, so:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> With all the above points addressed, I could successfully migrate from an
> older QEMU and back, so:
>=20
> Tested-by: Greg Kurz <groug@kaod.org>
>=20
> > +    },
> > =20
> >  static void spapr_machine_2_12_instance_options(MachineState *machine)
> >  {
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index c0c44fb91d..8c9e03f54d 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1025,7 +1025,6 @@ struct CPUPPCState {
> >  #if defined(TARGET_PPC64)
> >      /* PowerPC 64 SLB area */
> >      ppc_slb_t slb[MAX_SLB_ENTRIES];
> > -    int32_t slb_nr;
> >      /* tcg TLB needs flush (deferred slb inval instruction typically) =
*/
> >  #endif
> >      /* segment registers */
> > @@ -1216,6 +1215,8 @@ struct PowerPCCPU {
> >      uint64_t mig_insns_flags2;
> >      uint32_t mig_nb_BATs;
> >      bool pre_2_10_migration;
> > +    bool pre_2_13_migration;
> > +    int32_t mig_slb_nr;
> >  };
> > =20
> >  static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index b329cd8173..1bd38c6a90 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -484,7 +484,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> >              break;
> >          }
> >      }
> > -    env->slb_nr =3D smmu_info.slb_size;
> > +    cpu->hash64_opts->slb_size =3D smmu_info.slb_size;
> >      if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> >          cpu->hash64_opts->flags &=3D ~PPC_HASH64_1TSEG;
> >      }
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 0634cdb295..3d6434a006 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -18,6 +18,9 @@ static int cpu_load_old(QEMUFile *f, void *opaque, in=
t version_id)
> >      unsigned int i, j;
> >      target_ulong sdr1;
> >      uint32_t fpscr;
> > +#if defined(TARGET_PPC64)
> > +    int32_t slb_nr;
> > +#endif
> >      target_ulong xer;
> > =20
> >      for (i =3D 0; i < 32; i++)
> > @@ -49,7 +52,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, in=
t version_id)
> >      qemu_get_sbe32s(f, &env->access_type);
> >  #if defined(TARGET_PPC64)
> >      qemu_get_betls(f, &env->spr[SPR_ASR]);
> > -    qemu_get_sbe32s(f, &env->slb_nr);
> > +    qemu_get_sbe32s(f, &slb_nr);
> >  #endif
> >      qemu_get_betls(f, &sdr1);
> >      for (i =3D 0; i < 32; i++)
> > @@ -146,6 +149,15 @@ static bool cpu_pre_2_8_migration(void *opaque, in=
t version_id)
> >      return cpu->pre_2_8_migration;
> >  }
> > =20
> > +#if defined(TARGET_PPC64)
> > +static bool cpu_pre_2_13_migration(void *opaque, int version_id)
> > +{
> > +    PowerPCCPU *cpu =3D opaque;
> > +
> > +    return cpu->pre_2_13_migration;
> > +}
> > +#endif
> > +
> >  static int cpu_pre_save(void *opaque)
> >  {
> >      PowerPCCPU *cpu =3D opaque;
> > @@ -203,6 +215,11 @@ static int cpu_pre_save(void *opaque)
> >          cpu->mig_insns_flags2 =3D env->insns_flags2 & insns_compat_mas=
k2;
> >          cpu->mig_nb_BATs =3D env->nb_BATs;
> >      }
> > +    if (cpu->pre_2_13_migration) {
> > +        if (cpu->hash64_opts) {
> > +            cpu->mig_slb_nr =3D cpu->hash64_opts->slb_size;
> > +        }
> > +    }
> > =20
> >      return 0;
> >  }
> > @@ -478,7 +495,7 @@ static int slb_post_load(void *opaque, int version_=
id)
> > =20
> >      /* We've pulled in the raw esid and vsid values from the migration
> >       * stream, but we need to recompute the page size pointers */
> > -    for (i =3D 0; i < env->slb_nr; i++) {
> > +    for (i =3D 0; i < cpu->hash64_opts->slb_size; i++) {
> >          if (ppc_store_slb(cpu, i, env->slb[i].esid, env->slb[i].vsid) =
< 0) {
> >              /* Migration source had bad values in its SLB */
> >              return -1;
> > @@ -495,7 +512,7 @@ static const VMStateDescription vmstate_slb =3D {
> >      .needed =3D slb_needed,
> >      .post_load =3D slb_post_load,
> >      .fields =3D (VMStateField[]) {
> > -        VMSTATE_INT32_EQUAL(env.slb_nr, PowerPCCPU, NULL),
> > +        VMSTATE_INT32_TEST(mig_slb_nr, PowerPCCPU, cpu_pre_2_13_migrat=
ion),
> >          VMSTATE_SLB_ARRAY(env.slb, PowerPCCPU, MAX_SLB_ENTRIES),
> >          VMSTATE_END_OF_LIST()
> >      }
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index a5570c8774..7e0adecfd9 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -52,7 +52,7 @@ static ppc_slb_t *slb_lookup(PowerPCCPU *cpu, target_=
ulong eaddr)
> >      esid_256M =3D (eaddr & SEGMENT_MASK_256M) | SLB_ESID_V;
> >      esid_1T =3D (eaddr & SEGMENT_MASK_1T) | SLB_ESID_V;
> > =20
> > -    for (n =3D 0; n < env->slb_nr; n++) {
> > +    for (n =3D 0; n < cpu->hash64_opts->slb_size; n++) {
> >          ppc_slb_t *slb =3D &env->slb[n];
> > =20
> >          LOG_SLB("%s: slot %d %016" PRIx64 " %016"
> > @@ -80,7 +80,7 @@ void dump_slb(FILE *f, fprintf_function cpu_fprintf, =
PowerPCCPU *cpu)
> >      cpu_synchronize_state(CPU(cpu));
> > =20
> >      cpu_fprintf(f, "SLB\tESID\t\t\tVSID\n");
> > -    for (i =3D 0; i < env->slb_nr; i++) {
> > +    for (i =3D 0; i < cpu->hash64_opts->slb_size; i++) {
> >          slbe =3D env->slb[i].esid;
> >          slbv =3D env->slb[i].vsid;
> >          if (slbe =3D=3D 0 && slbv =3D=3D 0) {
> > @@ -93,10 +93,11 @@ void dump_slb(FILE *f, fprintf_function cpu_fprintf=
, PowerPCCPU *cpu)
> > =20
> >  void helper_slbia(CPUPPCState *env)
> >  {
> > +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> >      int n;
> > =20
> >      /* XXX: Warning: slbia never invalidates the first segment */
> > -    for (n =3D 1; n < env->slb_nr; n++) {
> > +    for (n =3D 1; n < cpu->hash64_opts->slb_size; n++) {
> >          ppc_slb_t *slb =3D &env->slb[n];
> > =20
> >          if (slb->esid & SLB_ESID_V) {
> > @@ -151,7 +152,7 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slo=
t,
> >      const PPCHash64SegmentPageSizes *sps =3D NULL;
> >      int i;
> > =20
> > -    if (slot >=3D env->slb_nr) {
> > +    if (slot >=3D cpu->hash64_opts->slb_size) {
> >          return -1; /* Bad slot number */
> >      }
> >      if (esid & ~(SLB_ESID_ESID | SLB_ESID_V)) {
> > @@ -202,7 +203,7 @@ static int ppc_load_slb_esid(PowerPCCPU *cpu, targe=
t_ulong rb,
> >      int slot =3D rb & 0xfff;
> >      ppc_slb_t *slb =3D &env->slb[slot];
> > =20
> > -    if (slot >=3D env->slb_nr) {
> > +    if (slot >=3D cpu->hash64_opts->slb_size) {
> >          return -1;
> >      }
> > =20
> > @@ -217,7 +218,7 @@ static int ppc_load_slb_vsid(PowerPCCPU *cpu, targe=
t_ulong rb,
> >      int slot =3D rb & 0xfff;
> >      ppc_slb_t *slb =3D &env->slb[slot];
> > =20
> > -    if (slot >=3D env->slb_nr) {
> > +    if (slot >=3D cpu->hash64_opts->slb_size) {
> >          return -1;
> >      }
> > =20
> > @@ -1115,6 +1116,7 @@ void ppc_hash64_finalize(PowerPCCPU *cpu)
> > =20
> >  const PPCHash64Options ppc_hash64_opts_basic =3D {
> >      .flags =3D 0,
> > +    .slb_size =3D 64,
> >      .sps =3D {
> >          { .page_shift =3D 12, /* 4K */
> >            .slb_enc =3D 0,
> > @@ -1129,6 +1131,7 @@ const PPCHash64Options ppc_hash64_opts_basic =3D {
> > =20
> >  const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
> >      .flags =3D PPC_HASH64_1TSEG | PPC_HASH64_AMR | PPC_HASH64_CI_LARGE=
PAGE,
> > +    .slb_size =3D 32,
> >      .sps =3D {
> >          {
> >              .page_shift =3D 12, /* 4K */
> > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > index f1babb0afc..d5fc03441d 100644
> > --- a/target/ppc/mmu-hash64.h
> > +++ b/target/ppc/mmu-hash64.h
> > @@ -157,6 +157,7 @@ struct PPCHash64Options {
> >  #define PPC_HASH64_AMR          0x00002
> >  #define PPC_HASH64_CI_LARGEPAGE 0x00004
> >      unsigned flags;
> > +    unsigned slb_size;
> >      PPCHash64SegmentPageSizes sps[PPC_PAGE_SIZES_MAX_SZ];
> >  };
> > =20
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index a925cf5cd3..2f63acd310 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -8195,9 +8195,6 @@ static void init_proc_970(CPUPPCState *env)
> >      gen_spr_970_dbg(env);
> > =20
> >      /* env variables */
> > -#if !defined(CONFIG_USER_ONLY)
> > -    env->slb_nr =3D 64;
> > -#endif
> >      env->dcache_line_size =3D 128;
> >      env->icache_line_size =3D 128;
> > =20
> > @@ -8272,9 +8269,6 @@ static void init_proc_power5plus(CPUPPCState *env)
> >      gen_spr_power5p_ear(env);
> > =20
> >      /* env variables */
> > -#if !defined(CONFIG_USER_ONLY)
> > -    env->slb_nr =3D 64;
> > -#endif
> >      env->dcache_line_size =3D 128;
> >      env->icache_line_size =3D 128;
> > =20
> > @@ -8389,9 +8383,6 @@ static void init_proc_POWER7(CPUPPCState *env)
> >      gen_spr_power7_book4(env);
> > =20
> >      /* env variables */
> > -#if !defined(CONFIG_USER_ONLY)
> > -    env->slb_nr =3D 32;
> > -#endif
> >      env->dcache_line_size =3D 128;
> >      env->icache_line_size =3D 128;
> > =20
> > @@ -8543,9 +8534,6 @@ static void init_proc_POWER8(CPUPPCState *env)
> >      gen_spr_power8_rpr(env);
> > =20
> >      /* env variables */
> > -#if !defined(CONFIG_USER_ONLY)
> > -    env->slb_nr =3D 32;
> > -#endif
> >      env->dcache_line_size =3D 128;
> >      env->icache_line_size =3D 128;
> > =20
> > @@ -8743,9 +8731,6 @@ static void init_proc_POWER9(CPUPPCState *env)
> >                          KVM_REG_PPC_PSSCR, 0);
> > =20
> >      /* env variables */
> > -#if !defined(CONFIG_USER_ONLY)
> > -    env->slb_nr =3D 32;
> > -#endif
> >      env->dcache_line_size =3D 128;
> >      env->icache_line_size =3D 128;
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrGw/0ACgkQbDjKyiDZ
s5LDjA/+JnuPizu4mnzb694sVduvv8X1g6MRcWOD9jVL9hHmnaB99Zlq8YaApDUh
j2TTRh2XH+T7GrHAtN9uIiSZdENcaBa9q1xm/lAPzATAmqWSj00XGxAF5NZqWGBb
YsnuKwdZuQHllM4/9xRhCLM1SnJOuJaD5usQgtIlu/tAti8+EmShBuDf2Un+j/Ek
ZSNmb8RB1zhN6+i20DjMHrO+E4xgkQmoHF8TliS6ydJB9VNRfQKESk42GZ9Tn8QM
mULYV+3WxREgsC0MTwof2+4QSttzxvtBD1F5Ok2E1z2Xlhs4aq/XeQn7boGo2xte
NtUaRjTBJq/Wc2OV0XPHYVgBEk2DchcJNQKF/2Uo8J1SFkfOQoWpOftKQVja1v+a
kmofh14ugz0PE9YEsEBSBhF4ctyIXCbiMHGtaAiDFaqPrdYv4677Wspc/VZFCveG
yexxI7bt/nEiclYwhW/PDg4CCd8vkp/s6+KHFkc/5D0fYAACuV2g1cH6T/JoxNjT
Hph4Zs0f2SXPeIgKPfPfGFaEe+e7wa3uQyTHmHTvua4lNDVeelD+KKr7kOFH9llx
/luBpP4MKOgp0zwAdYErF8WdeWoZ4gSUT8VONm9pcEv0C864t08ZW3t27Dl2Ys70
UNb11Qbv/Rh2Ef8OjwVx8VeqnRsoNQEdr4/JOxY8zbsZYHNyvhk=
=2Gqx
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
