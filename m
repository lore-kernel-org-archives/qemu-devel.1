Received: from eggs.gnu.org ([2001:4830:134:3::10]:35270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d42ZE-0007uY-LX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d42Z9-0004Ja-0N
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:51:59 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:42707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d42Z8-0004Fa-Mt
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:51:54 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5EC5CE75E7
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 11:51:50 +0200 (CEST)
Date: Fri, 28 Apr 2017 11:51:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170428115146.2d7854a6@bahia>
In-Reply-To: <alpine.DEB.2.10.1704271120100.11141@sstabellini-ThinkPad-X260>
References: <149328633283.30266.4224847428546759127.stgit@bahia>
	<149328636874.30266.8813988060953128881.stgit@bahia>
	<alpine.DEB.2.10.1704271120100.11141@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/VWw2AfZsC/mr.9VuVyGKiSn";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] 9pfs: handle broken transport
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

--Sig_/VWw2AfZsC/mr.9VuVyGKiSn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Apr 2017 11:51:24 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Thu, 27 Apr 2017, Greg Kurz wrote:
> > The 9p protocol is transport agnostic: if an error occurs when copying =
data
> > to/from the client, this should be handled by the transport layer [1] a=
nd
> > the 9p server should simply stop processing requests [2].
> >=20
> > [1] can be implemented in the transport marshal/unmarshal handlers. In =
the
> > case of virtio, this means calling virtio_error() to inform the guest t=
hat
> > the device isn't functional anymore.
> >=20
> > [2] means that the pdu_complete() function shouldn't send a reply back =
to
> > the client if the transport had a failure. This cannot be decided using=
 the
> > current error path though, since we cannot discriminate if the error co=
mes
> > from the transport or the backend. This patch hence introduces a flag in
> > the 9pfs state to record that the transport is broken. The device needs=
 to
> > be reset for the flag to be unset.
> >=20
> > This fixes Coverity issue CID 1348518.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v2: - use unlikely() when checking if the transport is broken
> >     - fail marshal/unmarshal if transport is broken
> >     - v9fs_xattr_read() mark transport as broken if v9fs_pack() fails
> > ---
> >  hw/9pfs/9p.c               |   45 ++++++++++++++++++++++++++++++++++++=
--------
> >  hw/9pfs/9p.h               |    1 +
> >  hw/9pfs/virtio-9p-device.c |   16 ++++++++++++++--
> >  3 files changed, 52 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 01deffa0c3b5..406c1937ed21 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -46,10 +46,17 @@ ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, co=
nst char *fmt, ...)
> >      ssize_t ret;
> >      va_list ap;
> > =20
> > +    if (unlikely(pdu->s->transport_broken)) {
> > +        return -EIO;
> > +    }
> > +
> >      va_start(ap, fmt);
> >      ret =3D pdu->s->transport->pdu_vmarshal(pdu, offset, fmt, ap);
> >      va_end(ap);
> > =20
> > +    if (ret < 0) {
> > +        pdu->s->transport_broken =3D true;
> > +    }
> >      return ret;
> >  }
> > =20
> > @@ -58,10 +65,17 @@ ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, =
const char *fmt, ...)
> >      ssize_t ret;
> >      va_list ap;
> > =20
> > +    if (unlikely(pdu->s->transport_broken)) {
> > +        return -EIO;
> > +    }
> > +
> >      va_start(ap, fmt);
> >      ret =3D pdu->s->transport->pdu_vunmarshal(pdu, offset, fmt, ap);
> >      va_end(ap);
> > =20
> > +    if (ret < 0) {
> > +        pdu->s->transport_broken =3D true;
> > +    }
> >      return ret;
> >  }
> > =20
> > @@ -624,15 +638,15 @@ void pdu_free(V9fsPDU *pdu)
> >      QLIST_INSERT_HEAD(&s->free_list, pdu, next);
> >  }
> > =20
> > -/*
> > - * We don't do error checking for pdu_marshal/unmarshal here
> > - * because we always expect to have enough space to encode
> > - * error details
> > - */
> >  static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
> >  {
> >      int8_t id =3D pdu->id + 1; /* Response */
> >      V9fsState *s =3D pdu->s;
> > +    int ret;
> > +
> > +    if (unlikely(s->transport_broken)) {
> > +        goto out_complete;
> > +    }
> > =20
> >      if (len < 0) {
> >          int err =3D -len;
> > @@ -644,11 +658,19 @@ static void coroutine_fn pdu_complete(V9fsPDU *pd=
u, ssize_t len)
> >              str.data =3D strerror(err);
> >              str.size =3D strlen(str.data);
> > =20
> > -            len +=3D pdu_marshal(pdu, len, "s", &str);
> > +            ret =3D pdu_marshal(pdu, len, "s", &str);
> > +            if (ret < 0) {
> > +                goto out_complete;
> > +            }
> > +            len +=3D ret;
> >              id =3D P9_RERROR;
> >          }
> > =20
> > -        len +=3D pdu_marshal(pdu, len, "d", err);
> > +        ret =3D pdu_marshal(pdu, len, "d", err);
> > +        if (ret < 0) {
> > +            goto out_complete;
> > +        }
> > +        len +=3D ret;
> > =20
> >          if (s->proto_version =3D=3D V9FS_PROTO_2000L) {
> >              id =3D P9_RLERROR;
> > @@ -657,7 +679,10 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu=
, ssize_t len)
> >      }
> > =20
> >      /* fill out the header */
> > -    pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag);
> > +    ret =3D pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag);
> > +    if (ret < 0) {
> > +        goto out_complete;
> > +    } =20
>=20
> If I am not mistaken, none of these "if (ret < 0)" are necessary in
> pdu_complete. Just like any of the other call sites of
> pdu_marshal/pdu_unmarshal, we could just let it go through the calls,
> which would actually do nothing once transport_broken is set.
>=20
> We could move the transport_broken check right before the call to
> push_and_notify.
>=20

Ugh, I now realize that any request that didn't hit the first marshal/unmar=
shal
error and that don't go through push_and_notify will leak a ring slot... I =
need
to rethink this series :-\

>=20
> >      /* keep these in sync */
> >      pdu->size =3D len;
> > @@ -665,6 +690,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu,=
 ssize_t len)
> > =20
> >      pdu->s->transport->push_and_notify(pdu);
> > =20
> > +out_complete:
> >      /* Now wakeup anybody waiting in flush for this request */
> >      if (!qemu_co_queue_next(&pdu->complete)) {
> >          pdu_free(pdu);
> > @@ -1702,6 +1728,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU =
*pdu, V9fsFidState *fidp,
> >                      read_count);
> >      qemu_iovec_destroy(&qiov_full);
> >      if (err < 0) {
> > +        s->transport_broken =3D true;
> >          return err;
> >      }
> >      offset +=3D err;
> > @@ -3596,6 +3623,8 @@ void v9fs_reset(V9fsState *s)
> >      while (!data.done) {
> >          aio_poll(qemu_get_aio_context(), true);
> >      }
> > +
> > +    s->transport_broken =3D false;
> >  }
> > =20
> >  static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
> > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > index 5312d8a42405..145d0c87dd6a 100644
> > --- a/hw/9pfs/9p.h
> > +++ b/hw/9pfs/9p.h
> > @@ -246,6 +246,7 @@ typedef struct V9fsState
> >      Error *migration_blocker;
> >      V9fsConf fsconf;
> >      V9fsQID root_qid;
> > +    bool transport_broken;
> >  } V9fsState;
> > =20
> >  /* 9p2000.L open flags */
> > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > index c71659823fdc..9e61fbf7c63e 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -158,8 +158,14 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, s=
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
> > +        virtio_9p_error(v, pdu->idx,
> > +                        "Failed to marshal VirtFS reply type %d", pdu-=
>id);
> > +    }
> > +    return ret;
> >  }
> > =20
> >  static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> > @@ -168,8 +174,14 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu,=
 size_t offset,
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
> > +        virtio_9p_error(v, pdu->idx,
> > +                        "Failed to unmarshal VirtFS request type %d", =
pdu->id);
> > +    }
> > +    return ret;
> >  }
> > =20
> >  /* The size parameter is used by other transports. Do not drop it. */ =
=20


--Sig_/VWw2AfZsC/mr.9VuVyGKiSn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkDELIACgkQAvw66wEB28JcOwCggic49ieqZ9XmAcL/Nirzsp5s
fIEAn31Pn0Uz3Puvv6UzF7wf9KrovSOe
=obs8
-----END PGP SIGNATURE-----

--Sig_/VWw2AfZsC/mr.9VuVyGKiSn--
