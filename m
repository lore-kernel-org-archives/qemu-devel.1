Received: from eggs.gnu.org ([2001:4830:134:3::10]:49040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYm4W-00050r-7X
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYm4T-00009Y-L7
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:08:07 -0500
Date: Mon, 17 Dec 2018 17:07:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181217060717.GI5597@umbus.fritz.box>
References: <20181211223823.13770-1-clg@kaod.org>
	<20181211223823.13770-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline
In-Reply-To: <20181211223823.13770-12-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v8 11/12] spapr: introduce a new sPAPR IRQ
 backend supporting XIVE and XICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:38:22PM +0100, C=E9dric Le Goater wrote:
> The 'dual' sPAPR IRQ backend supports both interrupt mode, XIVE
> exploitation mode and the legacy compatibility mode (XICS). both modes
> are not supported at the same time.
>=20
> The machine starts with the legacy mode and a new interrupt mode can
> then be negotiated by the CAS process. In this case, the new mode is
> activated after a reset to take into account the required changes in
> the machine. These impact the device tree layout, the interrupt
> presenter object and the exposed MMIO regions in the case of XIVE.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Changes since v7:
>=20
>  - usage of 'ic-mode' machine option
>=20
>  include/hw/ppc/spapr_irq.h |   1 +
>  hw/ppc/spapr.c             |  10 ++-
>  hw/ppc/spapr_hcall.c       |  11 +++
>  hw/ppc/spapr_irq.c         | 143 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 162 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index b34d5a00381b..29936498dbc8 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -51,6 +51,7 @@ typedef struct sPAPRIrq {
>  extern sPAPRIrq spapr_irq_xics;
>  extern sPAPRIrq spapr_irq_xics_legacy;
>  extern sPAPRIrq spapr_irq_xive;
> +extern sPAPRIrq spapr_irq_dual;
> =20
>  void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5d985e38a598..97a5e3c9929f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2636,11 +2636,11 @@ static void spapr_machine_init(MachineState *mach=
ine)
>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> =20
>      /* advertise XIVE on POWER9 machines */
> -    if (spapr->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
> +    if (spapr->irq->ov5 & (SPAPR_OV5_XIVE_EXPLOIT | SPAPR_OV5_XIVE_BOTH)=
) {
>          if (ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL=
_3_00,
>                                    0, spapr->max_compat_pvr)) {
>              spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
> -        } else {
> +        } else if (spapr->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
>              error_report("XIVE-only machines require a POWER9 CPU");
>              exit(1);
>          }
> @@ -3066,6 +3066,8 @@ static char *spapr_get_ic_mode(Object *obj, Error *=
*errp)
>          return g_strdup("xics");
>      } else if (spapr->irq =3D=3D &spapr_irq_xive) {
>          return g_strdup("xive");
> +    } else if (spapr->irq =3D=3D &spapr_irq_dual) {
> +        return g_strdup("dual");
>      }
>      g_assert_not_reached();
>  }
> @@ -3079,6 +3081,8 @@ static void spapr_set_ic_mode(Object *obj, const ch=
ar *value, Error **errp)
>          spapr->irq =3D &spapr_irq_xics;
>      } else if (strcmp(value, "xive") =3D=3D 0) {
>          spapr->irq =3D &spapr_irq_xive;
> +    } else if (strcmp(value, "dual") =3D=3D 0) {
> +        spapr->irq =3D &spapr_irq_dual;
>      } else {
>          error_setg(errp, "Bad value for \"ic-mode\" property");
>      }
> @@ -3127,7 +3131,7 @@ static void spapr_instance_init(Object *obj)
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
>                              spapr_set_ic_mode, NULL);
>      object_property_set_description(obj, "ic-mode",
> -                 "Specifies the interrupt controller mode (xics, xive)",
> +                 "Specifies the interrupt controller mode (xics, xive, d=
ual)",
>                   NULL);
>  }
> =20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index ae913d070f50..09386458f267 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1654,6 +1654,17 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
>                                            ov5_updates) !=3D 0);
>      }
> +
> +    /*
> +     * Generate a machine reset when we have an update of the
> +     * interrupt mode. Only required on the machine supporting both
> +     * mode.
> +     */
> +    if (!spapr->cas_reboot) {
> +        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT)
> +            && spapr->irq->ov5 & SPAPR_OV5_XIVE_BOTH;
> +    }
> +
>      spapr_ovec_cleanup(ov5_updates);
> =20
>      if (spapr->cas_reboot) {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index b1319905327f..31d195b08952 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -375,6 +375,149 @@ sPAPRIrq spapr_irq_xive =3D {
>      .reset       =3D spapr_irq_reset_xive,
>  };
> =20
> +/*
> + * Dual XIVE and XICS IRQ backend.
> + *
> + * Both interrupt mode, XIVE and XICS, objects are created but the
> + * machine starts in legacy interrupt mode (XICS). It can be changed
> + * by the CAS negotiation process and, in that case, the new mode is
> + * activated after extra machine reset.
> + */
> +
> +/*
> + * Returns the sPAPR IRQ backend negotiated by CAS. XICS is the
> + * default.
> + */
> +static sPAPRIrq *spapr_irq_current(sPAPRMachineState *spapr)
> +{
> +    return spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ?
> +        &spapr_irq_xive : &spapr_irq_xics;
> +}
> +
> +static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **errp)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    Error *local_err =3D NULL;
> +
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +        error_setg(errp, "No KVM support for the 'dual' machine");
> +        return;
> +    }
> +
> +    spapr_irq_xics.init(spapr, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    spapr_irq_xive.init(spapr, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +}
> +
> +static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, bool =
lsi,
> +                                Error **errp)
> +{
> +    int ret;
> +    Error *local_err =3D NULL;
> +
> +    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return ret;
> +    }
> +
> +    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
> +
> +    return ret;
> +}
> +
> +static void spapr_irq_free_dual(sPAPRMachineState *spapr, int irq, int n=
um)
> +{
> +    spapr_irq_xive.free(spapr, irq, num);
> +    spapr_irq_xics.free(spapr, irq, num);
> +}
> +
> +static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
> +{
> +    return spapr_irq_current(spapr)->qirq(spapr, irq);
> +}

This still makes me really nervous - I'd really prefer to have qirqs
independent of the backend, rather than relying on *every* irq using
device never looking up qirqs in advance.

> +static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monitor =
*mon)
> +{
> +    spapr_irq_current(spapr)->print_info(spapr, mon);
> +}
> +
> +static void spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
> +                                       uint32_t nr_servers, void *fdt,
> +                                       uint32_t phandle)
> +{
> +    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandl=
e);
> +}
> +
> +static Object *spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spapr,
> +                                              Object *cpu, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +
> +    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    /* Default to XICS interrupt mode */
> +    return spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
> +}
> +
> +static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int versio=
n_id)
> +{
> +    /*
> +     * Force a reset of the XIVE backend after migration. The machine
> +     * defaults to XICS at startup.
> +     */
> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        spapr_irq_xive.reset(spapr, &error_fatal);
> +    }
> +
> +    return spapr_irq_current(spapr)->post_load(spapr, version_id);
> +}
> +
> +static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
> +{
> +    /*
> +     * Reset the interrupt mode selected by CAS.
> +     */
> +    spapr_irq_current(spapr)->reset(spapr, errp);
> +}
> +
> +/*
> + * Define values in sync with the XIVE and XICS backend
> + */
> +#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
> +#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ_M=
SI)
> +
> +sPAPRIrq spapr_irq_dual =3D {
> +    .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
> +    .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
> +    .ov5         =3D SPAPR_OV5_XIVE_BOTH,
> +
> +    .init        =3D spapr_irq_init_dual,
> +    .claim       =3D spapr_irq_claim_dual,
> +    .free        =3D spapr_irq_free_dual,
> +    .qirq        =3D spapr_qirq_dual,
> +    .print_info  =3D spapr_irq_print_info_dual,
> +    .dt_populate =3D spapr_irq_dt_populate_dual,
> +    .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
> +    .post_load   =3D spapr_irq_post_load_dual,
> +    .reset       =3D spapr_irq_reset_dual,
> +};
> +
>  /*
>   * sPAPR IRQ frontend routines for devices
>   */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwXPRUACgkQbDjKyiDZ
s5L8vRAAyGa8s7lbAXNfqgelYluA20K7wxJEXFARRsBxDL4mSElcFJQsSGthdFSp
rxLrzNTIyKyVz+XtH25v8hkGDvIDfN/A6eehE/Usa8xuEAspLFkufeCTN4iOGL4J
Q6H8drcVl/ZHHMy/bPx66vaa/c6hjMK3oBu13VAlgCb/JXCW8tYo+D2N1tdKdLim
GbYdFo4Jv1uRmP9Dk5/5B94HVmTkCp729HWQLNGXr3/9Adlocy99o9chk0yXiwLy
lz4mZHQlZuWI0zF4pWfevaOrKEptczoaketq39rP3lONgezPv+U0id3vl89AK7bR
yJMdJoJNwHghy9cKM9EBef6Ib3cUBz2A/j0bZqxTvojEhBijWVK9dxikDFXARoLm
Yp5iXgPZBhKWa5Kdb/0BhzYkGiZ1iApltZTXXcXrhr4m0Qi0sySNpFq5mRxcE5mq
5XNrnP64/9jxhvALpQ9OdXZeW2fd9DfvPsncyDv5N8gDboo3UHDKE8/16juHz633
uPpkivSqHrNbtD8n5/cptP4lc3Ovdqm1xQ6wNtiuxlCd1S/tHhFnw8ZdK52u5AVl
Bxn/oB6SDYA2lhAunGwm+lEaKA/o5e9B+Z0YJB+C4I2EIoq5YPE9C+/HX76Z3z/M
LPkyU8+mIR3asbmZkbVWJ4ju50vr7CfYSz3v+gKm42L7LlMOAys=
=i6Tv
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--
