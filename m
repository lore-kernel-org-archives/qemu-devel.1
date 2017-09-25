Received: from eggs.gnu.org ([2001:4830:134:3::10]:58750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwbif-00088K-N4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwbie-00075J-Gr
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:19:17 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
Date: Mon, 25 Sep 2017 17:19:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170925135801.144261-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6lEvbFlCtbXBckPlw0CQ9lSjRsU4TEpkN"
Subject: Re: [Qemu-devel] [PATCH 8/8] nbd: Minimal structured read for client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6lEvbFlCtbXBckPlw0CQ9lSjRsU4TEpkN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
Subject: Re: [PATCH 8/8] nbd: Minimal structured read for client
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
 <20170925135801.144261-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 08:58 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal implementation: drop most of additional error information.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h  |   2 +
>  include/block/nbd.h |  15 ++++-
>  block/nbd-client.c  |  97 +++++++++++++++++++++++++-----
>  nbd/client.c        | 169 ++++++++++++++++++++++++++++++++++++++++++++=
+++-----
>  4 files changed, 249 insertions(+), 34 deletions(-)
>=20

> +++ b/include/block/nbd.h
> @@ -57,11 +57,17 @@ struct NBDRequest {
>  };
>  typedef struct NBDRequest NBDRequest;
> =20
> -struct NBDReply {
> +typedef struct NBDReply {
> +    bool simple;
>      uint64_t handle;
>      uint32_t error;
> -};
> -typedef struct NBDReply NBDReply;
> +
> +    uint16_t flags;
> +    uint16_t type;
> +    uint32_t tail_length;
> +    uint64_t offset;
> +    uint32_t hole_size;
> +} NBDReply;

This feels like it should be a discriminated union, rather than a struct
containing fields that are only sometimes valid...

> =20
>  #define NBD_SREP_TYPE_NONE          0
>  #define NBD_SREP_TYPE_OFFSET_DATA   1
> +#define NBD_SREP_TYPE_OFFSET_HOLE   2
>  #define NBD_SREP_TYPE_ERROR         NBD_SREP_ERR(1)
> +#define NBD_SREP_TYPE_ERROR_OFFSET  NBD_SREP_ERR(2)

=2E..especially since there is more than one type of SREP packet layout.

I also wonder why you are defining constants in a piecemeal fashion,
rather than all at once (even if your minimal server implementation
doesn't send a particular constant, there's no harm in defining them all
up front).

> +++ b/block/nbd-client.c
> @@ -179,9 +179,10 @@ err:
>      return rc;
>  }
> =20
> -static int nbd_co_receive_reply(NBDClientSession *s,
> -                                uint64_t handle,
> -                                QEMUIOVector *qiov)
> +static int nbd_co_receive_1_reply_or_chunk(NBDClientSession *s,

Long name, and unusual to mix in "1" instead of "one".  Would it be
better to name it nbd_co_receive_chunk, where we declare that a simple
reply is (roughly) the same amount of effort as a chunk in a structured
reply?

> +                                           uint64_t handle,
> +                                           bool *cont,
> +                                           QEMUIOVector *qiov)
>  {

No documentation of the function?

>      int ret;
>      int i =3D HANDLE_TO_INDEX(s, handle);
> @@ -191,29 +192,95 @@ static int nbd_co_receive_reply(NBDClientSession =
*s,
>      qemu_coroutine_yield();
>      s->requests[i].receiving =3D false;
>      if (!s->ioc || s->quit) {
> -        ret =3D -EIO;
> -    } else {
> -        assert(s->reply.handle =3D=3D handle);
> -        ret =3D -s->reply.error;
> -        if (qiov && s->reply.error =3D=3D 0) {
> +        *cont =3D false;
> +        return -EIO;
> +    }
> +
> +    assert(s->reply.handle =3D=3D handle);
> +    *cont =3D !(s->reply.simple || (s->reply.flags & NBD_SREP_FLAG_DON=
E));

We need to validate that the server is not sending us SREP chunks unless
we negotiated them.  I'm thinking it might be better to do it here
(maybe you did it somewhere else, but I haven't seen it yet; I'm
reviewing the patch in textual order rather than the order in which
things are called).

> +    ret =3D -s->reply.error;
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    if (s->reply.simple) {
> +        if (qiov) {
>              if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> -                                      NULL) < 0) {
> -                ret =3D -EIO;
> -                s->quit =3D true;
> +                                      NULL) < 0)
> +            {
> +                goto fatal;
>              }
>          }
> +        goto out;
> +    }
> =20
> -        /* Tell the read handler to read another header.  */
> -        s->reply.handle =3D 0;
> +    /* here we deal with successful structured reply */
> +    switch (s->reply.type) {
> +        QEMUIOVector sub_qiov;
> +    case NBD_SREP_TYPE_OFFSET_DATA:

This is putting a LOT of smarts directly into the receive routine.
Here's where I was previously wondering (and I think Paolo as well)
whether it might be better to split the efforts: the generic function
reads off the chunk information and any payload, but a per-command
callback function then parses the chunks.  Especially since the
definition of the chunks differs on a per-command basis (yes, the NBD
spec will try to not reuse an SREP chunk type across multiple commands
unless the semantics are similar, but that's a bit more fragile).  This
particularly matters given my statement above that you want a
discriminated union, rather than a struct that contains unused fields,
for handling different SREP chunk types.

My review has to pause here for now...


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6lEvbFlCtbXBckPlw0CQ9lSjRsU4TEpkN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJgNsACgkQp6FrSiUn
Q2pRqAf/ZJsEW/wDpRDXnRxY4nn3oEDkt+GobF/EpcRlkvv6dms/9Li4CrqoROBt
W3xlu5Z8USWLOFEKNRiwd5uxrC+g7ecMChBOBL/aRnMTTI7kIs6Fr1X/LHt7vpa8
kyhitRfgnkv4Div12+LVBLBG7x1t9R4lzyr0aaryZ1zfwukuCiLEghPacc2/1Snz
a7i0mCLNz6IwmBPegFzkTAKRiSSvaO/U3ppVvLiech/c7Rq97fwc7Tz0BFbu2urA
dsBkQbjDEBjGNtkcII71DJXN9byyMwZzXo59OuD38iuKy5JAdD7ZRAVkKSPKkVot
/IiV8+MbvBoVvWvPRnCBwn1QsmoxSw==
=zye7
-----END PGP SIGNATURE-----

--6lEvbFlCtbXBckPlw0CQ9lSjRsU4TEpkN--
