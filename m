Received: from eggs.gnu.org ([2001:4830:134:3::10]:60719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZrxY-0002Kp-GG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZrxS-0003Dn-3j
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:05:12 -0400
Date: Mon, 2 Jul 2018 15:54:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702055453.GZ3422@umbus.fritz.box>
References: <153026568125.394407.16374811229961951138.stgit@bahia.lan>
	<153026569690.394407.15353910318501418469.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E9SPMlsjsjqOlA3h"
Content-Disposition: inline
In-Reply-To: <153026569690.394407.15353910318501418469.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] target/ppc/kvm: get rid of
 kvm_get_fallback_smmu_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--E9SPMlsjsjqOlA3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 11:48:16AM +0200, Greg Kurz wrote:
> Now that we're checking our MMU configuration is supported by KVM,
> rather than adjusting it to KVM, it doesn't really make sense to
> have a fallback for kvm_get_smmu_info(). If KVM is too old or buggy
> to provide the details, we should rather treat this as an error.
>=20
> This patch thus adds error reporting to kvm_get_smmu_info() and get
> rid of the fallback code. QEMU will now terminate if KVM fails to
> provide MMU details. This may break some very old setups, but the
> simplification is worth the sacrifice.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Ok, so immediately failing with an old kernel wasn't actually what I
had in mind.  Instead I was suggesting just skipping the checks and
hoping for the best.  Still, either way the relevant kernels are
really ancient now, so I'll apply anyway.

> ---
>  target/ppc/kvm.c |  117 +++++++++---------------------------------------=
------
>  1 file changed, 20 insertions(+), 97 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 4df4ff6cbff2..b6000f12b98f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -248,107 +248,25 @@ static int kvm_booke206_tlb_init(PowerPCCPU *cpu)
> =20
> =20
>  #if defined(TARGET_PPC64)
> -static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
> -                                       struct kvm_ppc_smmu_info *info)
> +static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info =
*info,
> +                              Error **errp)
>  {
> -    CPUPPCState *env =3D &cpu->env;
>      CPUState *cs =3D CPU(cpu);
> +    int ret;
> =20
> -    memset(info, 0, sizeof(*info));
> -
> -    /* We don't have the new KVM_PPC_GET_SMMU_INFO ioctl, so
> -     * need to "guess" what the supported page sizes are.
> -     *
> -     * For that to work we make a few assumptions:
> -     *
> -     * - Check whether we are running "PR" KVM which only supports 4K
> -     *   and 16M pages, but supports them regardless of the backing
> -     *   store characteritics. We also don't support 1T segments.
> -     *
> -     *   This is safe as if HV KVM ever supports that capability or PR
> -     *   KVM grows supports for more page/segment sizes, those versions
> -     *   will have implemented KVM_CAP_PPC_GET_SMMU_INFO and thus we
> -     *   will not hit this fallback
> -     *
> -     * - Else we are running HV KVM. This means we only support page
> -     *   sizes that fit in the backing store. Additionally we only
> -     *   advertize 64K pages if the processor is ARCH 2.06 and we assume
> -     *   P7 encodings for the SLB and hash table. Here too, we assume
> -     *   support for any newer processor will mean a kernel that
> -     *   implements KVM_CAP_PPC_GET_SMMU_INFO and thus doesn't hit
> -     *   this fallback.
> -     */
> -    if (kvmppc_is_pr(cs->kvm_state)) {
> -        /* No flags */
> -        info->flags =3D 0;
> -        info->slb_size =3D 64;
> -
> -        /* Standard 4k base page size segment */
> -        info->sps[0].page_shift =3D 12;
> -        info->sps[0].slb_enc =3D 0;
> -        info->sps[0].enc[0].page_shift =3D 12;
> -        info->sps[0].enc[0].pte_enc =3D 0;
> -
> -        /* Standard 16M large page size segment */
> -        info->sps[1].page_shift =3D 24;
> -        info->sps[1].slb_enc =3D SLB_VSID_L;
> -        info->sps[1].enc[0].page_shift =3D 24;
> -        info->sps[1].enc[0].pte_enc =3D 0;
> -    } else {
> -        int i =3D 0;
> -
> -        /* HV KVM has backing store size restrictions */
> -        info->flags =3D KVM_PPC_PAGE_SIZES_REAL;
> -
> -        if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
> -            info->flags |=3D KVM_PPC_1T_SEGMENTS;
> -        }
> -
> -        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> -            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
> -            info->slb_size =3D 32;
> -        } else {
> -            info->slb_size =3D 64;
> -        }
> -
> -        /* Standard 4k base page size segment */
> -        info->sps[i].page_shift =3D 12;
> -        info->sps[i].slb_enc =3D 0;
> -        info->sps[i].enc[0].page_shift =3D 12;
> -        info->sps[i].enc[0].pte_enc =3D 0;
> -        i++;
> -
> -        /* 64K on MMU 2.06 and later */
> -        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> -            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
> -            info->sps[i].page_shift =3D 16;
> -            info->sps[i].slb_enc =3D 0x110;
> -            info->sps[i].enc[0].page_shift =3D 16;
> -            info->sps[i].enc[0].pte_enc =3D 1;
> -            i++;
> -        }
> -
> -        /* Standard 16M large page size segment */
> -        info->sps[i].page_shift =3D 24;
> -        info->sps[i].slb_enc =3D SLB_VSID_L;
> -        info->sps[i].enc[0].page_shift =3D 24;
> -        info->sps[i].enc[0].pte_enc =3D 0;
> +    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
> +        error_setg(errp, "KVM doesn't expose the MMU features it support=
s");
> +        error_append_hint(errp, "Consider switching to a newer KVM\n");
> +        return;
>      }
> -}
> -
> -static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info =
*info)
> -{
> -    CPUState *cs =3D CPU(cpu);
> -    int ret;
> =20
> -    if (kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
> -        ret =3D kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, info);
> -        if (ret =3D=3D 0) {
> -            return;
> -        }
> +    ret =3D kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, info);
> +    if (ret =3D=3D 0) {
> +        return;
>      }
> =20
> -    kvm_get_fallback_smmu_info(cpu, info);
> +    error_setg_errno(errp, -ret,
> +                     "KVM failed to provide the MMU features it supports=
");
>  }
> =20
>  struct ppc_radix_page_info *kvm_get_radix_page_info(void)
> @@ -415,7 +333,7 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void)
>          return false;
>      }
> =20
> -    kvm_get_smmu_info(cpu, &smmu_info);
> +    kvm_get_smmu_info(cpu, &smmu_info, &error_fatal);
>      return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
>  }
> =20
> @@ -423,13 +341,18 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
>  {
>      struct kvm_ppc_smmu_info smmu_info;
>      int iq, ik, jq, jk;
> +    Error *local_err =3D NULL;
> =20
>      /* For now, we only have anything to check on hash64 MMUs */
>      if (!cpu->hash64_opts || !kvm_enabled()) {
>          return;
>      }
> =20
> -    kvm_get_smmu_info(cpu, &smmu_info);
> +    kvm_get_smmu_info(cpu, &smmu_info, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> =20
>      if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)
>          && !(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> @@ -2168,7 +2091,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, uns=
igned int hash_shift)
> =20
>      /* Find the largest hardware supported page size that's less than
>       * or equal to the (logical) backing page size of guest RAM */
> -    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info);
> +    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info, &error_fatal);
>      rampagesize =3D qemu_getrampagesize();
>      best_page_shift =3D 0;
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E9SPMlsjsjqOlA3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5vikACgkQbDjKyiDZ
s5IQEA/+I2yBr+t2N46eMoXpXWCemmrMSGwoVvI+Hg3DYecdtc5Rea2QHxwYcuOY
OznOi59nubqDbEEVA8OyX9H1gAnKFcmKKULh1KQ2qjgR5g+VgFyO76Y2ej+rJno8
7hE27Skw/mUVWcQpSbZLgNXZexIsrF5X56eHTB3Wle9IwP7esAFQjfJAHztCqYkB
8zXgQFvby9yDgliERUfF+vqlmu1XTTT9N+BoMd5qjYsnIjzQK73/K/lRSg0LZP0j
GZRcb4SFwv4Zk5cnGFwUNKa9AiHrK7vHDe+fYZhLLrwb2n7TDzZd0jQQZozZ4SXT
qHnEmY4gKUmkqmNUNK4RYboVHBT9uln/nQzD93y9AQY1wmxIkHSnOiH9+MPTh0Qk
GgQjnRXxx4QO2nNL/4fC58q9NgPUwW6yDEPTyweldOE0Rb5inSsSWAJw4D3VCut5
Q0Pw28yCjgBImJReRILflUbfzf8NJz/RE3XvqviM8Fvo8s8N20otMzQCvlNL4Zia
/VMgb/nbr63kb1mUNKWI956ADpXcuo5j4BcU7PW43csLjNtHw6cLsxmStYkl5JTL
hSzowCH5PDumG+iQexVq0m7h6V8vZq9Ecj0WBj+YU0q7biPAAwlbIOKQbpQcntuV
FebqjiqayHBQQudQKyomsvICAhEaoBYg3RY7SDvCMWV1K1fev5I=
=0Igp
-----END PGP SIGNATURE-----

--E9SPMlsjsjqOlA3h--
