Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWtRI-000378-HP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 20:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWtRG-0003KI-KA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 20:35:52 -0500
Date: Wed, 12 Dec 2018 11:54:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181212005418.GG2719@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-17-clg@kaod.org>
	<20181211020350.GF4261@umbus.fritz.box>
	<771f030d-b69f-78e4-ac0c-9f37e3ab9c17@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <771f030d-b69f-78e4-ac0c-9f37e3ab9c17@kaod.org>
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


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:19:01AM +0100, C=E9dric Le Goater wrote:
> On 12/11/18 3:03 AM, David Gibson wrote:
> > On Sun, Dec 09, 2018 at 08:46:07PM +0100, C=E9dric Le Goater wrote:
> >> The interrupt mode is chosen by the CAS negotiation process and
> >> activated after a reset to take into account the required changes in
> >> the machine. These impact the device tree layout, the interrupt
> >> presenter object and the exposed MMIO regions in the case of XIVE.
> >>
> >> This default interrupt mode for the machine is XICS.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/spapr_irq.h |   1 +
> >>  hw/ppc/spapr.c             |   3 +-
> >>  hw/ppc/spapr_hcall.c       |  13 ++++
> >>  hw/ppc/spapr_irq.c         | 143 +++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 159 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >> index b34d5a00381b..29936498dbc8 100644
> >> --- a/include/hw/ppc/spapr_irq.h
> >> +++ b/include/hw/ppc/spapr_irq.h
> >> @@ -51,6 +51,7 @@ typedef struct sPAPRIrq {
> >>  extern sPAPRIrq spapr_irq_xics;
> >>  extern sPAPRIrq spapr_irq_xics_legacy;
> >>  extern sPAPRIrq spapr_irq_xive;
> >> +extern sPAPRIrq spapr_irq_dual;
> >> =20
> >>  void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
> >>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Erro=
r **errp);
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 5ef87a00f68b..fa41927d95dd 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2631,7 +2631,8 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> >> =20
> >>      /* advertise XIVE */
> >> -    if (smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
> >> +    if (smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT ||
> >> +        smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_BOTH) {
> >>          spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
> >>      }
> >> =20
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index ae913d070f50..186b6a65543f 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1654,6 +1654,19 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> >>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
> >>                                            ov5_updates) !=3D 0);
> >>      }
> >> +
> >> +    /*
> >> +     * Generate a machine reset when we have an update of the
> >> +     * interrupt mode. Only required on the machine supporting both
> >> +     * mode.
> >> +     */
> >> +    if (!spapr->cas_reboot) {
> >> +        sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >> +
> >> +        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_E=
XPLOIT)
> >> +            && smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_BOTH;
> >> +    }
> >> +
> >>      spapr_ovec_cleanup(ov5_updates);
> >> =20
> >>      if (spapr->cas_reboot) {
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> index a8e50725397c..7c34939f774a 100644
> >> --- a/hw/ppc/spapr_irq.c
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -392,6 +392,149 @@ sPAPRIrq spapr_irq_xive =3D {
> >>      .reset       =3D spapr_irq_reset_xive,
> >>  };
> >> =20
> >> +/*
> >> + * Dual XIVE and XICS IRQ backend.
> >> + *
> >> + * Both interrupt mode, XIVE and XICS, objects are created but the
> >> + * machine starts in legacy interrupt mode (XICS). It can be changed
> >> + * by the CAS negotiation process and, in that case, the new mode is
> >> + * activated after extra machine reset.
> >> + */
> >> +
> >> +/*
> >> + * Returns the sPAPR IRQ backend negotiated by CAS. XICS is the
> >> + * default.
> >> + */
> >> +static sPAPRIrq *spapr_irq_current(sPAPRMachineState *spapr)
> >> +{
> >> +    return spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ?
> >> +        &spapr_irq_xive : &spapr_irq_xics;
> >> +}
> >> +
> >> +static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **err=
p)
> >> +{
> >> +    MachineState *machine =3D MACHINE(spapr);
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> >> +        error_setg(errp, "No KVM support for the 'dual' machine");
> >> +        return;
> >> +    }
> >> +
> >> +    spapr_irq_xics.init(spapr, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >> +    spapr_irq_xive.init(spapr, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +}
> >> +
> >> +static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, bo=
ol lsi,
> >> +                                Error **errp)
> >> +{
> >> +    int ret;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return ret;
> >> +    }
> >> +
> >> +    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static void spapr_irq_free_dual(sPAPRMachineState *spapr, int irq, in=
t num)
> >> +{
> >> +    spapr_irq_xive.free(spapr, irq, num);
> >> +    spapr_irq_xics.free(spapr, irq, num);
> >> +}
> >> +
> >> +static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
> >> +{
> >> +    return spapr_irq_current(spapr)->qirq(spapr, irq);
> >=20
> > Urgh... I don't think this is going to work.  IIRC the various devices
> > (PHB, VIO, etc.)  are wired up to their qirqs at realize() time, so if
> > you reboot from a XIVE guest to XICS guest (or maybe the other way
> > around) the peripherals won't be able to signal irqs in the new
> > scheme.
>=20
> It does. The IRQ numbers are claimed in both backends.

Yes, I realize that, but the two backends still have their own set of
qirqs, which have their own set_irq routines associated with them.

> This is the problem since the very beginning. For reset and migration
> to work, we need to keep in sync the IRQ number space of the machine=20
> and the different interrupt controllers.

Sure, we have the numbers in sync, but that won't help if when the
peripherals do a qemu_irq_pulse() it goes to the wrong backend's
trigger routine.


>=20
> C.=20
>=20
>=20
> > I think instead we need a common set of qirqs, whose set_irq routine
> > looks at whether to signal XICS or XIVE.  FOr now I think the easiest
> > approach is to layer those on top of the existing XICS or XIVE
> > specific qirqs.  Later we might want to remove the (input) qirqs
> > entirely from the XICS and XIVE subsystems, instead having just
> > explicit trigger functions.  Then spapr will always supply the qirqs
> > which call into one or the other.
> >=20
> >> +}
> >> +
> >> +static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monit=
or *mon)
> >> +{
> >> +    spapr_irq_current(spapr)->print_info(spapr, mon);
> >> +}
> >> +
> >> +static void spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
> >> +                                       uint32_t nr_servers, void *fdt,
> >> +                                       uint32_t phandle)
> >> +{
> >> +    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, pha=
ndle);
> >> +}
> >> +
> >> +static Object *spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spap=
r,
> >> +                                              Object *cpu, Error **er=
rp)
> >> +{
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return NULL;
> >> +    }
> >> +
> >> +    /* Default to XICS interrupt mode */
> >> +    return spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
> >> +}
> >> +
> >> +static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int ver=
sion_id)
> >> +{
> >> +    /*
> >> +     * Force a reset of the XIVE backend after migration. The machine
> >> +     * defaults to XICS at startup.
> >> +     */
> >> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        spapr_irq_xive.reset(spapr, &error_fatal);
> >> +    }
> >> +
> >> +    return spapr_irq_current(spapr)->post_load(spapr, version_id);
> >> +}
> >> +
> >> +static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **er=
rp)
> >> +{
> >> +    /*
> >> +     * Reset the interrupt mode selected by CAS.
> >> +     */
> >> +    spapr_irq_current(spapr)->reset(spapr, errp);
> >> +}
> >> +
> >> +/*
> >> + * Define values in sync with the XIVE and XICS backend
> >> + */
> >> +#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
> >> +#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IR=
Q_MSI)
> >> +
> >> +sPAPRIrq spapr_irq_dual =3D {
> >> +    .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
> >> +    .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
> >> +    .ov5         =3D SPAPR_OV5_XIVE_BOTH,
> >> +
> >> +    .init        =3D spapr_irq_init_dual,
> >> +    .claim       =3D spapr_irq_claim_dual,
> >> +    .free        =3D spapr_irq_free_dual,
> >> +    .qirq        =3D spapr_qirq_dual,
> >> +    .print_info  =3D spapr_irq_print_info_dual,
> >> +    .dt_populate =3D spapr_irq_dt_populate_dual,
> >> +    .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
> >> +    .post_load   =3D spapr_irq_post_load_dual,
> >> +    .reset       =3D spapr_irq_reset_dual,
> >> +};
> >> +
> >>  /*
> >>   * sPAPR IRQ frontend routines for devices
> >>   */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwQXDQACgkQbDjKyiDZ
s5J0/Q//T4/pkMvaTElk6cu7Lnlv9YJpdboSA1i4t3oYk/WYSR6T4zRdgkETHCSQ
iOSp4kPNPugz8NyARiZ4SvzpzW2kFhq59FT4DCwzc2/pQQFbqshXparx7JDFbUaB
hKE+LlqY/G1YnGl1rnet99/KBsK1IYTMPK5PD8zfvA0VaByKz864NPg2ID8BuICR
RO+WxRSzXqMyld2iqpKg2G8DX7lnJrR2xJMmVvOdIfpwmoRdPV+4hoopTlUF7M+I
dmDPrnbSaUxjz4zYKd/8hPOfBrCep5dZLBuM6fMD0FRgJgOBMo1sJ7/p8B5XxY0s
XywgFdVk44aGXNcrfr+Cvwp7f7LIsV9NBdQZCgxJprBONEzFONDH7feGBYcuoFXI
HBEj5kzVEgjMQHgSmg0kovjGQhM5iIiWb9Wyq4l5h0e0zc+NLe3ejQjo9xLktrOw
1e8qKe6sC6cTevLCy1Dasbs+ildiSVAurJiyewkxkuMI4eTfuWP+03Jop7CEj+ym
zSJOMZbqPqpq2Gw2SFgofMy+GPvMOjO73BM2wKsu/0XBBLEak0PyC88jk+VQXHcY
XGwAD5zhEynCZlA/VoQbo4R5fxBpVYA9ZMHNS78mX/Mw8L7KFjxomsY8y9nEPyLS
7TS7SAlMBINbG1sNGqEDlVxukOXTrjNGlW0I2TW8RcIOmQrxwNQ=
=Cdn8
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
