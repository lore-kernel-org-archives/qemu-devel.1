Received: from eggs.gnu.org ([2001:4830:134:3::10]:57461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzYf3-000727-6k
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzYf0-0007BK-5G
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:39:45 -0400
Date: Wed, 4 Oct 2017 12:34:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004013456.GR3260@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659510129.25889.17733386928036958909.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N+qDRRsDvMgizTft"
Content-Disposition: inline
In-Reply-To: <150659510129.25889.17733386928036958909.stgit@aravinda>
Subject: Re: [Qemu-devel] [PATCH v5 5/6] ppc: spapr: Enable FWNMI capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--N+qDRRsDvMgizTft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 04:08:21PM +0530, Aravinda Prasad wrote:
> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
> the KVM causes guest exit with NMI as exit reason
> when it encounters a machine check exception on the
> address belonging to a guest. Without this capability
> enabled, KVM redirects machine check exceptions to
> guest's 0x200 vector.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_rtas.c  |   15 +++++++++++++++
>  target/ppc/kvm.c     |   13 +++++++++++++
>  target/ppc/kvm_ppc.h |    6 ++++++
>  3 files changed, 34 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 08e9a5e..d017a67 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -46,6 +46,7 @@
>  #include "qemu/cutils.h"
>  #include "trace.h"
>  #include "hw/ppc/fdt.h"
> +#include "kvm_ppc.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
> @@ -354,6 +355,20 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>                                    target_ulong args,
>                                    uint32_t nret, target_ulong rets)
>  {
> +    int ret;
> +
> +    ret =3D kvmppc_fwnmi_enable(cpu);

If you're enabling it here, doesn't that mean you need to disable it
on reset?

> +    if (ret =3D=3D 1) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    if (ret < 0) {
> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        return;
> +    }
> +
>      spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7e4ce02..59b3322 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -92,6 +92,7 @@ static int cap_mmu_radix;
>  static int cap_mmu_hash_v3;
>  static int cap_resize_hpt;
>  static int cap_ppc_pvr_compat;
> +static int cap_fwnmi;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -150,6 +151,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
> +    cap_fwnmi =3D kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2142,6 +2144,17 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mp=
ic_proxy)
>      }
>  }
> =20
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (!cap_fwnmi) {
> +        return 1;
> +    }
> +
> +    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);

Yeah, this is no good.  It means migration from a host that's fwnmi
capable to one that isn't will be subtly broken.  Instead you need to
make fwnmi capability a machine property.  If the property is
requested and the host kernel doesn't support it, you need to outright
fail, rather than try to fall back.

> +}
> +
>  int kvmppc_smt_threads(void)
>  {
>      return cap_ppc_smt ? cap_ppc_smt : 1;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 0139dae..55b6df2 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -28,6 +28,7 @@ void kvmppc_enable_clear_ref_mod_hcalls(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
>  int kvmppc_smt_threads(void);
>  void kvmppc_hint_smt_possible(Error **errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -157,6 +158,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
*cpu, int mpic_proxy)
>  {
>  }
> =20
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> +{
> +    return 1;

Likewise, this should be available, not banned, on TCG.  I think there
are existing problems with TCG<->KVM migration, but there's no
inherent reason they shouldn't work, so we don't want to introduce
extra reasons they don't.

Even if TCG will never generate fwnmis (for now), it should allow the
guest to register for them.

> +}
> +
>  static inline int kvmppc_smt_threads(void)
>  {
>      return 1;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N+qDRRsDvMgizTft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUOsAACgkQbDjKyiDZ
s5Jefg/9FyYUuak5fRXpnGv1xhrAr2vVa7oliStMctbtIE7maCrv4K0X1NwQsaJv
6ZCpthFNv0oeMLYJTieVFPU9CQZCMyptwH56X2PUYABu12xI/Zp8TyiWKZoM46Cy
KvPtk70AM07lY0r+rdOFowea1FPU5SdUKGnznexXtzti/pK5aKvW0EtPTJSGwPcU
tQJmj3dM8ldTdFhov/HLRONCEOVbWXJCO2tbr7LNaQkaal6497zrBqD7lpHZJStO
JYb/MSC3JAlBcl3ocbuIc4qxLGcULfnGfz4fSgcInaerb7yT2bZu9+tfHRCd9KCo
HNNy/vdErWR2DS8N+dLBRIBcZ6xs0/BLRE7w0jugiEoCd+EyQrNTE8KX2p0ynsKd
id1SLuOZ9uakvuF2ke8lUQmvhsvRGKMJ3Ydf0o1lh6Cnw5KJX6svlP2sTYNxr64g
xWTg9weOp3pG1ZJKsHfCa5l9wYp7rE7VjgIEuS7OOWdon81Z+5xDLFRVFRVAUC6K
sv9Wfm9oVFlR6wCbS0nlgD4Ny/EiRWeGiPeHx+09uMvelsTIB5AVsDQefC00tEgK
7EF2AG/pxJskKZcAut74lwCxmkMHY3Sa7801RrM4Hkn0jS/YWALJlW54OXY37TIE
pRfXnudzXY8+k1yJTjgMh/KnSDFp6W9D3/LHBvJ3Qi3mv1z1x6k=
=zwK1
-----END PGP SIGNATURE-----

--N+qDRRsDvMgizTft--
