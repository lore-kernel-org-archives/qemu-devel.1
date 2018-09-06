Received: from eggs.gnu.org ([2001:4830:134:3::10]:47110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fxlJq-0006k6-2U
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fxlJm-0006wX-RX
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:50:58 -0400
Date: Thu, 6 Sep 2018 13:25:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180906032543.GA26021@umbus.fritz.box>
References: <20180904092418.2380-1-nikunj@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20180904092418.2380-1-nikunj@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] target/ppc/kvm: set vcpu as
 online/offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@samba.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 02:54:18PM +0530, Nikunj A Dadhania wrote:
> Set the newly added register(KVM_REG_PPC_ONLINE) to indicate if the vcpu =
is
> online(1) or offline(0)
>=20
> KVM will use this information to set the RWMR register, which controls th=
e PURR
> and SPURR accumulation.
>=20
> CC: paulus@samba.org
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.ibm.com>

Merged to ppc-for-3.1, thanks.

> ---
>  hw/ppc/spapr_cpu_core.c | 1 +
>  hw/ppc/spapr_rtas.c     | 2 ++
>  target/ppc/kvm.c        | 9 +++++++++
>  target/ppc/kvm_ppc.h    | 7 +++++++
>  4 files changed, 19 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 876f0b3d9d..9863221756 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -90,6 +90,7 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_=
ulong nip, target_ulong r
> =20
>      env->nip =3D nip;
>      env->gpr[3] =3D r3;
> +    kvmppc_set_reg_ppc_online(cpu, 1);
>      CPU(cpu)->halted =3D 0;
>      /* Enable Power-saving mode Exit Cause exceptions */
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 4ac96bc94b..d6a0952154 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -33,6 +33,7 @@
>  #include "sysemu/device_tree.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/hw_accel.h"
> +#include "kvm_ppc.h"
> =20
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
> @@ -207,6 +208,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
>       * guest */
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
>      cs->halted =3D 1;
> +    kvmppc_set_reg_ppc_online(cpu, 0);
>      qemu_cpu_kick(cs);
>  }
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9211ee2ee1..7be8081968 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2785,3 +2785,12 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cp=
u)
> =20
>      return !kvmppc_is_pr(cs->kvm_state);
>  }
> +
> +void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (kvm_enabled()) {
> +        kvm_set_one_reg(cs, KVM_REG_PPC_ONLINE, &online);
> +    }
> +}
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 657582bb32..f696c6e498 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -72,6 +72,7 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> =20
>  bool kvmppc_hpt_needs_host_contiguous_pages(void);
>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
> +void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
> =20
>  #else
> =20
> @@ -187,6 +188,12 @@ static inline target_ulong kvmppc_configure_v3_mmu(P=
owerPCCPU *cpu,
>      return 0;
>  }
> =20
> +static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
> +                                             unsigned int online)
> +{
> +    return;
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static inline bool kvmppc_spapr_use_multitce(void)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluQnjUACgkQbDjKyiDZ
s5IjnA/+Oh/oRrOI/bXO9lH1qrTA6kK42OA4svP2Yibvn/U+hATgpI/pBu0HOFyb
0JhDxZ1qMhFWaG0d16M6jgOOIVK76VZrH7I1WYPSeMWxIbADGCXfZjaJK4ykiWSZ
FendlnSkEzfT54cFuFV9Gx+OBqN4zxgMNaDme3o7LuVb0Px9uRAHABb1/xO1b8kX
6VAylyPHin7ekm+RMIIDggwhyNqDG3PmlEqFMf/h7mvZ3kdowNS0Rjz2v8SYvr0U
WFXYl3UeTSKvCTI7k+31sTGein6jaFbmOPqJhkjmIfaPWkwyOdzSaTkZOr25kxMI
UH8he6uANovBZtQJTFd/GbsdLVj1MLRKC0AXApfBN3ZZcPGO8ZF7Z9fdnKckHWTO
y6MQBLdPKIw4rKmEUJkY5XYhuWctE3KlAF46sNnIznAm9Qi+ZBwTyTgTvALeURs6
t3CPfHzpa84yB+NRYQwoZfcu8cwlkempDHSuIIs3JQFOyGa32KpDd9lFsPbob6Ar
Yrk6ZgaPPfcWipUFS/t2dM7NxKLwWlzLYghnCuc2leCl406BiNVriWwRpT15EI7u
xrdLOPaT03mbG+FU7TQGw5o6CThjgNPozdliYVJ2qNfoyiDDrHxUex3VaV8LeIPR
7Wvh1tqllc7McXz8+z9ObcHVdHUNJvZqlXinXg7Yb9dUPoW8K5o=
=56i7
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
