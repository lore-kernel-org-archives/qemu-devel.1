Received: from eggs.gnu.org ([2001:4830:134:3::10]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csifv-0001Ej-7b
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csifs-0008DG-0J
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:24:07 -0400
Date: Tue, 28 Mar 2017 14:29:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328032948.GB21068@umbus.fritz.box>
References: <20170327052219.33110-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20170327052219.33110-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] target-ppc/kvm: Enable in-kernel TCE
 acceleration for multi-tce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 04:22:19PM +1100, Alexey Kardashevskiy wrote:
> This enables in-kernel handling of H_PUT_TCE_INDIRECT and
> H_STUFF_TCE hypercalls. The host kernel support is there since v4.6,
> in particular d3695aa4f452
> ("KVM: PPC: Add support for multiple-TCE hcalls").
>=20
> H_PUT_TCE is already accelerated and does not need any special enablement.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-2.10.

> ---
>  target/ppc/kvm_ppc.h |  6 ++++++
>  hw/ppc/spapr.c       |  4 +++-
>  target/ppc/kvm.c     | 14 ++++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 4b2fd9a609..f48243d13f 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -39,6 +39,7 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>  #ifndef CONFIG_USER_ONLY
>  off_t kvmppc_alloc_rma(void **rma);
>  bool kvmppc_spapr_use_multitce(void);
> +int kvmppc_spapr_enable_inkernel_multitce(void);
>  void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
>                                uint64_t bus_offset, uint32_t nb_table,
>                                int *pfd, bool need_vfio);
> @@ -180,6 +181,11 @@ static inline bool kvmppc_spapr_use_multitce(void)
>      return false;
>  }
> =20
> +static inline int kvmppc_spapr_enable_inkernel_multitce(void)
> +{
> +    return -1;
> +}
> +
>  static inline void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t pag=
e_shift,
>                                              uint64_t bus_offset,
>                                              uint32_t nb_table,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0e1c29bcf8..8027716f73 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2360,10 +2360,12 @@ static void ppc_spapr_init(MachineState *machine)
> =20
>      qemu_register_boot_set(spapr_boot_set, spapr);
> =20
> -    /* to stop and start vmclock */
>      if (kvm_enabled()) {
> +        /* to stop and start vmclock */
>          qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
>                                           &spapr->tb);
> +
> +        kvmppc_spapr_enable_inkernel_multitce();
>      }
>  }
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 6dc39623e5..560ce655c7 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2194,6 +2194,20 @@ bool kvmppc_spapr_use_multitce(void)
>      return cap_spapr_multitce;
>  }
> =20
> +int kvmppc_spapr_enable_inkernel_multitce(void)
> +{
> +    int ret;
> +
> +    ret =3D kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_ENABLE_HCALL, 0,
> +                            H_PUT_TCE_INDIRECT, 1);
> +    if (!ret) {
> +        ret =3D kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_ENABLE_HCALL, 0,
> +                                H_STUFF_TCE, 1);
> +    }
> +
> +    return ret;
> +}
> +
>  void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
>                                uint64_t bus_offset, uint32_t nb_table,
>                                int *pfd, bool need_vfio)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2dinAAoJEGw4ysog2bOSwGIP/1I5FMGwizG3wQfIR4Kufvdh
hhZQZb9AoR6xAzEGJZ9Mp1FjUJ3HL974yUXi5ei/5sTxjzVTXaSNO4sjIu8usglC
oDb1tWFSIfbgxu7aCMAvAPG7HeifR56zfZMnceqd0rAgegoge+1uYrfDzenvNqLH
BkoLrf09JBLIIuO9vRYAXu6U6VfBZFGn+F6Du6XmTjxTeXJuib9+yVA7GLd/UJFp
CHH3f/fwx75kUheUdxmo1EMF68A6fi85Hxey9gF5rgBi1OXWMefxm6sQxz8P51fq
1iHnWKUccs7bEY/c+yOSdpuuZtIMrvxFY1XssDtsj/ooiJ5PMbqVUf7JUQ9z6eHG
0yUEF/hsNljfJMW6IIUQOTY0VL0vbGp1oVRNnkj9g5CJVJH5OnMFQCn1Loye1ujH
dtbooqGoC2pnHf+YU0tTGNPWZzApdXi9BQlnjWBqZThZSdtq7+YEME0+4ga8qwdx
XQztukh0ZFoaQNFfbQFVOJU/DQUW7fD2igwr97j10TVUeAdH0GPfKOdOeZtappro
XYybMEGIyHitN45fEc5Jutw4uXNRtBbooE/FNQHDLfcuA76er2oc7OU9ICc3iiE8
ud57mlLpHCds3BwKDNhVOmI5dxYMi20oNTNmBOzZjGaVhwg4pZDkk/rvVsz7nZ5M
+rzSKL21pKODWOPwl91x
=RKfR
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
