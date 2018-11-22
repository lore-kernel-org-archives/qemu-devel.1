Received: from eggs.gnu.org ([2001:4830:134:3::10]:47218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPhGN-0004n7-0q
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 00:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPhGL-0005ap-Oj
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 00:10:51 -0500
Date: Thu, 22 Nov 2018 14:19:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181122031934.GC10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 02/36] ppc/xive: add support for the LSI
 interrupt sources
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


--rQ2U398070+RC21q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:56:55AM +0100, C=E9dric Le Goater wrote:
> The 'sent' status of the LSI interrupt source is modeled with the 'P'
> bit of the ESB and the assertion status of the source is maintained in
> an array under the main sPAPRXive object. The type of the source is
> stored in the same array for practical reasons.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Looks good except for some minor details.

> ---
>  include/hw/ppc/xive.h | 20 ++++++++++++-
>  hw/intc/xive.c        | 68 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 81 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 5fec4b08705d..e118acd59f1e 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -32,8 +32,10 @@ typedef struct XiveSource {
>      /* IRQs */
>      uint32_t        nr_irqs;
>      qemu_irq        *qirqs;
> +    unsigned long   *lsi_map;
> +    int32_t         lsi_map_size; /* for VMSTATE_BITMAP */

At some point it's possible we'll want XiveSource subclasses that just
know which irqs are LSI and which aren't without an explicit map.  But
this detail isn't exposed in the migration stream or the user
interface, so we can tweak it later as ncessary.

> -    /* PQ bits */
> +    /* PQ bits and LSI assertion bit */
>      uint8_t         *status;
> =20
>      /* ESB memory region */
> @@ -89,6 +91,7 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource *x=
src, int srcno)
>   * When doing an EOI, the Q bit will indicate if the interrupt
>   * needs to be re-triggered.
>   */
> +#define XIVE_STATUS_ASSERTED  0x4  /* Extra bit for LSI */
>  #define XIVE_ESB_VAL_P        0x2
>  #define XIVE_ESB_VAL_Q        0x1
> =20
> @@ -127,4 +130,19 @@ static inline qemu_irq xive_source_qirq(XiveSource *=
xsrc, uint32_t srcno)
>      return xsrc->qirqs[srcno];
>  }
> =20
> +static inline bool xive_source_irq_is_lsi(XiveSource *xsrc, uint32_t src=
no)
> +{
> +    assert(srcno < xsrc->nr_irqs);
> +    return test_bit(srcno, xsrc->lsi_map);
> +}
> +
> +static inline void xive_source_irq_set(XiveSource *xsrc, uint32_t srcno,
> +                                       bool lsi)

The function name isn't obvious about this being controlling LSI
configuration. '..._irq_set_lsi' maybe?

> +{
> +    assert(srcno < xsrc->nr_irqs);
> +    if (lsi) {
> +        bitmap_set(xsrc->lsi_map, srcno, 1);
> +    }
> +}
> +
>  #endif /* PPC_XIVE_H */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f7621f84828c..ac4605fee8b7 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -88,14 +88,40 @@ uint8_t xive_source_esb_set(XiveSource *xsrc, uint32_=
t srcno, uint8_t pq)
>      return xive_esb_set(&xsrc->status[srcno], pq);
>  }
> =20
> +/*
> + * Returns whether the event notification should be forwarded.
> + */
> +static bool xive_source_lsi_trigger(XiveSource *xsrc, uint32_t
> srcno)

What exactly "trigger" means isn't entirely obvious for an LSI.  Might
be clearer to have "lsi_assert" and "lsi_deassert" helpers instead.

> +{
> +    uint8_t old_pq =3D xive_source_esb_get(xsrc, srcno);
> +
> +    switch (old_pq) {
> +    case XIVE_ESB_RESET:
> +        xive_source_esb_set(xsrc, srcno, XIVE_ESB_PENDING);
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>  /*
>   * Returns whether the event notification should be forwarded.
>   */
>  static bool xive_source_esb_trigger(XiveSource *xsrc, uint32_t srcno)
>  {
> +    bool ret;
> +
>      assert(srcno < xsrc->nr_irqs);
> =20
> -    return xive_esb_trigger(&xsrc->status[srcno]);
> +    ret =3D xive_esb_trigger(&xsrc->status[srcno]);
> +
> +    if (xive_source_irq_is_lsi(xsrc, srcno) &&
> +        xive_source_esb_get(xsrc, srcno) =3D=3D XIVE_ESB_QUEUED) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "XIVE: queued an event on LSI IRQ %d\n", srcno);
> +    }
> +
> +    return ret;
>  }
> =20
>  /*
> @@ -103,9 +129,22 @@ static bool xive_source_esb_trigger(XiveSource *xsrc=
, uint32_t srcno)
>   */
>  static bool xive_source_esb_eoi(XiveSource *xsrc, uint32_t srcno)
>  {
> +    bool ret;
> +
>      assert(srcno < xsrc->nr_irqs);
> =20
> -    return xive_esb_eoi(&xsrc->status[srcno]);
> +    ret =3D xive_esb_eoi(&xsrc->status[srcno]);
> +
> +    /* LSI sources do not set the Q bit but they can still be
> +     * asserted, in which case we should forward a new event
> +     * notification
> +     */
> +    if (xive_source_irq_is_lsi(xsrc, srcno) &&
> +        xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> +        ret =3D xive_source_lsi_trigger(xsrc, srcno);
> +    }
> +
> +    return ret;
>  }
> =20
>  /*
> @@ -268,8 +307,17 @@ static void xive_source_set_irq(void *opaque, int sr=
cno, int val)
>      XiveSource *xsrc =3D XIVE_SOURCE(opaque);
>      bool notify =3D false;
> =20
> -    if (val) {
> -        notify =3D xive_source_esb_trigger(xsrc, srcno);
> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
> +        if (val) {
> +            xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
> +            notify =3D xive_source_lsi_trigger(xsrc, srcno);
> +        } else {
> +            xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
> +        }
> +    } else {
> +        if (val) {
> +            notify =3D xive_source_esb_trigger(xsrc, srcno);
> +        }
>      }
> =20
>      /* Forward the source event notification for routing */
> @@ -289,9 +337,11 @@ void xive_source_pic_print_info(XiveSource *xsrc, ui=
nt32_t offset, Monitor *mon)
>              continue;
>          }
> =20
> -        monitor_printf(mon, "  %08x %c%c\n", i + offset,
> +        monitor_printf(mon, "  %08x %s %c%c%c\n", i + offset,
> +                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI",
>                         pq & XIVE_ESB_VAL_P ? 'P' : '-',
> -                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
> +                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
> +                       xsrc->status[i] & XIVE_STATUS_ASSERTED ? 'A' : ' =
');
>      }
>  }
> =20
> @@ -299,6 +349,8 @@ static void xive_source_reset(DeviceState *dev)
>  {
>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> =20
> +    /* Do not clear the LSI bitmap */
> +
>      /* PQs are initialized to 0b01 which corresponds to "ints off" */
>      memset(xsrc->status, 0x1, xsrc->nr_irqs);
>  }
> @@ -325,6 +377,9 @@ static void xive_source_realize(DeviceState *dev, Err=
or **errp)
> =20
>      xsrc->status =3D g_malloc0(xsrc->nr_irqs);
> =20
> +    xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
> +    xsrc->lsi_map_size =3D xsrc->nr_irqs;
> +
>      memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
>                            &xive_source_esb_ops, xsrc, "xive.esb",
>                            (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
> @@ -338,6 +393,7 @@ static const VMStateDescription vmstate_xive_source =
=3D {
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32_EQUAL(nr_irqs, XiveSource, NULL),
>          VMSTATE_VBUFFER_UINT32(status, XiveSource, 1, NULL, nr_irqs),
> +        VMSTATE_BITMAP(lsi_map, XiveSource, 1, lsi_map_size),

This shouldn't be here.  The lsi_map is all set up at machine
configuration time and then static, so it doesn't need to be migrated.

>          VMSTATE_END_OF_LIST()
>      },
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv2IEQACgkQbDjKyiDZ
s5IM1A/9FhRYgyx2ViSubneiJmlMhJN9xAtS8wi21zwK+nBAR/ernVfoLwyAflHu
6wF5g1kNOrKRA3E+LTNog3Vq14xsRYHhtUyso1Pgf/EpMepPE+/SCrxBBGwc8Ftf
aX5fwVPv3/ih5PaSVwU66+WD1HYlP7ZWh4Cl/JMt1hdzbKUcIE2t6Zj1aACQ+pz2
1XQuWsrvttPzxQEIbxoOAl/qqs/eBy10BE6is/zv4L+DpT2Re1R3ODZxl3wAoOAn
Zdc2HaV/GXWBVM0zxjai5K0BpJdJgl4xNUdg8y/7S6iZLMfqDRWUDf25RukjwZHB
WIrz2Ahu6SqNOaS/YLzFulYyeURVb+aILyBvnE/tg5pnkDsN+ioQ7wnnkOedXmcf
XvBMUAc5k1rgizxFk0NDFb89vfMDsb0twN30ebXF74jPGKZEoyJWd1pRh5BBUAzz
tJTSg8LALvKLk05AJFU7Q/POtO20RlnLHMXIve4xs6tOopR+zgqbjU5TWEt1Lehk
Vr9AK83ySyys5wzreBlSkBNZE30mmG2hunu6tcO9lbaAgOnO0iPhmLq1S83YbFIL
sxB5DQYZf0aQ0n+1xDuM95m7knLTplPiF/DkyBbdANLaGYvoIqTZ5+Ge+KuoXxFN
Geyh2IRfrDspgFfzwlQWz5dec5oWnPzA3EcbTAGmsJ3roKQRePI=
=yc4n
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
