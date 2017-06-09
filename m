Received: from eggs.gnu.org ([2001:4830:134:3::10]:53712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mW-0007bS-2o
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mS-00012r-Vy
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:12 -0400
Date: Fri, 9 Jun 2017 12:10:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609021059.GD26521@umbus.fritz.box>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692936183.12119.5013623492394505174.stgit@bahia>
	<5022e1af-9b70-518a-ce61-cadc905e637f@kaod.org>
	<20170608163207.45ba5618@bahia.ttt.fr.ibm.com>
	<018ad85d-6b7f-53d9-e3dc-4a79fcc81767@kaod.org>
	<20170608174559.053df142@bahia.ttt.fr.ibm.com>
	<a5d61649-5e45-7e36-b5ac-06dbf14a71a3@kaod.org>
	<20170608190041.79e55b43@bahia.ttt.fr.ibm.com>
	<9fdf8493-625a-561f-ca07-e56a3bd797cf@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <9fdf8493-625a-561f-ca07-e56a3bd797cf@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 1/6] xics: introduce macros for ICP/ICS
 link properties
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


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 07:26:35PM +0200, C=E9dric Le Goater wrote:
> On 06/08/2017 07:00 PM, Greg Kurz wrote:
> > On Thu, 8 Jun 2017 18:08:44 +0200
> > C=E9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >>>>> FWIW, other people do that as well (see hw/i386/pc_q35.c for exampl=
e).   =20
> >>>>
> >>>> well, I don't see the benefits of changing a string constant by a=20
> >>>> define.=20
> >>>> =20
> >>>
> >>> Improved semantics,  especially since the "xics" string appears in=20
> >>> many places with different meanings.  =20
> >>
> >> ah ? If so, we should do a cleanup up. The code seems consistent from=
=20
> >> what I can see. xics is a general name for :
> >>
> >> 	'PowerPC interrupt controller (type 2)'=20
> >>
> >> and it is mostly used as a prefix. There are no "xics" object, only a=
=20
> >=20
> > I'm only talking about "xics" as a property name actually:
> >=20
> > $ git grep '"xics"'
> > hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), "xics"=
, &err);
> > hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), "xics"=
, &err);
> > hw/ppc/pnv.c:    object_property_add_const_link(OBJECT(&chip->psi), "xi=
cs",
> > hw/ppc/pnv.c:        object_property_add_const_link(OBJECT(pnv_core), "=
xics",
> > hw/ppc/pnv_core.c:    object_property_add_const_link(obj, "xics", OBJEC=
T(xi), &error_abort);
> > hw/ppc/pnv_core.c:    xi =3D object_property_get_link(OBJECT(dev), "xic=
s", &local_err);
> > hw/ppc/pnv_psi.c:    obj =3D object_property_get_link(OBJECT(dev), "xic=
s", &err);
> > hw/ppc/pnv_psi.c:    object_property_add_const_link(OBJECT(ics), "xics"=
, obj,  &error_abort);
> > hw/ppc/spapr.c:    object_property_add_const_link(obj, "xics", OBJECT(s=
papr), &error_abort);
> > hw/ppc/spapr_cpu_core.c:    object_property_add_const_link(obj, "xics",=
 OBJECT(spapr), &error_abort);
> >=20
> > You have to read the code to know which ones are related.
>=20
> The "xics" property link always point to the same object :=20
> the XICSFabric object which is the machine, spapr or pnv.=20
>=20
> > With this patch applied, it is mostly obvious, even for the newbie:
>=20
> ah. the goal is to know where in the code the link was set.=20
> It can be even more complex with aliases.

There doesn't seem to be a strong convention about whether to use raw
property names or defines across qemu.  I'm not all that fussed either
way.

I do see one small advantage to use defines: if you make a typo, it
will probably result in a compile time error, whereas with a bare
string it won't show up until a runtime error.

In this case, I intend to take the macro patch, mostly just on the
basis of avoiding further delays to rework the remaining patches.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOgOzAAoJEGw4ysog2bOS0wkP/0udQEMi07m6oQHCyi4Bj51m
ItKhsZoDEqU6tIMFcQWCgpeBWQTFwn/skz5joRrlvzb1NZ/UwQi9msB+MT112wW6
32vIrejA6vo6l7TcAk58FvO7gD5Kxl4SpE59bbAZSJbS00shQEJhIruuNry3CMy6
BahgqYr7YaqDsPVQrJw8nCUcnxlQvly6T+bCq6yppsk/+nZBh9IWrED4jbTaMejE
x752xpfHdYjRKSDEK1LmuPUmFm/yUA50GuHmnMSMir8R4HJWWuYwTmXtqZFBYHAm
0Q5LHY7BwCtzKcGwYLNys/eu0QyO3wyLjBnxdaZPD+xuGIPJESnqL29daV4lSUKP
o5JZ0M0py9OR4g+ofsZ4JsjYlx06FZtOsZ2AcgGLEqpyMsZ9I6jPqwv9fdUeKs8D
dISDWKTJTZie8Dng+XEdsX+GGaqp3lXWp2AYUd8eu/Hd9nhnnwG3X9abOtnjww/i
PcCkyaeUgeLH3hYha5q86uGUm5gEJN+kfrDm8SvDj4ThYcnPFFQPNfZyu3dUmrTd
VCUlpCT2aXZ4vk4OF11aFTk6MISMbIz0h4O5u/tLdp1zOCfAqI2c2bqc0GMw2ndM
ohHke/IsJKXjpXM4kX1dudKZqRAr6m9uFxOjFqs0Og7cSDAhFyLGC3oDxL8v/AMx
yiY1eFonIBSUtvGsW5uc
=Vqmz
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
