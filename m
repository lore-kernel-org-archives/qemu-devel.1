Received: from eggs.gnu.org ([2001:4830:134:3::10]:46329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cvzwf-00060E-44
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 01:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cvzwd-0000e8-Qc
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 01:26:57 -0400
Date: Thu, 6 Apr 2017 12:02:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170406020256.GA1991@umbus.fritz.box>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-4-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-4-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 03/21] ppc/pnv: Add support for POWER8+ LPC
 Controller
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:28PM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> It adds the Naples chip which supports proper LPC interrupts via the
> LPC controller rather than via an external CPLD.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [clg: - updated for qemu-2.9
>       - ported on latest PowerNV patchset ]
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/pnv.c             | 13 ++++++++++++-
>  hw/ppc/pnv_lpc.c         | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++--
>  include/hw/ppc/pnv_lpc.h |  9 +++++++++
>  3 files changed, 66 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 24e523f554c6..78133e5d20e1 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -373,7 +373,14 @@ static void pnv_lpc_isa_irq_handler_cpld(void *opaqu=
e, int n, int level)
> =20
>  static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
>  {
> -     /* XXX TODO */
> +    PnvChip *chip =3D opaque;
> +    PnvLpcController *lpc =3D &chip->lpc;
> +
> +    /* The Naples HW latches the 1 levels, clearing is done by SW */
> +    if (level) {
> +        lpc->lpc_hc_irqstat |=3D LPC_HC_IRQ_SERIRQ0 >> n;
> +        pnv_lpc_eval_irqs(lpc);
> +    }
>  }

Now that you have a more complete LPC model, I think this function,
and the allocation of the LPC irqs should move into pnv_lpc.c.


Apart from that, looks fine.

> =20
>  static ISABus *pnv_isa_create(PnvChip *chip)
> @@ -699,6 +706,10 @@ static void pnv_chip_init(Object *obj)
>      object_property_add_child(obj, "occ", OBJECT(&chip->occ), NULL);
>      object_property_add_const_link(OBJECT(&chip->occ), "psi",
>                                     OBJECT(&chip->psi), &error_abort);
> +
> +    /* The LPC controller needs PSI to generate interrupts */
> +    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
> +                                   OBJECT(&chip->psi), &error_abort);
>  }
> =20
>  static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 78db52415b11..20cbb6a0dbbd 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -250,6 +250,34 @@ static const MemoryRegionOps pnv_lpc_xscom_ops =3D {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> +void pnv_lpc_eval_irqs(PnvLpcController *lpc)
> +{
> +    bool lpc_to_opb_irq =3D false;
> +
> +    /* Update LPC controller to OPB line */
> +    if (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN) {
> +        uint32_t irqs;
> +
> +        irqs =3D lpc->lpc_hc_irqstat & lpc->lpc_hc_irqmask;
> +        lpc_to_opb_irq =3D (irqs !=3D 0);
> +    }
> +
> +    /* We don't honor the polarity register, it's pointless and unused
> +     * anyway
> +     */
> +    if (lpc_to_opb_irq) {
> +        lpc->opb_irq_input |=3D OPB_MASTER_IRQ_LPC;
> +    } else {
> +        lpc->opb_irq_input &=3D ~OPB_MASTER_IRQ_LPC;
> +    }
> +
> +    /* Update OPB internal latch */
> +    lpc->opb_irq_stat |=3D lpc->opb_irq_input & lpc->opb_irq_mask;
> +
> +    /* Reflect the interrupt */
> +    pnv_psi_irq_set(lpc->psi, PSIHB_IRQ_LPC_I2C, lpc->opb_irq_stat !=3D =
0);
> +}
> +
>  static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      PnvLpcController *lpc =3D opaque;
> @@ -300,12 +328,15 @@ static void lpc_hc_write(void *opaque, hwaddr addr,=
 uint64_t val,
>          break;
>      case LPC_HC_IRQSER_CTRL:
>          lpc->lpc_hc_irqser_ctrl =3D val;
> +        pnv_lpc_eval_irqs(lpc);
>          break;
>      case LPC_HC_IRQMASK:
>          lpc->lpc_hc_irqmask =3D val;
> +        pnv_lpc_eval_irqs(lpc);
>          break;
>      case LPC_HC_IRQSTAT:
>          lpc->lpc_hc_irqstat &=3D ~val;
> +        pnv_lpc_eval_irqs(lpc);
>          break;
>      case LPC_HC_ERROR_ADDRESS:
>          break;
> @@ -363,14 +394,15 @@ static void opb_master_write(void *opaque, hwaddr a=
ddr,
>      switch (addr) {
>      case OPB_MASTER_LS_IRQ_STAT:
>          lpc->opb_irq_stat &=3D ~val;
> +        pnv_lpc_eval_irqs(lpc);
>          break;
>      case OPB_MASTER_LS_IRQ_MASK:
> -        /* XXX Filter out reserved bits */
>          lpc->opb_irq_mask =3D val;
> +        pnv_lpc_eval_irqs(lpc);
>          break;
>      case OPB_MASTER_LS_IRQ_POL:
> -        /* XXX Filter out reserved bits */
>          lpc->opb_irq_pol =3D val;
> +        pnv_lpc_eval_irqs(lpc);
>          break;
>      case OPB_MASTER_LS_IRQ_INPUT:
>          /* Read only */
> @@ -398,6 +430,8 @@ static const MemoryRegionOps opb_master_ops =3D {
>  static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>  {
>      PnvLpcController *lpc =3D PNV_LPC(dev);
> +    Object *obj;
> +    Error *error =3D NULL;
> =20
>      /* Reg inits */
>      lpc->lpc_hc_fw_rd_acc_size =3D LPC_HC_FW_RD_4B;
> @@ -441,6 +475,15 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
>      pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(dev),
>                            &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
>                            PNV_XSCOM_LPC_SIZE);
> +
> +    /* get PSI object from chip */
> +    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
> +    if (!obj) {
> +        error_setg(errp, "%s: required link 'psi' not found: %s",
> +                   __func__, error_get_pretty(error));
> +        return;
> +    }
> +    lpc->psi =3D PNV_PSI(obj);
>  }
> =20
>  static void pnv_lpc_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 38e5506975aa..53040026c37b 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -23,6 +23,8 @@
>  #define PNV_LPC(obj) \
>       OBJECT_CHECK(PnvLpcController, (obj), TYPE_PNV_LPC)
> =20
> +typedef struct PnvPsi PnvPsi;
> +
>  typedef struct PnvLpcController {
>      DeviceState parent;
> =20
> @@ -62,6 +64,13 @@ typedef struct PnvLpcController {
> =20
>      /* XSCOM registers */
>      MemoryRegion xscom_regs;
> +
> +    /* PSI to generate interrupts */
> +    PnvPsi *psi;
>  } PnvLpcController;
> =20
> +#define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down to .=
=2E. */
> +
> +void pnv_lpc_eval_irqs(PnvLpcController *lpc);
> +
>  #endif /* _PPC_PNV_LPC_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5aHOAAoJEGw4ysog2bOS/eYP/0/a8chmHM793nrCe4rHkJwJ
VpBlgBLxAbiYxKGb2CEjJ8iZVZ6UXZwgR3iEceakWRrj3HgR67fGxmpvw7K+VCcM
w9CGtZdZmuTt9cWlqLvcC2iEx2bq4Sr1kgxxM7FU58/jNYuixTvDR5/2s6eQm7X/
K45GkcJSuZj+Gj0xTwmULys8kJ2UET22sdAT6mPZInVHmLOCoRSCiqxOx8PjvhOl
3e0r0TY6OytmCbXla8LoejxtSbqAxNPnFsFrnaVSvBeZXWM15j0KFHu27wPERwG0
UkJ8ngMgwrW9NKWrSvtDFwL4Cgi1byXjFGvdoEpK7uA1zjB3rpXr5dQWCdr12pXZ
TaTBjGOTouHsRSiWp0Uvst75p4qk4TXO7OblP4DMtzGZuxJClYunThW6y+4NkqWS
9y/scvu401oN052Usz0b1WNk2cUiv5tUDnWdqttAaGmxDOZ4Be8cpckDM7TNwsoF
HBu4xZX71/JZWuumM5e5qR0QptluVjJjX0pSZCbPC3kaj4TWAI4HaY5pvaKdj7K5
q9/S4wJwjP+JVqViqxcs45SJpUBgpBGe5+Da/KorfC+xgki3lGznG0c9Rje+8d2V
lxB6WxF2vebUZ0fTfoN7Z7q9Dn2dYThjcKDZjhE3owecS84jMEWNvJuTchssqh5n
YmoIXECA+m7GHpm5CmkA
=yOnP
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
