Received: from eggs.gnu.org ([2001:4830:134:3::10]:40008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5k2-0005SB-Po
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5k1-0007Sj-93
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:44:18 -0400
References: <20170808142944.145159-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a8eaea35-6959-e3ff-db0f-f7bf4448b61c@redhat.com>
Date: Tue, 8 Aug 2017 09:44:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170808142944.145159-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KhpGkggSrWFk0mvAMAmNurf5OmFNVn20E"
Subject: Re: [Qemu-devel] [PATCH for 2.10] block/nbd-client: always return
 EIO on and after the first io channel error
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
--KhpGkggSrWFk0mvAMAmNurf5OmFNVn20E
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <a8eaea35-6959-e3ff-db0f-f7bf4448b61c@redhat.com>
Subject: Re: [PATCH for 2.10] block/nbd-client: always return EIO on and after
 the first io channel error
References: <20170808142944.145159-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170808142944.145159-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 09:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Do not communicate after the first error to avoid communicating through=
t
> broken channel. The only exclusion is try to send NBD_CMD_DISC anyway o=
n
> in nbd_client_close.
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

It may be possible to do something even smaller:

>=20
>  block/nbd-client.h |  1 +
>  block/nbd-client.c | 58 +++++++++++++++++++++++++++++++++++++---------=
--------
>  2 files changed, 41 insertions(+), 18 deletions(-)
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
>  } NBDClientSession;
> =20
>  NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 25dd28406b..1282b2484e 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -49,6 +49,8 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)
>  {
>      NBDClientSession *client =3D nbd_get_client_session(bs);
> =20
> +    client->eio_to_all =3D true;
> +
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

How is this conditional ever reached? nbd_read_reply_entry() is our
workhorse, that is supposed to run until the client is ready to disconnec=
t.

>          assert(s->reply.handle =3D=3D 0);
>          ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
>          if (ret < 0) {
>              error_report_err(local_err);
>          }
> -        if (ret <=3D 0) {
> +        if (ret <=3D 0 || s->eio_to_all) {
>              break;
>          }

This says we're now supposed to break out of the while loop.  So unless
something can set s->eio_to_all during
aio_co_wake(s->recv_coroutine[i]), the next iteration of the loop won't
hit the first conditional.

Meanwhile, even if we skip the first conditional, this second
conditional will still end the loop prior to acting on anything received
from the server (the difference being whether we called
nbd_receive_reply() one additional time, but I don't see that as getting
in the way of a clean exit).

But my question is whether we can just go with a simpler fix: if we ever
break out of the workhorse loop of nbd_read_reply_entry(), then (and
only then) is when we call nbd_recv_coroutines_enter_all() to mop up any
pending transactions before tearing down the coroutines.  Is there
something we can do in nbd_recv_coroutines_enter_all() that will
guarantee that our final entry into each coroutine will fail?

I'm still playing with the idea locally.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KhpGkggSrWFk0mvAMAmNurf5OmFNVn20E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJzjUACgkQp6FrSiUn
Q2ohWwgAj7HS0EXhYRQAn7nAdxwhFv4hiqwQIjcp8xfllpKSgVsSwgiaQyFfCo94
2VoNHhTJnEb5hfplBpk0IvnYR3AWeKn+IWtAj9uBwYJHeaPEg7TeYSFSwzIlf4ph
wtLtIrWDyq/9rchnsquzT0RDCEtujdae4Wd/3UMqh9hG8LBP1JZjLeR7zFKZvXvQ
PfeXPUnYXq4zGV8ae/3TR85CVSDtTH7WJu6vhqcF/jguV0/e68ZgJ4QxApO4waBf
8yYBXneX6tEC+4G8lhdLo/mLvhqlOI2RXT113jYjC1AkZXE+Q9LOam8YsFnLjH1+
/hQMvadw8SPYYkHDvcMk8+fAsb8mtA==
=8UBI
-----END PGP SIGNATURE-----

--KhpGkggSrWFk0mvAMAmNurf5OmFNVn20E--
