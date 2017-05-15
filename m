Received: from eggs.gnu.org ([2001:4830:134:3::10]:51605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAEwT-0006fC-U2
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAEwQ-0002Aa-PW
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:17:37 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:40956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAEwQ-00029E-J2
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:17:34 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 235551FD03
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 14:17:33 +0200 (CEST)
Date: Mon, 15 May 2017 14:17:26 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170515141726.3ec8be7e@bahia>
In-Reply-To: <6bbb2627-c360-289f-039d-2b899e2e6d9c@kaod.org>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484839512.20089.2730407279712230463.stgit@bahia.lan>
	<6bbb2627-c360-289f-039d-2b899e2e6d9c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/K0c=7UZWKX11rB==to8b3yE";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 5/6] spapr-cpu-core: release ICP object
 when realization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/K0c=7UZWKX11rB==to8b3yE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 May 2017 14:02:34 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 05/15/2017 01:39 PM, Greg Kurz wrote:
> > While here we introduce a single error path to avoid code duplication.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_cpu_core.c |   16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 4389ef4c2aef..63d160f7e010 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -147,25 +147,25 @@ static void spapr_cpu_core_realize_child(Object *=
child, Error **errp)
> >      object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_=
abort);
> >      object_property_set_bool(obj, true, "realized", &local_err);
> >      if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > +        goto error; =20
>=20
> the error: statement below adds an object_unparent(). is that ok ?=20
>=20

Yes, this is the purpose of the patch actually.

The ICP object gets parented to the CPU a few lines above, so I guess we
should unparent in this error path as well.

Maybe I should rename the patch to "unparent ICP object when realization fa=
ils" ?

> C.=20
>=20
> >      }
> > =20
> >      object_property_set_bool(child, true, "realized", &local_err);
> >      if (local_err) {
> > -        object_unparent(obj);
> > -        error_propagate(errp, local_err);
> > -        return;
> > +        goto error;
> >      }
> > =20
> >      spapr_cpu_init(spapr, cpu, &local_err);
> >      if (local_err) {
> > -        object_unparent(obj);
> > -        error_propagate(errp, local_err);
> > -        return;
> > +        goto error;
> >      }
> > =20
> >      xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
> > +    return;
> > +
> > +error:
> > +    object_unparent(obj);
> > +    error_propagate(errp, local_err);
> >  }
> > =20
> >  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
> >  =20
>=20


--Sig_/K0c=7UZWKX11rB==to8b3yE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkZnFYACgkQAvw66wEB28J8MgCfQO/UZCAuprAibS0CsT7m74lP
BpQAn1Wgs1fkpcov91BnwPTTyo2A9KdS
=nRxD
-----END PGP SIGNATURE-----

--Sig_/K0c=7UZWKX11rB==to8b3yE--
