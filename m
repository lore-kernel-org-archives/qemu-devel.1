Received: from eggs.gnu.org ([2001:4830:134:3::10]:39029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coIyM-0004XJ-EJ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coIyL-0000AS-Gh
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:08:54 -0400
References: <20170314111157.14464-1-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e0d2aab2-d29f-09a7-4028-51c6df9f8978@redhat.com>
Date: Thu, 16 Mar 2017 01:08:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170314111157.14464-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FCR7CnQrx5IWVqfxx2JAFOxltxFMtK52J"
Subject: Re: [Qemu-devel] [PATCH] nbd-client: fix handling of hungup
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FCR7CnQrx5IWVqfxx2JAFOxltxFMtK52J
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <e0d2aab2-d29f-09a7-4028-51c6df9f8978@redhat.com>
Subject: Re: [PATCH] nbd-client: fix handling of hungup connections
References: <20170314111157.14464-1-pbonzini@redhat.com>
In-Reply-To: <20170314111157.14464-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 14.03.2017 12:11, Paolo Bonzini wrote:
> After the switch to reading replies in a coroutine, nothing is
> reentering pending receive coroutines if the connection hangs.
> Move nbd_recv_coroutines_enter_all to the reply read coroutine,
> which is the place where hangups are detected.  nbd_teardown_connection=

> can simply wait for the reply read coroutine to detect the hangup
> and clean up after itself.
>=20
> This wouldn't be enough though because nbd_receive_reply returns 0
> (rather than -EPIPE or similar) when reading from a hung connection.
> Fix the return value check in nbd_read_reply_entry.
>=20
> This fixes qemu-iotests 083.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 12 ++++++------
>  nbd/client.c       |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 0dc12c2..1e2952f 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -33,17 +33,15 @@
>  #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)b=
s))
>  #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ ((uint64_t)(intptr_t)b=
s))
> =20
> -static void nbd_recv_coroutines_enter_all(BlockDriverState *bs)
> +static void nbd_recv_coroutines_enter_all(NBDClientSession *s)
>  {
> -    NBDClientSession *s =3D nbd_get_client_session(bs);
>      int i;
> =20
>      for (i =3D 0; i < MAX_NBD_REQUESTS; i++) {
>          if (s->recv_coroutine[i]) {
> -            qemu_coroutine_enter(s->recv_coroutine[i]);
> +            aio_co_wake(s->recv_coroutine[i]);
>          }
>      }
> -    BDRV_POLL_WHILE(bs, s->read_reply_co);
>  }
> =20
>  static void nbd_teardown_connection(BlockDriverState *bs)
> @@ -58,7 +56,7 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)
>      qio_channel_shutdown(client->ioc,
>                           QIO_CHANNEL_SHUTDOWN_BOTH,
>                           NULL);
> -    nbd_recv_coroutines_enter_all(bs);
> +    BDRV_POLL_WHILE(bs, client->read_reply_co);
> =20
>      nbd_client_detach_aio_context(bs);
>      object_unref(OBJECT(client->sioc));
> @@ -76,7 +74,7 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
>      for (;;) {
>          assert(s->reply.handle =3D=3D 0);
>          ret =3D nbd_receive_reply(s->ioc, &s->reply);
> -        if (ret < 0) {
> +        if (ret <=3D 0) {
>              break;
>          }
> =20
> @@ -103,6 +101,8 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>          aio_co_wake(s->recv_coroutine[i]);
>          qemu_coroutine_yield();
>      }
> +
> +    nbd_recv_coroutines_enter_all(s);
>      s->read_reply_co =3D NULL;
>  }
> =20
> diff --git a/nbd/client.c b/nbd/client.c
> index 5c9dee3..746e9a7 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -812,6 +812,6 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply=
 *reply)
>          LOG("invalid magic (got 0x%" PRIx32 ")", magic);
>          return -EINVAL;
>      }
> -    return 0;
> +    return sizeof(buf);

I'd (weakly) prefer for this function to instead return an error value
(e.g. -EPIPE as the commit message says) if read_sync() returned 0. This
is because a return value of 0 is often used to signify success and it's
always a bit weird if functions to not adhere to this convention. Just a
rather weak preference, though.

So:

Reviewed-by: Max Reitz <mreitz@redhat.com>

And generously leaving it to you (whether) to apply the patch. O:-)

Max

>  }
> =20
>=20



--FCR7CnQrx5IWVqfxx2JAFOxltxFMtK52J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljJ14wSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxhkIAIpJItvfS5ktmY2yTolv8oysO9AB4A2C
iB38Mzhx4HPObj6e5+yZjupne1Z3jHHAmkHT2vqOCmYAbhSK5VWa7peL5/qSkVz7
aqhsOrom1FRX0aR+gwxZlLBPeiINYctL+ssuMj1s173bkaAV/VrpseBnLzvJPIAn
VF5dkrN8ewYOpYUAVWtD12VmFkm/Dn8laQ3+aFDlwUdXliyQK6Hu7V9LJ2BtzCNi
btiN/7fv7+WhXGT32L77Y/3ZOcQBNDSjTQjWyrdeKJcCzvrL4ODiVx1ZHugn2CBQ
4WBtHENvswJfoXPswFjH4aqk6JUftpC9/HPJNdJeNNBExGSm4a4ttnA=
=hkkv
-----END PGP SIGNATURE-----

--FCR7CnQrx5IWVqfxx2JAFOxltxFMtK52J--
