Received: from eggs.gnu.org ([2001:4830:134:3::10]:52673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1dZG-0005xW-Nw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1dZF-0006Vd-2k
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:18:22 -0400
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c57b76e-eb34-7825-9c8b-9ee5bd909b02@redhat.com>
Date: Mon, 9 Oct 2017 14:18:10 -0500
MIME-Version: 1.0
In-Reply-To: <20171009172723.190282-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eE2vcKHn2FsBTAFM7UjXr2hhDOU0RHSQI"
Subject: Re: [Qemu-devel] [PATCH v2 04/10] nbd-server: refactor simple reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eE2vcKHn2FsBTAFM7UjXr2hhDOU0RHSQI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <5c57b76e-eb34-7825-9c8b-9ee5bd909b02@redhat.com>
Subject: Re: [PATCH v2 04/10] nbd-server: refactor simple reply sending
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
 <20171009172723.190282-9-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Dan for a qio question - search for your name below]

On 10/09/2017 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> Get rid of calculating structure fields offsets by hand and set_cork,
> rename nbd_co_send_reply to nbd_co_send_simple_reply. Do not use
> NBDReply which will be upgraded in future patches to handle both simple=

> and structured replies and will be used only in the client.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  6 ++++
>  nbd/nbd-internal.h  |  9 +++++
>  nbd/server.c        | 97 ++++++++++++++++++++++-----------------------=
--------
>  3 files changed, 56 insertions(+), 56 deletions(-)

Feels a bit big for one patch, although I'm borderline for being able to
take it as-is.

>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 707fd37575..49008980f4 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -63,6 +63,12 @@ struct NBDReply {
>  };
>  typedef struct NBDReply NBDReply;
> =20
> +typedef struct NBDSimpleReply {
> +    uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
> +    uint32_t error;
> +    uint64_t handle;
> +} QEMU_PACKED NBDSimpleReply;
> +

So (one of?) the goal of this patch is to use a packed struct for
on-the-wire transmissions, instead of manually packing things into
offsets by hand.  I can live with that.

>  /* Transmission (export) flags: sent from server to client during hand=
shake,
>     but describe what will happen during transmission */
>  #define NBD_FLAG_HAS_FLAGS      (1 << 0)        /* Flags are there */
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index 2d6663de23..320abef296 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -113,6 +113,15 @@ static inline int nbd_write(QIOChannel *ioc, const=
 void *buffer, size_t size,
>      return qio_channel_write_all(ioc, buffer, size, errp) < 0 ? -EIO :=
 0;
>  }
> =20
> +/* nbd_writev
> + * Writes @size bytes to @ioc. Returns 0 on success.
> + */
> +static inline int nbd_writev(QIOChannel *ioc, const struct iovec *iov,=

> +                             size_t niov, Error **errp)

Comment is wrong; you don't have a @size parameter.

> +{
> +    return qio_channel_writev_all(ioc, iov, niov, errp) < 0 ? -EIO : 0=
;
> +}

Do we really need this, or can we just directly use
qio_channel_writev_all() at the lone site that uses this new interface?

> +
>  struct NBDTLSHandshakeData {
>      GMainLoop *loop;
>      bool complete;
> diff --git a/nbd/server.c b/nbd/server.c
> index a1b21a6951..57d5598e0f 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -902,26 +902,6 @@ static int nbd_receive_request(QIOChannel *ioc, NB=
DRequest *request,
>      return 0;
>  }
> =20
> -static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **er=
rp)

So instead of taking a non-packed struct, doing the hand-packing here,
then sending the message, you split this up...

> -static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int=
 len,
> -                             Error **errp)
> +static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iove=
c *iov,
> +                                        unsigned niov, Error **errp)
>  {
> -    NBDClient *client =3D req->client;
>      int ret;
> =20
>      g_assert(qemu_in_coroutine());
> -
> -    trace_nbd_co_send_reply(reply->handle, reply->error, len);
> -
>      qemu_co_mutex_lock(&client->send_lock);
>      client->send_coroutine =3D qemu_coroutine_self();
> =20
> -    if (!len) {
> -        ret =3D nbd_send_reply(client->ioc, reply, errp);
> -    } else {
> -        qio_channel_set_cork(client->ioc, true);
> -        ret =3D nbd_send_reply(client->ioc, reply, errp);
> -        if (ret =3D=3D 0) {
> -            ret =3D nbd_write(client->ioc, req->data, len, errp);
> -            if (ret < 0) {
> -                ret =3D -EIO;
> -            }
> -        }
> -        qio_channel_set_cork(client->ioc, false);
> -    }
> +    ret =3D nbd_writev(client->ioc, iov, niov, errp);

=2E..the transmission is now done via iov so that you can send two buffer=
s
at once without having to play with the cork,...

Dan - are we guaranteed that qio_channel_writev_all() with a multi-iov
argument called by one thread will send all its data in order, without
being interleaved with any other parallel coroutine also calling
qio_channel_writev_all()?  In other words, it looks like the NBD code
was previously using manual cork changes to ensure that two halves of a
message were sent without interleave, but Vladimir is now relying on the
qio code to do that under the hood.

> =20
>      client->send_coroutine =3D NULL;
>      qemu_co_mutex_unlock(&client->send_lock);
> +
>      return ret;
>  }
> =20
> +static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t=
 error,
> +                                       uint64_t handle)
> +{
> +    stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
> +    stl_be_p(&reply->error, error);
> +    stq_be_p(&reply->handle, handle);
> +}

=2E..loading the packed struct is now its own helper function,...

> +
> +static int nbd_co_send_simple_reply(NBDClient *client,
> +                                    uint64_t handle,
> +                                    uint32_t error,
> +                                    void *data,
> +                                    size_t size,
> +                                    Error **errp)
> +{
> +    NBDSimpleReply reply;
> +    struct iovec iov[] =3D {
> +        {.iov_base =3D &reply, .iov_len =3D sizeof(reply)},
> +        {.iov_base =3D data, .iov_len =3D size}
> +    };
> +
> +    trace_nbd_co_send_reply(handle, error, size);
> +
> +    set_be_simple_reply(&reply, system_errno_to_nbd_errno(error), hand=
le);
> +
> +    return nbd_co_send_iov(client, iov, size ? 2 : 1, errp);
> +}

=2E..and the function gets renamed, all at once.  Okay, maybe it IS easie=
r
to review if split.  A good split might be:

Focus on naming: Rename nbd_co_send_reply() to
nbd_co_send_simple_reply() in one patch (in fact, this part should be
squashed with the rename of the magic number in 3/10)

Focus on conversion to on-the-wire representation: Add the packed struct
and set_be_simple_reply() in one patch, but still using corks

Focus on simplified transmission: Switch to using iov to send both
halves of a two-part message in one transaction

> +
>  /* nbd_co_receive_request
>   * Collect a client request. Return 0 if request looks valid, -EIO to =
drop
>   * connection right away, and any other negative value to report an er=
ror to
> @@ -1331,7 +1324,6 @@ static coroutine_fn void nbd_trip(void *opaque)
>      NBDExport *exp =3D client->exp;
>      NBDRequestData *req;
>      NBDRequest request =3D { 0 };    /* GCC thinks it can be used unin=
itialized */
> -    NBDReply reply;
>      int ret;
>      int flags;
>      int reply_data_len =3D 0;
> @@ -1351,11 +1343,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>          goto disconnect;
>      }
> =20
> -    reply.handle =3D request.handle;
> -    reply.error =3D 0;
> -
>      if (ret < 0) {
> -        reply.error =3D -ret;
>          goto reply;
>      }

Oh, and you're doing a fourth thing - tracking the error directly in ret
instead of buried in reply.error.  Could also be split.

> =20
>  reply:
>      if (local_err) {
> -        /* If we are here local_err is not fatal error, already stored=
 in
> -         * reply.error */
> +        /* If we are here local_err is not fatal error, which should b=
e sent
> +         * to client. */

Reads awkwardly (even pre-patch); maybe this is better:

/* If we get here, local_err was not a fatal error, and should be sent
to the client. */

>          error_report_err(local_err);
>          local_err =3D NULL;
>      }
> =20
> -    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0=
) {
> +    if (nbd_co_send_simple_reply(req->client, request.handle,
> +                                 ret < 0 ? -ret : 0,
> +                                 req->data, reply_data_len, &local_err=
) < 0)
> +    {
>          error_prepend(&local_err, "Failed to send reply: ");
>          goto disconnect;
>      }
>=20

I'm not necessarily going to insist that you split things if I don't see
any other reasons to respin the series; but I might also try to do the
split locally and post it for you to see my thinking (remember, a series
of small patches that each do one thing well can be easier to review
than large patches, even if it results in more emails).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eE2vcKHn2FsBTAFM7UjXr2hhDOU0RHSQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnby3IACgkQp6FrSiUn
Q2oqyAf9Efg5maBePc+KWAaKhjDk7cCY76qHvyUTXrJLyUKBnlX+QwzT3/rduSKr
qFlUtrcxqlwM2Ba/ZfOHJzLNmsdxTaW8ui55J8wn1Jo2bdK3FxfSSUWn1sD8/0aL
mS00dZ/O7c8T4y0jn27AzM9VwD11hS5EgOBGI6lJ5zDiaVe1O9b/avk6akkXO+d7
3NfRY0GPvs9i2S1pi8LEC1xEkLAMZ81UK+/3qMEFWkTBb6aiVqeR+NG9lJJPT9gU
yOfZQgJWQraU1KCStXmgouUqCwDaGpjaHgUHzLJB6lf98Y6eUqnEVkJ6Jyq2mt7m
a6PLeX1SHSqpH9tVDxVMHo5hdZAt6w==
=QbVT
-----END PGP SIGNATURE-----

--eE2vcKHn2FsBTAFM7UjXr2hhDOU0RHSQI--
