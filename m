Received: from eggs.gnu.org ([2001:4830:134:3::10]:50705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdotE-0006Nq-Cc
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdotC-0004lu-OI
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:00:16 -0500
Date: Wed, 15 Feb 2017 12:58:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170215015834.GA435@umbus.fritz.box>
References: <1486994957-20400-1-git-send-email-clg@kaod.org>
	<1486994957-20400-2-git-send-email-clg@kaod.org>
	<20170214050219.GH2169@umbus.fritz.box>
	<32f762b6-0fc0-fd1f-d0f1-6265436c8274@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <32f762b6-0fc0-fd1f-d0f1-6265436c8274@kaod.org>
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


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 08:04:42AM +0100, C=E9dric Le Goater wrote:
> On 02/14/2017 06:02 AM, David Gibson wrote:
> > On Mon, Feb 13, 2017 at 03:09:16PM +0100, C=E9dric Le Goater wrote:
> >> Today, the ICS (Interrupt Controller Source) object is created and
> >> realized by the init and realize routines of the XICS object, but some
> >> of the parameters are only known at the machine level.
> >>
> >> These parameters are passed from the sPAPR machine to the ICS object
> >> in a rather convoluted way using property handlers and a class handler
> >> of the XICS object. The number of irqs required to allocate the IRQ
> >> state objects in the ICS realize routine is one of them.
> >>
> >> Let's simplify the process by creating the ICS object along with the
> >> XICS object at the machine level and link the ICS into the XICS list
> >> of ICSs at this level also. In the sPAPR machine, there is only a
> >> single ICS but that will change with the PowerNV machine.
> >>
> >> Also, QOMify the creation of the objects and get rid of the
> >> superfluous code.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > I like the basic idea here: while the ics and icp objects are pretty
> > straightforward, the "xics" object has always been a bit of a hack,
> > with logic that really belongs in the machine.
> >=20
> > But.. I don't think the approach here really works.  Specifically..
> >=20
> > [snip]
> >> -static XICSState *try_create_xics(const char *type, int nr_servers,
> >> -                                  int nr_irqs, Error **errp)
> >> -{
> >> -    Error *err =3D NULL;
> >> -    DeviceState *dev;
> >> +static XICSState *try_create_xics(const char *type, const char *type_=
ics,
> >> +                                  int nr_servers, int nr_irqs, Error =
**errp)
> >> +{
> >> +    Error *err =3D NULL, *local_err =3D NULL;
> >> +    XICSState *xics;
> >> +    ICSState *ics =3D NULL;
> >> +
> >> +    xics =3D XICS_COMMON(object_new(type));
> >> +    qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
> >> +    object_property_set_int(OBJECT(xics), nr_servers, "nr_servers", &=
err);
> >> +    object_property_set_bool(OBJECT(xics), true, "realized", &local_e=
rr);
> >> +    error_propagate(&err, local_err);
> >> +    if (err) {
> >> +        goto error;
> >> +    }
> >> =20
> >> -    dev =3D qdev_create(NULL, type);
> >> -    qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
> >> -    qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
> >> -    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> >> +    ics =3D ICS_SIMPLE(object_new(type_ics));
> >> +    object_property_add_child(OBJECT(xics), "ics", OBJECT(ics), NULL);
> >> +    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
> >> +    object_property_set_bool(OBJECT(ics), true, "realized", &local_er=
r);
> >> +    error_propagate(&err, local_err);
> >>      if (err) {
> >> -        error_propagate(errp, err);
> >> -        object_unparent(OBJECT(dev));
> >> -        return NULL;
> >> +        goto error;
> >> +    }
> >> +
> >> +    ics->xics =3D xics;
> >> +    QLIST_INSERT_HEAD(&xics->ics, ics, list);
> >=20
> > Poking into the ics and xics objects directly from the machine here
> > violates abstraction even worse than the existing xics device does.
> > In fact, avoiding that is basically why the xics device exists in the
> > first place.
>=20
> Well, currently, xics_set_nr_servers() also does a :
>=20
> 	icp->xics =3D xics;

Well.. yes, but that's at least from code within the xics files,
moving it into the machine makes the abstraction breakage worse.  (You
could think of it at the moment as treating XICS as a "friend" class
of ICS and ICP).

> So, I think we can live with it until we move the ICS and ICP objects=20
> out of XICS ?

As an interim step it might be acceptable, yes.  I wouldn't want to
apply the change except as part of a series which completes the
transition, though.

> if this is the only worrisome problem in the patch, I can start the
> series with a QOM Interface handler implemented at the machine level,=20
> something like :=20

The QLIST_INSERT_HEAD() is also a problem.  Inside the XICS object it
altered ICS internal state, which is bad.  Inside the machine it
alters both XICS and ICS internal state, which is worse.

>=20
> 	void (*ics_insert)(ICSState *ics);
>=20
> doing the insert above to hide the temporary hideousness. Is that ok ?=20

I don't 100% follow how you intend to use that, but it sounds like it
mightg work.

> And, as you propose below, I think we can add the 'xics' link property=20
> right now to get rid of :
>=20
> 	ic[ps]->xics =3D xics;

Yes, I think that's a better option.

> > I've thought about this a bit more, and I think I know how to solve
> > this better now.
> >
> > I think that "xics" shouldn't be a concrete object at all, instead it
> > should be a QOM interface, implemented by the machine type.  Both ICS
> > and ICP would take a link property to find their xics.=20
>=20
> yes.
>=20
> > The xics
> > interface would provide methods to return an ics object given an irq
> > number and to return an icp object given a server number. This gives
> > full control of the irq and server number spaces back to the machine
> > type, which is really where it belongs.
>=20
> Yes, I agree, we started talking about it a while ago :
>=20
>     http://lists.nongnu.org/archive/html/qemu-ppc/2016-11/msg00056.html

Ah, sorry, I'd forgotten that.

> and this is what this first series is trying to do. It prepares ground=20
> by emptying the XICS object.=20
>=20
> The next step is to move out :
>=20
>     ICPState *ss;
>     QLIST_HEAD(, ICSState) ics;
>=20
> from XICSState to sPAPRMachineState I think. This is when the QOM=20
> interfaces will come in play but we need to untangle the code slowly,=20
> to understand what is being done (honestly, it is not that obvious). =20
>=20
> As for xics->nr_servers, the only place where I still have doubts is=20
> ics_simple_post_load(). It should be easier after more cleanups.
>=20
> This is like mahjong, you need to start from the right piece :)

Ah, ok.  Sorry, I'd forgotten the context of that discussion.  As
initial steps to a more thorough cleanup, these look fine.  However, I
don't want to commit them, except as part of a series which ends up
with less abstration violations than we started with, rather than
more.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYo7XIAAoJEGw4ysog2bOSOBYP/3TBxZEKFM3JkTFgRtprsWQy
DMEaKBD+Rx6Pc6A1ZLcKGJdq75yPSKv00OhI7f5nL+AHIE5TmgX7eRtDQWrWXSpC
jpRGHSlEtEMScYqE31XjhWtt3hMjs+Hp44iRqJv3LQcJ2inBO8EG2ApJ6Iowf1+D
dQZm9BZ3e1a8hU/woR+asFkDIoOJcOViO1LUaDIiDB26N2QlHlyxZAQDdvAWqbN2
/iV1gzDCPLVUapiJVBMglFUusVNQKZyG987reEh49OcEeNtXmMYY3T8hOks+EbB1
D/wrhMNbzY+q8mu4OdK3hy0vYtCF9P/D67z6B4yq3Ru+fnKiiN9g/jWREbI7CwtS
eOesphJWoUQq6nfip0aCnzxSejfeas0OnLiKd+Q2ldWfRPg6pjBKo5bNyJxN/y0b
8LucqmuJaCyB0vVStVJHmJHfCYz0nkJ+qaOGF1rDd+MekVYyaJOKZOT/HkswYpXG
7KxQ8xfgxsJEuRTSd6N9p+CBHysHrTLHn5yfLC9v3/ou/RQdupWGvnEyM1niORNg
lvjUzMrbh+Vx7mrcLS8pZg+SmhktxIYGv0MzebD1d1zqP5ae9KAxDPFPVLPKgJfT
FBetAvAFLui3vkidlFG3N7jWIETk8ZZ1NuuAMR4GdoKohzcj5HSzZtapBIFUCa7P
NrClcQ55zNm+hPY3kFKm
=p+fw
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
