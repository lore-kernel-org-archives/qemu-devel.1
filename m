Received: from eggs.gnu.org ([2001:4830:134:3::10]:38894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbbK3-0002as-Uw
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbbK2-0002RN-7O
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:06:47 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-13-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c695908-24e9-bde6-8e04-772072263dc4@redhat.com>
Date: Wed, 8 Feb 2017 17:06:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-13-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IxnwTlBFDghOCEkl5jXPC3r2nqvPww7vg"
Subject: Re: [Qemu-devel] [PATCH 12/18] nbd: BLOCK_STATUS for bitmap export:
 client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IxnwTlBFDghOCEkl5jXPC3r2nqvPww7vg
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <6c695908-24e9-bde6-8e04-772072263dc4@redhat.com>
Subject: Re: [PATCH 12/18] nbd: BLOCK_STATUS for bitmap export: client part
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-13-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rather light on the commit description. Might be worth pointing to the
NBD protocol that it is implementing, particularly since that part of
the protocol is still an extension and may be subject to change based on
what we learn in our implementation attempt.

> ---
>  block/nbd-client.c   | 146 +++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  block/nbd-client.h   |   6 +++
>  block/nbd.c          |   9 +++-
>  include/block/nbd.h  |   6 ++-
>  nbd/client.c         | 103 +++++++++++++++++++++++++++++++++++-
>  nbd/server.c         |   2 -
>  qapi/block-core.json |   5 +-
>  qemu-nbd.c           |   2 +-
>  8 files changed, 270 insertions(+), 9 deletions(-)

Again, this is a high-level review where I haven't closely checked the sp=
ec.

>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index ff96bd1635..c7eb21fb02 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -388,6 +388,147 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, =
int64_t offset, int count)
> =20
>  }
> =20
> +static inline ssize_t read_sync(QIOChannel *ioc, void *buffer, size_t =
size)
> +{
> +    struct iovec iov =3D { .iov_base =3D buffer, .iov_len =3D size };
> +    /* Sockets are kept in blocking mode in the negotiation phase.  Af=
ter
> +     * that, a non-readable socket simply means that another thread st=
ole
> +     * our request/reply.  Synchronization is done with recv_coroutine=
, so
> +     * that this is coroutine-safe.
> +     */
> +    return nbd_wr_syncv(ioc, &iov, 1, size, true);
> +}

Does this need a coroutine_fn tag?  I wonder if part of this patch
should be split, to introduce the new helper function and rework
existing calls in one patch, then add new BLOCK_STATUS stuff in another.

> +
> +static int nbd_client_co_cmd_block_status(BlockDriverState *bs, uint64=
_t offset,
> +                                          uint64_t bytes, NBDExtent **=
pextents,
> +                                          unsigned *nb_extents)
> +{

> +
> +    nbd_co_receive_reply(client, &request, &reply, NULL);
> +    if (reply.error !=3D 0) {
> +        ret =3D -reply.error;
> +    }
> +    if (reply.simple) {
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +    if (reply.error !=3D 0) {
> +        ret =3D -reply.error;
> +        goto fail;
> +    }

Duplicate check for reply.error.

> +    if (reply.type !=3D NBD_REPLY_TYPE_BLOCK_STATUS) {
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    read_sync(client->ioc, &context_id, sizeof(context_id));
> +    cpu_to_be32s(&context_id);
> +    if (client->meta_data_context_id !=3D context_id) {
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    nb =3D (reply.length - sizeof(context_id)) / sizeof(NBDExtent);
> +    extents =3D g_new(NBDExtent, nb);

reply.length is server-controlled. I didn't closely check whether we
have any sanity checks that prevent a malicious server from sending a
bogus length that would cause us to allocate far too much memory.  We
may already have such a check (we forbid incoming read packets larger
than 32M), so this is more just making sure that those existing checks
cover this code too.

> +    if (read_sync(client->ioc, extents, nb * sizeof(NBDExtent)) !=3D
> +        nb * sizeof(NBDExtent))
> +    {
> +        ret =3D -EIO;
> +        goto fail;
> +    }
> +
> +    if (!(reply.flags && NBD_REPLY_FLAG_DONE)) {

Wrong logic. s/&&/&/

> +        nbd_co_receive_reply(client, &request, &reply, NULL);
> +        if (reply.simple) {
> +            ret =3D -EINVAL;
> +            goto fail;
> +        }
> +        if (reply.error !=3D 0) {
> +            ret =3D -reply.error;
> +            goto fail;
> +        }
> +        if (reply.type !=3D NBD_REPLY_TYPE_NONE ||
> +            !(reply.flags && NBD_REPLY_FLAG_DONE)) {
> +            ret =3D -EINVAL;
> +            goto fail;

It looks like you are insisting that the server send at most one extent
packet, and that either that packet, or a concluding TYPE_NONE packet,
must end the transaction (and if not, you drop the connection). While
that may happen to be the implementation you wrote for qemu as the
server, I don't think it is a requirement in the NBD spec, and that a
server could reasonably send multiple fragments that you must reassemble
into the overall final reply.  In fact, the final reply packet could be
NBD_REPLY_TYPE_ERROR instead of NBD_REPLY_TYPE_NONE (if there was a
late-breaking error detection that invalidates code sent earlier), which
you should handle gracefully rather than aborting the connection.

> +        }
> +    }
> +
> +    for (i =3D 0; i < nb; ++i) {
> +        cpu_to_be32s(&extents[i].length);
> +        cpu_to_be32s(&extents[i].flags);

Is it worth sanity-checking that the server's reported extents actually
fall within the range we requested information on (well, other than the
last extent which may extend beyond the range)?  When it comes to
network communication, both the client and the server SHOULD assume that
the other side may become malicious at any time, and verify that all
data makes sense before relying on it.

> +    }
> +
> +    *pextents =3D extents;
> +    *nb_extents =3D nb;
> +    nbd_coroutine_end(client, &request);
> +    return 0;
> +
> +fail:
> +    g_free(extents);
> +    nbd_coroutine_end(client, &request);
> +    return ret;
> +}
> +

> +++ b/block/nbd-client.h

> @@ -34,6 +34,8 @@ typedef struct NBDClientSession {

> =20
>  void nbd_client_detach_aio_context(BlockDriverState *bs);
>  void nbd_client_attach_aio_context(BlockDriverState *bs,
>                                     AioContext *new_context);
> =20
> +
>  #endif /* NBD_CLIENT_H */

Why the added blank line here?

> diff --git a/block/nbd.c b/block/nbd.c
> index 35f24be069..63bc3f04d0 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -382,6 +382,11 @@ static QemuOptsList nbd_runtime_opts =3D {
>              .type =3D QEMU_OPT_STRING,
>              .help =3D "ID of the TLS credentials to use",
>          },
> +        {
> +            .name =3D "bitmap",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "Name of dirty bitmap to export",
> +        },
>      },
>  };

I'm confused here - it seems like the name of a dirty bitmap to export
is a server detail, not a client detail.  After all, it is the server
that is using the bitmap to inform the client of what extents have a
given property.  So does this hunk belong in a different patch in the
series?

> +++ b/include/block/nbd.h
> @@ -181,6 +181,8 @@ enum {
>  #define NBD_REPLY_TYPE_ERROR ((1 << 15) + 1)
>  #define NBD_REPLY_TYPE_ERROR_OFFSET ((1 << 15) + 2)
> =20
> +#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8) /* 1 mb of extents data =
*/

The commit message might be a good place to document why you picked this
arbitrary limit (1 million extents covers a LOT of file if each extent
in turn represents a cluster of that file); meanwhile, since each extent
occupies 8 bytes, this means that you are clamping the server to send at
most 8 megabytes before you drop the connection (compared to accepting
32 megabytes for a read).

> =20
> +static int nbd_receive_query_meta_context(QIOChannel *ioc, const char =
*export,
> +                                          const char *context, bool *o=
k,
> +                                          Error **errp)
> +{
> +    int ret;
> +    nbd_opt_reply reply;
> +    size_t export_len =3D strlen(export);
> +    size_t context_len =3D strlen(context);
> +    size_t data_len =3D 4 + export_len + 4 + 4 + context_len;
> +
> +    char *data =3D g_malloc(data_len);
> +    char *p =3D data;
> +    int nb_reps =3D 0;
> +
> +    *ok =3D false;
> +    stl_be_p(p, export_len);
> +    memcpy(p +=3D 4, export, export_len);
> +    stl_be_p(p +=3D export_len, 1);
> +    stl_be_p(p +=3D 4, context_len);
> +    memcpy(p +=3D 4, context, context_len);

Is '4' better than 'sizeof(...)' here?

> +
> +    TRACE("Requesting set_meta_context option from server");
> +    ret =3D nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, dat=
a_len, data,
> +                                errp);

> +        if (read_sync(ioc, &context_id, sizeof(context_id)) !=3D
> +            sizeof(context_id))
> +        {
> +            ret =3D -EIO;
> +            goto out;
> +        }
> +
> +        be32_to_cpus(&context_id);
> +
> +        len =3D reply.length - sizeof(context_id);
> +        context_name =3D g_malloc(len + 1);
> +        if (read_sync(ioc, context_name, len) !=3D len) {
> +
> +            ret =3D -EIO;
> +            goto out;
> +        }
> +        context_name[len] =3D '\0';

Shouldn't we validate that the context name returned by the server
matches our expectations of the context name we requested?

> +
> +        TRACE("set meta: %u %s", context_id, context_name);
> +
> +        nb_reps++;
> +    }
> +
> +    *ok =3D nb_reps =3D=3D 1 && reply.type =3D=3D NBD_REP_ACK;

Insisting on exactly one context reply works only if you ensure that you
only request exactly one context; but we may want to request
'base:allocation' in addition to 'qemu:bitmapname' at some point.  Also,
I think the spec allows for the server to send a different number of
contexts than what we request (whether a context that it always provides
even though we didn't request it, or omitting something we requested
because it is unable to provide it).

> @@ -589,6 +680,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const c=
har *name, uint16_t *flags,
>                      nbd_receive_simple_option(ioc, NBD_OPT_STRUCTURED_=
REPLY,
>                                                false, NULL) =3D=3D 0;
>              }
> +
> +            if (!!structured_reply && *structured_reply && !!bitmap_na=
me) {

Why the use of !! to coerce pointers to bool when you already have &&
coercing to bool?

> +                int ret;
> +                assert(!!bitmap_ok);

Another pointless use of !!

> +                ret =3D nbd_receive_query_bitmap(ioc, name, bitmap_nam=
e,
> +                                               bitmap_ok, errp) =3D=3D=
 0;
> +                if (ret < 0) {
> +                    goto fail;
> +                }
> +            }
>          }
>          /* write the export name request */

> +++ b/nbd/server.c
> @@ -21,8 +21,6 @@
>  #include "qapi/error.h"
>  #include "nbd-internal.h"
> =20
> -#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8) /* 1 mb of extents data =
*/
> -

This is needless churn, since you only barely introduced this in an
earlier patch.  Stick it in the final file in the first patch where you
introduce it.

> +++ b/qapi/block-core.json
> @@ -2331,12 +2331,15 @@
>  #
>  # @tls-creds:   #optional TLS credentials ID
>  #
> +# @bitmap:   #optional Dirty bitmap name to export (vz-7.4)

s/vz-7.4/2.9/


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IxnwTlBFDghOCEkl5jXPC3r2nqvPww7vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYm6R6AAoJEKeha0olJ0Nqw6sH/3AzRLzdz52p8BXzuGxvw2Ji
tOLEZ5mwX9Ec/1RuczRcx+pC6IFeU1iX5KROQvbPrOxrAtgGMkRB/S+n31arAoyK
sENSccXjMYa+SR+DVS19TXN6+D5ScYES7wmGbl2a0jfCqEf/ElGZHyR5OajYxA6p
1VBoGkNoY/4xhtHrSbVEFGWB3J1W6DY5VRyDOSNwK/GjMumIKwI/gq+eI7GEMT8N
0eXsW+LBXAC0jHr+TdK42ucmw1K+OdyMH4HtoPu1OshMeAB0BjMh6ev5sDUFycxB
t3EkZIe5uNiOcvZQrHY1HyXc2eAJFUWIVx0YDz27QG5bv1seWixhVvx3n2JMY3g=
=u51X
-----END PGP SIGNATURE-----

--IxnwTlBFDghOCEkl5jXPC3r2nqvPww7vg--
