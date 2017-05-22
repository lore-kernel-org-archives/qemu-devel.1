Received: from eggs.gnu.org ([2001:4830:134:3::10]:48184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCcqB-0002jP-0U
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCcq7-0004Wi-Rs
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:12:59 -0400
Date: Mon, 22 May 2017 12:04:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522020413.GF30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518994010.24289.12584852638589552255.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <149518994010.24289.12584852638589552255.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] target/ppc: consolidate CPU
 device-tree id computation in helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 12:32:20PM +0200, Greg Kurz wrote:
> For historical reasons, we compute CPU device-tree ids with a non-trivial
> logic. This patch consolidate the logic in a single helper to be used
> in various places where it is currently open-coded.
>=20
> It is okay to get rid of DIV_ROUND_UP() because we're sure that the number
> of threads per core in the guest cannot exceed the number of threads per
> core in the host.

However, your new logic still gives different answers in some cases.
In particular when max_cpus is not a multiple of smp_threads.  Which
is generally a bad idea, but allowed for older machine types for
compatibility.   e.g. smp_threads=3D4, max_cpus=3D6 smt=3D8

Old logic:
	         DIV_ROUND_UP(6 * 8, 4)
	       =3D =E2=8C=8848 / 4=E2=8C=89 =3D 12

New logic gives: =E2=8C=8A6 / 4=E2=8C=8B * 8 + (6 % 4)
               =3D 1 * 8 + 2
	       =3D 10

In any case the DIV_ROUND_UP() isn't to handle the case where guest
threads-per-core is bigger than host threads-per-core, it's (IIRC) for
the case where guest threads-per-core is not a factor of host
threads-per-core.  Again, a bad idea, but I think allowed in some old
cases.

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c              |    6 ++----
>  target/ppc/cpu.h            |   17 +++++++++++++++++
>  target/ppc/translate_init.c |    3 +--
>  3 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 75e298b4c6be..1bb05a9a6b07 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -981,7 +981,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
>      void *fdt;
>      sPAPRPHBState *phb;
>      char *buf;
> -    int smt =3D kvmppc_smt_threads();
> =20
>      fdt =3D g_malloc0(FDT_MAX_SIZE);
>      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> @@ -1021,7 +1020,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHANDL=
E_XICP);
> +    spapr_dt_xics(ppc_cpu_dt_id_from_index(max_cpus), fdt, PHANDLE_XICP);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> @@ -1977,7 +1976,6 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>      MachineState *machine =3D MACHINE(spapr);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      char *type =3D spapr_get_cpu_core_type(machine->cpu_model);
> -    int smt =3D kvmppc_smt_threads();
>      const CPUArchIdList *possible_cpus;
>      int boot_cores_nr =3D smp_cpus / smp_threads;
>      int i;
> @@ -2014,7 +2012,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>              sPAPRDRConnector *drc =3D
>                  spapr_dr_connector_new(OBJECT(spapr),
>                                         SPAPR_DR_CONNECTOR_TYPE_CPU,
> -                                       (core_id / smp_threads) * smt);
> +                                       ppc_cpu_dt_id_from_index(core_id)=
);
> =20
>              qemu_register_reset(spapr_drc_reset, drc);
>          }
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 401e10e7dad8..47fe6c64698f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2529,4 +2529,21 @@ int ppc_get_vcpu_dt_id(PowerPCCPU *cpu);
>  PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id);
> =20
>  void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n);
> +
> +#if !defined(CONFIG_USER_ONLY)
> +#include "sysemu/cpus.h"
> +#include "target/ppc/kvm_ppc.h"
> +
> +static inline int ppc_cpu_dt_id_from_index(int cpu_index)
> +{
> +    /* POWER HV support has an historical limitation that different thre=
ads
> +     * on a single core cannot be in different guests at the same time. =
In
> +     * order to allow KVM to assign guest threads to host cores accordin=
gly,
> +     * CPU device tree ids are spaced by the number of threads per host =
cores.
> +     */
> +    return (cpu_index / smp_threads) * kvmppc_smt_threads()
> +        + (cpu_index % smp_threads);
> +}
> +#endif
> +
>  #endif /* PPC_CPU_H */
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 56a0ab22cfbe..837a9a496a65 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9851,8 +9851,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>      }
> =20
>  #if !defined(CONFIG_USER_ONLY)
> -    cpu->cpu_dt_id =3D (cs->cpu_index / smp_threads) * max_smt
> -        + (cs->cpu_index % smp_threads);
> +    cpu->cpu_dt_id =3D ppc_cpu_dt_id_from_index(cs->cpu_index);
> =20
>      if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->cpu_dt_id)) {
>          error_setg(errp, "Can't create CPU with id %d in KVM", cpu->cpu_=
dt_id);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIkcaAAoJEGw4ysog2bOSgowP/3s4ia2uIldSgbm5ZLKpeI/C
wdimLR2F3O//7shQSdtMDv6n4Txv5KN9K8aCd0U5n2MoHi8ZY+WOMXQH7j3F9IUx
1zvbszrW29YXmdAfCJjU3hmIDjDOwKzHu3khnbrX03SHNnY7Xmse2N6x7qDlDR/x
4azvUzJ2RgQYpZpSVd3PB0fVwkoKhstY+AIyJDwp83pzkkq7xxV63XGg4nMnzC4X
dqk+EUbCXVbi5/VIHHK7XtgfCh+ZJDj7s93jsnnXBIFAbk1JY156CZr7ubtAzwmT
BA6ERbEjIKV/XARyHTA1pZIr2jZofrKYTA/pQaGKl4NOBMOG6YF7FRVif8jWwD9q
P/cdmVW7rUQbtZ1iBmbFarRdukl+30UeahXzeAFkAHtPt0ouWgfEu5ROnNGkS55F
7DNSUnPTCl89P3zICQjyDBoUrn+3gEFb9p8CNAI0/jNpvPSG0kBfI+p78hIfqKNx
cxWZtOfUtoPJWB+lTJ3KDJzyMbSWLut27h/hxG1ZQTUMMM12G0CLQrVZtIZlyB72
n4mSh/4ITJCw8w7GlcogjYkZA/CaXILmWwd+mFkNTeHCWh9LTwm01on1tV9VOooj
WayxOfc2IyfG9mZTtZVvHmvBbkTDskPaSpIiGBtfuUDs21eNjbia8RZ9airfVBP5
G+Rqd1HeBtWHD4sfp2r8
=qGT8
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
