Received: from eggs.gnu.org ([2001:4830:134:3::10]:50089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dalzz-0005NG-VA
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 12:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dalzx-0005Vj-BK
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 12:50:56 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:52034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dalzx-0005VI-2K
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 12:50:53 -0400
Received: from player759.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 858C685E59
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 18:50:51 +0200 (CEST)
Date: Thu, 27 Jul 2017 18:50:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170727185042.14889377@bahia.lan>
In-Reply-To: <20170726052443.GF8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100564746.27487.5195312465666688402.stgit@bahia>
	<20170726052443.GF8978@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/V=h2L962gkxQvi5f89e0MR5";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 13/26] qdev: store DeviceState's
 canonical path to use when unparenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

--Sig_/V=h2L962gkxQvi5f89e0MR5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 15:24:43 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jul 25, 2017 at 08:00:47PM +0200, Greg Kurz wrote:
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >=20
> > device_unparent(dev, ...) is called when a device is unparented,
> > either directly, or as a result of a parent device being
> > finalized, and handles some final cleanup for the device. Part
> > of this includes emiting a DEVICE_DELETED QMP event to notify
> > management, which includes the device's path in the composition
> > tree as provided by object_get_canonical_path().
> >=20
> > object_get_canonical_path() assumes the device is still connected
> > to the machine/root container, and will assert otherwise, but
> > in some situations this isn't the case:
> >=20
> > If the parent is finalized as a result of object_unparent(), it
> > will still be attached to the composition tree at the time any
> > children are unparented as a result of that same call to
> > object_unparent(). However, in some cases, object_unparent()
> > will complete without finalizing the parent device, due to
> > lingering references that won't be released till some time later.
> > One such example is if the parent has MemoryRegion children (which
> > take a ref on their parent), who in turn have AddressSpace's (which
> > take a ref on their regions), since those AddressSpaces get cleaned
> > up asynchronously by the RCU thread.
> >=20
> > In this case qdev:device_unparent() may be called for a child Device
> > that no longer has a path to the root/machine container, causing
> > object_get_canonical_path() to assert.
> >=20
> > Fix this by storing the canonical path during realize() so the
> > information will still be available for device_unparent() in such
> > cases. =20
>=20
> Hm.  I'm no expert on the QOM model, but I'm not sure this is the
> right approach.
>=20
> I would have thought the right time to emit the DEVICE_DELETED message
> would be when the device leaves the main composition tree, even if it
> could be finalized later.
>=20
> If we made that the case, does this problem go away?
>=20

I'm no expert either and I confess I took this patch simply because it was
in Michael's original patchset. :)

But according to Michael's answer, it seems that the issue has a broader
scope than just PHB hotplug...=20

> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > Changes since RFC:
> > - rebased against ppc-for-2.10
> > ---
> >  hw/core/qdev.c         |   15 ++++++++++++---
> >  include/hw/qdev-core.h |    1 +
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 606ab53c42cd..a64b35c16251 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -928,6 +928,12 @@ static void device_set_realized(Object *obj, bool =
value, Error **errp)
> >              goto post_realize_fail;
> >          }
> > =20
> > +        /* always re-initialize since we clean up in device_unparent()=
 instead
> > +         * of unrealize()
> > +         */
> > +        g_free(dev->canonical_path);
> > +        dev->canonical_path =3D object_get_canonical_path(OBJECT(dev));
> > +
> >          if (qdev_get_vmsd(dev)) {
> >              if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(=
dev), dev,
> >                                                 dev->instance_id_alias,
> > @@ -984,6 +990,7 @@ child_realize_fail:
> >      }
> > =20
> >  post_realize_fail:
> > +    g_free(dev->canonical_path);
> >      if (dc->unrealize) {
> >          dc->unrealize(dev, NULL);
> >      }
> > @@ -1102,10 +1109,12 @@ static void device_unparent(Object *obj)
> > =20
> >      /* Only send event if the device had been completely realized */
> >      if (dev->pending_deleted_event) {
> > -        gchar *path =3D object_get_canonical_path(OBJECT(dev));
> > +        g_assert(dev->canonical_path);
> > =20
> > -        qapi_event_send_device_deleted(!!dev->id, dev->id, path, &erro=
r_abort);
> > -        g_free(path);
> > +        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canoni=
cal_path,
> > +                                       &error_abort);
> > +        g_free(dev->canonical_path);
> > +        dev->canonical_path =3D NULL;
> >      }
> > =20
> >      qemu_opts_del(dev->opts);
> > diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> > index ae317286a480..9237b6849ff3 100644
> > --- a/include/hw/qdev-core.h
> > +++ b/include/hw/qdev-core.h
> > @@ -153,6 +153,7 @@ struct DeviceState {
> >      /*< public >*/
> > =20
> >      const char *id;
> > +    char *canonical_path;
> >      bool realized;
> >      bool pending_deleted_event;
> >      QemuOpts *opts;
> >  =20
>=20


--Sig_/V=h2L962gkxQvi5f89e0MR5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll6GeIACgkQAvw66wEB28JMJACfUM+TaNJsxU6q4GAqemb24qpy
DzkAn3JcCKXjHooi2v1+/w2ryo1/+6Ey
=XhzP
-----END PGP SIGNATURE-----

--Sig_/V=h2L962gkxQvi5f89e0MR5--
