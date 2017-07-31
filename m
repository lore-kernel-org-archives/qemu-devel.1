Received: from eggs.gnu.org ([2001:4830:134:3::10]:59163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcEDk-0002hk-6K
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcEDf-00059W-5U
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:11:08 -0400
Received: from 2.mo7.mail-out.ovh.net ([87.98.143.68]:60054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcEDe-000574-UL
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:11:03 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id C703764BA5
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 19:11:00 +0200 (CEST)
Date: Mon, 31 Jul 2017 19:10:49 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170731191049.532ccd8c@bahia.lan>
In-Reply-To: <150151915325.13537.10448083238606290383@loki>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1501119055-4060-3-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170731175139.5d569df6@bahia.lan>
	<150151915325.13537.10448083238606290383@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/agV0AMcreZUzl78k.mylk8L";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/3] Revert "qdev: Free QemuOpts
 when the QOM path goes away"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, armbru@redhat.com

--Sig_/agV0AMcreZUzl78k.mylk8L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Jul 2017 11:39:13 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Greg Kurz (2017-07-31 10:51:39)
> > On Wed, 26 Jul 2017 20:30:54 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> >  =20
> > > This reverts commit abed886ec60cf239a03515cf0b30fb11fa964c44.
> > >=20
> > > This patch originally addressed an issue where a DEVICE_DELETED
> > > event could be emitted (in device_unparent()) before a Device's
> > > QemuOpts were cleaned up (in device_finalize()), leading to a
> > > "duplicate ID" error if management attempted to immediately add
> > > a device with the same ID in response to the DEVICE_DELETED event.
> > >=20
> > > An alternative will be implemented in a subsequent patch where we
> > > defer the DEVICE_DELETED event until device_finalize(), which would
> > > also prevent the race, so we revert the original fix in preparation.
> > >  =20
> >=20
> > Do you really need to revert abed886ec60cf239a03515cf0b30fb11fa964c44 ?
> >=20
> > IIUC, the purpose of this series is to fix/workaround the VFIO cleanup =
issue.
> > Even if it also relates to when we emit DEVICE_DELETED, it isn't exactl=
y the
> > same problem here, is it ? =20
>=20
> That's true, but since the implementation of the VFIO fix requires
> moving qemu_opts_del() to back to finalize(), and since that
> effectively reverts the change made in abed88, I figured it was
> better to revert the patch directly as opposed as a side-effect
> of patch 3.
>=20

Fair enough.

Reviewed-by: Greg Kurz <groug@kaod.org>

> >  =20
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > ---
> > >  hw/core/qdev.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > index a64b35c..08c4061 100644
> > > --- a/hw/core/qdev.c
> > > +++ b/hw/core/qdev.c
> > > @@ -1067,6 +1067,7 @@ static void device_finalize(Object *obj)
> > >      NamedGPIOList *ngl, *next;
> > > =20
> > >      DeviceState *dev =3D DEVICE(obj);
> > > +    qemu_opts_del(dev->opts);
> > > =20
> > >      QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
> > >          QLIST_REMOVE(ngl, node);
> > > @@ -1116,9 +1117,6 @@ static void device_unparent(Object *obj)
> > >          g_free(dev->canonical_path);
> > >          dev->canonical_path =3D NULL;
> > >      }
> > > -
> > > -    qemu_opts_del(dev->opts);
> > > -    dev->opts =3D NULL;
> > >  }
> > > =20
> > >  static void device_class_init(ObjectClass *class, void *data) =20
> >  =20
>=20


--Sig_/agV0AMcreZUzl78k.mylk8L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll/ZJoACgkQAvw66wEB28IGaQCeO7pWwSOADMKeFghV8MbqHqhS
M5cAnR7d/gWUdWN2EoTSIDneG5icVzps
=jMLe
-----END PGP SIGNATURE-----

--Sig_/agV0AMcreZUzl78k.mylk8L--
