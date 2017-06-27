Received: from eggs.gnu.org ([2001:4830:134:3::10]:49940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dPkOM-0004zn-Ha
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 02:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dPkOH-0004Td-Kh
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 02:54:30 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:36042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dPkOH-0004R2-Au
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 02:54:25 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D8AD210D032
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 08:54:22 +0200 (CEST)
Date: Tue, 27 Jun 2017 08:54:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170627085418.38a58b9e@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <alpine.DEB.2.10.1706261553370.12819@sstabellini-ThinkPad-X260>
References: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
	<149820032558.7187.9574922678907797880.stgit@bahia.lan>
	<alpine.DEB.2.10.1706261553370.12819@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/aVdYO5y1oCclPyq6ENeaCpT";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] virtio-9p: break device if buffers
 are misconfigured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

--Sig_/aVdYO5y1oCclPyq6ENeaCpT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jun 2017 16:22:23 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Fri, 23 Jun 2017, Greg Kurz wrote:
> > The 9P protocol is transport agnostic: if the guest misconfigured the
> > buffers, the best we can do is to set the broken flag on the device.
> >=20
> > Since virtio_pdu_vmarshal() may be called by several active PDUs, we
> > check if the transport isn't broken already to avoid printing extra
> > error messages.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v4: - update changelog and add comment to explain why we check vdev->br=
oken
> >       in virtio_pdu_vmarshal()
> >     - dropped uneeded vdev->broken check in virtio_pdu_vunmarshal()
> > ---
> >  hw/9pfs/9p.c               |    2 +-
> >  hw/9pfs/9p.h               |    2 +-
> >  hw/9pfs/virtio-9p-device.c |   48 ++++++++++++++++++++++++++++++++++++=
+++-----
> >  hw/9pfs/xen-9p-backend.c   |    3 ++-
> >  4 files changed, 47 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index a0ae98f7ca6f..8e5cac71eb60 100644
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
> > index 1a68c1622d3a..ed9e4817a26c 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -146,8 +146,22 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, s=
ize_t offset,
> >      V9fsState *s =3D pdu->s;
> >      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem =3D v->elems[pdu->idx];
> > -
> > -    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt=
, ap);
> > +    int ret; =20
>=20
> I think ret should be ssize_t
>=20

Yes, you're right. I'll change that.

>=20
> > +    ret =3D v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fm=
t, ap);
> > +    if (ret < 0) {
> > +        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> > +
> > +        /* Any active PDU may try to send something back to the client=
 without
> > +         * knowing if the transport is broken or not. This could resul=
t in
> > +         * MAX_REQ - 1 (ie, 127) extra error messages being printed.
> > +         */
> > +        if (!vdev->broken) {
> > +            virtio_error(vdev, "Failed to encode VirtFS reply type %d",
> > +                         pdu->id + 1);
> > +        }
> > +    }
> > +    return ret;
> >  }
> > =20
> >  static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> > @@ -156,28 +170,52 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu=
, size_t offset,
> >      V9fsState *s =3D pdu->s;
> >      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem =3D v->elems[pdu->idx];
> > +    int ret; =20
>=20
> same here
>=20

Ditto.

>=20
> > -    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1,=
 fmt, ap);
> > +    ret =3D v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1=
, fmt, ap);
> > +    if (ret < 0) {
> > +        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> > +
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
>=20
> Maybe you could include the same changes you made for xen, see below
>=20

Sure, I'd be glad to do so. I just have one concern. In the virtio case, we=
 call
virtio_error() which does two things: print an error message AND set the de=
vice
broken flag (no more I/O until device is reset). Is there something similar=
 with
the xen transport ?

>=20
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index a82cf81..83a2bfe 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -125,10 +125,17 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
>      Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
>      struct iovec in_sg[2];
>      int num;
> +    ssize_t ret;
> =20
>      xen_9pfs_in_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
>                     in_sg, &num, pdu->idx, ROUND_UP(offset + 128, 512));
> -    return v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
> +   =20
> +    ret =3D v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
> +    if (ret < 0) {
> +        xen_pv_printf(&xen_9pfs->xendev, 0,
> +                      "Failed to encode VirtFS request type %d", pdu->id=
 + 1);
> +    }
> +    return ret;
>  }
> =20
>  static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> @@ -139,10 +146,17 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
>      Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
>      struct iovec out_sg[2];
>      int num;
> +    ssize_t ret;
> =20
>      xen_9pfs_out_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
>                      out_sg, &num, pdu->idx);
> -    return v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
> +   =20
> +    ret =3D v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
> +    if (ret < 0) {
> +        xen_pv_printf(&xen_9pfs->xendev, 0,
> +                      "Failed to decode VirtFS request type %d", pdu->id=
);
> +    }
> +    return ret;
>  }
> =20
>  static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> @@ -153,11 +167,20 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU =
*pdu,
>      Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
>      Xen9pfsRing *ring =3D &xen_9pfs->rings[pdu->tag % xen_9pfs->num_ring=
s];
>      int num;
> +    size_t buf_size;
> =20
>      g_free(ring->sg);
> =20
>      ring->sg =3D g_malloc0(sizeof(*ring->sg) * 2);
>      xen_9pfs_out_sg(ring, ring->sg, &num, pdu->idx);
> +
> +    buf_size =3D iov_size(ring->sg, num);
> +    if (buf_size  < size) {
> +        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> +                "needs %zu bytes, buffer has %zu", pdu->id, size,
> +                buf_size);
> +    }
> +
>      *piov =3D ring->sg;
>      *pniov =3D num;
>  }
> @@ -170,11 +193,20 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *=
pdu,
>      Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
>      Xen9pfsRing *ring =3D &xen_9pfs->rings[pdu->tag % xen_9pfs->num_ring=
s];
>      int num;
> +    size_t buf_size;
> =20
>      g_free(ring->sg);
> =20
>      ring->sg =3D g_malloc0(sizeof(*ring->sg) * 2);
>      xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
> +
> +    buf_size =3D iov_size(ring->sg, num);
> +    if (buf_size  < size) {
> +        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> +                "needs %zu bytes, buffer has %zu", pdu->id, size,
> +                buf_size);
> +    }
> +
>      *piov =3D ring->sg;
>      *pniov =3D num;
>  }


--Sig_/aVdYO5y1oCclPyq6ENeaCpT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllSARoACgkQAvw66wEB28KqtQCeK322rW36Vllipr/20DhStGRh
WlEAoJ3C7wYuMPminVJy5+Q/uGFUvuFm
=Q91U
-----END PGP SIGNATURE-----

--Sig_/aVdYO5y1oCclPyq6ENeaCpT--
