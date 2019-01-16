Received: from eggs.gnu.org ([209.51.188.92]:57562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjo0Q-0003qR-Sz
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjo0C-00028p-GX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:25:22 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64d9a2e7-6dd9-d71b-b9bf-c476e9e218f8@redhat.com>
Date: Wed, 16 Jan 2019 10:25:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xATbs4uVqwn2EufGZYIo1tuuuqNIm92ZC"
Subject: Re: [Qemu-devel] [PATCH v4 06/10] block/nbd-client: move from quit
 to state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xATbs4uVqwn2EufGZYIo1tuuuqNIm92ZC
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Message-ID: <64d9a2e7-6dd9-d71b-b9bf-c476e9e218f8@redhat.com>
Subject: Re: [PATCH v4 06/10] block/nbd-client: move from quit to state
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Dan]

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> To implement reconnect we need several states for the client:
> CONNECTED, QUIT and two CONNECTING states. CONNECTING states will
> be realized in the following patches. This patch implements CONNECTED
> and QUIT.
>=20
> QUIT means, that we should close the connection and fail all current
> and further requests (like old quit =3D true).
>=20
> CONNECTED means that connection is ok, we can send requests (like old
> quit =3D false).
>=20
> For receiving loop we use a comparison of the current state with QUIT,
> because reconnect will be in the same loop, so it should be looping
> until the end.
>=20
> Opposite, for requests we use a comparison of the current state with
> CONNECTED, as we don't want to send requests in CONNECTING states (
> which are unreachable now, but will be reachable after the following
> commits)
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h |  9 ++++++++-
>  block/nbd-client.c | 55 ++++++++++++++++++++++++++++++++--------------=
--------
>  2 files changed, 41 insertions(+), 23 deletions(-)

Dan just recently proposed patches to SocketChardev in general to use a
state machine that distinguishes between connecting and connected:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03339.html

I'm wondering how much of his work is related or can be reused to get
restartable connections on NBD sockets?

Remember, right now, the NBD code always starts in blocking mode, and
does single-threaded handshaking until it is ready for transmission,
then switches to non-blocking mode for all subsequent transmissions (so,
for example, servicing a read request can assume that the socket is
valid without further waiting).  But once we start allowing reconnects,
a read request will need to detect when one socket has gone down, and
wait for its replacement socket to come back up, in order to retry the
request; this retry is in a context where we are in non-blocking
context, but the retry must establish a new socket, and possibly convert
the socket into TLS mode, all before being ready to retry the read reques=
t.

>=20
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index 2f047ba614..5367425774 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -23,6 +23,13 @@ typedef struct {
>      bool receiving;         /* waiting for read_reply_co? */
>  } NBDClientRequest;
> =20
> +typedef enum NBDClientState {
> +    NBD_CLIENT_CONNECTING_WAIT,
> +    NBD_CLIENT_CONNECTING_NOWAIT,

Would we be better off adding these enum values in the later patch that
uses them?

> +    NBD_CLIENT_CONNECTED,
> +    NBD_CLIENT_QUIT
> +} NBDClientState;
> +
>  typedef struct NBDClientSession {
>      QIOChannelSocket *sioc; /* The master data channel */
>      QIOChannel *ioc; /* The current I/O channel which may differ (eg T=
LS) */
> @@ -32,10 +39,10 @@ typedef struct NBDClientSession {
>      CoQueue free_sema;
>      Coroutine *read_reply_co;
>      int in_flight;
> +    NBDClientState state;
> =20
>      NBDClientRequest requests[MAX_NBD_REQUESTS];
>      NBDReply reply;
> -    bool quit;
>  } NBDClientSession;
> =20
>  NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 7eaf0149f0..a91fd3ea3e 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -34,6 +34,12 @@
>  #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(b=
s))
>  #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(b=
s))
> =20
> +/* @ret would be used for reconnect in future */

s/would/will/

> +static void nbd_channel_error(NBDClientSession *s, int ret)
> +{
> +    s->state =3D NBD_CLIENT_QUIT;
> +}
> +
>  static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
>  {
>      int i;
> @@ -73,14 +79,15 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>      int ret =3D 0;
>      Error *local_err =3D NULL;
> =20
> -    while (!s->quit) {
> +    while (s->state !=3D NBD_CLIENT_QUIT) {
>          assert(s->reply.handle =3D=3D 0);
>          ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>          }
>          if (ret <=3D 0) {
> -            break;
> +            nbd_channel_error(s, ret ? ret : -EIO);
> +            continue;

I guess the continue instead of the break is pre-supposing that
nbd_channel_error() might be able to recover in later patches?  But for
this patch, there is no change in control flow, because the loop
condition is met for no further iterations, the same as a break would
have done.

The rest of the patch looks sane, but fails to apply easily for me (I'm
getting enough rebase churn, that it's getting harder to state if it is
accurate against the latest git master).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xATbs4uVqwn2EufGZYIo1tuuuqNIm92ZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/Wt8ACgkQp6FrSiUn
Q2ouuAf/QsxWWwkhg4l+Gq/rJ8Cp9bUQuItDauPAC+pVu1nQpT6i8QecKjUFX34o
yvqVcY+hVyjj0EOpOGi3RQUwstgfnNnT0/ekVyCJRQ4AG3RPDDfi/JdCaetCcMzG
QOioCnk+CfMOtPY6ObW86GBQFvuOFU+U5UEltAMiN5TT1mb63Fh1CjPus77aB4Jn
x56ZSHZPglWrDfByaADX2iJ5qs7mrd3g+4wjwmhIs6RnYZV+fMPfrzEM9dmw+Hsu
ysi4/mqAsgCz0Ut4df4OgY5zY6GDykXPZBCsavX2qfdWpTb1bu69gCaJfAeXz+BZ
zGdnioaDSY9cOTpd+HIayybBBRY+qQ==
=IIkV
-----END PGP SIGNATURE-----

--xATbs4uVqwn2EufGZYIo1tuuuqNIm92ZC--
