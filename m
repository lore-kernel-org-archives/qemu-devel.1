Received: from eggs.gnu.org ([2001:4830:134:3::10]:58097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e35W9-0008Lq-Pg
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e35W8-0000NB-3C
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:21:09 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-13-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0988f6a8-a590-0bb8-7ab6-73810313cd3b@redhat.com>
Date: Fri, 13 Oct 2017 14:20:58 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-13-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kDHhxK6rE4xHLomna2u1N9sB3Hh8hPxbM"
Subject: Re: [Qemu-devel] [PATCH v3 12/13] nbd/client: prepare
 nbd_receive_reply for structured reply
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
--kDHhxK6rE4xHLomna2u1N9sB3Hh8hPxbM
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <0988f6a8-a590-0bb8-7ab6-73810313cd3b@redhat.com>
Subject: Re: [PATCH v3 12/13] nbd/client: prepare nbd_receive_reply for
 structured reply
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-13-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> In following patch nbd_receive_reply will be used both for simple
> and structured reply header receiving.
> NBDReply is altered into union of simple reply header and structured
> reply chunk header, simple error translation moved to block/nbd-client
> to be consistent with further structured reply error translation.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  30 ++++++++++++----
>  block/nbd-client.c  |   8 +++--
>  nbd/client.c        | 102 +++++++++++++++++++++++++++++++++++++++++---=
--------
>  nbd/trace-events    |   3 +-
>  4 files changed, 113 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 09e4592971..1ef8c8897f 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -57,12 +57,6 @@ struct NBDRequest {
>  };
>  typedef struct NBDRequest NBDRequest;
> =20
> -struct NBDReply {
> -    uint64_t handle;
> -    uint32_t error;
> -};
> -typedef struct NBDReply NBDReply;

The old struct is not packed,

> -
>  typedef struct NBDSimpleReply {
>      uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
>      uint32_t error;
> @@ -77,9 +71,33 @@ typedef struct NBDStructuredReplyChunk {
>      uint32_t length; /* length of payload */
>  } QEMU_PACKED NBDStructuredReplyChunk;
> =20
> +typedef union NBDReply {
> +    NBDSimpleReply simple;
> +    NBDStructuredReplyChunk structured;
> +    struct {
> +        /* @magic and @handle fields have the same offset and size bot=
h in
> +         * simple reply and structured reply chunk, so let them be acc=
essible
> +         * without ".simple." or ".structured." specification
> +         */
> +        uint32_t magic;
> +        uint32_t _skip;
> +        uint64_t handle;
> +    } QEMU_PACKED;
> +} NBDReply;

but the new is. I'm not sure if that's a good idea.  When we are dealing
with items on the wire, compilers may emit inefficient code for dealing
with packed structs; once we've parsed off the wire, putting things in a
non-packed struct for the remainder of our local handling may have
better performance.  I'm not striking this outright, especially if Paolo
has an opinion here.

> +
>  #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
>  #define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
> =20
> +static inline bool nbd_reply_is_simple(NBDReply *reply)
> +{
> +    return reply->magic =3D=3D NBD_SIMPLE_REPLY_MAGIC;
> +}
> +
> +static inline bool nbd_reply_is_structured(NBDReply *reply)
> +{
> +    return reply->magic =3D=3D NBD_STRUCTURED_REPLY_MAGIC;
> +}
> +

Putting functions in the middle of structs/constants feels odd; I would
sink these down to the bottom.

>  typedef struct NBDStructuredRead {
>      NBDStructuredReplyChunk h;
>      uint64_t offset;
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index c0683c3c83..58493b7ac4 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -92,7 +92,9 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
>          i =3D HANDLE_TO_INDEX(s, s->reply.handle);
>          if (i >=3D MAX_NBD_REQUESTS ||
>              !s->requests[i].coroutine ||
> -            !s->requests[i].receiving) {
> +            !s->requests[i].receiving ||
> +            nbd_reply_is_structured(&s->reply))
> +        {

I did a double-take here, but it makes sense: for this patch, we aren't
actually expecting structured replies (we aren't negotiating it with the
server yet), and therefore a server sending us one is a bug.

>              break;
>          }
> =20
> @@ -194,8 +196,8 @@ static int nbd_co_receive_reply(NBDClientSession *s=
,
>          ret =3D -EIO;
>      } else {
>          assert(s->reply.handle =3D=3D handle);
> -        ret =3D -s->reply.error;
> -        if (qiov && s->reply.error =3D=3D 0) {
> +        ret =3D -nbd_errno_to_system_errno(s->reply.simple.error);

So here, you are stating that client.c no longer performs the errno
translation, by placing the duty on the caller instead. [1]

> +        if (qiov && ret =3D=3D 0) {
>              if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
>                                        NULL) < 0) {
>                  ret =3D -EIO;
> diff --git a/nbd/client.c b/nbd/client.c
> index f0f3075569..a38e1a7d8e 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -910,6 +910,57 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *=
request)
>      return nbd_write(ioc, buf, sizeof(buf), NULL);
>  }
> =20
> +/* nbd_receive_simple_reply
> + * Read simple reply except magic field (which should be already read)=
=2E
> + * Payload is not read (payload is possible for CMD_READ, but here we =
even
> + * don't know whether it take place or not).

I'll probably do some wordsmithing here when I post v4.

> + */
> +static int nbd_receive_simple_reply(QIOChannel *ioc, NBDSimpleReply *r=
eply,
> +                                    Error **errp)
> +{
> +    int ret;
> +
> +    assert(reply->magic =3D=3D NBD_SIMPLE_REPLY_MAGIC);
> +
> +    ret =3D nbd_read(ioc, (uint8_t *)reply + sizeof(reply->magic),
> +                   sizeof(*reply) - sizeof(reply->magic), errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    be32_to_cpus(&reply->error);
> +    be64_to_cpus(&reply->handle);
> +

Worth a trace here? [2]

> +    return 0;
> +}
> +
> +/* nbd_receive_structured_reply_chunk
> + * Read structured reply chunk except magic field (which should be alr=
eady
> + * read).
> + * Payload is not read.
> + */
> +static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
> +                                              NBDStructuredReplyChunk =
*chunk,
> +                                              Error **errp)
> +{
> +    int ret;
> +
> +    assert(chunk->magic =3D=3D NBD_STRUCTURED_REPLY_MAGIC);
> +
> +    ret =3D nbd_read(ioc, (uint8_t *)chunk + sizeof(chunk->magic),
> +                   sizeof(*chunk) - sizeof(chunk->magic), errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    be16_to_cpus(&chunk->flags);
> +    be16_to_cpus(&chunk->type);
> +    be64_to_cpus(&chunk->handle);
> +    be32_to_cpus(&chunk->length);

Worth a trace here?

> +
> +    return 0;
> +}
> +
>  /* nbd_receive_reply
>   * Returns 1 on success
>   *         0 on eof, when no data was read (errp is not set)
> @@ -917,37 +968,48 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest =
*request)
>   */
>  int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
>  {
> -    uint8_t buf[NBD_REPLY_SIZE];
> -    uint32_t magic;
>      int ret;
> =20
> -    ret =3D nbd_read_eof(ioc, buf, sizeof(buf), errp);
> +    ret =3D nbd_read_eof(ioc, &reply->magic, sizeof(reply->magic), err=
p);
>      if (ret <=3D 0) {
>          return ret;
>      }
> =20
> -    /* Reply
> -       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
> -       [ 4 ..  7]    error   (0 =3D=3D no error)
> -       [ 7 .. 15]    handle
> -     */
> +    be32_to_cpus(&reply->magic);
> =20
> -    magic =3D ldl_be_p(buf);
> -    reply->error  =3D ldl_be_p(buf + 4);
> -    reply->handle =3D ldq_be_p(buf + 8);
> +    switch (reply->magic) {
> +    case NBD_SIMPLE_REPLY_MAGIC:
> +        ret =3D nbd_receive_simple_reply(ioc, &reply->simple, errp);
> +        if (ret < 0) {
> +            break;
> +        }
> =20
> -    reply->error =3D nbd_errno_to_system_errno(reply->error);

[1] here's where we changed the responsibility. But I see you mentioned
it in the commit message, so we're okay.

> +        if (reply->simple.error =3D=3D NBD_ESHUTDOWN) {
> +            /* This works even on mingw which lacks a native ESHUTDOWN=
 */
> +            error_setg(errp, "server shutting down");
> +            return -EINVAL;
> +        }
> =20
> -    if (reply->error =3D=3D ESHUTDOWN) {
> -        /* This works even on mingw which lacks a native ESHUTDOWN */
> -        error_setg(errp, "server shutting down");
> +        trace_nbd_receive_simple_reply(
> +                nbd_errno_to_system_errno(reply->simple.error),

However, it does make this trace a bit awkward.  Maybe we just tweak the
trace to now output the raw value received over the wire, rather than
the local host value; in fact, if we had a lookup function for the
various NBD errors, the trace could include the name in addition to the
error number.  Separate cleanup, as it is something that existing code
could benefit from, so I'll tackle that in my v4.

> +                reply->simple.handle);
> +        break;
> +    case NBD_STRUCTURED_REPLY_MAGIC:
> +        ret =3D nbd_receive_structured_reply_chunk(ioc, &reply->struct=
ured, errp);
> +        if (ret < 0) {
> +            break;
> +        }
> +        trace_nbd_receive_structured_reply_chunk(reply->structured.fla=
gs,
> +                                                 reply->structured.typ=
e,
> +                                                 reply->structured.han=
dle,
> +                                                 reply->structured.len=
gth);

[2] oh, you are tracing here on success, rather than in the helper. Not
sure if it makes much difference.

> +++ b/nbd/trace-events
> @@ -30,7 +30,8 @@ nbd_client_loop_ret(int ret, const char *error) "NBD =
loop returned %d: %s"
>  nbd_client_clear_queue(void) "Clearing NBD queue"
>  nbd_client_clear_socket(void) "Clearing NBD socket"
>  nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_=
t flags, uint16_t type, const char *name) "Sending request to server: { .=
from =3D %" PRIu64", .len =3D %" PRIu32 ", .handle =3D %" PRIu64 ", .flag=
s =3D 0x%" PRIx16 ", .type =3D %" PRIu16 " (%s) }"
> -nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got=
 reply: { magic =3D 0x%" PRIx32 ", .error =3D % " PRId32 ", handle =3D %"=
 PRIu64" }"
> +nbd_receive_simple_reply(int32_t error, uint64_t handle) "Got simple r=
eply: { error =3D % " PRId32 ", handle =3D %" PRIu64" }"
> +nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, uint=
64_t handle, uint32_t length) "Got structured reply chunk: { flags =3D 0x=
%" PRIx16 ", type =3D %d, handle =3D %" PRIu64 ", length =3D %" PRIu32 " =
}"

I'd love to see a %s for the structured type, another lookup function
I'll propose for my v4.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kDHhxK6rE4xHLomna2u1N9sB3Hh8hPxbM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnhEhoACgkQp6FrSiUn
Q2osLwgAjtWnBxbmS2Y4np0m2GmKzW0szNf+9FOWqpkcFwRsIZJU2Nuj4wD3b85h
+ngDXLfAfFkglvQZbWQMnaKMDYTmVVyd/3pjPtQdalRR0tbC1TTxH7zZeThm33Vp
aWQyv9ctUloQ5vlXLw5FLzzjoPLPPpamze/VgOZYyIEI+QEJ3JTZDdPu76Sjgban
IaI1a17xJKumLPMBNTuCMoJqA+yqju2voSi4U0pmRaRTZ2AwDoobXDhAyh4ILaDw
ulB5lKrrEbSLoMypy6yAdpMhd/WFsHK5NCkJV4h/BipoS39Az2nRcMwL/jjxJPQP
C9uejSfETw2sMWj1l3eJ8WmEnuGw6w==
=Pwz9
-----END PGP SIGNATURE-----

--kDHhxK6rE4xHLomna2u1N9sB3Hh8hPxbM--
