Received: from eggs.gnu.org ([209.51.188.92]:43911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk8I0-0001kw-Nn
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk8Hz-0004IB-CI
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:05:00 -0500
References: <20190116142356.31515-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b2b710e-3255-a2a0-3e13-855bc5e96a1b@redhat.com>
Date: Thu, 17 Jan 2019 08:04:46 -0600
MIME-Version: 1.0
In-Reply-To: <20190116142356.31515-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TncpsXASgDeSmxd9NkLPALRwsMk3ypDqW"
Subject: Re: [Qemu-devel] [RFC] nbd: generalize usage of nbd_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TncpsXASgDeSmxd9NkLPALRwsMk3ypDqW
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com
Message-ID: <4b2b710e-3255-a2a0-3e13-855bc5e96a1b@redhat.com>
Subject: Re: [RFC] nbd: generalize usage of nbd_read
References: <20190116142356.31515-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190116142356.31515-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/16/19 8:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> We generally do very similar things around nbd_read: error_prepend,
> specifying, what we have tried to read and be_to_cpu conversion of
> integers.
>=20
> So, it seems reasonable to move common things to helper functions,
> which:
> 1. simplify code a bit
> 2. generalize nbd_read error descriptions, all starting with
>    "Failed to read"
> 3. make it more difficult to forget to convert things from BE
>=20
> Possible TODO:
> make a helper to read sized variable buffers, like
>=20
>   uint32_t len
>   @len bytes buffer follows
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi Eric!
>=20
> I have an idea of several helpers around nbd_read, what do you think
> about it?
>=20
> It now based on your "nbd: add qemu-nbd --list", and if we like it,
> I'll fix iotests appropriately (if they fail, but I think, they should)=

> and rebase onto final version of your series.
>=20
> Based-on:<20190112175812.27068-1-eblake@redhat.com>
>=20
>  include/block/nbd.h | 33 ++++++++++++++++-
>  block/nbd-client.c  |  5 +--
>  nbd/client.c        | 89 ++++++++++++++-------------------------------=

>  nbd/common.c        |  2 +-
>  nbd/server.c        | 27 +++++---------
>  5 files changed, 71 insertions(+), 85 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 80ee3cc997..f3d3ffc749 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -23,6 +23,7 @@
>  #include "qapi/qapi-types-block.h"
>  #include "io/channel-socket.h"
>  #include "crypto/tlscreds.h"
> +#include "qapi/error.h"
> =20
>  /* Handshake phase structs - this struct is passed on the wire */
> =20
> @@ -336,11 +337,39 @@ void nbd_server_start(SocketAddress *addr, const =
char *tls_creds,
>   * Reads @size bytes from @ioc. Returns 0 on success.
>   */
>  static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,=

> -                           Error **errp)
> +                           const char *desc, Error **errp)
>  {
> -    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : =
0;
> +    int ret =3D qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -E=
IO : 0;
> +
> +    if (ret < 0) {
> +        if (desc) {
> +            error_prepend(errp, "Failed to read %s: ", desc);
> +        } else {
> +            error_prepend(errp, "Failed to read from socket: ");
> +        }

Do we need the error_prepend() at all when there is no desc?  For that
matter, does prepending "Failed to read..." add any useful information
to the error message in the first place?

> +        return -1;
> +    }
> +
> +    return 0;
>  }
> =20
> +#define DEF_NBD_READ(bits) \
> +static inline int nbd_read ## bits(QIOChannel *ioc, uint ## bits ## _t=
 *val, \
> +                                   const char *desc, Error **errp)    =
       \
> +{                                                                     =
       \
> +    if (nbd_read(ioc, val, sizeof(*val), desc, errp) < 0) {           =
       \
> +        return -1;                                                    =
       \
> +    }                                                                 =
       \
> +    *val =3D be ## bits ## _to_cpu(*val);                             =
         \
> +    return 0;                                                         =
       \
> +}
> +
> +DEF_NBD_READ(16)
> +DEF_NBD_READ(32)
> +DEF_NBD_READ(64)

I'd write:

DEF_NBD_READ(16) /* nbd_read16 */

to aid grep-ability of the source code when looking where the function
is defined.

> +
> +#undef DEF_NBD_READ
> +
>  static inline bool nbd_reply_is_simple(NBDReply *reply)
>  {
>      return reply->magic =3D=3D NBD_SIMPLE_REPLY_MAGIC;
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 813539676d..5c97052608 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -337,10 +337,9 @@ static int nbd_co_receive_offset_data_payload(NBDC=
lientSession *s,
>          return -EINVAL;
>      }
> =20
> -    if (nbd_read(s->ioc, &offset, sizeof(offset), errp) < 0) {
> +    if (nbd_read64(s->ioc, &offset, "OFFSET_DATA offset", errp) < 0) {=

>          return -EIO;
>      }
> -    be64_to_cpus(&offset);

The idea seems to be worthwhile; the callsites are indeed shorter when
using the new wrappers.

> =20
>      data_size =3D chunk->length - sizeof(offset);
>      assert(data_size);
> @@ -387,7 +386,7 @@ static coroutine_fn int nbd_co_receive_structured_p=
ayload(
>      }
> =20
>      *payload =3D g_new(char, len);
> -    ret =3D nbd_read(s->ioc, *payload, len, errp);
> +    ret =3D nbd_read(s->ioc, *payload, len, "structured payload", errp=
);

Okay, so maybe prepending DOES help, in letting you know which part of
the message was being read.


> @@ -166,10 +165,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, N=
BDOptionReply *reply,
>              goto cleanup;
>          }
>          msg =3D g_malloc(reply->length + 1);
> -        if (nbd_read(ioc, msg, reply->length, errp) < 0) {
> -            error_prepend(errp, "failed to read option error %" PRIu32=

> -                          " (%s) message: ",
> -                          reply->type, nbd_rep_lookup(reply->type));
> +        if (nbd_read(ioc, msg, reply->length, "option error", errp) < =
0) {

On the other hand, the text being prepended here loses some information
compared to what it previously had. If none of the iotests are
triggering this particular failure path, it's hard to argue that anyone
is hitting it enough to notice the difference, at which point is it even
worth prepending anything if the error is unlikely.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--TncpsXASgDeSmxd9NkLPALRwsMk3ypDqW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAi34ACgkQp6FrSiUn
Q2oAcgf+O+Ue7Q+Myz04PtiFiuHfbhPMD1AvmhJp3Q1zwe5mdAXywWAPBWtD4OQg
NJsAPtKGI/xYh3/yfQ67FQiMNwaYzUhEbfkvqWFfLDVhj23rwGUR/sIjnLFYJ3f6
TzUFaqSqbic9ggcqYcwfj4duBY8OkU9Mp4EhTWlrgyhirUN7T4C3sD1Bvb3ijR7q
O2Z6OExQOCPlOYuimfVpo9+co2VpwUg5iunDi0M26KoSn1g1CX6IR3kjcIxVPZD1
O7zOsZ6OhGsO4+jYezun6cO5JB0pYnOAwnVt5JTBd4FCfQBOPzZbwslmkGZghens
LXjLbLoYnAWSYOxPhEfWiEIxch69Hw==
=sKIY
-----END PGP SIGNATURE-----

--TncpsXASgDeSmxd9NkLPALRwsMk3ypDqW--
