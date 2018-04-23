Received: from eggs.gnu.org ([2001:4830:134:3::10]:52470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAVLL-0003k4-Tn
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAVLI-000569-QI
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:52:55 -0400
Date: Mon, 23 Apr 2018 16:52:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180423065245.GH19804@umbus.fritz.box>
References: <20180423061302.24201-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20180423061302.24201-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc/kvm: set vcpu as online/offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@samba.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 11:43:02AM +0530, Nikunj A Dadhania wrote:
> Set the newly added register(KVM_REG_PPC_ONLINE) to indicate if the vcpu =
is
> online(1) or offline(0)
>=20
> KVM will use this information to set the RWMR register, which controls th=
e PURR
> and SPURR accumulation.
>=20
> CC: paulus@samba.org
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>=20
> ---
>=20
> http://patchwork.ozlabs.org/patch/901897/
> ---
>  hw/ppc/spapr.c                  | 1 +
>  hw/ppc/spapr_rtas.c             | 4 ++++
>  linux-headers/asm-powerpc/kvm.h | 1 +

The usual convention is to send updates to the imported headers, as a
general update to a specific kernel SHA, rather than folding just the
necessary parts into the patches that use them.

This will need to wait for 2.13.

>  target/ppc/kvm.c                | 9 +++++++++
>  target/ppc/kvm_ppc.h            | 6 ++++++
>  5 files changed, 21 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a81570e7c8..48bafe3765 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1549,6 +1549,7 @@ static void spapr_machine_reset(void)
>      first_ppc_cpu->env.gpr[5] =3D 0;
>      first_cpu->halted =3D 0;
>      first_ppc_cpu->env.nip =3D SPAPR_ENTRY_POINT;
> +    kvmppc_set_reg_ppc_online(first_ppc_cpu, 1);
> =20
>      spapr->cas_reboot =3D false;
>  }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 0ec5fa4cfe..0874a746dd 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -33,6 +33,7 @@
>  #include "sysemu/device_tree.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/kvm.h"
> +#include "kvm_ppc.h"
> =20
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
> @@ -184,6 +185,8 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMac=
hineState *spapr,
>          spapr_cpu_set_endianness(cpu);
>          spapr_cpu_update_tb_offset(cpu);
> =20
> +        kvmppc_set_reg_ppc_online(cpu, 1);
> +
>          qemu_cpu_kick(cs);
> =20
>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> @@ -204,6 +207,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
>      cs->halted =3D 1;
> +    kvmppc_set_reg_ppc_online(cpu, 0);
>      qemu_cpu_kick(cs);
> =20
>      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/=
kvm.h
> index 833ed9a16a..1b32b56a03 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -633,6 +633,7 @@ struct kvm_ppc_cpu_char {
>  #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
> =20
>  #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
> +#define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
> =20
>  /* Transactional Memory checkpointed state:
>   * This is all GPRs, all VSX regs and a subset of SPRs
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 79a436a384..32a146f838 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2877,3 +2877,12 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cp=
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
> index 4d2789eef6..7a915fe422 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -72,6 +72,7 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ul=
ong flags, int shift);
>  bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> =20
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
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
>  static inline off_t kvmppc_alloc_rma(void **rma)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrdgr0ACgkQbDjKyiDZ
s5Jkbg//SisiW9fu4NvfT/P49oN0qGPNeag1CqhcJ/sVmwEUIg6CrSKadDVa+GeU
pOHbr1v6wms6/JLq0BFUv7Hkf+p43qcfn75Z137JI9yOReOa6tJrTDJENzxEpY/Q
4UmTjxXbIONpKf6eSJiaCoTOPcNWumj68a22n4jIdwRKrK+cDGAW1NZUGe9aA19m
PoaSlE4UaRYR2HREF99bY2RoQ+ILAcTwSmuVn3wJzjkhCiL10lSux4T1IHyZVSmB
LFVRLlRlqmupAA8mBbmwaV+W+xJdOVYsmXB82YwnXR9vF6dD8uRkXq+iH8HZxWo+
MptZjrqlegVlKp0g6gKh6izhwWFOwd1CY13lQH613zt1Pv6IZvinZ9Z0C95oXFqf
AHZ1Ef0ni6wMdOUsnzETp9aUY3xlrHgX5cRzwEuDGvmJVo0TgqrkkR8Ei8kQd32j
f1w0Ts04Qww6dVG+BpQxO5IwjgyrOvcW/AFEN/qj/J4mZ5/zd0odYw02QavrvZX1
mO6rrMrspIm1tnRbb/oByldNYnDE0FNyfgghSZr2zY3f727D2Dw/OezQDVlFE7R1
/MkLc7Wa+bc66OmATfNxH/wy80kR/+hIWaF/+W6FN4P2k4WpE1/saUae0x45imHC
Pff2Z0LTCRCqR2LZm7uZs0ME5YQ5oWRcqtKFzcxCtkI1Uh+4zNU=
=x0JJ
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
