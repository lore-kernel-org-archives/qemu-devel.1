Received: from eggs.gnu.org ([2001:4830:134:3::10]:39268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQrym-0004fh-Sx
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQryj-0008SN-IZ
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:12:44 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:53235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQryj-0008O7-8j
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:12:41 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5404610F159
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 11:12:37 +0200 (CEST)
Date: Fri, 30 Jun 2017 11:12:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170630111233.3b22c1bc@bahia.lan>
In-Reply-To: <20170630023317-mutt-send-email-mst@kernel.org>
References: <149868263738.23385.16723444264552987199.stgit@bahia.lan>
	<149868267036.23385.17703911111121496563.stgit@bahia.lan>
	<20170630023317-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/+sBp/DAVjeYZf2zYandaLSc";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 3/5] virtio-9p: break device if buffers
 are misconfigured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

--Sig_/+sBp/DAVjeYZf2zYandaLSc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jun 2017 02:33:22 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jun 28, 2017 at 10:44:30PM +0200, Greg Kurz wrote:
> > The 9P protocol is transport agnostic: if the guest misconfigured the
> > buffers, the best we can do is to set the broken flag on the device.
> >=20
> > Since virtio_pdu_vmarshal() may be called by several active PDUs, we
> > check if the transport isn't broken already to avoid printing extra
> > error messages.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20

Oops, I've already sent a pull request and it got merged.

Thanks for the Reviewed-by's anyway.

> > ---
> > v5: - use ssize_t variable in virtio_pdu_v[un]marshal()
> >     - drop remaining vdev->broken check (MST suggested to discuss calli=
ng
> >       virtio_error() when the device is already broken to a separate th=
read)
> > ---
> >  hw/9pfs/9p.c               |    2 +-
> >  hw/9pfs/9p.h               |    2 +-
> >  hw/9pfs/virtio-9p-device.c |   40 ++++++++++++++++++++++++++++++++++++=
----
> >  hw/9pfs/xen-9p-backend.c   |    3 ++-
> >  4 files changed, 40 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 96d268334865..da0d6da65b45 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1664,7 +1664,7 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector =
*qiov, V9fsPDU *pdu,
> >      unsigned int niov;
> > =20
> >      if (is_write) {
> > -        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov);
> > +        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, siz=
e + skip);
> >      } else {
> >          pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size=
 + skip);
> >      }
> > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > index aac1b0b2ce3d..d1cfeaf10e4f 100644
> > --- a/hw/9pfs/9p.h
> > +++ b/hw/9pfs/9p.h
> > @@ -363,7 +363,7 @@ struct V9fsTransport {
> >      void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **p=
iov,
> >                                          unsigned int *pniov, size_t si=
ze);
> >      void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **=
piov,
> > -                                         unsigned int *pniov);
> > +                                         unsigned int *pniov, size_t s=
ize);
> >      void        (*push_and_notify)(V9fsPDU *pdu);
> >  };
> > =20
> > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > index 1a68c1622d3a..62650b0a6b99 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -146,8 +146,16 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, s=
ize_t offset,
> >      V9fsState *s =3D pdu->s;
> >      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem =3D v->elems[pdu->idx];
> > +    ssize_t ret;
> > =20
> > -    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt=
, ap);
> > +    ret =3D v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fm=
t, ap);
> > +    if (ret < 0) {
> > +        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> > +
> > +        virtio_error(vdev, "Failed to encode VirtFS reply type %d",
> > +                     pdu->id + 1);
> > +    }
> > +    return ret;
> >  }
> > =20
> >  static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> > @@ -156,28 +164,52 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu=
, size_t offset,
> >      V9fsState *s =3D pdu->s;
> >      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem =3D v->elems[pdu->idx];
> > +    ssize_t ret;
> > +
> > +    ret =3D v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1=
, fmt, ap);
> > +    if (ret < 0) {
> > +        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> > =20
> > -    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1,=
 fmt, ap);
> > +        virtio_error(vdev, "Failed to decode VirtFS request type %d", =
pdu->id);
> > +    }
> > +    return ret;
> >  }
> > =20
> > -/* The size parameter is used by other transports. Do not drop it. */
> >  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **p=
iov,
> >                                          unsigned int *pniov, size_t si=
ze)
> >  {
> >      V9fsState *s =3D pdu->s;
> >      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem =3D v->elems[pdu->idx];
> > +    size_t buf_size =3D iov_size(elem->in_sg, elem->in_num);
> > +
> > +    if (buf_size < size) {
> > +        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> > +
> > +        virtio_error(vdev,
> > +                     "VirtFS reply type %d needs %zu bytes, buffer has=
 %zu",
> > +                     pdu->id + 1, size, buf_size);
> > +    }
> > =20
> >      *piov =3D elem->in_sg;
> >      *pniov =3D elem->in_num;
> >  }
> > =20
> >  static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **=
piov,
> > -                                         unsigned int *pniov)
> > +                                         unsigned int *pniov, size_t s=
ize)
> >  {
> >      V9fsState *s =3D pdu->s;
> >      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem =3D v->elems[pdu->idx];
> > +    size_t buf_size =3D iov_size(elem->out_sg, elem->out_num);
> > +
> > +    if (buf_size < size) {
> > +        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> > +
> > +        virtio_error(vdev,
> > +                     "VirtFS request type %d needs %zu bytes, buffer h=
as %zu",
> > +                     pdu->id, size, buf_size);
> > +    }
> > =20
> >      *piov =3D elem->out_sg;
> >      *pniov =3D elem->out_num;
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > index 922cc967be63..a82cf817fe45 100644
> > --- a/hw/9pfs/xen-9p-backend.c
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -147,7 +147,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> > =20
> >  static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> >                                             struct iovec **piov,
> > -                                           unsigned int *pniov)
> > +                                           unsigned int *pniov,
> > +                                           size_t size)
> >  {
> >      Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
> >      Xen9pfsRing *ring =3D &xen_9pfs->rings[pdu->tag % xen_9pfs->num_ri=
ngs]; =20


--Sig_/+sBp/DAVjeYZf2zYandaLSc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllWFgEACgkQAvw66wEB28KjJwCeLKDYgK+wQ+DEHsGi8CRFTieq
1UIAniesreLXzsfbHn8VuJp3gKnJmB/G
=UJPU
-----END PGP SIGNATURE-----

--Sig_/+sBp/DAVjeYZf2zYandaLSc--
