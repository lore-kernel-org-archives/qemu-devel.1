Received: from eggs.gnu.org ([2001:4830:134:3::10]:50703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdotD-0006Nm-Te
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdotC-0004lm-EU
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:00:16 -0500
Date: Wed, 15 Feb 2017 12:59:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170215015957.GD12369@umbus.fritz.box>
References: <1486994957-20400-1-git-send-email-clg@kaod.org>
	<1486994957-20400-2-git-send-email-clg@kaod.org>
	<20170214050219.GH2169@umbus.fritz.box>
	<32f762b6-0fc0-fd1f-d0f1-6265436c8274@kaod.org>
	<7cde2ccc-95cb-5ace-e50c-91095cc2c6b8@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <7cde2ccc-95cb-5ace-e50c-91095cc2c6b8@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc/xics: remove set_nr_irqs() handler
 from XICSStateClass
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


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 03:52:09PM +0100, C=E9dric Le Goater wrote:
> On 02/14/2017 08:04 AM, C=E9dric Le Goater wrote:
> > On 02/14/2017 06:02 AM, David Gibson wrote:
> >> On Mon, Feb 13, 2017 at 03:09:16PM +0100, C=E9dric Le Goater wrote:
> >>> Today, the ICS (Interrupt Controller Source) object is created and
> >>> realized by the init and realize routines of the XICS object, but some
> >>> of the parameters are only known at the machine level.
> >>>
> >>> These parameters are passed from the sPAPR machine to the ICS object
> >>> in a rather convoluted way using property handlers and a class handler
> >>> of the XICS object. The number of irqs required to allocate the IRQ
> >>> state objects in the ICS realize routine is one of them.
> >>>
> >>> Let's simplify the process by creating the ICS object along with the
> >>> XICS object at the machine level and link the ICS into the XICS list
> >>> of ICSs at this level also. In the sPAPR machine, there is only a
> >>> single ICS but that will change with the PowerNV machine.
> >>>
> >>> Also, QOMify the creation of the objects and get rid of the
> >>> superfluous code.
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>
> >> I like the basic idea here: while the ics and icp objects are pretty
> >> straightforward, the "xics" object has always been a bit of a hack,
> >> with logic that really belongs in the machine.
> >>
> >> But.. I don't think the approach here really works.  Specifically..
> >>
> >> [snip]
> >>> -static XICSState *try_create_xics(const char *type, int nr_servers,
> >>> -                                  int nr_irqs, Error **errp)
> >>> -{
> >>> -    Error *err =3D NULL;
> >>> -    DeviceState *dev;
> >>> +static XICSState *try_create_xics(const char *type, const char *type=
_ics,
> >>> +                                  int nr_servers, int nr_irqs, Error=
 **errp)
> >>> +{
> >>> +    Error *err =3D NULL, *local_err =3D NULL;
> >>> +    XICSState *xics;
> >>> +    ICSState *ics =3D NULL;
> >>> +
> >>> +    xics =3D XICS_COMMON(object_new(type));
> >>> +    qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
> >>> +    object_property_set_int(OBJECT(xics), nr_servers, "nr_servers", =
&err);
> >>> +    object_property_set_bool(OBJECT(xics), true, "realized", &local_=
err);
> >>> +    error_propagate(&err, local_err);
> >>> +    if (err) {
> >>> +        goto error;
> >>> +    }
> >>> =20
> >>> -    dev =3D qdev_create(NULL, type);
> >>> -    qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
> >>> -    qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
> >>> -    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> >>> +    ics =3D ICS_SIMPLE(object_new(type_ics));
> >>> +    object_property_add_child(OBJECT(xics), "ics", OBJECT(ics), NULL=
);
> >>> +    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
> >>> +    object_property_set_bool(OBJECT(ics), true, "realized", &local_e=
rr);
> >>> +    error_propagate(&err, local_err);
> >>>      if (err) {
> >>> -        error_propagate(errp, err);
> >>> -        object_unparent(OBJECT(dev));
> >>> -        return NULL;
> >>> +        goto error;
> >>> +    }
> >>> +
> >>> +    ics->xics =3D xics;
> >>> +    QLIST_INSERT_HEAD(&xics->ics, ics, list);
> >>
> >> Poking into the ics and xics objects directly from the machine here
> >> violates abstraction even worse than the existing xics device does.
> >> In fact, avoiding that is basically why the xics device exists in the
> >> first place.
> >=20
> > Well, currently, xics_set_nr_servers() also does a :
> >=20
> > 	icp->xics =3D xics;
> >=20
> > So, I think we can live with it until we move the ICS and ICP objects=
=20
> > out of XICS ?
> >=20
> > if this is the only worrisome problem in the patch, I can start the
> > series with a QOM Interface handler implemented at the machine level,=
=20
> > something like :=20
> >=20
> > 	void (*ics_insert)(ICSState *ics);
> >=20
> > doing the insert above to hide the temporary hideousness. Is that ok ?=
=20
>=20
> After some thought, I don't think this one is important. At the=20
> machine level, it seems OK to me to insert an ICS in the XICS list.=20
> I agree that XICS should disappear, but it is still there for the=20
> moment.=20
>=20
> > And, as you propose below, I think we can add the 'xics' link property=
=20
> > right now to get rid of :
> >=20
> > 	ic[ps]->xics =3D xics;
>=20
> I have a v2 ready adding the 'xics' link property but keeping the=20
> QLIST_INSERT_HEAD() call in try_create_xics(). Do you think it is=20
> worth sending as an initial cleanup :
>=20
>  5 files changed, 96 insertions(+), 225 deletions(-)
>=20
> or do you want the full picture to be addressed ?=20

I don't think I'll want to merge until the full picture is addressed.
However, I'm fine with posting incomplete versions for earlier review
- just label them RFC and note in the 0/N comment that there's more
work to be done to complete the picture.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYo7YdAAoJEGw4ysog2bOSlvMQAI4tbBJHfZtyM7ItVk1qd/oJ
Oy/NwwVMfwTp96J0BNiXCZxY86MGXLfWPaprCFdAwgVxC6r9jpVV7Ay98FxXQQsn
xXbFHUHOABSQ0zD7v3jB2nHdJ6FCxfvwREAKXklwTd3zsQ2Yejb5WB17ZgXaPjmE
sxTq68YXQ8HG/pkwIKJHornu+tCsZIwHU8UW5CKuFxPelrm3LQ3HsIom95PvhNgY
PuMzh43+7+YMFnhoYhKrKh7Y+8N3NukAhqjBVh9/OO2wbCmWVHceNGjTSuQqekB1
WSIp4PPFLSZj8mmvZQrduqtoLzrmifdY77QKtKk7XLq3cMhm794iVj7Tcn1XMf1e
VY4YXJAOYUYxPc7ZWQf8xmeSQbG2+qMY5PIzh0KC/7Z/f4rV7LQM1nfIn4WyH6z/
yAA6q5yhJWcuPXmGn3uKa2P/79a5n+De0vrWK8lQ+Kdm2uuUhxXNmvB3qzfd/+w2
gXjrDpukL9qm+lREvweaqgfuiTAe1T4jy+jiAAjufvtAzXCL92QB2ijYnIahMLB0
RtATXG64vT5LRfAouMRUbe6Q1CZsHo29vUt47sWoGT3X1j82bAePuF2kQTpa4wf7
5viuhoBqM5GYhkPhW5muRquyRiilidTQsAAgIVZo6C5Tj1AZFY2D5tVhYxcWdIJ6
wz0a4CVZ7RiMm6y64gAQ
=n7/d
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
