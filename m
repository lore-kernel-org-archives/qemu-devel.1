Received: from eggs.gnu.org ([2001:4830:134:3::10]:46390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct5JK-0001rg-GK
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct5JH-0003am-6P
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:34:18 -0400
Date: Wed, 29 Mar 2017 15:11:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329041152.GV21068@umbus.fritz.box>
References: <1490686352-24017-1-git-send-email-clg@kaod.org>
	<1490686352-24017-2-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OlucDFihBVSxvK/7"
Content-Disposition: inline
In-Reply-To: <1490686352-24017-2-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] ppc/xics: introduce an 'icp'
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


--OlucDFihBVSxvK/7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 09:32:25AM +0200, C=E9dric Le Goater wrote:
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
> To reach that goal, we choose to introduce an 'icp' backlink under
> PowerPCCPU, and let the machine core init routine do the ICPState
> lookup. The resulting object is stored under PowerPCCPU which is
> passed on to xics_cpu_setup(). The IRQ 'server' number in XICS is now
> generic. sPAPR uses 'cpu_dt_id' and PowerNV will use 'PIR' number.
>=20
> This also has the benefit of simplifying the sPAPR hcall routines
> which do not need to do any ICPState lookups anymore.

Since you've changed the type to a generic Object *, the name needs to
be changed to something generic as well.  Maybe 'intc' or
'irq_private'.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
> Changes since v2:
>=20
>  - changed the 'icp' backlink type to be an 'Object'
>=20
>  hw/intc/xics.c          |  4 ++--
>  hw/intc/xics_spapr.c    | 20 +++++---------------
>  hw/ppc/spapr_cpu_core.c |  5 ++++-
>  target/ppc/cpu.h        |  1 +
>  4 files changed, 12 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index e740989a1162..bb485cc5b078 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -52,7 +52,7 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
> +    ICPState *icp =3D ICP(cpu->icp);
> =20
>      assert(icp);
>      assert(cs =3D=3D icp->cs);
> @@ -65,7 +65,7 @@ void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
> +    ICPState *icp =3D ICP(cpu->icp);
>      ICPStateClass *icpc;
> =20
>      assert(icp);
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 84d24b2837a7..6144f9876ae3 100644
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
> +    icp_set_cppr(ICP(cpu->icp), cppr);
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
> +    uint32_t xirr =3D icp_accept(ICP(cpu->icp));
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
> +    uint32_t xirr =3D icp_accept(ICP(cpu->icp));
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
> +    icp_eoi(ICP(cpu->icp), xirr);
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
> +    uint32_t xirr =3D icp_ipoll(ICP(cpu->icp), &mfrr);
> =20
>      args[0] =3D xirr;
>      args[1] =3D mfrr;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 6883f0991ae9..f9ca3f09a0f8 100644
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
> @@ -80,7 +82,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
>          }
>      }
> =20
> -    xics_cpu_setup(XICS_FABRIC(spapr), cpu);
> +    cpu->icp =3D OBJECT(icp);
> +    xics_cpu_setup(xi, cpu);
> =20
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 5ee33b3fd315..774f2d717831 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1196,6 +1196,7 @@ struct PowerPCCPU {
>      uint32_t max_compat;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> +    Object *icp;
> =20
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OlucDFihBVSxvK/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2zQIAAoJEGw4ysog2bOSwtgQAOJc+qPMF/abbBF3n8NBrYpv
ZBirjhKPdwPNctgYTG25Zd9oxqNezOvtDqlRQmxYjxYXefFxjFzJEOFGeIYV0eiz
mbRqUV2rJiLfUQfWUdlwpKKjfhNaWRaDp+VTUxa6dYiFwjVLUg8g8HBJmZMHQ86j
5F8L4xjRp2UJnbsWVwUQhNoy1WZOfJzw8enX4EA2IUaOZxRbjXURJjow1xHyhcTe
zWdMhOX2A3wqwTxUtTybq0nP15s/wy4dSdAnIJUKNKX03jtQRR7DNn94y47hh146
s6Cm955zjNCi3RcOOeVj3Ka/gZKx5Nia45DqAwiGAolEVmtg3WdtSMGsafQ5+5qm
BmLPJGSQQu2zCmuRghGZpfRZk+7Jx7nwCuILFzODpaeEA/UtgDXsnIKhR0Nrs6DA
2OW17unc+FM9hbm/DsggTb/CPe4/x9IcS36/VTZnZoPwESTJX1KfVKsCV2Yq1qj2
tpVllzLphMEWcmivXAHIEyoAiffZ+eRgfv+40jOM6dqanv5azYowp5xgHEcKf1G9
2BNk6x/qRghOHLNkjldGqElLUG36kcgMgDFxqZmJmxXKJW5ouSjTormCX22KlODK
w0Pnuw5KUI2DOuM3n0niurlI/t26uIP3xq982ZE5GahRqr+nHTPR2OXHuFVLde3f
xlgJXnRwEAc0Pc3MhsdQ
=JVLS
-----END PGP SIGNATURE-----

--OlucDFihBVSxvK/7--
