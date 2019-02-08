Received: from eggs.gnu.org ([209.51.188.92]:42336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzT1-0003BQ-LA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzSz-0004yw-Ti
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:51 -0500
Date: Fri, 8 Feb 2019 16:44:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190208054445.GD12810@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 01/19] ppc/xive: hardwire the Physical CAM
 line of the thread context
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


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:07AM +0100, C=E9dric Le Goater wrote:
> By default on P9, the HW CAM line (23bits) is hardwired to :
>=20
>       0x000||0b1||4Bit chip number||7Bit Thread number.
>=20
> When the block group mode is enabled at the controller level (PowerNV),
> the CAM line is changed for CAM compares to :
>=20
>       4Bit chip number||0x001||7Bit Thread number
>=20
> This will require changes in xive_presenter_tctx_match() possibly.
> This is a lowlevel functionality of the HW controller and it is not
> strictly needed. Leave it for later.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h |  1 +
>  hw/intc/xive.c        | 53 ++++++++++++++++++++++++++++++++++++++++---
>  hw/ppc/pnv_core.c     | 16 ++++++++-----
>  3 files changed, 61 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index ec3bb2aae45a..04d54e8315f7 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -319,6 +319,7 @@ typedef struct XiveTCTX {
>      qemu_irq    output;
> =20
>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> +    uint32_t    hw_cam;

I don't love the fact that the hw_cam field is mirroring something
that's in the regs structure.  Any way you can have the property poke
the right value directly into regs?  Or else split up regs so you can
set the pieces individually.

>  } XiveTCTX;
> =20
>  /*
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 2e9b8efd4342..f5642f2338de 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -469,6 +469,12 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
>      Object *obj;
>      Error *local_err =3D NULL;
> =20
> +    if (!tctx->hw_cam) {
> +        error_setg(errp, "XIVE: HW CAM is not set for CPU %d",
> +                   tctx->cs->cpu_index);
> +        return;
> +    }
> +
>      obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
>      if (!obj) {
>          error_propagate(errp, local_err);
> @@ -509,11 +515,17 @@ static const VMStateDescription vmstate_xive_tctx =
=3D {
>      },
>  };
> =20
> +static Property  xive_tctx_properties[] =3D {
> +    DEFINE_PROP_UINT32("hw-cam", XiveTCTX, hw_cam, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void xive_tctx_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->desc =3D "XIVE Interrupt Thread Context";
> +    dc->props =3D xive_tctx_properties;
>      dc->realize =3D xive_tctx_realize;
>      dc->unrealize =3D xive_tctx_unrealize;
>      dc->vmsd =3D &vmstate_xive_tctx;
> @@ -526,8 +538,21 @@ static const TypeInfo xive_tctx_info =3D {
>      .class_init    =3D xive_tctx_class_init,
>  };
> =20
> +/*
> + * The HW CAM line (23bits) is hardwired to :
> + *
> + *   0x000||0b1||4Bit chip number||7Bit Thread number.
> + */
> +static uint32_t hw_cam_line(uint8_t chip_id, uint8_t tid)
> +{
> +    return 1 << 11 | (chip_id & 0xf) << 7 | (tid & 0x7f);
> +}
> +
>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
>  {
> +    CPUPPCState *env =3D &POWERPC_CPU(cpu)->env;
> +    uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
> +    uint32_t hw_cam =3D hw_cam_line((pir >> 8) & 0xf, pir & 0x7f);
>      Error *local_err =3D NULL;
>      Object *obj;
> =20
> @@ -535,6 +560,10 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xr=
tr, Error **errp)
>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
>      object_unref(obj);
>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> +    object_property_set_int(obj, hw_cam, "hw-cam", &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          goto error;
> @@ -1112,14 +1141,28 @@ XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, =
CPUState *cs)
>      return xrc->get_tctx(xrtr, cs);
>  }
> =20
> +/*
> + * When the block grouping is enabled, the CAM line is changed to :
> + *
> + *   4Bit chip number||0x001||7Bit Thread number.
> + */
> +static bool xive_presenter_tctx_match_hw(XiveRouter *xrtr, XiveTCTX *tct=
x,
> +                                         uint8_t nvt_blk, uint32_t nvt_i=
dx)
> +{
> +    /* TODO: block group support */
> +    return tctx->hw_cam =3D=3D hw_cam_line(nvt_blk, nvt_idx);
> +}
> +
>  /*
>   * The thread context register words are in big-endian format.
>   */
> -static int xive_presenter_tctx_match(XiveTCTX *tctx, uint8_t format,
> +static int xive_presenter_tctx_match(XiveRouter *xrtr,
> +                                     XiveTCTX *tctx, uint8_t format,
>                                       uint8_t nvt_blk, uint32_t nvt_idx,
>                                       bool cam_ignore, uint32_t logic_ser=
v)
>  {
>      uint32_t cam =3D xive_nvt_cam_line(nvt_blk, nvt_idx);
> +    uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
>      uint32_t qw2w2 =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
>      uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>      uint32_t qw0w2 =3D xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
> @@ -1142,7 +1185,11 @@ static int xive_presenter_tctx_match(XiveTCTX *tct=
x, uint8_t format,
> =20
>          /* F=3D0 & i=3D0: Specific NVT notification */
> =20
> -        /* TODO (PowerNV) : PHYS ring */
> +        /* PHYS ring */
> +        if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
> +            xive_presenter_tctx_match_hw(xrtr, tctx, nvt_blk, nvt_idx)) {
> +            return TM_QW3_HV_PHYS;
> +        }
> =20
>          /* HV POOL ring */
>          if ((be32_to_cpu(qw2w2) & TM_QW2W2_VP) &&
> @@ -1199,7 +1246,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
>           * Check the thread context CAM lines and record matches. We
>           * will handle CPU exception delivery later
>           */
> -        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_id=
x,
> +        ring =3D xive_presenter_tctx_match(xrtr, tctx, format, nvt_blk, =
nvt_idx,
>                                           cam_ignore, logic_serv);
>          /*
>           * Save the context and follow on to catch duplicates, that we
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 7c806da720c6..f035522b4ec9 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -114,12 +114,6 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChi=
p *chip, Error **errp)
>          return;
>      }
> =20
> -    pcc->intc_create(chip, cpu, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
>      core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &erro=
r_abort);
> =20
>      /*
> @@ -129,6 +123,16 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChi=
p *chip, Error **errp)
>       */
>      pir->default_value =3D core_pir + thread_index;
> =20
> +    /*
> +     * On P9, the interrupt presenter needs to hardwire the PIR value
> +     * in the thread interrupt context of the CPU.
> +     */
> +    pcc->intc_create(chip, cpu, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      /* Set time-base frequency to 512 MHz */
>      cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdF00ACgkQbDjKyiDZ
s5LSKw/+N05/vLRiC2IHEM6hNVbT/Z8LML0UhunWR5YNq6Cg7P7185uKTmx3MmUG
8kHE5I4OBg02OU/jcoRdq4Ofa9sDQYkHhMx4UVH/blN1Ur8dFyL6GDZkWeLKqeKR
tm+v2wX6EEvwoUVbuPLAKpiszcRAWPCedap+gcBIKWtCuT2jrQjxvZGmXV5JHCZd
2HIxsJD79dFcPiwpk9+rn/QEruJEiEWOsZCD21b5xItQPS6T18ft/f0lvA2yzIDL
Y2AaKRdrnyUger+pQjwpbn1L2fp7JOyp21A/WlHMSb/WwDpdurzVfM/L59ITJQ7v
IszNb5thh3Odm3ERlKwnD/YhiuninwHEcRNUE9nJw1kVIPkX+UpsIW56XM+hYUB4
UCPt4tKTHHm5UPDzFUbGfO6aImUr6Xq5bmFOW85iG65QTmV3r2GApCkIUr1WcEqU
Cl38aIoYU3x2qLusrcXpuuk8yay30AUXKEqrsizB4aZebdtN/soabW2YDebLLSF3
nIQw6QFS51DNgDNsmCYaDWw9iRXV+dSI8Ti1uwzW4+/RhJievrCWJsoR0c11bFTI
6EQl8xA/1slMUGMao2L0TB1rkTgRSu4QZrWi7xDgRYLn6NxFBEcQQf8loM4fCplF
tkw+oqlxqWavdeYSyK7jqU1Fvn3bpWvPHh7fI7dvO59iRnzUrYY=
=GUf3
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
