Received: from eggs.gnu.org ([2001:4830:134:3::10]:51334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFta-0001J9-RS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtX-0002ye-5v
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:50 -0400
Date: Tue, 19 Sep 2017 12:44:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919024417.GJ27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3CAnR4CLEnEWqRMR"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/21] ppc/xive: provide a link to
 the sPAPR ICS object under XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--3CAnR4CLEnEWqRMR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:18PM +0200, C=E9dric Le Goater wrote:
> The sPAPR machine first starts with a XICS interrupt model and
> depending on the guest capabilities, the XIVE exploitation mode is
> negotiated during CAS. A reset should then be performed to rebuild the
> device tree but the same IRQ numbers which were allocated by the
> devices prior to reset, when the XICS model was operating, are still
> in use.
>=20
> For this purpose, we need a common IRQ number allocator for both the
> interrupt models: XICS legacy or XIVE exploitation. This is what the
> ICSIRQState array of the XICS interrupt source is used for. It also
> contains the LSI/MSI flag of an interrupt which will we need later on.
>=20
> So, let's provide a link to the sPAPR ICS object under XIVE to make
> use of it.

Blech, please don't.  The XIVE code absolutely shouldn't be
referencing XICS objects, it's a recipe for trouble down the line.

If we have to have some sort of abstract "spapr interrupt source"
object that could map to either an ICS irq, or a XIVE source then we
can do that, but don't directly link XIVE and XICS.  *Especially* not
new-in-terms-of-old like this, rather than old-in-terms-of-new.


>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c        | 12 ++++++++++++
>  include/hw/ppc/spapr_xive.h |  4 ++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 6d98528fae68..1681affb0848 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -56,6 +56,8 @@ void spapr_xive_reset(void *dev)
>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>  {
>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
> +    Object *obj;
> +    Error *err =3D NULL;
> =20
>      if (!xive->nr_targets) {
>          error_setg(errp, "Number of interrupt targets needs to be greate=
r 0");
> @@ -68,6 +70,16 @@ static void spapr_xive_realize(DeviceState *dev, Error=
 **errp)
>          return;
>      }
> =20
> +    /* Retrieve SPAPR ICS source to share the IRQ number allocator */

This really suggests we need to move the irq number allocator out of
XICS and into the general spapr code.  Or get rid of it entirely
(using a more static irq mapping) if possible.

> +    obj =3D object_property_get_link(OBJECT(dev), "ics", &err);
> +    if (!obj) {
> +        error_setg(errp, "%s: required link 'ics' not found: %s",
> +                   __func__, error_get_pretty(err));
> +        return;
> +    }
> +
> +    xive->ics =3D ICS_BASE(obj);
> +
>      /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
>      xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
>      xive->sbe =3D g_malloc0(xive->sbe_size);
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index b17dd4f17b0b..29112589b37f 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -24,6 +24,7 @@
>  typedef struct sPAPRXive sPAPRXive;
>  typedef struct XiveIVE XiveIVE;
>  typedef struct XiveEQ XiveEQ;
> +typedef struct ICSState ICSState;
> =20
>  #define TYPE_SPAPR_XIVE "spapr-xive"
>  #define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
> @@ -35,6 +36,9 @@ struct sPAPRXive {
>      uint32_t     nr_targets;
>      uint32_t     nr_irqs;
> =20
> +    /* IRQ */
> +    ICSState     *ics;  /* XICS source inherited from the SPAPR machine =
*/
> +
>      /* XIVE internal tables */
>      uint8_t      *sbe;
>      uint32_t     sbe_size;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3CAnR4CLEnEWqRMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAhIEACgkQbDjKyiDZ
s5KbTQ/9Fxm+eD/mC0ck2hVkZa5tDoWWOQPyegLf6MxhzumMKJiHdbbhXCDqEF9O
AWlmVU3yz8DrNhtqc8HMLtsXeKGlak9kXpNz0KL5vz0UGctHUyFOE46bkuWidV03
5puLp5/fnXgD7o9T44EJiT449/X9z2wrAw0lVNwia4Fl6roGOwQgwov5W6TQWsus
Vn+FR+gTOkNLG6FhX2LL+kQ0/ROOxjo2kJDAc1NthVZwfsw2l5EdjldNUA8nIRHk
6Xrl4Gpeby2Fh/cstxpBeUMCtUY/P77CISgAvjMx914/i29EtjY4/PWiIU/5UohF
rAZqZOgvBpLasknc5NfGWCgaSjWL8bYR+U7aSayyoB/K9nEx2zjSRbXiW2YVbeW1
3fTguPZdekBYrZ/L8MmJf1RN9msYzbLHkucv3l6M2ZVk6h/8u9g/bRuwBJSQjUs9
9IeapJ63dSqqm8uxrRUrGMZjg0PHmSyDv1VpmhCna05+RxpqWv/vbRQeKVL0m2oc
L7IIDbEWBZFuak+u4+2Ka2C6fzZ1xgQpngsy0pgBVx8sUWjvcdGLVm5qQWx6oEc3
2AFZAaXNKYjRIhRdmBwf6jMZaRs85d9ps8kPpcNGFWheHHUt8mtXQoQsTw5io41v
n4HZPGBtRwjrZoJYc/hAaIKxjkYoKOXJa/pTvSZR94PBE208S7I=
=wwlt
-----END PGP SIGNATURE-----

--3CAnR4CLEnEWqRMR--
