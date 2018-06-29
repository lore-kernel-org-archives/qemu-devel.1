Received: from eggs.gnu.org ([2001:4830:134:3::10]:57590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlqm-0001Hx-QB
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 01:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlqk-0001ph-Rl
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 01:21:40 -0400
Date: Fri, 29 Jun 2018 15:16:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629051604.GK3422@umbus.fritz.box>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
	<153018089136.336571.15410439376219137880.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <153018089136.336571.15410439376219137880.stgit@bahia>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 12:14:51PM +0200, Greg Kurz wrote:
> In a future patch the machine code will need to retrieve the MMU
> information from KVM during machine initialization before the CPUs
> are created.
>=20
> Actually, KVM_PPC_GET_SMMU_INFO is a VM class ioctl, and thus, it only
> needs the kvm_state global variable to be set. The fallback code only
> needs informations from the machine's CPU model class.
>=20
> So this patch basically drops the CPU argument to kvm_get_smmu_info()
> and kvm_get_fallback_smmu_info(). The kvm_state and current_machine
> globals are used instead to reach out to KVM and CPU model details
> respectively.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

This looks more or less correct, but I think there's a better way to
approach it.

Something I meant to do once the pagesize cleanups were made, but
didn't get around to is to eliminate kvm_get_fallback_smmu_info()
entirely.  Instead we can allow kvm_get_smmu_info() to fail.  Since
we're now just checking the configured setup against KVM's
capabilities, rather than adjusting the configured setup according to
KVM's capabilities, we can just skip the checking if we can't get the
smmu info.

That might result in slightly more cryptic failure modes errors for
really old kernels, but I think that's worth it for simpler logic.

> ---
>  target/ppc/kvm.c        |   37 ++++++++++++++++++-------------------
>  target/ppc/mmu-hash64.h |    8 +++++++-
>  2 files changed, 25 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 4df4ff6cbff2..9fae89ff8175 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -248,11 +248,12 @@ static int kvm_booke206_tlb_init(PowerPCCPU *cpu)
> =20
> =20
>  #if defined(TARGET_PPC64)
> -static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
> -                                       struct kvm_ppc_smmu_info *info)
> +static void kvm_get_fallback_smmu_info(struct kvm_ppc_smmu_info *info)
>  {
> -    CPUPPCState *env =3D &cpu->env;
> -    CPUState *cs =3D CPU(cpu);
> +    const PowerPCCPUClass *pcc;
> +
> +    assert(current_machine !=3D NULL);
> +    pcc =3D POWERPC_CPU_CLASS(object_class_by_name(current_machine->cpu_=
type));
> =20
>      memset(info, 0, sizeof(*info));
> =20
> @@ -278,7 +279,7 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
u,
>       *   implements KVM_CAP_PPC_GET_SMMU_INFO and thus doesn't hit
>       *   this fallback.
>       */
> -    if (kvmppc_is_pr(cs->kvm_state)) {
> +    if (kvmppc_is_pr(kvm_state)) {
>          /* No flags */
>          info->flags =3D 0;
>          info->slb_size =3D 64;
> @@ -300,12 +301,12 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *=
cpu,
>          /* HV KVM has backing store size restrictions */
>          info->flags =3D KVM_PPC_PAGE_SIZES_REAL;
> =20
> -        if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
> +        if (hash64_opts_has(pcc->hash64_opts, PPC_HASH64_1TSEG)) {
>              info->flags |=3D KVM_PPC_1T_SEGMENTS;
>          }
> =20
> -        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> -            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
> +        if (pcc->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> +            pcc->mmu_model =3D=3D POWERPC_MMU_2_07) {
>              info->slb_size =3D 32;
>          } else {
>              info->slb_size =3D 64;
> @@ -319,8 +320,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
u,
>          i++;
> =20
>          /* 64K on MMU 2.06 and later */
> -        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> -            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
> +        if (pcc->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> +            pcc->mmu_model =3D=3D POWERPC_MMU_2_07) {
>              info->sps[i].page_shift =3D 16;
>              info->sps[i].slb_enc =3D 0x110;
>              info->sps[i].enc[0].page_shift =3D 16;
> @@ -336,19 +337,18 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *=
cpu,
>      }
>  }
> =20
> -static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info =
*info)
> +static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      int ret;
> =20
> -    if (kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
> -        ret =3D kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, info);
> +    if (kvm_check_extension(kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
> +        ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_SMMU_INFO, info);
>          if (ret =3D=3D 0) {
>              return;
>          }
>      }
> =20
> -    kvm_get_fallback_smmu_info(cpu, info);
> +    kvm_get_fallback_smmu_info(info);
>  }
> =20
>  struct ppc_radix_page_info *kvm_get_radix_page_info(void)
> @@ -408,14 +408,13 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cp=
u,
> =20
>  bool kvmppc_hpt_needs_host_contiguous_pages(void)
>  {
> -    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
>      static struct kvm_ppc_smmu_info smmu_info;
> =20
>      if (!kvm_enabled()) {
>          return false;
>      }
> =20
> -    kvm_get_smmu_info(cpu, &smmu_info);
> +    kvm_get_smmu_info(&smmu_info);
>      return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
>  }
> =20
> @@ -429,7 +428,7 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
>          return;
>      }
> =20
> -    kvm_get_smmu_info(cpu, &smmu_info);
> +    kvm_get_smmu_info(&smmu_info);
> =20
>      if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)
>          && !(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> @@ -2168,7 +2167,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, uns=
igned int hash_shift)
> =20
>      /* Find the largest hardware supported page size that's less than
>       * or equal to the (logical) backing page size of guest RAM */
> -    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info);
> +    kvm_get_smmu_info(&info);
>      rampagesize =3D qemu_getrampagesize();
>      best_page_shift =3D 0;
> =20
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index f11efc9cbc1f..00a249f26bc3 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -169,9 +169,15 @@ struct PPCHash64Options {
>  extern const PPCHash64Options ppc_hash64_opts_basic;
>  extern const PPCHash64Options ppc_hash64_opts_POWER7;
> =20
> +static inline bool hash64_opts_has(const PPCHash64Options *opts,
> +                                   unsigned feature)
> +{
> +    return !!(opts->flags & feature);
> +}

Any exported function from mmu-hash64.c shoud have a name prefixed
with "ppc_hash64_".

>  static inline bool ppc_hash64_has(PowerPCCPU *cpu, unsigned feature)
>  {
> -    return !!(cpu->hash64_opts->flags & feature);
> +    return hash64_opts_has(cpu->hash64_opts, feature);
>  }
> =20
>  #endif /* CONFIG_USER_ONLY */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1wJIACgkQbDjKyiDZ
s5LrrQ//cYKqauQr+2ZnwremdXXMtbkbKoTuqZXwj17MnLM1dpWew1bE5Fnz/yht
9+waNBxQl8POn2tHnKkSFMCi2aLAP7bt/9MtRFX8WizagQTPsEHM3z7jcb46LK+5
1/UP68Qcsq88+Dl2Fym9XZVph3i8qAERVxL+0pxUc6NQgBxT9w9ID91kBePUFz7m
Hy3ycXV+popDuX0u5/6qDpcgQV1371si4tW69PInIzHDZZmU89qA/8vPAfaIISIh
MbPSp+Lk2qOOz1d0+rv2G0qLVrYLwAIrZt4zD3eyeAWkso9JFLGUoGCrHKHChr1m
sahj3NmNE2kKgWQr+aUpoByayfQYgSnCgGxYfh1AQ4GHUbPCbAGdXyYFuc2sgtLo
mKdA+erEQ4nlNf9AsFiVSUSc3ttqUzN4ACU+IW2LHLY31pFmdmRdNkzH9NQ0k7Wu
NtaYJPTozJPLMNW72ZGtrjN7oK9x/era7JOVOO4Dg1v+vjpOX7RJhVBkhMUhPqBz
4PSiKSVCtoOGhw7R3fzBsBzPFK3kU6gvRAbabIURFyCpDzTNQINQE6Tdb6ushur/
dUSpzN3H8VLnc/tz/SkLKUEB4VkFnobxlGdkXypIJ8d12RI/PTy4kTVm0u4g9qHT
FqalfCB9lZyTjhBtaON4sBUH4QLsJy8Q1W6JNGngv74VndUnJ4o=
=3GTo
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
