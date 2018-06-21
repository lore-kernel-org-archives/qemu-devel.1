Received: from eggs.gnu.org ([2001:4830:134:3::10]:46355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVyII-000738-PC
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVyID-0007WK-2i
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:02:30 -0400
Date: Thu, 21 Jun 2018 22:01:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621120125.GB2009@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-10-david@gibson.dropbear.id.au>
	<38a07f7b-caf1-944f-c8d5-1e35d57ae1b8@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <38a07f7b-caf1-944f-c8d5-1e35d57ae1b8@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 9/9] spapr: Don't rewrite mmu capabilities
 in KVM mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, abologna@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 09:53:10AM +0200, C=E9dric Le Goater wrote:
> On 06/18/2018 08:36 AM, David Gibson wrote:
> > Currently during KVM initialization on POWER, kvm_fixup_page_sizes()
> > rewrites a bunch of information in the cpu state to reflect the
> > capabilities of the host MMU and KVM.  This overwrites the information
> > that's already there reflecting how the TCG implementation of the MMU w=
ill
> > operate.
> >=20
> > This means that we can get guest-visibly different behaviour between KVM
> > and TCG (and between different KVM implementations).  That's bad.  It a=
lso
> > prevents migration between KVM and TCG.
> >=20
> > The pseries machine type now has filtering of the pagesizes it allows t=
he
> > guest to use which means it can present a consistent model of the MMU
> > across all accelerators.
> >=20
> > So, we can now replace kvm_fixup_page_sizes() with kvm_check_mmu() which
> > merely verifies that the expected cpu model can be faithfully handled by
> > KVM, rather than updating the cpu model to match KVM.
> >=20
> > We call kvm_check_mmu() from the spapr cpu reset code.  This is a hack:
>=20
> I think this is fine but we are still doing some MMU checks in=20
> kvm_arch_init_vcpu() we might want to do in a single routine.

Uh.. sort of.  We do do some messing around for BookE 2.06.  That
probably should move into the check_mmu routine.  Actually, it
probably needs to be turned around to give consistent behaviour
between TCG and KVM.  But in any case that'll require more looking at
how BookE works, so it's a project for another day.

The other check is about transactional memory and doesn't actually
have to do with the MMU at all.  It's keyed off env->mmu_model, but
that's an abuse, we should be doing a compat check instead.  Yes,
something to clean up, buit not really in scope for here.

>=20
> > conceptually it makes more sense where fixup_page_sizes() was - in the =
KVM
> > cpu init path.  However, doing that would require moving the platform's
> > pagesize filtering much earlier, which would require a lot of work maki=
ng
> > further adjustments.  There wouldn't be a lot of concrete point to doing
> > that, since the only KVM implementation which has the awkward MMU
> > restrictions is KVM HV, which can only work with an spapr guest anyway.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_caps.c     |   2 +-
> >  hw/ppc/spapr_cpu_core.c |   2 +
> >  target/ppc/kvm.c        | 133 ++++++++++++++++++++--------------------
> >  target/ppc/kvm_ppc.h    |   5 ++
> >  4 files changed, 73 insertions(+), 69 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 0584c7c6ab..bc89a4cd70 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -308,7 +308,7 @@ static void cap_safe_indirect_branch_apply(sPAPRMac=
hineState *spapr,
> >  void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
> >                            Error **errp)
> >  {
> > -    hwaddr maxpagesize =3D (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MPS]=
);
> > +    hwaddr maxpagesize =3D (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MAXP=
AGESIZE]);
>=20
> There might be some renames I missed. no big issue.

Looks like this fixup hunk ended up in the wrong patch.  I've folded
it into the right place now.

>=20
> > =20
> >      if (!kvmppc_hpt_needs_host_contiguous_pages()) {
> >          return;
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 324623190d..4e8fa28796 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -78,6 +78,8 @@ static void spapr_cpu_reset(void *opaque)
> >      spapr_cpu->dtl_size =3D 0;
> > =20
> >      spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
> > +
> > +    kvm_check_mmu(cpu, &error_fatal);
> >  }
> > =20
> >  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3)
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 9cfbd388ad..b386335014 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -419,93 +419,93 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void)
> >      return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
> >  }
> > =20
> > -static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32=
_t shift)
> > +void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
> >  {
> > -    if (!kvmppc_hpt_needs_host_contiguous_pages()) {
> > -        return true;
> > -    }
> > -
> > -    return (1ul << shift) <=3D rampgsize;
> > -}
> > -
> > -static long max_cpu_page_size;
> > -
> > -static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> > -{
> > -    static struct kvm_ppc_smmu_info smmu_info;
> > -    static bool has_smmu_info;
> > -    CPUPPCState *env =3D &cpu->env;
> > +    struct kvm_ppc_smmu_info smmu_info;
> >      int iq, ik, jq, jk;
> > =20
> > -    /* We only handle page sizes for 64-bit server guests for now */
> > -    if (!(env->mmu_model & POWERPC_MMU_64)) {
> > +    /* For now, we only have anything to check on hash64 MMUs */
> > +    if (!cpu->hash64_opts || !kvm_enabled()) {
> >          return;
> >      }
> > =20
> > -    /* Collect MMU info from kernel if not already */
> > -    if (!has_smmu_info) {
> > -        kvm_get_smmu_info(cpu, &smmu_info);
> > -        has_smmu_info =3D true;
> > -    }
> > +    kvm_get_smmu_info(cpu, &smmu_info);
>=20
> kvm_ppc_smmu_info and PPCHash64Options really are dual objects, and the=
=20
> routine below checks that they are in sync. Pity that we have to maintain
> two different structs. I guess we can't do differently.

No, and I don't think it really makes sense to try.  kvm_ppc_smmu_info
is about the host+KVM capabilities, PPCHash64Options is about the
guest capabilities.  The guest options need to be supportable by the
host, but they *don't* need to be identical (and no longer will be
after this series).


> > -    if (!max_cpu_page_size) {
> > -        max_cpu_page_size =3D qemu_getrampagesize();
> > +    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)
> > +        && !(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> > +        error_setg(errp,
> > +                   "KVM does not support 1TiB segments which guest exp=
ects");
> > +        return;
> >      }
> > =20
> > -    /* Convert to QEMU form */
> > -    memset(cpu->hash64_opts->sps, 0, sizeof(*cpu->hash64_opts->sps));
> > -
> > -    /* If we have HV KVM, we need to forbid CI large pages if our
> > -     * host page size is smaller than 64K.
> > -     */
> > -    if (kvmppc_hpt_needs_host_contiguous_pages()) {
> > -        if (getpagesize() >=3D 0x10000) {
> > -            cpu->hash64_opts->flags |=3D PPC_HASH64_CI_LARGEPAGE;
> > -        } else {
> > -            cpu->hash64_opts->flags &=3D ~PPC_HASH64_CI_LARGEPAGE;
> > -        }
> > +    if (smmu_info.slb_size < cpu->hash64_opts->slb_size) {
> > +        error_setg(errp, "KVM only supports %u SLB entries, but guest =
needs %u",
> > +                   smmu_info.slb_size, cpu->hash64_opts->slb_size);
> > +        return;
> >      }
> >
>=20
> The routine below is doing a simple PPCHash64SegmentPageSizes compare.=20
> Is it possible to move it in the mmu-hash64.c file ? It means introducing
> kvm notions under mmu-hash64.c

Yes it would, which is why I didn't put it in mmu-hash64.c.  Moreover
it would involve including KVM specific struct definitions from kernel
arch-specific header files into files that don't expect to use kernel
arch specific header files.

>=20
> >      /*
> > -     * XXX This loop should be an entry wide AND of the capabilities t=
hat
> > -     *     the selected CPU has with the capabilities that KVM support=
s.
> > +     * Verify that every pagesize supported by the cpu model is
> > +     * supported by KVM with the same encodings
> >       */
> > -    for (ik =3D iq =3D 0; ik < KVM_PPC_PAGE_SIZES_MAX_SZ; ik++) {
> > +    for (iq =3D 0; iq < ARRAY_SIZE(cpu->hash64_opts->sps); iq++) {
> >          PPCHash64SegmentPageSizes *qsps =3D &cpu->hash64_opts->sps[iq];
> > -        struct kvm_ppc_one_seg_page_size *ksps =3D &smmu_info.sps[ik];
> > +        struct kvm_ppc_one_seg_page_size *ksps;
> > =20
> > -        if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_size,
> > -                                 ksps->page_shift)) {
> > -            continue;
> > -        }
> > -        qsps->page_shift =3D ksps->page_shift;
> > -        qsps->slb_enc =3D ksps->slb_enc;
> > -        for (jk =3D jq =3D 0; jk < KVM_PPC_PAGE_SIZES_MAX_SZ; jk++) {
> > -            if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_siz=
e,
> > -                                     ksps->enc[jk].page_shift)) {
> > -                continue;
> > -            }
> > -            qsps->enc[jq].page_shift =3D ksps->enc[jk].page_shift;
> > -            qsps->enc[jq].pte_enc =3D ksps->enc[jk].pte_enc;
> > -            if (++jq >=3D PPC_PAGE_SIZES_MAX_SZ) {
> > +        for (ik =3D 0; ik < ARRAY_SIZE(smmu_info.sps); ik++) {
> > +            if (qsps->page_shift =3D=3D smmu_info.sps[ik].page_shift) {
> >                  break;
> >              }
> >          }
> > -        if (++iq >=3D PPC_PAGE_SIZES_MAX_SZ) {
> > -            break;
> > +        if (ik >=3D ARRAY_SIZE(smmu_info.sps)) {
> > +            error_setg(errp, "KVM doesn't support for base page shift =
%u",
> > +                       qsps->page_shift);
> > +            return;
> > +        }
> > +
> > +        ksps =3D &smmu_info.sps[ik];
> > +        if (ksps->slb_enc !=3D qsps->slb_enc) {
> > +            error_setg(errp,
> > +"KVM uses SLB encoding 0x%x for page shift %u, but guest expects 0x%x",
> > +                       ksps->slb_enc, ksps->page_shift, qsps->slb_enc);
> > +            return;
> > +        }
> > +
> > +        for (jq =3D 0; jq < ARRAY_SIZE(qsps->enc); jq++) {
> > +            for (jk =3D 0; jk < ARRAY_SIZE(ksps->enc); jk++) {
> > +                if (qsps->enc[jq].page_shift =3D=3D ksps->enc[jk].page=
_shift) {
> > +                    break;
> > +                }
> > +            }
> > +
> > +            if (jk >=3D ARRAY_SIZE(ksps->enc)) {
> > +                error_setg(errp, "KVM doesn't support page shift %u/%u=
",
> > +                           qsps->enc[jq].page_shift, qsps->page_shift);
> > +                return;
> > +            }
> > +            if (qsps->enc[jq].pte_enc !=3D ksps->enc[jk].pte_enc) {
> > +                error_setg(errp,
> > +"KVM uses PTE encoding 0x%x for page shift %u/%u, but guest expects 0x=
%x",
> > +                           ksps->enc[jk].pte_enc, qsps->enc[jq].page_s=
hift,
> > +                           qsps->page_shift, qsps->enc[jq].pte_enc);
> > +                return;
> > +            }
> >          }
> >      }
> > -    cpu->hash64_opts->slb_size =3D smmu_info.slb_size;
> > -    if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> > -        cpu->hash64_opts->flags &=3D ~PPC_HASH64_1TSEG;
> > -    }
> > -}
> > -#else /* defined (TARGET_PPC64) */
> > =20
> > -static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> > -{
> > +    if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
> > +        /* Mostly what guest pagesizes we can use are related to the
> > +         * host pages used to map guest RAM, which is handled in the
> > +         * platform code. Cache-Inhibited largepages (64k) however are
> > +         * used for I/O, so if they're mapped to the host at all it
> > +         * will be a normal mapping, not a special hugepage one used
> > +         * for RAM. */
> > +        if (getpagesize() < 0x10000) {
> > +            error_setg(errp,
> > +"KVM can't supply 64kiB CI pages, which guest expects\n");
> > +        }
> > +    }
> >  }
> > -
> >  #endif /* !defined (TARGET_PPC64) */
> > =20
> >  unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> > @@ -551,9 +551,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >      CPUPPCState *cenv =3D &cpu->env;
> >      int ret;
> > =20
> > -    /* Gather server mmu info from KVM and update the CPU state */
> > -    kvm_fixup_page_sizes(cpu);
> > -
> >      /* Synchronize sregs with kvm */
> >      ret =3D kvm_arch_sync_sregs(cpu);
> >      if (ret) {
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index 443fca0a4e..657582bb32 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -71,6 +71,7 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_=
ulong flags, int shift);
> >  bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> > =20
> >  bool kvmppc_hpt_needs_host_contiguous_pages(void);
> > +void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
> > =20
> >  #else
> > =20
> > @@ -227,6 +228,10 @@ static inline bool kvmppc_hpt_needs_host_contiguou=
s_pages(void)
> >      return false;
> >  }
> > =20
> > +static inline void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
> > +{
> > +}
> > +
> >  static inline bool kvmppc_has_cap_spapr_vfio(void)
> >  {
> >      return false;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsrk5UACgkQbDjKyiDZ
s5J0lQ/+IN/irsJCUlr9c3oQ0dnAVApdC2154g6xUISPsxXoFLs756vh3p/k/d+K
3xnUcJpgiFYIS5N+BkMw5Ti9xfTPiER3GyD+McJLoEJaTfqERDD7v50cQQKf2ssn
8a0z70XFRzKDm5ZknLEEv3m/hQ4oZTRg056l95c5YFfCfOtWOrlijqpCPSt8iUxc
4Fqbvdd5nPufdEAgcZNlR659cCTuME5bVnCcIzeFbCOAh4QxPNuPnIzz0jJji+C5
mAFW4VzfqSz4wkd9LUGoIqyw+jyW8J0MyXgF4wh2aySkZMOxZCsysDA4ToA9111c
zXEq4S1Ze0nuViZ/a82te+kl0ZWcTbgKwK77AhL8j0ZLW3vypfchkwoqlgoWX/t9
7HYSAZt5EYgNOxni5vADjg735ggd+Sr6Cf8mvMmvtyp8BdjpegR7K4KJnzrNQVOR
TqU5BeCvjq9otzt5+IuO7b5Sy2UrH9lduH8haL4yq5u6xYtdXjdLPCn2oqDz7Ds8
EPFWqyha25LCX8jhcO3JL6aAXD1b2tTp+HBlX1ar0Iz4c22q71iAWyF3ssFTL3EO
4sMn7MnaBo4Vk+AgEnzmFTb/pFeIATYdV0ukhWDUGfElCsR7V0BqjjTu7F7LATqQ
opPU2rx5QcSts+wFLTOe6sgz6g6bGG23OZiqfJwdL04clkT+NJY=
=UMmD
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
