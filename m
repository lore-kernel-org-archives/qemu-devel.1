Received: from eggs.gnu.org ([2001:4830:134:3::10]:55424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csmGn-0001gf-4T
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csmGi-0001CP-4U
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:14:25 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:40662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csmGh-0001C3-UP
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:14:20 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E2EB053791
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 10:14:17 +0200 (CEST)
Date: Tue, 28 Mar 2017 10:14:09 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170328101409.1aa23618@bahia.lan>
In-Reply-To: <20170327211728-mutt-send-email-mst@kernel.org>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
	<149063676337.4447.2095575576822297032.stgit@bahia.lan>
	<20170327211728-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/kMMyDVHTNI_TsYGSbW9ZE95";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio: Error object based
 virtio_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/kMMyDVHTNI_TsYGSbW9ZE95
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Mar 2017 21:20:56 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Mar 27, 2017 at 07:46:03PM +0200, Greg Kurz wrote:
> > This introduces an Error object based implementation of virtio_error().=
 It
> > allows to implement virtio_error() wrappers in device-specific code.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/virtio/virtio.c         |   21 ++++++++++++++++-----
> >  include/hw/virtio/virtio.h |    1 +
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 03592c542a55..4036f4816038 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2443,6 +2443,16 @@ void virtio_device_set_child_bus_name(VirtIODevi=
ce *vdev, char *bus_name)
> >      vdev->bus_name =3D g_strdup(bus_name);
> >  }
> > =20
> > +static void virtio_device_set_broken(VirtIODevice *vdev)
> > +{
> > +    vdev->broken =3D true;
> > +
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_R=
ESET);
> > +        virtio_notify_config(vdev);
> > +    }
> > +}
> > +
> >  void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *f=
mt, ...)
> >  {
> >      va_list ap; =20
>=20
> It's worth pondering whether we can set this for versions < 1.0 too.
>=20

I don't understand this question... Are you talking of the NEEDS_RESET
status bit (we may expose this flag to non-virtio1 drivers?) or the
broken flag itself (we should not implement broken legacy devices) ?

>=20
> > @@ -2451,12 +2461,13 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevi=
ce *vdev, const char *fmt, ...)
> >      error_vreport(fmt, ap);
> >      va_end(ap);
> > =20
> > -    vdev->broken =3D true;
> > +    virtio_device_set_broken(vdev);
> > +}
> > =20
> > -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > -        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_R=
ESET);
> > -        virtio_notify_config(vdev);
> > -    }
> > +void virtio_error_err(VirtIODevice *vdev, Error *err)
> > +{
> > +    error_report_err(err);
> > +    virtio_device_set_broken(vdev);
> >  }
> > =20
> >  static void virtio_memory_listener_commit(MemoryListener *listener) =20
>=20
> Should this skip error report if device is already broken?
> Otherwise we'll get a ton of errors in the log.
>=20

I don't think so: if the device is broken, it stops processing virtqueues
in and out, until it gets reset. And even though we would have a stubborn
guest that keeps breaking the device again and again, libvirt has size
limited and rotating log files.

> Also, whether to stop the device, or the VM, or just warn,
> seems like a policy decision. Why not set it on command line
> like we do for other storage?
>=20

Huh? This patch simply introduces a new API to a feature that underwent
several rounds of discussion and reached a reasonable consensus (even
your R-b).

I'm not sure this 9pfs series is the right place to talk about all the
behavior changes you're suggesting for virtio_error()... I'd rather
drop this patch and duplicate code in virtio-9p instead if I want the
fixes to go to 2.9.

Cc'ing Connie and Stefanha for insights.

> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 15efcf205711..5b13c5f67b63 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -150,6 +150,7 @@ void virtio_init(VirtIODevice *vdev, const char *na=
me,
> >  void virtio_cleanup(VirtIODevice *vdev);
> > =20
> >  void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_AT=
TR(2, 3);
> > +void virtio_error_err(VirtIODevice *vdev, Error *err);
> > =20
> >  /* Set the child bus name. */
> >  void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_na=
me); =20


--Sig_/kMMyDVHTNI_TsYGSbW9ZE95
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljaG1EACgkQAvw66wEB28KWMgCfR7KMr7lFp8EQPIQFo1Mpr6Yn
/7wAmgK18OZSF4WyXYDcj8+vz4jEPBSo
=Go7M
-----END PGP SIGNATURE-----

--Sig_/kMMyDVHTNI_TsYGSbW9ZE95--
