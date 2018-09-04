Received: from eggs.gnu.org ([2001:4830:134:3::10]:34423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fx4rr-0008RG-OX
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 02:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fx4ro-0000tK-88
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 02:31:15 -0400
Date: Tue, 4 Sep 2018 15:57:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180904055705.GH2679@umbus.fritz.box>
References: <20180904053039.19543-1-nikunj@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q6STzHxy03qt/hK9"
Content-Disposition: inline
In-Reply-To: <20180904053039.19543-1-nikunj@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc/kvm: set vcpu as
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


--Q6STzHxy03qt/hK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 11:00:39AM +0530, Nikunj A Dadhania wrote:
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
> ---
>  hw/ppc/spapr_cpu_core.c | 1 +
>  hw/ppc/spapr_rtas.c     | 3 +++
>  target/ppc/kvm.c        | 9 +++++++++
>  target/ppc/kvm_ppc.h    | 6 ++++++
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
> index 4ac96bc94b..ce8072689b 100644
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
> @@ -187,6 +188,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPR=
MachineState *spapr,
>      newcpu->env.tb_env->tb_offset =3D callcpu->env.tb_env->tb_offset;
> =20
>      spapr_cpu_set_entry_state(newcpu, start, r3);
> +    kvmppc_set_reg_ppc_online(newcpu, 1);

You're setting online in spapr_cpu_set_entry_state() called
immediately above, so you don't need it here as well.

> =20
>      qemu_cpu_kick(CPU(newcpu));
> =20
> @@ -207,6 +209,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMach=
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
> index 657582bb32..d635032bd9 100644
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
> @@ -187,6 +188,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(P=
owerPCCPU *cpu,
>      return 0;
>  }
> =20
> +static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned i=
nt online)
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

--Q6STzHxy03qt/hK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluOHq4ACgkQbDjKyiDZ
s5If3RAAw5GplYYhsjGg1TAGUk/jG1C6WXVBQVVvR6VtPvirx7X7xC8F2YbA7+6A
f8boMub4L6HzZkvqtk/Exksr1kzAhHu2VXj6keP8rD29juTAC1NB45prUzI4+CBx
1OWzFuWQwEX0UkAHu4OE/a4uyvge0sXY4rHZwKiCn9RdrMYW+jPt3PAQRQ3VjHMw
7hec+3GOdmuzfG8s+gb/NjpC4k7Ae3/i27AG5gQ97bAsoNGk+Siqqb6xvzra0bQb
FV2mcrTkq/l5r4C0nZ4xhHlwpPl8B56E6TRu32dFo107omYpwskMiz5SM0fGuLqM
eImVer4JzTSlv6sOayrjQqZxiHTFul/DFxnXJ5/WT6xDVC86dVxmNnYgzZ4OtKBC
ri6GijbH7hi7DOeIoanyFFbHC/iNPJk1wDKJ2bTAfKEvWvJDL+N1U5gmDuDWUb/a
HFa3lS5Y+tPRxCFn85tg6lT/6Viriv8gp5ZmQb+OeOR67xUsuqM/WC1nCChL2pti
M52FvQBT2z5hDdSiL924njqIeFpCo0UEgWsT9v465pIv9MvwUWEd8vAWw6ZzSBhX
lhrntq38MXRUKRMfcMXFXc39jRDQWWupCM+V9B2MpLJ01AA2J14FlK7pLeyolO6u
1d3gQOhVfy0IEPO9MAMK+AFtyk0wi4rVj6ICx2NA5/kJNmm+7Fs=
=1BAU
-----END PGP SIGNATURE-----

--Q6STzHxy03qt/hK9--
