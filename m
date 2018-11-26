Received: from eggs.gnu.org ([2001:4830:134:3::10]:39485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRBIH-0007ia-TP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRBIG-0005jB-Q2
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:26:57 -0500
Date: Mon, 26 Nov 2018 16:39:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181126053947.GG2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-3-clg@kaod.org>
	<20181122031934.GC10448@umbus.fritz.box>
	<75cdc1f3-f337-3c37-b234-d96222a370d2@kaod.org>
	<20181123010852.GT10448@umbus.fritz.box>
	<8270d5fc-ab20-f47d-37d8-1e2ba179fbfd@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline
In-Reply-To: <8270d5fc-ab20-f47d-37d8-1e2ba179fbfd@kaod.org>
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


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 02:28:35PM +0100, C=E9dric Le Goater wrote:
>=20
> >>>> +/*
> >>>> + * Returns whether the event notification should be forwarded.
> >>>> + */
> >>>> +static bool xive_source_lsi_trigger(XiveSource *xsrc, uint32_t
> >>>> srcno)
> >>>
> >>> What exactly "trigger" means isn't entirely obvious for an LSI.  Might
> >>> be clearer to have "lsi_assert" and "lsi_deassert" helpers instead.
> >>
> >> This is called only when the interrupt is asserted. So it is a=20
> >> simplified LSI trigger depending only on the 'P' bit.
> >=20
> > Yes, I see that.  But the result is that while the MSI logic is
> > encapsulated in the MSI trigger function, this leaves the LSI logic
> > split across the trigger function and set_irq() itself. I think it=20
> > would be better to have assert and deassert helpers instead, which
> > handle both the trigger/notification and also the updating of the
> > ASSERTED bit.
>=20
> Something like the xive_source_set_irq_lsi() below ?

Uh.. not exactly what I had in mind, but close enough.

[snip]
+/*
> + * Returns whether the event notification should be forwarded.
> + */
>  static bool xive_source_esb_trigger(XiveSource *xsrc, uint32_t srcno)
>  {
> +    bool notify;
> +
>      assert(srcno < xsrc->nr_irqs);
> =20
> -    return xive_esb_trigger(&xsrc->status[srcno]);
> +    notify =3D xive_esb_trigger(&xsrc->status[srcno]);
> +
> +    if (xive_source_irq_is_lsi(xsrc, srcno) &&

Except that this block can go, since this function is no longer called
for LSIs.

> +        xive_source_esb_get(xsrc, srcno) =3D=3D XIVE_ESB_QUEUED) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "XIVE: queued an event on LSI IRQ %d\n", srcno);
> +    }
> +
> +    return notify;
>  }
> =20
>  /*
> @@ -103,9 +127,22 @@ static bool xive_source_esb_trigger(Xive
>   */
>  static bool xive_source_esb_eoi(XiveSource *xsrc, uint32_t srcno)
>  {
> +    bool notify;
> +
>      assert(srcno < xsrc->nr_irqs);
> =20
> -    return xive_esb_eoi(&xsrc->status[srcno]);
> +    notify =3D xive_esb_eoi(&xsrc->status[srcno]);
> +
> +    /* LSI sources do not set the Q bit but they can still be
> +     * asserted, in which case we should forward a new event
> +     * notification
> +     */
> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
> +        bool level =3D xsrc->status[srcno] & XIVE_STATUS_ASSERTED;
> +        notify =3D xive_source_set_irq_lsi(xsrc, srcno, level);
> +    }
> +
> +    return notify;
>  }
> =20
>  /*
> @@ -268,8 +305,12 @@ static void xive_source_set_irq(void *op
>      XiveSource *xsrc =3D XIVE_SOURCE(opaque);
>      bool notify =3D false;
> =20
> -    if (val) {
> -        notify =3D xive_source_esb_trigger(xsrc, srcno);
> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
> +        notify =3D xive_source_set_irq_lsi(xsrc, srcno, val);
> +    } else {
> +        if (val) {
> +            notify =3D xive_source_esb_trigger(xsrc, srcno);
> +        }
>      }
> =20
>      /* Forward the source event notification for routing */
> @@ -289,9 +330,11 @@ void xive_source_pic_print_info(XiveSour
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
> @@ -299,6 +342,8 @@ static void xive_source_reset(DeviceStat
>  {
>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> =20
> +    /* Do not clear the LSI bitmap */
> +
>      /* PQs are initialized to 0b01 which corresponds to "ints off" */
>      memset(xsrc->status, 0x1, xsrc->nr_irqs);
>  }
> @@ -324,6 +369,7 @@ static void xive_source_realize(DeviceSt
>                                       xsrc->nr_irqs);
> =20
>      xsrc->status =3D g_malloc0(xsrc->nr_irqs);
> +    xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
> =20
>      memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
>                            &xive_source_esb_ops, xsrc, "xive.esb",
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv7hyAACgkQbDjKyiDZ
s5L+YQ//clI8BFYpPo8Yd90J2jxdZ6p7ALFsGVI5+UxVWX6LlnB+MEvwI04yMnmw
zya209S5IA6QSefL1Mxp80DFM4dXUj40VBI4NsDX/9w1xCjHJVbWrTo/4sOn4aqN
LbSRHpHuXV8zLW1eJosLVnIAXyenKoWoQEy8XSbWOpHJHo5S9MdCqTLLLzuXfpDt
xicKBvvOrN8xyDFpqwImAau/XWHb2vw7G039EHIYCfpzgSp1gXiHmnL/mDROHUDP
VEp/SZjt054zAHFW92SCxkrMlnFBWf4muXXl2giJgCHBH7pN6NdmdXyGGkbX0GiT
fPflN0COyC6ph6F0jfs7EjcS5jEqIELzfSm458NkUlPJfjkJ+LrVMOvaXvU/yr/a
omYGJSyDuXk2WHIHIaXXvBCZpsD4IqdWwc0YbByc+NpuWWFWOi8xfoa/0BqW0t7/
5uCFlxM0yYrwCihL8t0tvAT6rpQsMidw0Kgworhaa97DBLkRIGLPG21EKRcU694g
Opmfv8/F0iOir5IcVuW9BhXr4lRvTHdI/1TiekADX/6hrp2d1hVRAaHYSj3k9eIi
hQg4h1oaFtTYZ8LYTINxubmJy+lz4XglEVGtcMk2MEwzWLznWMNiCYQLSWTZCrmE
4pOMKhE7uiYqaO+KqLR61u8aWy/4vsUv1bY7Hb446e94xZKuLEs=
=Gfjy
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
