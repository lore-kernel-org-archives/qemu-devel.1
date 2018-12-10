Received: from eggs.gnu.org ([2001:4830:134:3::10]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWFRP-0004Gn-Db
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWFRJ-0003k3-GR
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:53:19 -0500
Date: Mon, 10 Dec 2018 17:42:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210064214.GV4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EjUKZjov3T4fFoFJ"
Content-Disposition: inline
In-Reply-To: <20181209194610.29727-13-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 12/19] spapr: add a 'reset' method to
 the sPAPR IRQ backend
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


--EjUKZjov3T4fFoFJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 08:46:03PM +0100, C=E9dric Le Goater wrote:
> For the time being, the XIVE reset handler updates the OS CAM line of
> the vCPU as it is done under a real hypervisor when a vCPU is
> scheduled to run on a HW thread.
>=20
> This handler will become even more useful when we introduce the
> machine supporting both interrupt modes, XIVE and XICS. In this
> machine, the interrupt mode is chosen by the CAS negotiation process
> and activated after a reset.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_irq.h  |  2 ++
>  include/hw/ppc/spapr_xive.h |  1 +
>  hw/intc/spapr_xive.c        | 24 ++++++++++++++++++++++++
>  hw/ppc/spapr.c              |  5 +++++
>  hw/ppc/spapr_irq.c          | 24 ++++++++++++++++++++++++
>  5 files changed, 56 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 84a25ffb6c65..63061a009b4c 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -44,6 +44,7 @@ typedef struct sPAPRIrq {
>      Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
>                                 Error **errp);
>      int (*post_load)(sPAPRMachineState *spapr, int version_id);
> +    void (*reset)(sPAPRMachineState *spapr, Error **errp);
>  } sPAPRIrq;
> =20
>  extern sPAPRIrq spapr_irq_xics;
> @@ -55,6 +56,7 @@ int spapr_irq_claim(sPAPRMachineState *spapr, int irq, =
bool lsi, Error **errp);
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
> +void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
> =20
>  /*
>   * XICS legacy routines
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 728a5e8dc163..7244a6231ce6 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -47,5 +47,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
> +void spapr_xive_reset_tctx(sPAPRXive *xive);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index a6d854b07690..560d8d031f74 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -179,6 +179,30 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
>  }
> =20
> +/*
> + * When a Virtual Processor is scheduled to run on a HW thread, the
> + * hypervisor pushes its identifier in the OS CAM line. Emulate the
> + * same behavior under QEMU.
> + */
> +void spapr_xive_reset_tctx(sPAPRXive *xive)
> +{
> +    CPUState *cs;
> +    uint8_t  nvt_blk;
> +    uint32_t nvt_idx;
> +    uint32_t nvt_cam;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
> +
> +        spapr_xive_cpu_to_nvt(cpu, &nvt_blk, &nvt_idx);
> +
> +        nvt_cam =3D cpu_to_be32(TM_QW1W2_VO |
> +                              xive_nvt_cam_line(nvt_blk, nvt_idx));
> +        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
> +    }
> +}
> +
>  static void spapr_xive_end_reset(XiveEND *end)
>  {
>      memset(end, 0, sizeof(*end));
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8cea4cad1732..98d69f09e080 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1619,6 +1619,11 @@ static void spapr_machine_reset(void)
> =20
>      qemu_devices_reset();
> =20
> +    /* This is fixing some of the default configuration of the XIVE
> +     * devices. To be called after the reset of the machine devices.
> +     */
> +    spapr_irq_reset(spapr, &error_fatal);
> +
>      /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
>       * if this device is used by another device (eg, a running vhost bac=
kend
>       * will crash QEMU if the DIMM holding the vring goes away). To avoi=
d such
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 35a067cad3f8..04f5c9665550 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -209,6 +209,10 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
>      return 0;
>  }
> =20
> +static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
> +{
> +}

You already have a check for a NULL reset hook in spapr_irq_reset() so
you could omit this empty function.

> +
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> @@ -225,6 +229,7 @@ sPAPRIrq spapr_irq_xics =3D {
>      .dt_populate =3D spapr_dt_xics,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
> +    .reset       =3D spapr_irq_reset_xics,
>  };
> =20
>  /*
> @@ -333,6 +338,15 @@ static int spapr_irq_post_load_xive(sPAPRMachineStat=
e *spapr, int version_id)
>      return 0;
>  }
> =20
> +static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
> +{
> +    /*
> +     * Set the OS CAM line of the cpu interrupt thread context. Needs
> +     * to come after the XiveTCTX reset handlers.
> +     */
> +    spapr_xive_reset_tctx(spapr->xive);
> +}
> +
>  /*
>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>   * with XICS.
> @@ -353,6 +367,7 @@ sPAPRIrq spapr_irq_xive =3D {
>      .dt_populate =3D spapr_dt_xive,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
>      .post_load   =3D spapr_irq_post_load_xive,
> +    .reset       =3D spapr_irq_reset_xive,
>  };
> =20
>  /*
> @@ -398,6 +413,15 @@ int spapr_irq_post_load(sPAPRMachineState *spapr, in=
t version_id)
>      return smc->irq->post_load(spapr, version_id);
>  }
> =20
> +void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    if (smc->irq->reset) {
> +        smc->irq->reset(spapr, errp);
> +    }
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EjUKZjov3T4fFoFJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwOCsYACgkQbDjKyiDZ
s5I/XxAAylBjoy+BT6ju5HBtsUBebwHm2UO8CyYXYyxLDE56Dg8/2AloQFHRElDl
I5ZPSxDWP2OfcqXQQYPMyxwGqMYR/8zKx7BByUsi53tUqILHXYLMH91Ep0SgplAB
tXf4l+jMlBe4vtP79fsmMaq0Io2++aZqyJcpuBA4lpdhfrUi1zXxT7FqCxoZzs68
u2umOdqED3Acv1AkOKuE6V+8ntw2ziOkrYyThMIo931kvFENRc6c7lbYzbvRoUX3
3wHKtyXLddBYa9LZ/1X3ogEaWi0A69qbZ+n0A/30Oyu6YXrfC52zV6+wFXXbP/+a
EfG6TnWNvQMaiNM1gwtgHMDgpcolr1rQLTksn5ghda8UwFkfY1yfc5RL1xq0gqNC
BhOQ2mxrGNVeS+BvL3zpgPj3TCokLpyOj3twcQz3KKuiNK7LnpUurL7U1wuHk3/R
Xrj2ACDi0QDSZ3zv5vHOm467a1eFM5k1Mwbhqw2rHLBBYAPO4kkHt4xR02agw0cL
MNnmiN6YmEwOtwWq6q58qdsuUk32s6TMe9Z4dy6Ay5wc0p7v0roxan2VwAz4zina
YTKFE8K1JXYdOadcUO/EdcnCWokFUQPI+VGdEXKqdIiAELz0Tz2gdEOEF2bmigi9
/YPBt7OFQCuYu5tXk7jhxgYr0LtM6ra30h9HKTj5kl6pfQVySqw=
=JIgq
-----END PGP SIGNATURE-----

--EjUKZjov3T4fFoFJ--
