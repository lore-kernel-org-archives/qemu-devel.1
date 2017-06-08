Received: from eggs.gnu.org ([2001:4830:134:3::10]:47737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJ0nl-0003IO-GQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJ0nh-00055G-C9
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:00:53 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:39873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dJ0nh-00053z-4d
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:00:49 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id A8A043EA7F
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 19:00:47 +0200 (CEST)
Date: Thu, 8 Jun 2017 19:00:41 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608190041.79e55b43@bahia.ttt.fr.ibm.com>
In-Reply-To: <a5d61649-5e45-7e36-b5ac-06dbf14a71a3@kaod.org>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692936183.12119.5013623492394505174.stgit@bahia>
	<5022e1af-9b70-518a-ce61-cadc905e637f@kaod.org>
	<20170608163207.45ba5618@bahia.ttt.fr.ibm.com>
	<018ad85d-6b7f-53d9-e3dc-4a79fcc81767@kaod.org>
	<20170608174559.053df142@bahia.ttt.fr.ibm.com>
	<a5d61649-5e45-7e36-b5ac-06dbf14a71a3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/.aCsbRgum6.7APyc77Ps+79";
	protocol="application/pgp-signature"
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/.aCsbRgum6.7APyc77Ps+79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 18:08:44 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> >>> FWIW, other people do that as well (see hw/i386/pc_q35.c for example)=
.   =20
> >>
> >> well, I don't see the benefits of changing a string constant by a=20
> >> define.=20
> >> =20
> >=20
> > Improved semantics,  especially since the "xics" string appears in=20
> > many places with different meanings.  =20
>=20
> ah ? If so, we should do a cleanup up. The code seems consistent from=20
> what I can see. xics is a general name for :
>=20
> 	'PowerPC interrupt controller (type 2)'=20
>=20
> and it is mostly used as a prefix. There are no "xics" object, only a=20

I'm only talking about "xics" as a property name actually:

$ git grep '"xics"'
hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), "xics", &e=
rr);
hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), "xics", &e=
rr);
hw/ppc/pnv.c:    object_property_add_const_link(OBJECT(&chip->psi), "xics",
hw/ppc/pnv.c:        object_property_add_const_link(OBJECT(pnv_core), "xics=
",
hw/ppc/pnv_core.c:    object_property_add_const_link(obj, "xics", OBJECT(xi=
), &error_abort);
hw/ppc/pnv_core.c:    xi =3D object_property_get_link(OBJECT(dev), "xics", =
&local_err);
hw/ppc/pnv_psi.c:    obj =3D object_property_get_link(OBJECT(dev), "xics", =
&err);
hw/ppc/pnv_psi.c:    object_property_add_const_link(OBJECT(ics), "xics", ob=
j,  &error_abort);
hw/ppc/spapr.c:    object_property_add_const_link(obj, "xics", OBJECT(spapr=
), &error_abort);
hw/ppc/spapr_cpu_core.c:    object_property_add_const_link(obj, "xics", OBJ=
ECT(spapr), &error_abort);

You have to read the code to know which ones are related.

With this patch applied, it is mostly obvious, even for the newbie:

$ git grep -E 'IC._PROP_XICS|"xics"'
hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_X=
ICS, &err);
hw/intc/xics.c:        error_setg(errp, "%s: required link '" ICP_PROP_XICS=
 "' not found: %s",
hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_X=
ICS, &err);
hw/intc/xics.c:        error_setg(errp, "%s: required link '" ICS_PROP_XICS=
 "' not found: %s",

hw/ppc/pnv.c:    object_property_add_const_link(OBJECT(&chip->psi), "xics",
hw/ppc/pnv.c:        object_property_add_const_link(OBJECT(pnv_core), "xics=
",

these two ^^ are related to...

hw/ppc/pnv_core.c:    object_property_add_const_link(obj, ICP_PROP_XICS, OB=
JECT(xi),

hw/ppc/pnv_core.c:    xi =3D object_property_get_link(OBJECT(dev), "xics", =
&local_err);
hw/ppc/pnv_psi.c:    obj =3D object_property_get_link(OBJECT(dev), "xics", =
&err);

these two ^^

hw/ppc/pnv_psi.c:    object_property_add_const_link(OBJECT(ics), ICS_PROP_X=
ICS, obj,
hw/ppc/spapr.c:    object_property_add_const_link(obj, ICS_PROP_XICS, OBJEC=
T(spapr),
hw/ppc/spapr_cpu_core.c:    object_property_add_const_link(obj, ICP_PROP_XI=
CS, OBJECT(spapr),
include/hw/ppc/xics.h:#define ICP_PROP_XICS "xics"
include/hw/ppc/xics.h:#define ICS_PROP_XICS "xics"

> XICSFabric which is a QOM interface of the machine with a bunch of=20
> handlers. It worked out pretty well for sPAPR and PowerNV.
>=20
> It won't be the case for XIVE, the interrupt controller (type 3) for=20
> the P9. It is more complex and there are quite a lot of internal=20
> states which will need to be gathered under an object. We can keep=20
> the ICPState fortunately but the sources are quite different.
>=20
> C.
>=20


--Sig_/.aCsbRgum6.7APyc77Ps+79
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5grkACgkQAvw66wEB28IyvACcC8wnZEY9aDVhqS8v1QxrQrKr
SdMAnR8z4oH3qwgxXp/Pva8oFZzluywK
=j0BC
-----END PGP SIGNATURE-----

--Sig_/.aCsbRgum6.7APyc77Ps+79--
