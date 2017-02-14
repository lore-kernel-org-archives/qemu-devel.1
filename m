Received: from eggs.gnu.org ([2001:4830:134:3::10]:60294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdVG6-0000Mv-1f
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 00:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdVG4-00013D-Ll
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 00:02:34 -0500
Date: Tue, 14 Feb 2017 16:02:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170214050219.GH2169@umbus.fritz.box>
References: <1486994957-20400-1-git-send-email-clg@kaod.org>
	<1486994957-20400-2-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <1486994957-20400-2-git-send-email-clg@kaod.org>
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


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 03:09:16PM +0100, C=E9dric Le Goater wrote:
> Today, the ICS (Interrupt Controller Source) object is created and
> realized by the init and realize routines of the XICS object, but some
> of the parameters are only known at the machine level.
>=20
> These parameters are passed from the sPAPR machine to the ICS object
> in a rather convoluted way using property handlers and a class handler
> of the XICS object. The number of irqs required to allocate the IRQ
> state objects in the ICS realize routine is one of them.
>=20
> Let's simplify the process by creating the ICS object along with the
> XICS object at the machine level and link the ICS into the XICS list
> of ICSs at this level also. In the sPAPR machine, there is only a
> single ICS but that will change with the PowerNV machine.
>=20
> Also, QOMify the creation of the objects and get rid of the
> superfluous code.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I like the basic idea here: while the ics and icp objects are pretty
straightforward, the "xics" object has always been a bit of a hack,
with logic that really belongs in the machine.

But.. I don't think the approach here really works.  Specifically..

[snip]
> -static XICSState *try_create_xics(const char *type, int nr_servers,
> -                                  int nr_irqs, Error **errp)
> -{
> -    Error *err =3D NULL;
> -    DeviceState *dev;
> +static XICSState *try_create_xics(const char *type, const char *type_ics,
> +                                  int nr_servers, int nr_irqs, Error **e=
rrp)
> +{
> +    Error *err =3D NULL, *local_err =3D NULL;
> +    XICSState *xics;
> +    ICSState *ics =3D NULL;
> +
> +    xics =3D XICS_COMMON(object_new(type));
> +    qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
> +    object_property_set_int(OBJECT(xics), nr_servers, "nr_servers", &err=
);
> +    object_property_set_bool(OBJECT(xics), true, "realized", &local_err);
> +    error_propagate(&err, local_err);
> +    if (err) {
> +        goto error;
> +    }
> =20
> -    dev =3D qdev_create(NULL, type);
> -    qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
> -    qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
> -    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> +    ics =3D ICS_SIMPLE(object_new(type_ics));
> +    object_property_add_child(OBJECT(xics), "ics", OBJECT(ics), NULL);
> +    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
> +    object_property_set_bool(OBJECT(ics), true, "realized", &local_err);
> +    error_propagate(&err, local_err);
>      if (err) {
> -        error_propagate(errp, err);
> -        object_unparent(OBJECT(dev));
> -        return NULL;
> +        goto error;
> +    }
> +
> +    ics->xics =3D xics;
> +    QLIST_INSERT_HEAD(&xics->ics, ics, list);

Poking into the ics and xics objects directly from the machine here
violates abstraction even worse than the existing xics device does.
In fact, avoiding that is basically why the xics device exists in the
first place.

I've thought about this a bit more, and I think I know how to solve
this better now.

I think that "xics" shouldn't be a concrete object at all, instead it
should be a QOM interface, implemented by the machine type.  Both ICS
and ICP would take a link property to find their xics.  The xics
interface would provide methods to return an ics object given an irq
number and to return an icp object given a server number. This gives
full control of the irq and server number spaces back to the machine
type, which is really where it belongs.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoo9ZAAoJEGw4ysog2bOS8MoP/iT1gGKqLO8H4UDni4bwrcHk
Q8hvkeo3peGR1X4PLDCEMmKbDXduDbFTAlh61dv325UllA7rm3P61GPl1IGLiU/P
NY7Y7zFR605y1gP8p3hrqZ2ei8Z4hwsZE6+eNlDCYa8t8Yhav3WoJ+seIuGxgaVK
PZldJ37im9dxxBfBzJa21uFT8lZGNhKr/NlbfsJahM6XxYifWzbCRiYXaVSKJgXV
Bv534Z7zp050Snmbo+J2OH/FL/cIjwOUqhezaQ8OjuTqo3CECqtox1tiOKtljlmB
Nw1XbIyGkocRxpRstKI1wa0cxytEpWtyt3Ix/fKauHlIa8W3xm7NxAq94ZwH7+Ic
5fTBGPPJ3xq2S1zZXLH1QnjtLWrBZx1MgwHH6E3QPt36nXuTU1+AOWaL+XU+ZC7U
lKBpL7s2p6XwFPUhgoQ2INhDClDLBTHzs4i0b8Hq8iJbFnFc9eL8J5AU9Gkh2VDg
dwMRwu4hVz//qGjPn/Wzi5jhb6oRalWMui2McHHJKfmOOHM61pYOeDVQ1ytPG5W0
RLwPfWgLhpS94QX+ll80XsXnR4nOTRnkb5LgtAnOBd8fr0Dazp5E+6Yrj9VvN9XV
YmgmpynAq/pswAvUlQjH2edxBEFN6+aZxUaS90zScN1SYH6e1OKMgoM6dwS60r3r
Rk78FJ6bR/YmGIlvFPwU
=SAWA
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
