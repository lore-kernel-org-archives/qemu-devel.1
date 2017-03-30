Received: from eggs.gnu.org ([2001:4830:134:3::10]:53281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctXpd-0002n7-3n
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctXpb-0008LI-3G
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:01:33 -0400
Date: Thu, 30 Mar 2017 17:46:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170330064631.GG22163@umbus>
References: <1490795611-4762-1-git-send-email-clg@kaod.org>
	<1490795611-4762-2-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <1490795611-4762-2-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 1/9] ppc/xics: introduce an 'intc'
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


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 03:53:23PM +0200, C=E9dric Le Goater wrote:
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
> To reach that goal, we choose to introduce a generic 'intc' backlink
> under PowerPCCPU, and let the machine core init routine do the
> ICPState lookup. The resulting object is passed on to xics_cpu_setup()
> which does the store under PowerPCCPU. The IRQ 'server' number in XICS
> is now generic. sPAPR uses 'cpu_dt_id' and PowerNV will use 'PIR'
> number.
>=20
> This also has the benefit of simplifying the sPAPR hcall routines
> which do not need to do any ICPState lookups anymore.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This one's ready to go, I've merged to ppc-for-2.10.

> ---
>=20
> Changes since v3:
>  - renamed 'icp' backlink to a more generic name 'intc'
>=20
>  Changes since v2:
>  - changed the 'icp' backlink type to be an 'Object'
>=20
>  hw/intc/xics.c          |  6 +++---
>  hw/intc/xics_spapr.c    | 20 +++++---------------
>  hw/ppc/spapr_cpu_core.c |  4 +++-
>  include/hw/ppc/xics.h   |  2 +-
>  target/ppc/cpu.h        |  1 +
>  5 files changed, 13 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index e740989a1162..56fe70cd10e9 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -52,7 +52,7 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
> +    ICPState *icp =3D ICP(cpu->intc);
> =20
>      assert(icp);
>      assert(cs =3D=3D icp->cs);
> @@ -61,15 +61,15 @@ void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
>      icp->cs =3D NULL;
>  }
> =20
> -void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
> +void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
>      ICPStateClass *icpc;
> =20
>      assert(icp);
> =20
> +    cpu->intc =3D OBJECT(icp);
>      icp->cs =3D cs;
> =20
>      icpc =3D ICP_GET_CLASS(icp);
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 84d24b2837a7..58f100d379cb 100644
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
> +    icp_set_cppr(ICP(cpu->intc), cppr);
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
> +    uint32_t xirr =3D icp_accept(ICP(cpu->intc));
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
> +    uint32_t xirr =3D icp_accept(ICP(cpu->intc));
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
> +    icp_eoi(ICP(cpu->intc), xirr);
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
> +    uint32_t xirr =3D icp_ipoll(ICP(cpu->intc), &mfrr);
> =20
>      args[0] =3D xirr;
>      args[1] =3D mfrr;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 6883f0991ae9..7db61bd72476 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -63,6 +63,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
>                             Error **errp)
>  {
>      CPUPPCState *env =3D &cpu->env;
> +    XICSFabric *xi =3D XICS_FABRIC(spapr);
> +    ICPState *icp =3D xics_icp_get(xi, CPU(cpu)->cpu_index);
> =20
>      /* Set time-base frequency to 512 MHz */
>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> @@ -80,7 +82,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
>          }
>      }
> =20
> -    xics_cpu_setup(XICS_FABRIC(spapr), cpu);
> +    xics_cpu_setup(xi, cpu, icp);
> =20
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 9a5e715fe553..5e0244447fcd 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -168,7 +168,7 @@ void spapr_dt_xics(int nr_servers, void *fdt, uint32_=
t phandle);
> =20
>  qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
>  ICPState *xics_icp_get(XICSFabric *xi, int server);
> -void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu);
> +void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp);
>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu);
> =20
>  /* Internal XICS interfaces */
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 5ee33b3fd315..b5f93272b839 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1196,6 +1196,7 @@ struct PowerPCCPU {
>      uint32_t max_compat;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> +    Object *intc;
> =20
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY3KnHAAoJEGw4ysog2bOSMCcP+QEQ7mqy1HgiKGCXGwPdCREg
Ze66iz2GK2NVEcjJj2VRDmKk92yeL2Q94xZgl9Zyub1309sginhDLNnrKNHFzxtt
8mWV05H8YWwH3e0m0eUKZWCHHoVlGSCBoTqSdUtFBBlfKCPR+gwOm7dJDA6u355D
e1TuSG/0KYg+jZPljhLiM5IrtNJrPKNgZ2lMEJ6w8ghfnZ/2jSjZmElnQQXx3m0H
+fVVEP+vbs19dlTBjy1NWyz8ygt9vnWlCkr2iiIcSJlwzGI3NWlI7D9TVfY2efYP
R58Hq9VxUAyV695qtYy8jimVp9II/ov0N45eOZRg+yYfzYdCiw/vXXjdOPb6YT6O
IdzFHyyzbTmKL6/zdU8x1ZlwH0414T75jwD1SZJf+AsmRFdGkiPhMMXqRZuZUIlA
YkBX8aLW2VmHy8c/pRjfZH59gEZ7xAvHvlc8LaEXftO0Kv4VO2G5UzzPSC2rsCH8
6v4svzCRx5ezzC2RdkL3IaY1+yrJpPu1Rq0b81oT+VAmbd2wgn8HhObgxrzQpcLB
zdE+JvQAGZjqUPbYnxRnXd9xIa+VCmgLf2vgv9h4jIR1p7LjzVpgxs4v09ILEKIn
GBuEGi5abqCDS96o13UTTjpySU62gAFcG1nXoHDKLRXM1mjm5qMkEmzq80p3HbK5
qvU1iqdgmIBIxEGvKAxz
=xEPA
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
