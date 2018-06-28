Received: from eggs.gnu.org ([2001:4830:134:3::10]:35575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYVpW-0001zm-QH
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYVpS-0003Rg-H8
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:15:18 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:36958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYVpS-0003PM-4g
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:15:14 -0400
Received: from player726.ha.ovh.net (unknown [10.109.122.9])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 60923B83BC
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:15:12 +0200 (CEST)
Date: Thu, 28 Jun 2018 14:14:58 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180628141458.4b0ed948@bahia.lan>
In-Reply-To: <22d24364-67cf-8bfc-a10c-53c0f999a985@kaod.org>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
	<153018089136.336571.15410439376219137880.stgit@bahia>
	<22d24364-67cf-8bfc-a10c-53c0f999a985@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc/kvm: don't pass cpu to
 kvm_get_smmu_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 28 Jun 2018 13:56:58 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 06/28/2018 12:14 PM, Greg Kurz wrote:
> > In a future patch the machine code will need to retrieve the MMU
> > information from KVM during machine initialization before the CPUs
> > are created.
> >=20
> > Actually, KVM_PPC_GET_SMMU_INFO is a VM class ioctl, and thus, it only
> > needs the kvm_state global variable to be set. The fallback code only
> > needs informations from the machine's CPU model class.
> >=20
> > So this patch basically drops the CPU argument to kvm_get_smmu_info()
> > and kvm_get_fallback_smmu_info(). The kvm_state and current_machine
> > globals are used instead to reach out to KVM and CPU model details
> > respectively.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> one question below,
>=20
> Thanks,
>=20
> C.
>=20
> > ---
> >  target/ppc/kvm.c        |   37 ++++++++++++++++++-------------------
> >  target/ppc/mmu-hash64.h |    8 +++++++-
> >  2 files changed, 25 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 4df4ff6cbff2..9fae89ff8175 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -248,11 +248,12 @@ static int kvm_booke206_tlb_init(PowerPCCPU *cpu)
> > =20
> > =20
> >  #if defined(TARGET_PPC64)
> > -static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
> > -                                       struct kvm_ppc_smmu_info *info)
> > +static void kvm_get_fallback_smmu_info(struct kvm_ppc_smmu_info *info)
> >  {
> > -    CPUPPCState *env =3D &cpu->env;
> > -    CPUState *cs =3D CPU(cpu);
> > +    const PowerPCCPUClass *pcc;
> > +
> > +    assert(current_machine !=3D NULL); =20
>=20
> can that ever happen ?=20
>=20

It shouldn't, hence the assert() rather than merely SEGV'ing below.

> > +    pcc =3D POWERPC_CPU_CLASS(object_class_by_name(current_machine->cp=
u_type));
> > =20
> >      memset(info, 0, sizeof(*info));
> > =20
> > @@ -278,7 +279,7 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *=
cpu,
> >       *   implements KVM_CAP_PPC_GET_SMMU_INFO and thus doesn't hit
> >       *   this fallback.
> >       */
> > -    if (kvmppc_is_pr(cs->kvm_state)) {
> > +    if (kvmppc_is_pr(kvm_state)) {
> >          /* No flags */
> >          info->flags =3D 0;
> >          info->slb_size =3D 64;
> > @@ -300,12 +301,12 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU=
 *cpu,
> >          /* HV KVM has backing store size restrictions */
> >          info->flags =3D KVM_PPC_PAGE_SIZES_REAL;
> > =20
> > -        if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
> > +        if (hash64_opts_has(pcc->hash64_opts, PPC_HASH64_1TSEG)) {
> >              info->flags |=3D KVM_PPC_1T_SEGMENTS;
> >          }
> > =20
> > -        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> > -            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
> > +        if (pcc->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> > +            pcc->mmu_model =3D=3D POWERPC_MMU_2_07) {
> >              info->slb_size =3D 32;
> >          } else {
> >              info->slb_size =3D 64;
> > @@ -319,8 +320,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *=
cpu,
> >          i++;
> > =20
> >          /* 64K on MMU 2.06 and later */
> > -        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> > -            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
> > +        if (pcc->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> > +            pcc->mmu_model =3D=3D POWERPC_MMU_2_07) {
> >              info->sps[i].page_shift =3D 16;
> >              info->sps[i].slb_enc =3D 0x110;
> >              info->sps[i].enc[0].page_shift =3D 16;
> > @@ -336,19 +337,18 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU=
 *cpu,
> >      }
> >  }
> > =20
> > -static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_inf=
o *info)
> > +static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info)
> >  {
> > -    CPUState *cs =3D CPU(cpu);
> >      int ret;
> > =20
> > -    if (kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO))=
 {
> > -        ret =3D kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, inf=
o);
> > +    if (kvm_check_extension(kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
> > +        ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_SMMU_INFO, info);
> >          if (ret =3D=3D 0) {
> >              return;
> >          }
> >      }
> > =20
> > -    kvm_get_fallback_smmu_info(cpu, info);
> > +    kvm_get_fallback_smmu_info(info);
> >  }
> > =20
> >  struct ppc_radix_page_info *kvm_get_radix_page_info(void)
> > @@ -408,14 +408,13 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *=
cpu,
> > =20
> >  bool kvmppc_hpt_needs_host_contiguous_pages(void)
> >  {
> > -    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> >      static struct kvm_ppc_smmu_info smmu_info;
> > =20
> >      if (!kvm_enabled()) {
> >          return false;
> >      }
> > =20
> > -    kvm_get_smmu_info(cpu, &smmu_info);
> > +    kvm_get_smmu_info(&smmu_info);
> >      return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
> >  }
> > =20
> > @@ -429,7 +428,7 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
> >          return;
> >      }
> > =20
> > -    kvm_get_smmu_info(cpu, &smmu_info);
> > +    kvm_get_smmu_info(&smmu_info);
> > =20
> >      if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)
> >          && !(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> > @@ -2168,7 +2167,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, u=
nsigned int hash_shift)
> > =20
> >      /* Find the largest hardware supported page size that's less than
> >       * or equal to the (logical) backing page size of guest RAM */
> > -    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info);
> > +    kvm_get_smmu_info(&info);
> >      rampagesize =3D qemu_getrampagesize();
> >      best_page_shift =3D 0;
> > =20
> > diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> > index f11efc9cbc1f..00a249f26bc3 100644
> > --- a/target/ppc/mmu-hash64.h
> > +++ b/target/ppc/mmu-hash64.h
> > @@ -169,9 +169,15 @@ struct PPCHash64Options {
> >  extern const PPCHash64Options ppc_hash64_opts_basic;
> >  extern const PPCHash64Options ppc_hash64_opts_POWER7;
> > =20
> > +static inline bool hash64_opts_has(const PPCHash64Options *opts,
> > +                                   unsigned feature)
> > +{
> > +    return !!(opts->flags & feature);
> > +}
> > +
> >  static inline bool ppc_hash64_has(PowerPCCPU *cpu, unsigned feature)
> >  {
> > -    return !!(cpu->hash64_opts->flags & feature);
> > +    return hash64_opts_has(cpu->hash64_opts, feature);
> >  }
> > =20
> >  #endif /* CONFIG_USER_ONLY */
> >  =20
>=20
