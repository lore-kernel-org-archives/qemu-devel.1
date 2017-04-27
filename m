Received: from eggs.gnu.org ([2001:4830:134:3::10]:44897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3dSw-0008BJ-1L
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3dSs-0002gk-2U
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:03:50 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:57340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d3dSr-0002fD-Rj
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:03:45 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 327A5E9DC7
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 09:03:43 +0200 (CEST)
Date: Thu, 27 Apr 2017 09:03:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170427090337.47214682@bahia>
In-Reply-To: <20170427024124-mutt-send-email-mst@kernel.org>
References: <149321107781.13002.9081643707477650100.stgit@bahia.lan>
	<20170426151548.0b30d39c.cornelia.huck@de.ibm.com>
	<20170426152946.5d7a4922@bahia>
	<20170427024124-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rWTQfeQrMBhYDgCgeV5tug4";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] virtio: allow broken device to notify guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/rWTQfeQrMBhYDgCgeV5tug4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Apr 2017 02:42:56 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 26, 2017 at 03:29:46PM +0200, Greg Kurz wrote:
> > On Wed, 26 Apr 2017 15:15:48 +0200
> > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> >  =20
> > > On Wed, 26 Apr 2017 14:51:17 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >  =20
> > > > According to section 2.1.2 of the virtio-1 specification:
> > > >=20
> > > > "The device SHOULD set DEVICE_NEEDS_RESET when it enters an error s=
tate that
> > > > a reset is needed. If DRIVER_OK is set, after it sets DEVICE_NEEDS_=
RESET,
> > > > the device MUST send a device configuration change notification to =
the
> > > > driver."
> > > >=20
> > > > Commit "f5ed36635d8f virtio: stop virtqueue processing if device is=
 broken"
> > > > introduced a virtio_error() call that just does that:
> > > >=20
> > > > - internally mark the device as broken
> > > > - set the DEVICE_NEEDS_RESET bit in the status
> > > > - send a configuration change notification
> > > >=20
> > > > Unfortunately, virtio_notify_vector(), called by virtio_notify_conf=
ig(),
> > > > returns right away when the device is marked as broken and the noti=
fication
> > > > isn't sent in this case.
> > > >=20
> > > > The spec doesn't say whether a broken device can send notifications
> > > > in other situations or not. But since the driver isn't supposed to =
do
> > > > anything but to reset the device, it makes sense to keep the check =
in
> > > > virtio_notify_config().
> > > >=20
> > > > Marking the device as broken AFTER the configuration change notific=
ation was
> > > > sent is enough to fix the issue.
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/virtio/virtio.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 03592c542a55..890b4d7eb751 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -2451,12 +2451,12 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIO=
Device *vdev, const char *fmt, ...)
> > > >      error_vreport(fmt, ap);
> > > >      va_end(ap);
> > > >=20
> > > > -    vdev->broken =3D true;
> > > > -
> > > >      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > > >          virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEE=
DS_RESET);
> > > >          virtio_notify_config(vdev);
> > > >      }
> > > > +
> > > > +    vdev->broken =3D true;
> > > >  }
> > > >=20
> > > >  static void virtio_memory_listener_commit(MemoryListener *listener)
> > > >    =20
> > >=20
> > > Good catch.
> > >=20
> > > Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > >=20
> > > Should this be cc:stable, as it's a spec violation?
> > >  =20
> >=20
> > I don't know if this qualifies for stable, but if it does then it affec=
ts
> > all versions >=3D 2.8.0. =20
>=20
>=20
> It's a SHOULD so not a violation, just a quality of implementation

Setting DEVICE_NEEDS_RESET is indeed a SHOULD, but failing to send the
configuration change notification violates a MUST statement, FWIW.

> issue. Seems a bit too intrusive for stable and we are yet to
> have drivers actually handling these errors, so let's wait a bit
> and see.
>=20

Fair enough.

> I'll apply this to master for now.
>=20
>=20

Thanks.

--
Greg

--Sig_/rWTQfeQrMBhYDgCgeV5tug4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkBl8kACgkQAvw66wEB28JMyQCfTf4b/+Rg1Jek7LckYTFVnLX/
UbUAnRlFXjDuLx2s6x4RfvUAQGon0Eyj
=52mv
-----END PGP SIGNATURE-----

--Sig_/rWTQfeQrMBhYDgCgeV5tug4--
