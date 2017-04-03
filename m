Received: from eggs.gnu.org ([2001:4830:134:3::10]:55574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cusFr-0000eS-CS
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 23:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cusFo-0000Qf-9U
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 23:02:07 -0400
Date: Mon, 3 Apr 2017 13:01:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170403030150.GC10997@umbus.fritz.box>
References: <20170401123741.38469-1-aik@ozlabs.ru>
	<20170401123741.38469-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20170401123741.38469-5-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu v3 4/4] spapr/iommu: Enable
 in-kernel TCE acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2017 at 11:37:41PM +1100, Alexey Kardashevskiy wrote:
> This uses new kernel KVM_CAP_SPAPR_TCE_VFIO capability to enable
> in-kernel acceleration of TCE update requests which will go via
> the VFIO KVM device.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/kvm_ppc.h | 6 ++++++
>  hw/ppc/spapr_iommu.c | 4 ++++
>  target/ppc/kvm.c     | 7 ++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f48243d13f..ce7327a4e0 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -46,6 +46,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t =
page_shift,
>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
>  int kvmppc_reset_htab(int shift_hint);
>  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
> +bool kvmppc_has_cap_spapr_vfio(void);
>  #endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
>  int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function=
);
> @@ -216,6 +217,11 @@ static inline bool kvmppc_is_mem_backend_page_size_o=
k(char *obj_path)
>      return true;
>  }
> =20
> +static inline bool kvmppc_has_cap_spapr_vfio(void)
> +{
> +    return false;
> +}
> +
>  #endif /* !CONFIG_USER_ONLY */
> =20
>  static inline bool kvmppc_has_cap_epr(void)
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index f7531a6408..35c2516fcb 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -293,6 +293,10 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bo=
ol need_vfio)
> =20
>      tcet->need_vfio =3D need_vfio;
> =20
> +    if (!need_vfio || (tcet->fd !=3D -1 && kvmppc_has_cap_spapr_vfio()))=
 {
> +        return;
> +    }
> +
>      oldtable =3D tcet->table;
> =20
>      tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 20f07ff320..76bd92c663 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -132,7 +132,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>      cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
>      cap_spapr_multitce =3D kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE=
);
> -    cap_spapr_vfio =3D false;
> +    cap_spapr_vfio =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_VFIO);
>      cap_one_reg =3D kvm_check_extension(s, KVM_CAP_ONE_REG);
>      cap_hior =3D kvm_check_extension(s, KVM_CAP_PPC_HIOR);
>      cap_epr =3D kvm_check_extension(s, KVM_CAP_PPC_EPR);
> @@ -2422,6 +2422,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
> +bool kvmppc_has_cap_spapr_vfio(void)
> +{
> +    return cap_spapr_vfio;
> +}
> +
>  static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(pcc);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4bseAAoJEGw4ysog2bOSwtAQAOIbfDYd8pq18CNIVrGTmAFe
3hSFhe/2lHDlbWbVeEiqSDLxywEzUQFjM05mwNFzAMJnsEhfa+LSLHW+v77+tr8v
4JcoDDVfAFwW/1JYbmIee8F0XKQVklfRD0PlcXIjiutI4huX+Y3IgVeYT41B5KyR
gfGOeOyYk7BFR2IUc9GwrvynopMP36L7Ot1zFok/BO9XtAmcUXxRkU78NQYAwR8b
6K8kjOhqGF/PYMWD5bqT5HsJxxX/ooJCBPQPGp3/bHlAK54IpiidnZT9Lt+ASWA2
kMeNIA7IuPXsv9sG45AbuJWkEflFopF4T1DnaZSrgppDfv8PNZDPXxpqqdR2EBvm
qJKBdm5yrjp5rbLas7LoMk/+e7HO6hlid3MSXmu5qaOc2ylF12SVtcfExCEE2MIQ
hV6Od80JQCRJKz7Ru0CGXzeuDSvgspfCtzILZWMQNAssdXPZoaKyy06DaeknT8O3
4e2EGTwCS6qUG0xQx3g1r7cR2oE1tO2iXSRaRg3gl200prTi3Pms0VSGHr2sgSA8
K1bPDbEERQCTKUpX4ljMWEomm3R2eZQmKE1o49dJ96Li9I0mdVIx4p92lJ4KJSDA
pkTiNHCFIWK5wfkT9TBxpdiGEIIWdnJ57K6w+EH9ddAbhhgOY340C0ng8ruWYghL
x4mv36pVww7rrIAZU3U/
=eKmQ
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
