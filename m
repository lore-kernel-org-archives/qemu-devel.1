Received: from eggs.gnu.org ([2001:4830:134:3::10]:57274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cub0S-0002MT-EJ
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 04:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cub0Q-0000Tx-Na
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 04:37:04 -0400
Date: Sun, 2 Apr 2017 18:25:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170402082559.GH16790@umbus.fritz.box>
References: <1490795611-4762-3-git-send-email-clg@kaod.org>
	<1490886484-6147-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <1490886484-6147-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 2+/9] spapr: allocate the ICPState
 object from under sPAPRCPUCore
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


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 05:08:04PM +0200, C=E9dric Le Goater wrote:
> Today, all the ICPs are created before the CPUs, stored in an array
> under the sPAPR machine and linked to the CPU when the core threads
> are realized. This modeling brings some complexity when a lookup in
> the array is required and it can be simplified by allocating the ICPs
> when the CPUs are.
>=20
> This is the purpose of this proposal which introduces a new 'icp_type'
> field under the machine and creates the ICP objects of the right type
> (KVM or not) before the PowerPCCPU object are.
>=20
> This change allows more cleanups : the removal of the icps array under
> the sPAPR machine and the removal xics_get_cpu_index_by_dt_id() helper.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Tested with KVM and TCG. migration is fine.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

But please resend with the whole series, I've lost track of which
versions are which.

>=20
>  hw/intc/xics.c          | 11 -----------
>  hw/ppc/spapr.c          | 47 ++++++++++++++-----------------------------=
----
>  hw/ppc/spapr_cpu_core.c | 18 ++++++++++++++----
>  include/hw/ppc/spapr.h  |  2 +-
>  include/hw/ppc/xics.h   |  2 --
>  5 files changed, 29 insertions(+), 51 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 56fe70cd10e9..d4428b41b03a 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -38,17 +38,6 @@
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
> =20
> -int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
> -{
> -    PowerPCCPU *cpu =3D ppc_get_vcpu_by_dt_id(cpu_dt_id);
> -
> -    if (cpu) {
> -        return cpu->parent_obj.cpu_index;
> -    }
> -
> -    return -1;
> -}
> -
>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b9f7f8607869..18d8fe7458c1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -103,7 +103,6 @@ static int try_create_xics(sPAPRMachineState *spapr, =
const char *type_ics,
>      XICSFabric *xi =3D XICS_FABRIC(spapr);
>      Error *err =3D NULL, *local_err =3D NULL;
>      ICSState *ics =3D NULL;
> -    int i;
> =20
>      ics =3D ICS_SIMPLE(object_new(type_ics));
>      object_property_add_child(OBJECT(spapr), "ics", OBJECT(ics), NULL);
> @@ -112,34 +111,14 @@ static int try_create_xics(sPAPRMachineState *spapr=
, const char *type_ics,
>      object_property_set_bool(OBJECT(ics), true, "realized", &local_err);
>      error_propagate(&err, local_err);
>      if (err) {
> -        goto error;
> +        error_propagate(errp, err);
> +        return -1;
>      }
> =20
> -    spapr->icps =3D g_malloc0(nr_servers * sizeof(ICPState));
>      spapr->nr_servers =3D nr_servers;
> -
> -    for (i =3D 0; i < nr_servers; i++) {
> -        ICPState *icp =3D &spapr->icps[i];
> -
> -        object_initialize(icp, sizeof(*icp), type_icp);
> -        object_property_add_child(OBJECT(spapr), "icp[*]", OBJECT(icp), =
NULL);
> -        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xi), =
NULL);
> -        object_property_set_bool(OBJECT(icp), true, "realized", &err);
> -        if (err) {
> -            goto error;
> -        }
> -        object_unref(OBJECT(icp));
> -    }
> -
>      spapr->ics =3D ics;
> +    spapr->icp_type =3D type_icp;
>      return 0;
> -
> -error:
> -    error_propagate(errp, err);
> -    if (ics) {
> -        object_unparent(OBJECT(ics));
> -    }
> -    return -1;
>  }
> =20
>  static int xics_system_init(MachineState *machine,
> @@ -1366,9 +1345,10 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>      int err =3D 0;
> =20
>      if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
> -        int i;
> -        for (i =3D 0; i < spapr->nr_servers; i++) {
> -            icp_resend(&spapr->icps[i]);
> +        CPUState *cs;
> +        CPU_FOREACH(cs) {
> +            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +            icp_resend(ICP(cpu->intc));
>          }
>      }
> =20
> @@ -3026,20 +3006,21 @@ static void spapr_ics_resend(XICSFabric *dev)
> =20
>  static ICPState *spapr_icp_get(XICSFabric *xi, int cpu_dt_id)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> -    int server =3D xics_get_cpu_index_by_dt_id(cpu_dt_id);
> +    PowerPCCPU *cpu =3D ppc_get_vcpu_by_dt_id(cpu_dt_id);
> =20
> -    return (server < spapr->nr_servers) ? &spapr->icps[server] : NULL;
> +    return cpu ? ICP(cpu->intc) : NULL;
>  }
> =20
>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>                                   Monitor *mon)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> -    int i;
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -    for (i =3D 0; i < spapr->nr_servers; i++) {
> -        icp_pic_print_info(&spapr->icps[i], mon);
> +        icp_pic_print_info(ICP(cpu->intc), mon);
>      }
> =20
>      ics_pic_print_info(spapr->ics, mon);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 4e1a99591d19..c80eb7c34f9f 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -63,8 +63,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
>                             Error **errp)
>  {
>      CPUPPCState *env =3D &cpu->env;
> -    XICSFabric *xi =3D XICS_FABRIC(spapr);
> -    ICPState *icp =3D xics_icp_get(xi, cpu->cpu_dt_id);
> =20
>      /* Set time-base frequency to 512 MHz */
>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> @@ -82,8 +80,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
>          }
>      }
> =20
> -    xics_cpu_setup(xi, cpu, icp);
> -
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
>  }
> @@ -143,18 +139,32 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild, Error **errp)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    Object *obj;
> +
> +    obj =3D object_new(spapr->icp_type);
> +    object_property_add_child(OBJECT(spapr), "icp[*]", obj, NULL);
> +    object_property_add_const_link(obj, "xics", OBJECT(spapr), NULL);
> +    object_property_set_bool(obj, true, "realized", &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
> +        object_unparent(obj);
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
>      spapr_cpu_init(spapr, cpu, &local_err);
>      if (local_err) {
> +        object_unparent(obj);
>          error_propagate(errp, local_err);
>          return;
>      }
> +
> +    xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
>  }
> =20
>  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 808aac870359..db3d4acb18a6 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -96,7 +96,7 @@ struct sPAPRMachineState {
>      MemoryHotplugState hotplug_memory;
> =20
>      uint32_t nr_servers;
> -    ICPState *icps;
> +    const char *icp_type;
>  };
> =20
>  #define H_SUCCESS         0
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 5e0244447fcd..88e0f021b168 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -172,8 +172,6 @@ void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, =
ICPState *icp);
>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu);
> =20
>  /* Internal XICS interfaces */
> -int xics_get_cpu_index_by_dt_id(int cpu_dt_id);
> -
>  void icp_set_cppr(ICPState *icp, uint8_t cppr);
>  void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
>  uint32_t icp_accept(ICPState *ss);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4LWVAAoJEGw4ysog2bOSzB8QAKQXbu31CupE+o11hPE6Op5f
neuBnBNVeSHE6Tbl0eHVDNpwWMlEtSQaZouacW/k2nNvo9j8JyBNVXOGB7CLTnIw
6Q0Ojvd1GB10QyTEMsHf3yDQ4hWSWt/yJEFM5Afysx3nQwcdky3/SvSG7qk/4Hot
CjOLIaH4tNwqqIxRGPB6fgQyFV3Z3YIWcl0mDg84FI0R/bJDcUex5wlcbeHuOWRB
1j4p6X2zHUpmWrylczksKaa6YNSMThyyxmOyu6iBi9jukAtpDhHfJ36AlFusDefg
3jWQIAEzcwvV07lWbgV78caPqvlZDdiS8HyCnfD/F912ksSjEPiiLLpLePxf7L3g
hPtspVH4UyE85UTsaZhzVcDWa3064yVuIZdu9Pjrwt6sJnClFUlQR3LBRoNCv2Ii
UjDjAhtUO3p0nIOV6AcreNgBIR1hw+tEKpMB0pum9yjKUGElZwXSXOKUoc3J7Esz
g0Yc2EpiAuBHSAS2s4RhxJM9kQ4eiWiP17rjgEwBhd/mJ6lO8tjYr1FZwChcpeHM
putewaKGV5x6tQG0NfY99Xm2agySmix6inGxPbE/B2NUkIHeQXncYDfzfaIo602l
v2BRdnTnyE5UYyE4brZRl8HCwVVBsNAxnB0CaeFzchxK0xHIDm6aMsM+eWXFjvZK
JvFb1NJGAae1E7QDqBfB
=0clA
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
