Received: from eggs.gnu.org ([2001:4830:134:3::10]:58229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cqe5g-00044s-Hu
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cqe5a-0003mW-7X
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:06:08 -0400
Date: Wed, 22 Mar 2017 17:33:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170322063349.GE19078@umbus.fritz.box>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-2-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <1489674912-21942-2-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] ppc/xics: introduce an ICPState
 backlink under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:35:05PM +0100, C=E9dric Le Goater wrote:
> Today, the ICPState array of the sPAPR machine is indexed with
> 'cpu_index' of the CPUState. This numbering of CPUs is internal to
> QEMU and the guest only knows about what is exposed in the device
> tree, that is the 'cpu_dt_id'. This is why sPAPR uses the helper
> xics_get_cpu_index_by_dt_id() to do the mapping in a couple of places.
>=20
> To provide a more generic XICS layer, we need to abstract the IRQ
> 'server' number and remove any assumption made on its nature. It
> should not be used as a 'cpu_index' for lookups like xics_cpu_setup()
> and xics_cpu_destroy() do.
>=20
> To reach that goal, we choose to introduce an ICPState backlink under
> PowerPCCPU, and let the machine core init routine do the ICPState
> lookup. The resulting object is stored under PowerPCCPU which is
> passed on to xics_cpu_setup(). The IRQ 'server' number in XICS is now
> generic. sPAPR uses 'cpu_dt_id' and PowerNV will use 'PIR' number.
>=20
> This also has the benefit of simplifying the sPAPR hcall routines
> which do not need to do any ICPState lookups anymore.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Having a direct link from the cpu to the interrupt state is a good
idea.  However, I'm not so fond of having a field that's specific to a
particular platforms intc in the CPU.  I'd suggest making it instead
an Object *.  We can use it for ICP now, but other platforms can use
it for pointers to per-cpu interrupt state if they need to.

> ---
>  hw/intc/xics.c          |  4 ++--
>  hw/intc/xics_spapr.c    | 20 +++++---------------
>  hw/ppc/spapr_cpu_core.c |  4 +++-
>  target/ppc/cpu.h        |  2 ++
>  4 files changed, 12 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index e740989a1162..5cde86ceb3bc 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -52,7 +52,7 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
> +    ICPState *icp =3D cpu->icp;
> =20
>      assert(icp);
>      assert(cs =3D=3D icp->cs);
> @@ -65,7 +65,7 @@ void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
> +    ICPState *icp =3D cpu->icp;
>      ICPStateClass *icpc;
> =20
>      assert(icp);
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 84d24b2837a7..178b3adc8af7 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -43,11 +43,9 @@
>  static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> -    CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
>      target_ulong cppr =3D args[0];
> =20
> -    icp_set_cppr(icp, cppr);
> +    icp_set_cppr(cpu->icp, cppr);
>      return H_SUCCESS;
>  }
> =20
> @@ -69,9 +67,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
>  static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> -    CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
> -    uint32_t xirr =3D icp_accept(icp);
> +    uint32_t xirr =3D icp_accept(cpu->icp);
> =20
>      args[0] =3D xirr;
>      return H_SUCCESS;
> @@ -80,9 +76,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
>  static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                               target_ulong opcode, target_ulong *args)
>  {
> -    CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
> -    uint32_t xirr =3D icp_accept(icp);
> +    uint32_t xirr =3D icp_accept(cpu->icp);
> =20
>      args[0] =3D xirr;
>      args[1] =3D cpu_get_host_ticks();
> @@ -92,21 +86,17 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
>  static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                            target_ulong opcode, target_ulong *args)
>  {
> -    CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
>      target_ulong xirr =3D args[0];
> =20
> -    icp_eoi(icp, xirr);
> +    icp_eoi(cpu->icp, xirr);
>      return H_SUCCESS;
>  }
> =20
>  static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                              target_ulong opcode, target_ulong *args)
>  {
> -    CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
>      uint32_t mfrr;
> -    uint32_t xirr =3D icp_ipoll(icp, &mfrr);
> +    uint32_t xirr =3D icp_ipoll(cpu->icp, &mfrr);
> =20
>      args[0] =3D xirr;
>      args[1] =3D mfrr;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 6883f0991ae9..59f1cba6fba5 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -63,6 +63,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
>                             Error **errp)
>  {
>      CPUPPCState *env =3D &cpu->env;
> +    XICSFabric *xi =3D XICS_FABRIC(spapr);
> =20
>      /* Set time-base frequency to 512 MHz */
>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> @@ -80,7 +81,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
>          }
>      }
> =20
> -    xics_cpu_setup(XICS_FABRIC(spapr), cpu);
> +    cpu->icp =3D xics_icp_get(xi, CPU(cpu)->cpu_index);
> +    xics_cpu_setup(xi, cpu);
> =20
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 5ee33b3fd315..b1626d0a6607 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1176,6 +1176,7 @@ do {                                            \
> =20
>  typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
>  typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
> +typedef struct ICPState ICPState;
> =20
>  /**
>   * PowerPCCPU:
> @@ -1196,6 +1197,7 @@ struct PowerPCCPU {
>      uint32_t max_compat;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> +    ICPState *icp;
> =20
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY0hrLAAoJEGw4ysog2bOSFEIP/R/D9zKmJyF/gydXtcOAFE54
ADuW9f0d4zUVFYXmMVwKXCQTf3JHjKkyERu0ZVvIbjVQ2LsUW6tjECgZZCDl4r6g
tcWyW/d5/QGrR25tqBLO/XNM5SDsqhMIayCCiJJxTd+UPfguX87tAiVkPH9Q5XTi
ltmwziPf19yzLOKtFVGWkbcYqjIhNO3DRFoNyv/CmFOGqFmCZKgwnwOS6hbq5BTI
Ddxtl+HH6ff44B4cIz21IIpOQE6xC0RIOdnZzT3Nh9Pd74HTReKcCXgERhn0eaKN
LtXL0DdHXRZ0++huTUJitX6iYPrgo8lEoQZ1YYvwsow1Cp9xnw446Te5RiPokAux
URgeFv1LhAGQlMuD/BIQpmmWZCh4+9/nhgl/6O/v1/DG9TxYyYKvHMSzdtqOXZu+
WCgW0W796msV9lAEolOMDdTkiQfpLMSYy1Byw9GPhmJqAhvWYHYV/r36qhqo7DiE
Hnh9Gn9F2lXYUcw6yKwytH2zaQYpuU5WOCnFijfxwN/OGH/Kjvdb6QA5OBrh70Tv
ZnhWT1YyqMAglVmKucMHKy3EFKeLjJhkIF1IgZiED5DJt7jtyCivq5A146LkOpfh
GL19latBdPg8cYk099Ck20zL06sL/lM5e821hZhPbDSnERXBH5RJvmapRY5CGgUn
6ZISTd4aTyIe4RONmA4k
=Z/P4
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
