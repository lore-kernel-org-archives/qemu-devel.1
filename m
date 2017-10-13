Received: from eggs.gnu.org ([2001:4830:134:3::10]:50880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e36vp-0007D0-Ri
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e36vn-0004ax-6T
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:51:45 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-14-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b7d8ffe-ded8-364d-b185-a373a7ca0db0@redhat.com>
Date: Fri, 13 Oct 2017 15:51:28 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JxvbBeEdHdtCE24mfasK5UIbLAhNhucvu"
Subject: Re: [Qemu-devel] [PATCH v3 13/13] nbd: Minimal structured read for
 client
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
--JxvbBeEdHdtCE24mfasK5UIbLAhNhucvu
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <7b7d8ffe-ded8-364d-b185-a373a7ca0db0@redhat.com>
Subject: Re: [PATCH v3 13/13] nbd: Minimal structured read for client
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-14-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal implementation: for structured error only error_report error
> message.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |   6 +
>  block/nbd-client.c  | 395 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
>  nbd/client.c        |   7 +
>  3 files changed, 379 insertions(+), 29 deletions(-)
>=20

The fun stuff!

> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 1ef8c8897f..e3350b67a4 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -203,6 +203,11 @@ enum {
>  #define NBD_SREP_TYPE_ERROR         NBD_SREP_ERR(1)
>  #define NBD_SREP_TYPE_ERROR_OFFSET  NBD_SREP_ERR(2)
> =20
> +static inline bool nbd_srep_type_is_error(int type)
> +{
> +    return type & (1 << 15);
> +}

Knock-on effects to your earlier reply that s/srep/reply/ was okay.
Again, I'm not a fan of inline functions until after all the structs and
constants have been declared, so I'd sink this a bit lower.

> +
>  /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
>   * but only a limited set of errno values is specified in the protocol=
=2E
>   * Everything else is squashed to EINVAL.
> @@ -241,6 +246,7 @@ static inline int nbd_errno_to_system_errno(int err=
)
>  struct NBDExportInfo {
>      /* Set by client before nbd_receive_negotiate() */
>      bool request_sizes;
> +    bool structured_reply;
>      /* Set by server results during nbd_receive_negotiate() */

You are correct that the client has to set this before negotiate (if we
are in qemu-nbd and about to hand over to the kernel, we must NOT
request structured_reply unless the kernel has been patched to
understand structured replies - but upstream NBD isn't there yet; but if
we are using block/nbd-client.c, then we can request it). But we must
also check this AFTER negotiate, to see if the server understood our
request (how we handle reads depends on what mode the server is in).  So
maybe this needs another comment.

> +++ b/block/nbd-client.c
> @@ -29,6 +29,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"

What errors are we reporting directly, instead of feeding back through
errp?  Without seeing the rest of the patch yet, I'm suspicious of this
include.

>  #include "nbd-client.h"
> =20
>  #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(b=
s))
> @@ -93,7 +94,7 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
>          if (i >=3D MAX_NBD_REQUESTS ||
>              !s->requests[i].coroutine ||
>              !s->requests[i].receiving ||
> -            nbd_reply_is_structured(&s->reply))
> +            (nbd_reply_is_structured(&s->reply) && !s->info.structured=
_reply))
>          {

Do we set a good error message when the server sends us garbage? [1]

>              break;
>          }
> @@ -181,75 +182,406 @@ err:
>      return rc;
>  }
> =20
> -static int nbd_co_receive_reply(NBDClientSession *s,
> -                                uint64_t handle,
> -                                QEMUIOVector *qiov)
> +static inline void payload_advance16(uint8_t **payload, uint16_t **ptr=
)
> +{
> +    *ptr =3D (uint16_t *)*payload;
> +    be16_to_cpus(*ptr);

Won't work.  This is a potentially unaligned cast, where you don't have
the benefit of a packed struct, and the compiler will probably gripe at
you on platforms stricter than x86.  Instead, if I remember correctly,
we should use
 *ptr =3D ldw_be_p(*ptr);
Ditto to your other sizes.

Why not a helper for an 8-bit read?

> +static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chun=
k,
> +                                         uint8_t *payload, QEMUIOVecto=
r *qiov)
> +{
> +    uint64_t *offset;
> +    uint32_t *hole_size;
> +
> +    if (chunk->length !=3D sizeof(*offset) + sizeof(*hole_size)) {
> +        return -EINVAL;

Should we plumb in errp, and return a decent error message that way
rather than relying on a mere -EINVAL which forces us to drop connection
with the server and treat all remaining outstanding requests as EIO?

Thinking a bit more: If we get here, the server sent us the wrong number
of bytes - but we know from chunk->length how much data the server
claims to have coming, even if we don't know what to do with that data.
And we've already read the payload into malloc'd memory, so we are in
sync to read more replies from the server.  So we don't have to hang up,
but it's probably safer to hang up than to misinterpret what the server
sent and risking misbehavior down the road.

> +    }
> +
> +    payload_advance64(&payload, &offset);
> +    payload_advance32(&payload, &hole_size);
> +
> +    if (*offset + *hole_size > qiov->size) {
> +        return -EINVAL;
> +    }

Whereas here, the server sent us the right number of bytes, but with
invalid semantics (a weaker class of error than above).  Still, once we
know the server is violating protocol, we're probably wiser to hang up
than persisting on keeping the connection with the server.

We aren't checking for overlap with any previously-received chunk, or
with any previously-received error-with-offset.  I'm okay with that, as
it really is easier to implement on the client side (just because the
spec says the server is buggy for doing that does not mean we have to
spend resources in the client validating if the server is buggy).

> +
> +    qemu_iovec_memset(qiov, *offset, 0, *hole_size);
> +
> +    return 0;
> +}
> +
> +static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
> +                                   uint8_t *payload, int *request_ret)=

> +{
> +    uint32_t *error;
> +    uint16_t *message_size;
> +
> +    assert(chunk->type & (1 << 15));
> +
> +    if (chunk->length < sizeof(error) + sizeof(message_size)) {
> +        return -EINVAL;
> +    }

Again, should we plumb in the use of errp, rather than just
disconnecting from the server?

> +
> +    payload_advance32(&payload, &error);
> +    payload_advance16(&payload, &message_size);
> +
> +    error_report("%.*s", *message_size, payload);

I think this one is wrong - we definitely want to log the error message
that we got (or at least trace it), but since the chunk is in reply to a
pending request, we should be able to feed the error message to errp of
the request, rather than reporting it here and losing it.

Also, if *message_size is 0, error_report("") isn't very useful (and
right now, the simple server implementation doesn't send a message).

> +
> +    /* TODO add special case for ERROR_OFFSET */
> +
> +    *request_ret =3D nbd_errno_to_system_errno(*error);

We should validate that the server didn't send us 0 for success.

> +
> +    return 0;

So if we get here, we know we have an error, but we did the minimal
handling of it (regardless of what chunk type it has), and can resume
communication with the server.  This matches the NBD spec.

> +}
> +
> +static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
> +                                              QEMUIOVector *qiov)
> +{
> +    QEMUIOVector sub_qiov;
> +    uint64_t offset;
> +    size_t data_size;
> +    int ret;
> +    NBDStructuredReplyChunk *chunk =3D &s->reply.structured;
> +
> +    assert(nbd_reply_is_structured(&s->reply));
> +
> +    if (chunk->length < sizeof(offset)) {
> +        return -EINVAL;
> +    }
> +
> +    if (nbd_read(s->ioc, &offset, sizeof(offset), NULL) < 0) {
> +        return -EIO;

errp plumbing is missing (instead of ignoring the nbd_read() error and
relying just on our own -EIO, we should also try to preserve the
original error message).

> +    }
> +    be64_to_cpus(&offset);
> +
> +    data_size =3D chunk->length - sizeof(offset);
> +    if (offset + data_size > qiov->size) {
> +        return -EINVAL;
> +    }
> +
> +    qemu_iovec_init(&sub_qiov, qiov->niov);
> +    qemu_iovec_concat(&sub_qiov, qiov, offset, data_size);
> +    ret =3D qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov,=
 NULL);

errp plumbing again.

> +    qemu_iovec_destroy(&sub_qiov);
> +
> +    return ret < 0 ? -EIO : 0;
> +}
> +
> +#define NBD_MAX_MALLOC_PAYLOAD 1000

Feels rather arbitrary, and potentially somewhat small.  What is the
justification for this number, as opposed to reusing NBD_MAX_BUFFER_SIZE
(32M) or some other value?

Should this limit be in a .h file, next to NBD_MAX_BUFFER_SIZE?

> +static int nbd_co_receive_structured_payload(NBDClientSession *s,
> +                                             void **payload)

Documentation should mention that the result requires qemu_vfree()
instead of the more usual g_free()

> +{
> +    int ret;
> +    uint32_t len;
> +
> +    assert(nbd_reply_is_structured(&s->reply));
> +
> +    len =3D s->reply.structured.length;
> +
> +    if (len =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    if (payload =3D=3D NULL) {
> +        return -EINVAL;
> +    }

Again, missing a useful error message (the server sent us payload that
we aren't expecting) for reporting back through errp.

> +
> +    if (len > NBD_MAX_MALLOC_PAYLOAD) {
> +        return -EINVAL;
> +    }
> +
> +    *payload =3D qemu_memalign(8, len);
> +    ret =3D nbd_read(s->ioc, *payload, len, NULL);

errp plumbing

> +    if (ret < 0) {
> +        qemu_vfree(*payload);
> +        *payload =3D NULL;
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +/* nbd_co_do_receive_one_chunk
> + * for simple reply:
> + *   set request_ret to received reply error
> + *   if qiov is not NULL: read payload to @qiov
> + * for structured reply chunk:
> + *   if error chunk: read payload, set @request_ret, do not set @paylo=
ad
> + *   else if offset_data chunk: read payload data to @qiov, do not set=
 @payload
> + *   else: read payload to @payload

Mention that payload must be freed with qemu_vfree()

> + */
> +static int nbd_co_do_receive_one_chunk(NBDClientSession *s, uint64_t h=
andle,
> +                                       bool only_structured, int *requ=
est_ret,
> +                                       QEMUIOVector *qiov, void **payl=
oad)
>  {
>      int ret;
>      int i =3D HANDLE_TO_INDEX(s, handle);
> +    void *local_payload =3D NULL;
> +
> +    if (payload) {
> +        *payload =3D NULL;
> +    }
> +    *request_ret =3D 0;
> =20
>      /* Wait until we're woken up by nbd_read_reply_entry.  */
>      s->requests[i].receiving =3D true;
>      qemu_coroutine_yield();
>      s->requests[i].receiving =3D false;
>      if (!s->ioc || s->quit) {
> -        ret =3D -EIO;
> -    } else {
> -        assert(s->reply.handle =3D=3D handle);
> -        ret =3D -nbd_errno_to_system_errno(s->reply.simple.error);
> -        if (qiov && ret =3D=3D 0) {
> -            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> -                                      NULL) < 0) {

Okay, I'll admit that we are already lacking errp plumbing, so adding it
in this patch is not fair (if we add it, it can be a separate patch).

> -                ret =3D -EIO;
> -                s->quit =3D true;
> -            }
> +        return -EIO;
> +    }
> +
> +    assert(s->reply.handle =3D=3D handle);
> +
> +    if (nbd_reply_is_simple(&s->reply)) {
> +        if (only_structured) {
> +            return -EINVAL;
>          }

[1] Earlier, you checked that the server isn't sending structured
replies where we expect simple; and here you're checking that the server
isn't sending simple replies where we expect structured.  Good, we've
covered both mismatches, and I can see why you have it in separate
locations.

> =20
> -        /* Tell the read handler to read another header.  */
> -        s->reply.handle =3D 0;
> +        *request_ret =3D -nbd_errno_to_system_errno(s->reply.simple.er=
ror);
> +        if (*request_ret < 0 || !qiov) {
> +            return 0;
> +        }
> +
> +        return qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> +                                     NULL) < 0 ? -EIO : 0;
> +    }
> +
> +    /* handle structured reply chunk */
> +    assert(s->info.structured_reply);
> +
> +    if (s->reply.structured.type =3D=3D NBD_SREP_TYPE_NONE) {
> +        return 0;

We should also check that the server properly set NBD_REPLY_FLAG_DONE
(if we got this type and the flag wasn't set, the server is sending
garbage, and we should request disconnect soon). [2]

> +    }
> +
> +    if (s->reply.structured.type =3D=3D NBD_SREP_TYPE_OFFSET_DATA) {
> +        if (!qiov) {
> +            return -EINVAL;
> +        }
> +
> +        return nbd_co_receive_offset_data_payload(s, qiov);
> +    }
> +
> +    if (nbd_srep_type_is_error(s->reply.structured.type)) {
> +        payload =3D &local_payload;
> +    }
> +
> +    ret =3D nbd_co_receive_structured_payload(s, payload);
> +    if (ret < 0) {
> +        return ret;
>      }
> =20
> -    s->requests[i].coroutine =3D NULL;
> +    if (nbd_srep_type_is_error(s->reply.structured.type)) {
> +        ret =3D nbd_parse_error_payload(&s->reply.structured, local_pa=
yload,
> +                                      request_ret);
> +        qemu_vfree(local_payload);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +/* nbd_co_receive_one_chunk
> + * Read reply, wake up read_reply_co and set s->quit if needed.
> + * Return value is a fatal error code or normal nbd reply error code
> + */
> +static int nbd_co_receive_one_chunk(NBDClientSession *s, uint64_t hand=
le,

Is this function called in coroutine context?  Presumably yes, because
of the _co_ infix; but then it should also have the coroutine_fn marker
in the declaration.

> +                                    bool only_structured,
> +                                    QEMUIOVector *qiov, NBDReply *repl=
y,
> +                                    void **payload)
> +{
> +    int request_ret;
> +    int ret =3D nbd_co_do_receive_one_chunk(s, handle, only_structured=
,
> +                                          &request_ret, qiov, payload)=
;
> +
> +    if (ret < 0) {
> +        s->quit =3D true;
> +    } else {
> +        /* For assert at loop start in nbd_read_reply_entry */
> +        if (reply) {
> +            *reply =3D s->reply;
> +        }
> +        s->reply.handle =3D 0;
> +        ret =3D request_ret;
> +    }
> =20
> -    /* Kick the read_reply_co to get the next reply.  */
>      if (s->read_reply_co) {
>          aio_co_wake(s->read_reply_co);
>      }
> =20
> +    return ret;
> +}
> +
> +typedef struct NBDReplyChunkIter {
> +    int ret;
> +    bool done, only_structured;
> +} NBDReplyChunkIter;
> +
> +#define NBD_FOREACH_REPLY_CHUNK(s, iter, handle, structured, \
> +                                qiov, reply, payload) \
> +    for (iter =3D (NBDReplyChunkIter) { .only_structured =3D structure=
d }; \
> +         nbd_reply_chunk_iter_receive(s, &iter, handle, qiov, reply, p=
ayload);)
> +
> +static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
> +                                         NBDReplyChunkIter *iter,
> +                                         uint64_t handle,
> +                                         QEMUIOVector *qiov, NBDReply =
*reply,
> +                                         void **payload)
> +{
> +    int ret;
> +    NBDReply local_reply;
> +    NBDStructuredReplyChunk *chunk;
> +    if (s->quit) {
> +        if (iter->ret =3D=3D 0) {
> +            iter->ret =3D -EIO;
> +        }
> +        goto break_loop;
> +    }
> +
> +    if (iter->done) {
> +        /* Previous iteration was last. */
> +        goto break_loop;
> +    }
> +
> +    if (reply =3D=3D NULL) {
> +        reply =3D &local_reply;
> +    }
> +
> +    ret =3D nbd_co_receive_one_chunk(s, handle, iter->only_structured,=

> +                                   qiov, reply, payload);
> +    if (ret < 0 && iter->ret =3D=3D 0) {
> +        /* If it is a fatal error s->qiov is set by nbd_co_receive_one=
_chunk */

did you mean s->quit here?

> +        iter->ret =3D ret;
> +    }
> +
> +    /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple r=
eply. */
> +    if (nbd_reply_is_simple(&s->reply) || s->quit) {
> +        goto break_loop;
> +    }
> +
> +    chunk =3D &reply->structured;
> +    iter->only_structured =3D true;

Interesting observation - the NBD spec lets us return a structured error
even to a non-read command.  Only NBD_CMD_READ requires a structured
reply when we haven't yet received any reply; but you are correct that
once a given handle sees one structured chunk without a done bit, then
all future replies for that handle must also be structured.

> +
> +    if (chunk->type =3D=3D NBD_SREP_TYPE_NONE) {
> +        if (!(chunk->flags & NBD_SREP_FLAG_DONE)) {
> +            /* protocol error */
> +            s->quit =3D true;
> +            if (iter->ret =3D=3D 0) {
> +                iter->ret =3D -EIO;
> +            }

[2] Ah, I see you did it here instead!

> +        }
> +        goto break_loop;
> +    }
> +
> +    if (chunk->flags & NBD_SREP_FLAG_DONE) {
> +        /* This iteration is last. */
> +        iter->done =3D true;
> +    }
> +
> +    /* Execute the loop body */
> +    return true;
> +
> +break_loop:
> +    s->requests[HANDLE_TO_INDEX(s, handle)].coroutine =3D NULL;
> +
>      qemu_co_mutex_lock(&s->send_mutex);
>      s->in_flight--;
>      qemu_co_queue_next(&s->free_sema);
>      qemu_co_mutex_unlock(&s->send_mutex);
> =20
> -    return ret;
> +    return false;
> +}
> +
> +static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t ha=
ndle)
> +{
> +    NBDReplyChunkIter iter;
> +
> +    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, NULL, NULL) =
{
> +        /* nbd_reply_chunk_iter_receive does all the work */
> +        ;
> +    }
> +
> +    return iter.ret;
> +}
> +
> +static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t =
handle,
> +                                        QEMUIOVector *qiov)
> +{
> +    NBDReplyChunkIter iter;
> +    NBDReply reply;
> +    void *payload =3D NULL;
> +
> +    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,=

> +                            qiov, &reply, &payload)
> +    {
> +        int ret;
> +
> +        switch (reply.structured.type) {
> +        case NBD_SREP_TYPE_OFFSET_DATA:
> +            /* special cased in nbd_co_receive_one_chunk, data is alre=
ady
> +             * in qiov */
> +            break;
> +        case NBD_SREP_TYPE_OFFSET_HOLE:
> +            ret =3D nbd_parse_offset_hole_payload(&reply.structured, p=
ayload,
> +                                                qiov);
> +            if (ret < 0) {
> +                s->quit =3D true;
> +            }
> +            break;
> +        default:
> +            /* not allowed reply type */

Slightly misleading; may want to also point out that error chunks were
already captured during the foreach loop.

> +            s->quit =3D true;
> +        }
> +
> +        qemu_vfree(payload);
> +        payload =3D NULL;
> +    }
> +
> +    return iter.ret;
>  }
> =20
>  static int nbd_co_request(BlockDriverState *bs,
>                            NBDRequest *request,
> -                          QEMUIOVector *qiov)
> +                          QEMUIOVector *write_qiov)

The rename is somewhat cosmetic, but I think it reads well.

>  {
>      NBDClientSession *client =3D nbd_get_client_session(bs);
>      int ret;
> =20
> -    if (qiov) {
> -        assert(request->type =3D=3D NBD_CMD_WRITE || request->type =3D=
=3D NBD_CMD_READ);
> -        assert(request->len =3D=3D iov_size(qiov->iov, qiov->niov));
> +    assert(request->type !=3D NBD_CMD_READ);
> +    if (write_qiov) {
> +        assert(request->type =3D=3D NBD_CMD_WRITE);
> +        assert(request->len =3D=3D iov_size(write_qiov->iov, write_qio=
v->niov));
>      } else {
> -        assert(request->type !=3D NBD_CMD_WRITE && request->type !=3D =
NBD_CMD_READ);
> +        assert(request->type !=3D NBD_CMD_WRITE);
>      }
> -    ret =3D nbd_co_send_request(bs, request,
> -                              request->type =3D=3D NBD_CMD_WRITE ? qio=
v : NULL);
> +    ret =3D nbd_co_send_request(bs, request, write_qiov);
>      if (ret < 0) {
>          return ret;
>      }
> =20
> -    return nbd_co_receive_reply(client, request->handle,
> -                                request->type =3D=3D NBD_CMD_READ ? qi=
ov : NULL);
> +    return nbd_co_receive_return_code(client, request->handle);
>  }

So basically read was special enough that it no longer shares the common
code at this level.  Still, I like how you've divided things among the
various functions.

> =20
>  int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
>                           uint64_t bytes, QEMUIOVector *qiov, int flags=
)
>  {
> +    int ret;
> +    NBDClientSession *client =3D nbd_get_client_session(bs);
>      NBDRequest request =3D {
>          .type =3D NBD_CMD_READ,
>          .from =3D offset,
> @@ -259,7 +591,12 @@ int nbd_client_co_preadv(BlockDriverState *bs, uin=
t64_t offset,
>      assert(bytes <=3D NBD_MAX_BUFFER_SIZE);
>      assert(!flags);
> =20
> -    return nbd_co_request(bs, &request, qiov);
> +    ret =3D nbd_co_send_request(bs, &request, NULL);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return nbd_co_receive_cmdread_reply(client, request.handle, qiov);=

>  }
> =20

And of course, your next goal is adding a block_status function that
will also special-case chunked replies - but definitely a later patch ;)

>  int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
> diff --git a/nbd/client.c b/nbd/client.c
> index a38e1a7d8e..2f256ee771 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -687,6 +687,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const c=
har *name,
>          if (fixedNewStyle) {
>              int result;
> =20
> +            result =3D nbd_request_simple_option(ioc, NBD_OPT_STRUCTUR=
ED_REPLY,
> +                                               errp);

Bug - we must NOT request this option unless we know we can handle the
server saying yes.  When nbd-client is handling the connection, we're
fine; but when qemu-nbd is handling the connection by using ioctls to
hand off to the kernel, we MUST query the kernel to see if it supports
structured replies (well, for now, we can get by with saying that we
KNOW the kernel code has not been written yet, and therefore our query
is a constant false, but someday we'll have a future patch in that area).=


> +            if (result < 0) {
> +                goto fail;
> +            }
> +            info->structured_reply =3D result =3D=3D 1;
> +
>              /* Try NBD_OPT_GO first - if it works, we are done (it
>               * also gives us a good message if the server requires
>               * TLS).  If it is not available, fall back to
>=20

A lot to digest in this message. While I was comfortable tweaking
previous patches, and/or inserting some of my own for a v4, I think this
one is complex enough that I'd prefer it if I send 9-12 + my own
followup patches as my v4, then you rebase this one on top of that.  But
I also think you have a very promising patch here; you got a lot of
things right (even if it didn't have much in the way of comments), and
the design is looking reasonable.  Perhaps it is also worth seeing if
Paolo has review comments on this one.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JxvbBeEdHdtCE24mfasK5UIbLAhNhucvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnhJ1EACgkQp6FrSiUn
Q2p7JQgAmGR2QlDffwwcb1/uRUWifihsiJ70SkMt7LQtH2/i7ZWuOfJhnbpbfvMw
+hApYBk7Yc6y5DyevOuJMmJ20HrZXyFeqkZOy1hhmLl6FijtDOJJ3MbKxZciHUP6
X/yAIxLbjAeMODvjhduwoKAmYYNPafCbCPyKHL9rMSXHnjNU+1k0iJuRNipi85Uh
SpaLp1NAisnSiL0RUMufu81cIOz0sZXNQWxv4oXOUXBzouCpc4XSXve/iv5J81fR
3MqdxG01TN9hQoNv/KJkNTKDY7+1S1yf0Y1W98+Va+kDDB7/2PbBqtTYg2BdguhV
GoWpO38hKcZ5DCD0jbzNYhWFJ8mU/A==
=ekRA
-----END PGP SIGNATURE-----

--JxvbBeEdHdtCE24mfasK5UIbLAhNhucvu--
