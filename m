Received: from eggs.gnu.org ([2001:4830:134:3::10]:49487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWXbm-0008Hy-Jh
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWXRQ-0006ku-B1
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:06:35 -0500
Date: Tue, 11 Dec 2018 13:03:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211020350.GF4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="juLeBF1Sbpsr6d7u"
Content-Disposition: inline
In-Reply-To: <20181209194610.29727-17-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 16/19] spapr: introduce a new sPAPR IRQ
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


--juLeBF1Sbpsr6d7u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 08:46:07PM +0100, C=E9dric Le Goater wrote:
> The interrupt mode is chosen by the CAS negotiation process and
> activated after a reset to take into account the required changes in
> the machine. These impact the device tree layout, the interrupt
> presenter object and the exposed MMIO regions in the case of XIVE.
>=20
> This default interrupt mode for the machine is XICS.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_irq.h |   1 +
>  hw/ppc/spapr.c             |   3 +-
>  hw/ppc/spapr_hcall.c       |  13 ++++
>  hw/ppc/spapr_irq.c         | 143 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 159 insertions(+), 1 deletion(-)
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
> index 5ef87a00f68b..fa41927d95dd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2631,7 +2631,8 @@ static void spapr_machine_init(MachineState *machin=
e)
>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> =20
>      /* advertise XIVE */
> -    if (smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
> +    if (smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT ||
> +        smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_BOTH) {
>          spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>      }
> =20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index ae913d070f50..186b6a65543f 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1654,6 +1654,19 @@ static target_ulong h_client_architecture_support(=
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
> +        sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT)
> +            && smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_BOTH;
> +    }
> +
>      spapr_ovec_cleanup(ov5_updates);
> =20
>      if (spapr->cas_reboot) {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index a8e50725397c..7c34939f774a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -392,6 +392,149 @@ sPAPRIrq spapr_irq_xive =3D {
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

Urgh... I don't think this is going to work.  IIRC the various devices
(PHB, VIO, etc.)  are wired up to their qirqs at realize() time, so if
you reboot from a XIVE guest to XICS guest (or maybe the other way
around) the peripherals won't be able to signal irqs in the new
scheme.

I think instead we need a common set of qirqs, whose set_irq routine
looks at whether to signal XICS or XIVE.  FOr now I think the easiest
approach is to layer those on top of the existing XICS or XIVE
specific qirqs.  Later we might want to remove the (input) qirqs
entirely from the XICS and XIVE subsystems, instead having just
explicit trigger functions.  Then spapr will always supply the qirqs
which call into one or the other.

> +}
> +
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

--juLeBF1Sbpsr6d7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPGwIACgkQbDjKyiDZ
s5KVAxAArPYFeAQIvy/s1XR7Wwy1aynIMPCtmD0ajAVtd3LrJw0IN4iZ+xOk3+UA
+24PhUDNd0bmAFYACXlWEbR4HVtAbthBumRFs1rUTX7qOVjQWJH2+1BuUSSNt152
fnDftx7OA7C0bXQOKPXhYnEqfzjOZ75sseKQuKjpsACQIqR/J6kDlGV9lBXePGqY
IhwW4QQVH9As50vNYXsw1AHG3f34+ihdy64ZrtyutprcCQoLhzI2u+jv0bjqInJO
56fysIC+WPlxdjZMd+b4n7svdckHQhMq40xAzJlu5J3A/pIjw/KBMyw3fpWzSm+M
c8qUv+HJlaLsyUwxKkDbLltaWEfCqRDM1ImeR3iYL/2hm4v+Z8wwSMVKffcTfzEr
2YvxoUK/2/+UdOUH6e001il6GM7vG553N9XW86TPYJCuxt0xrKJL084tR5lXeqiP
DHZ+mHIZnQJuovo82cLL+hTM1AoZ1gPyibYh/f0yjT600hCpc9oGCag+DtKFf46r
kahA6lr7il4jdQPt75EYYvZLgesBRU8nDasfz61+rnPGxVdWpwN5m00fHea3E5gq
ijyy4OY1fq/aYpyNNu1xGgdyD7r0VSDwC72Bc/RvLkeHOMtmDuoaSSB8ZbaOEbUg
u+T46D40DfFYGx1/xevC2HB7fOcMD++I0UVjzOIWBCHMfHGRQnw=
=7Kf3
-----END PGP SIGNATURE-----

--juLeBF1Sbpsr6d7u--
