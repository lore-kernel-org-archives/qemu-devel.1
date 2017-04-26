Received: from eggs.gnu.org ([2001:4830:134:3::10]:44718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3N12-0001Zd-UE
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3N0y-0003XP-Vu
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:29:56 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:51168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d3N0y-0003X2-P8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:29:52 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4F725E9BF2
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 15:29:51 +0200 (CEST)
Date: Wed, 26 Apr 2017 15:29:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170426152946.5d7a4922@bahia>
In-Reply-To: <20170426151548.0b30d39c.cornelia.huck@de.ibm.com>
References: <149321107781.13002.9081643707477650100.stgit@bahia.lan>
	<20170426151548.0b30d39c.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/=RB=WOcthGPvRb7bq_Ql7W1";
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>

--Sig_/=RB=WOcthGPvRb7bq_Ql7W1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Apr 2017 15:15:48 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Wed, 26 Apr 2017 14:51:17 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > According to section 2.1.2 of the virtio-1 specification:
> >=20
> > "The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state=
 that
> > a reset is needed. If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESE=
T,
> > the device MUST send a device configuration change notification to the
> > driver."
> >=20
> > Commit "f5ed36635d8f virtio: stop virtqueue processing if device is bro=
ken"
> > introduced a virtio_error() call that just does that:
> >=20
> > - internally mark the device as broken
> > - set the DEVICE_NEEDS_RESET bit in the status
> > - send a configuration change notification
> >=20
> > Unfortunately, virtio_notify_vector(), called by virtio_notify_config(),
> > returns right away when the device is marked as broken and the notifica=
tion
> > isn't sent in this case.
> >=20
> > The spec doesn't say whether a broken device can send notifications
> > in other situations or not. But since the driver isn't supposed to do
> > anything but to reset the device, it makes sense to keep the check in
> > virtio_notify_config().
> >=20
> > Marking the device as broken AFTER the configuration change notificatio=
n was
> > sent is enough to fix the issue.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/virtio/virtio.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 03592c542a55..890b4d7eb751 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2451,12 +2451,12 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevi=
ce *vdev, const char *fmt, ...)
> >      error_vreport(fmt, ap);
> >      va_end(ap);
> >=20
> > -    vdev->broken =3D true;
> > -
> >      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >          virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_R=
ESET);
> >          virtio_notify_config(vdev);
> >      }
> > +
> > +    vdev->broken =3D true;
> >  }
> >=20
> >  static void virtio_memory_listener_commit(MemoryListener *listener)
> >  =20
>=20
> Good catch.
>=20
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>=20
> Should this be cc:stable, as it's a spec violation?
>=20

I don't know if this qualifies for stable, but if it does then it affects
all versions >=3D 2.8.0.

--Sig_/=RB=WOcthGPvRb7bq_Ql7W1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkAoMoACgkQAvw66wEB28J8WACdHTLUgBx9SNMkaNwbSYOGEO6F
1mkAnRu3ssN/RuTxsO9L6A9fKmZhkHO/
=VD8P
-----END PGP SIGNATURE-----

--Sig_/=RB=WOcthGPvRb7bq_Ql7W1--
