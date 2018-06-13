Received: from eggs.gnu.org ([2001:4830:134:3::10]:39590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2M2-0006v0-D7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2Ly-0004w1-FE
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:46:14 -0400
Date: Wed, 13 Jun 2018 19:42:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613094258.GE30690@umbus.fritz.box>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-3-david@gibson.dropbear.id.au>
	<20180613110939.28d30cf0@bahia.lab.toulouse-stg.fr.ibm.com>
	<e69b80c7-8334-cf7a-5b23-85c5e6c3517b@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="keyOwv2R5UpfANsk"
Content-Disposition: inline
In-Reply-To: <e69b80c7-8334-cf7a-5b23-85c5e6c3517b@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/7] pnv: Add missing error check during
 cpu realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--keyOwv2R5UpfANsk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 11:14:57AM +0200, C=E9dric Le Goater wrote:
> >> index 13ad7d9e04..efb68226bb 100644
> >> --- a/hw/ppc/pnv_core.c
> >> +++ b/hw/ppc/pnv_core.c
> >> @@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
> >> =20
> >>          snprintf(name, sizeof(name), "thread[%d]", i);
> >>          object_property_add_child(OBJECT(pc), name, obj, &local_err);
> >> +        if (local_err) {
> >> +            goto err;
> >> +        }
> >>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
> >>                                    "pir", &local_err);
> >>          if (local_err) {
> >=20
> > Hmm... the current error path seems to assume failures to be
> > caused by object_property_add_child(). It hence unparents the
> > previously parented CPUs, but not the current one. So we'll
> > miss one call to object_unparent() if object_property_add_alias()
> > fails.
>=20
> yes, let's just put NULL or &error_abort instead.

Yeah, good idea, I'll change it in a new spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--keyOwv2R5UpfANsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg5yAACgkQbDjKyiDZ
s5JKDhAAmyqjwQoasQuSxYf0KZpkIC6pt3FUUYMARTKhKl1EA+1uwRDJRrCI0weT
OpoPF+Ode8v7ei6oiNOE+QnSQakrPWBMPAXm4nN+Sys8U4tf1dUE9EC0qQE62MF/
14Kyhrp9+aLPhQW1MdRXONC+D/OIEhR6PciB4rwRPP5Pcxzq6SFuZDllpyFA1rwU
ddMYzdFBgjgIVtkZkZjBjxZNgOuAv79XZE3UBipt4dKvaOB2GudCXp2cV7K6VUj8
xvYwuGxxwDARFKPGaH108iL67Qc2kNDwEZsJrDR9X7IpL4bZ5nDnQWr8E1hJkLUu
j8qHXxe4roS4RMW7BL6DaYVvXcZ/cAPZfXHuhu2BjAxaTHuO/mXwCuwgDF3moNk/
6hwt3QW69y9FcmbYj1yP8scsRTn6gcUf7Go4nN3lUHR2fXwT4LPcZBtzPzWDoJpA
GtRAvMVQivKLSE0sj8ZhUIrpGBuZJ1iFS4dmLxODA38x+S7ihnuUR2IrKTtDgxYY
h+4Z90kHkCaOzXOHC5TxG/3PzLSQYWFL2u6ynXPjwUymkgPegKfF1yUH6Ajr3RaY
d7aUKbADu2Y2gSYdzhEZUKtTj8daPOpb5jiyUJayfR5pvjaGjyRC6gCRHSSMvErH
ifUW/wk34TGGISR+fGjGfbKmKgRkJvG8xx+5dMS7Auewm2cagXY=
=BA7p
-----END PGP SIGNATURE-----

--keyOwv2R5UpfANsk--
