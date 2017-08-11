Received: from eggs.gnu.org ([2001:4830:134:3::10]:40919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgIPe-0004if-HK
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 18:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgIPc-0002ho-M0
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 18:28:14 -0400
References: <20170808152607.147691-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6079e4c4-ae54-826f-8cb4-dbcd773ecf50@redhat.com>
Date: Fri, 11 Aug 2017 17:28:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170808152607.147691-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mCXsU1tibphIuSKLO5VfIM206rxb9ucRU"
Subject: Re: [Qemu-devel] [PATCH v2 for 2.10] block/nbd-client: always
 return EIO on and after the first io channel error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mCXsU1tibphIuSKLO5VfIM206rxb9ucRU
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <6079e4c4-ae54-826f-8cb4-dbcd773ecf50@redhat.com>
Subject: Re: [PATCH v2 for 2.10] block/nbd-client: always return EIO on and
 after the first io channel error
References: <20170808152607.147691-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170808152607.147691-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:

Initial review, I'm still playing with this one, and will reply again on
Monday.

> Do not communicate after the first error to avoid communicating through=
t

s/throught/through a/

> broken channel. The only exclusion is try to send NBD_CMD_DISC anyway o=
n
> in nbd_client_close.

I think the exclusion is wrong - if we detected the server sending us
garbage, we're probably better off disconnecting entirely rather than
trying to assume that the server will give us a clean disconnect via
NBD_CMD_DISC.

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all. Here is a patch, fixing a problem noted in
> [PATCH 06/17] block/nbd-client: fix nbd_read_reply_entry
> and
> [PATCH 17/17] block/nbd-client: always return EIO on and after the firs=
t io channel error
> and discussed on list.
>=20
> If it will be applied to 2.10, then I'll rebase my 'nbd client refactor=
ing and fixing'
> on it (for 2.11). If not - I'll prefer not rebase the series, so, do no=
t apply this
> patch for 2.11.
>=20
> v2: set eio_to_all in nbd_co_send_request and nbd_co_receive_reply in c=
ase of error
>=20
>  block/nbd-client.h |  1 +
>  block/nbd-client.c | 65 +++++++++++++++++++++++++++++++++++++++-------=
--------
>  2 files changed, 48 insertions(+), 18 deletions(-)
>=20
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index df80771357..28db9922c8 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -29,6 +29,7 @@ typedef struct NBDClientSession {
> =20
>      Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
>      NBDReply reply;
> +    bool eio_to_all;

Bikeshedding - I'm wondering if there is a better name; maybe 'error' or
'server_broken'?

>  } NBDClientSession;
> =20
>  NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 25dd28406b..a72cb7690a 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -49,6 +49,8 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)
>  {
>      NBDClientSession *client =3D nbd_get_client_session(bs);
> =20
> +    client->eio_to_all =3D true;
> +

Okay, if you set it here, then it does NOT mean 'server_broken' - and if
we reached this spot normally, we still WANT the NBD_CMD_DISC.  So do we
really need to set it here?

>      if (!client->ioc) { /* Already closed */
>          return;
>      }
> @@ -74,12 +76,16 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>      Error *local_err =3D NULL;
> =20
>      for (;;) {
> +        if (s->eio_to_all) {
> +            break;
> +        }
> +
>          assert(s->reply.handle =3D=3D 0);
>          ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
>          if (ret < 0) {
>              error_report_err(local_err);
>          }
> -        if (ret <=3D 0) {
> +        if (ret <=3D 0 || s->eio_to_all) {

I'm still wondering if we need this condition at two points in the loop,
or if merely checking at the beginning of the cycle is sufficient (like
I said in my counterproposal thread, I'll be hammering away at your
patch under gdb over the weekend, to see if I can trigger all the
additions under some situation).

>              break;
>          }
> =20
> @@ -107,6 +113,7 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>          qemu_coroutine_yield();
>      }
> =20
> +    s->eio_to_all =3D true;

I think this one should be guarded by 'if (ret < 0)' - we also break out
of the for loop when ret =3D=3D 0 (aka EOF because the server ended
cleanly), which is not the same as the server sending us garbage.

>      nbd_recv_coroutines_enter_all(s);
>      s->read_reply_co =3D NULL;
>  }
> @@ -118,6 +125,10 @@ static int nbd_co_send_request(BlockDriverState *b=
s,
>      NBDClientSession *s =3D nbd_get_client_session(bs);
>      int rc, ret, i;
> =20
> +    if (s->eio_to_all) {
> +        return -EIO;
> +    }
> +

This one is good.

>      qemu_co_mutex_lock(&s->send_mutex);
>      while (s->in_flight =3D=3D MAX_NBD_REQUESTS) {
>          qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
> @@ -135,15 +146,15 @@ static int nbd_co_send_request(BlockDriverState *=
bs,
>      assert(i < MAX_NBD_REQUESTS);
>      request->handle =3D INDEX_TO_HANDLE(s, i);
> =20
> -    if (!s->ioc) {
> +    if (s->eio_to_all) {
>          qemu_co_mutex_unlock(&s->send_mutex);
> -        return -EPIPE;
> +        return -EIO;
>      }

I don't know if changing the errno is wise; maybe we want to keep both
conditions (the !s->ioc and the s->eio_to_all) - especially if we only
set eio_to_all on an actual detection of server garbage rather than on
all exit paths.

> =20
>      if (qiov) {
>          qio_channel_set_cork(s->ioc, true);
>          rc =3D nbd_send_request(s->ioc, request);
> -        if (rc >=3D 0) {
> +        if (rc >=3D 0 && !s->eio_to_all) {
>              ret =3D nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->le=
n, false,
>                            NULL);
>              if (ret !=3D request->len) {
> @@ -155,7 +166,13 @@ static int nbd_co_send_request(BlockDriverState *b=
s,
>          rc =3D nbd_send_request(s->ioc, request);
>      }
>      qemu_co_mutex_unlock(&s->send_mutex);
> -    return rc;
> +
> +    if (rc < 0 || s->eio_to_all) {
> +        s->eio_to_all =3D true;
> +        return -EIO;

I think this one makes sense.

> +    }
> +
> +    return 0;
>  }
> =20
>  static void nbd_co_receive_reply(NBDClientSession *s,
> @@ -169,14 +186,16 @@ static void nbd_co_receive_reply(NBDClientSession=
 *s,
>      qemu_coroutine_yield();
>      *reply =3D s->reply;
>      if (reply->handle !=3D request->handle ||
> -        !s->ioc) {
> +        !s->ioc || s->eio_to_all) {
>          reply->error =3D EIO;
> +        s->eio_to_all =3D true;
>      } else {
>          if (qiov && reply->error =3D=3D 0) {
>              ret =3D nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->le=
n, true,
>                            NULL);
> -            if (ret !=3D request->len) {
> +            if (ret !=3D request->len || s->eio_to_all) {
>                  reply->error =3D EIO;
> +                s->eio_to_all =3D true;
>              }

This may be redundant with setting eio_to_all in nbd_read_reply_entry.

>          }
> =20
> @@ -225,8 +244,10 @@ int nbd_client_co_preadv(BlockDriverState *bs, uin=
t64_t offset,
>      } else {
>          nbd_co_receive_reply(client, &request, &reply, qiov);
>      }
> -    nbd_coroutine_end(bs, &request);
> -    return -reply.error;
> +    if (request.handle !=3D 0) {
> +        nbd_coroutine_end(bs, &request);
> +    }

I'm not sure about this one - don't we always need to call
nbd_coroutine_end for resource cleanup, even when we detected an error?

> @@ -384,6 +412,7 @@ int nbd_client_init(BlockDriverState *bs,
>      logout("session init %s\n", export);
>      qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
> =20
> +    client->eio_to_all =3D false;

This one happens by default since we zero-initialize, but explicit
initialization doesn't hurt.

>      client->info.request_sizes =3D true;
>      ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
>                                  tlscreds, hostname,
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mCXsU1tibphIuSKLO5VfIM206rxb9ucRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmOL3IACgkQp6FrSiUn
Q2r+WAgAl4/2Gka0vX9V1NKrcMjuNbQLWcZKtJ6MIJjKzvjXOa6bONzZgKp2NH0g
h+FkzF4QW1djHXwYK2piz1vXz0POyRMKmOKdeQyCKq+dtrFUwO4ij3lYYSd6m9M0
Rzvga6noDC45UT7QFnrAeCKMicjnrTxhhSIiBmcumIoA69k0mUJ8xkSGQ/7lJOKK
w1pqMrE3JatmliA5nYFJS+BbDX8g8LyGrbdv92S2kTtiO4rYXmkv/ASg/daSiMIW
CN7oY3b9QIvivjUDgT0pftFV0AqyKb3XSLMvYG9WEGIYMUu8vTVR5VbDLL3knuYA
6RE1LwH2O6GBfhZtvOWlw1OTTtupMw==
=Ys3k
-----END PGP SIGNATURE-----

--mCXsU1tibphIuSKLO5VfIM206rxb9ucRU--
