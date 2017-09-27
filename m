Received: from eggs.gnu.org ([2001:4830:134:3::10]:35922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx3Nr-00082R-1t
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 23:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx3Np-0005qY-Rs
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 23:51:39 -0400
Date: Wed, 27 Sep 2017 13:51:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170927035114.GL12504@umbus>
References: <20170720072231.35054-1-aik@ozlabs.ru>
	<20170720072231.35054-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AGBBLMjITsWHeOTZ"
Content-Disposition: inline
In-Reply-To: <20170720072231.35054-4-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v4 3/3] spapr/iommu: Enable in-kernel
 TCE acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--AGBBLMjITsWHeOTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 05:22:31PM +1000, Alexey Kardashevskiy wrote:
> This uses new kernel KVM_CAP_SPAPR_TCE_VFIO capability to enable
> in-kernel acceleration of TCE update requests which will go via
> the VFIO KVM device.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I reviewed this before, but I realized a minor nit here.

> ---
>  target/ppc/kvm_ppc.h | 6 ++++++
>  hw/ppc/spapr_iommu.c | 4 ++++
>  target/ppc/kvm.c     | 7 ++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 6bc6fb3e2d..96936ec50f 100644
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
> @@ -220,6 +221,11 @@ static inline bool kvmppc_is_mem_backend_page_size_o=
k(const char *obj_path)
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
> index 82fca61a75..3b4c1f50f4 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -289,6 +289,10 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bo=
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
> index 85713795de..413ce84509 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -134,7 +134,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>      cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
>      cap_spapr_multitce =3D kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE=
);
> -    cap_spapr_vfio =3D false;
> +    cap_spapr_vfio =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_VFIO);

This should probably be kvm_vm_check_extension().  It might not now,
but the availability of the VFIO TCE extension could logically depend
on whether we're KVM or PR, so we need the kernel to know which one
we're dealing with.  See "ppc/kvm: check some capabilities with
kvm_vm_check_extension()" in ppc-for-2.11 for some recent changes on
the same basis (not merged yet, so the SHA's not fixed).

>      cap_one_reg =3D kvm_check_extension(s, KVM_CAP_ONE_REG);
>      cap_hior =3D kvm_check_extension(s, KVM_CAP_PPC_HIOR);
>      cap_epr =3D kvm_check_extension(s, KVM_CAP_PPC_EPR);
> @@ -2428,6 +2428,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
> +bool kvmppc_has_cap_spapr_vfio(void)
> +{
> +    return cap_spapr_vfio;
> +}
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr =3D mfpvr();

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AGBBLMjITsWHeOTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnLIC8ACgkQbDjKyiDZ
s5Lo3Q/7BPnzG5/d7zlEfV2Xj3C7gwIZwbe/kNH1znTmWtPV29ph+vDBrWl3hClX
LaL2wur4aOxRK2e+iSICBVcQ9b2mgGm5tS3M/o/dUDOZ5LMhe1VuN8Ee73ENzHtj
IZ6qBb/rqvmo9YMABwwmEsouc4BIGOgbHfdc1/2TljzktOJ6TWW+uh0KHqvBYxp2
O3IaP3Rw//9OHu6OZFGMjOtkl39XMf4oOZOAUklOGd/8isguTBy80dcUWyr8MWKb
DfODP0JWvUTCk4RCr3kpR16QQpfCOOcJ3AMg8XF69A9p50QOIpA9FCx6zhrxPAcC
aqw2a002apP71cKzWk7YqneAPDhfOUCrXMWQHBgzJMBzuw8bK2yoeGU72f97xItT
4dFRCbDeV2FL6SyXrUAoi97D7z1YoHovyFpufPoEQIKyW8dTUKZnPGDo5nv4Vu4G
GmAYWNHfoXpkKtObK20M1dm8C6J3WdCB2pryk4flXxZsMpN3YY4TT/OreZOvSS+Y
5O8Ng2k1tfkvGOZdTYWrMBXkB8U8/QNR61MhCHqKg5ES8xg73KXQOywh98I/1RI4
YKHOWL9mhNFMvl/kuF9UQWKwMmf4Y9glRyzh5B2PISBb37KXYAGwv1BmD7INfdam
N5Xv/rebioc0bSRaiFJZRN8UTQ6BAQmsCyq2Dc0EsBYqAVWsGuA=
=BYaB
-----END PGP SIGNATURE-----

--AGBBLMjITsWHeOTZ--
