Received: from eggs.gnu.org ([2001:4830:134:3::10]:60693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZrxT-0002Jl-AR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZrxS-0003Dd-2M
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:05:07 -0400
Date: Mon, 2 Jul 2018 16:01:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702060105.GA3422@umbus.fritz.box>
References: <153026568125.394407.16374811229961951138.stgit@bahia.lan>
	<153026571205.394407.1842744312813398945.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ELawpaRm0uGyL1wg"
Content-Disposition: inline
In-Reply-To: <153026571205.394407.1842744312813398945.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] target/ppc/kvm: don't pass cpu to
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--ELawpaRm0uGyL1wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 11:48:32AM +0200, Greg Kurz wrote:
11;rgb:ffff/ffff/ffff> In a future patch the machine code will need to retr=
ieve the MMU
> information from KVM during machine initialization before the CPUs
> are created.
>=20
> Actually, KVM_PPC_GET_SMMU_INFO is a VM class ioctl, and thus, we
> don't need to have a CPU object around. We just need for KVM to
> be initialized and use the kvm_state global. This patch just does
> that.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0.

> ---
> v2: - fallback code was dropped by a previous patch
> ---
>  target/ppc/kvm.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b6000f12b98f..9211ee2ee1a0 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -248,19 +248,19 @@ static int kvm_booke206_tlb_init(PowerPCCPU *cpu)
> =20
> =20
>  #if defined(TARGET_PPC64)
> -static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info =
*info,
> -                              Error **errp)
> +static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **er=
rp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      int ret;
> =20
> -    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
> +    assert(kvm_state !=3D NULL);
> +
> +    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
>          error_setg(errp, "KVM doesn't expose the MMU features it support=
s");
>          error_append_hint(errp, "Consider switching to a newer KVM\n");
>          return;
>      }
> =20
> -    ret =3D kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, info);
> +    ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_GET_SMMU_INFO, info);
>      if (ret =3D=3D 0) {
>          return;
>      }
> @@ -326,14 +326,13 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cp=
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
> -    kvm_get_smmu_info(cpu, &smmu_info, &error_fatal);
> +    kvm_get_smmu_info(&smmu_info, &error_fatal);
>      return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
>  }
> =20
> @@ -348,7 +347,7 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
>          return;
>      }
> =20
> -    kvm_get_smmu_info(cpu, &smmu_info, &local_err);
> +    kvm_get_smmu_info(&smmu_info, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -2091,7 +2090,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, uns=
igned int hash_shift)
> =20
>      /* Find the largest hardware supported page size that's less than
>       * or equal to the (logical) backing page size of guest RAM */
> -    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info, &error_fatal);
> +    kvm_get_smmu_info(&info, &error_fatal);
>      rampagesize =3D qemu_getrampagesize();
>      best_page_shift =3D 0;
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ELawpaRm0uGyL1wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5v6EACgkQbDjKyiDZ
s5K4Dw//SvnopgpVqDDd2XbYVsIwpH0qMOix9gXXKdA2/QRdL2tSXJy2I1UIdHsH
qCbg6M6bCMuPdQ7VYpC4/10CyGfvwlMjmAQ7rCJn+yU4OHgO9yekMq1MxmNVYVi2
+m5ik9w2pMRobuRxdEcLyAcnacKx1q6XwjuF/DoZLDQ2LH6XBwY9f+CD15M9UYHR
DPfi/9i+CPn5YDon/mlNXQavJlumcwAU0z7Nx1dVRVHC1x/hVSvzuKIGEgbZ5Kux
2dEmB7XNBP7zzKoSSlCIgEQzfa5sLv6PgWq+j8AsXPGFW4+5y41ZdGyzUynUAeh4
tXY1qZY6WUB6MsrmEhGMtBfZLXiEPxg7doxi0B6UHEk89TCoArqXM+wkvWfHOOOy
nraOP4Pt+LLMnFuO3tbxshcXRRXLvC0yqZTyMwcZFsk0VQx0hEEDPT00HcTvQggV
Op8xWLZ+LVAnNngv5aXSzyL6OhCG5WVZlJCtvniq1H2Q3BAtYeMEPkFmkO6alwl+
Ivr40E3Y0H88zGEMmcbhGbt3hViNeVwUFTWwbJ5DxnP19r5HFUY5lNZ8ew8G2+Q4
LI8T6MyvZ3zntlXwDssHV5kIFj5gI1Wif6cZ5Rn7LciuMMsyDoQOtl+tHM/gnP7u
Axt/Vw1bcKqsGztR8HSGq5r9kH9PAh2b8Wyp8c0/voF6accd0NY=
=Cn83
-----END PGP SIGNATURE-----

--ELawpaRm0uGyL1wg--
