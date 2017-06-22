Received: from eggs.gnu.org ([2001:4830:134:3::10]:56387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNvz8-0003Fc-VV
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNvz5-0008DX-1x
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:52:59 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:39967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNvz4-0008DN-Nt
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:52:54 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3693A10C103
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 08:52:53 +0200 (CEST)
Date: Thu, 22 Jun 2017 08:52:49 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170622085249.775c959b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170622010851-mutt-send-email-mst@kernel.org>
References: <149806690313.3840.13274158676579302242.stgit@bahia.lan>
	<149806693574.3840.9096786036333390842.stgit@bahia.lan>
	<20170622010851-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/k2tXRcMmCJD9hw0X/wU+Axu";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] virtio-9p: break device if buffers
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

--Sig_/k2tXRcMmCJD9hw0X/wU+Axu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jun 2017 01:09:24 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jun 21, 2017 at 07:42:15PM +0200, Greg Kurz wrote:
> > The 9P protocol is transport agnostic: if the guest misconfigured the
> > buffers, the best we can do is to set the broken flag on the device.
> >=20
> > We check if the transport isn't broken already to avoid printing extra
> > error messages.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p.c               |    2 +-
> >  hw/9pfs/9p.h               |    2 +-
> >  hw/9pfs/virtio-9p-device.c |   45 ++++++++++++++++++++++++++++++++++++=
++++----
> >  hw/9pfs/xen-9p-backend.c   |    3 ++-
> >  4 files changed, 45 insertions(+), 7 deletions(-)
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
> > index 1a68c1622d3a..873f42e24818 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -146,8 +146,18 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, s=
ize_t offset,
> >      V9fsState *s =3D pdu->s;
> >      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem =3D v->elems[pdu->idx];
> > +    int ret;
> > =20
> > -    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt=
, ap);
> > +    ret =3D v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fm=
t, ap);
> > +    if (ret < 0) {
> > +        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> > +
> > +        if (!vdev->broken) {
> > +            virtio_error(vdev, "Failed to encode VirtFS reply type %d",
> > +                         pdu->id + 1);
> > +        }
> > +    }
> > +    return ret;
> >  }
> > =20
> >  static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> > @@ -156,28 +166,55 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu=
, size_t offset,
> >      V9fsState *s =3D pdu->s;
> >      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem =3D v->elems[pdu->idx];
> > +    int ret;
> > =20
> > -    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1,=
 fmt, ap);
> > +    ret =3D v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1=
, fmt, ap);
> > +    if (ret < 0) {
> > +        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> > +
> > +        if (!vdev->broken) { =20
>=20
> Do we really need this test? And why?
>=20

Indeed, you're right. We need this for marshal since several active PDUs
may try to send data back to the client. But we definitely don't need it
for unmarshal since we only submit one PDU at a time.

I'll remove it.

> > +            virtio_error(vdev, "Failed to decode VirtFS request type %=
d",
> > +                         pdu->id);
> > +        }
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


--Sig_/k2tXRcMmCJD9hw0X/wU+Axu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllLaUEACgkQAvw66wEB28JAowCgoh0HotMyEGrkqvXa241y4ntG
/3cAnjPAffkr10fhpK0vwntjqv2Ak/mI
=OEHs
-----END PGP SIGNATURE-----

--Sig_/k2tXRcMmCJD9hw0X/wU+Axu--
