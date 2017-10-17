Received: from eggs.gnu.org ([2001:4830:134:3::10]:39562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4ZFI-0001Vv-PE
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4ZFG-00074o-6f
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:17:52 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171017125710.11626-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7480d774-569e-9b43-8f0c-7b3b4d9bfbf0@redhat.com>
Date: Tue, 17 Oct 2017 16:17:37 -0500
MIME-Version: 1.0
In-Reply-To: <20171017125710.11626-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j8BMSqONKrFxhrTgXu8Fi6Qd4WIQqVQtU"
Subject: Re: [Qemu-devel] [PATCH v4 RFC 9/8] nbd: Minimal structured read
 for client
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
--j8BMSqONKrFxhrTgXu8Fi6Qd4WIQqVQtU
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <7480d774-569e-9b43-8f0c-7b3b4d9bfbf0@redhat.com>
Subject: Re: [PATCH v4 RFC 9/8] nbd: Minimal structured read for client
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171017125710.11626-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171017125710.11626-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 07:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal implementation: for structured error only error_report error
> message.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20

>=20
> RFC: I don't like resulting error handling: it is rather confusing,
>     requires a lot of definitions of "local_err" which looks bad. Propa=
gating,
>     setting error and then drop it for errp=3DNULL case - all it looks =
not
>     very effective. Any ideas?

As long as the function you call has a sane return value that can easily
be used to tell if you had an error or not, you can often use that to
pass errp through the call, rather than needing a local_err and
error_propagate().  I'll see if I can spot such places during my review.

>  include/block/nbd.h |  12 ++
>  nbd/nbd-internal.h  |   1 -
>  block/nbd-client.c  | 483 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
>  nbd/client.c        |  10 ++
>  4 files changed, 474 insertions(+), 32 deletions(-)

Feels like a big patch.  Of course, we can't enable the client
requesting structured replies until all the pieces are in place
(otherwise, it becomes difficult to bisect a broken client against a
working server); but it may be possible to split this patch into smaller
pieces if it would aid review.  That said, I'm fine keeping it as one
big patch, if I don't see too much that needs tweaking.

First, before I review anything, a quick check, with this patch applied:

Server:
$ ./qemu-nbd -x foo -f qcow2 --trace=3D'nbd_*' file -r

Client:
$ ./qemu-io -f raw nbd://localhost:10809/foo --trace=3D'nbd_*'

Looking at the trace, the negotiation succeeds (yay!).

But in the client, I then perform 'w 0 0' (a zero-byte write, which
should fail because the server is read-only).  I see:

C: 19481@1508268433.381446:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 0, .handle =3D 93997172956880, .flags =3D 0x1, .t=
ype =3D 1
(write) }
S: 19479@1508268433.381516:nbd_receive_request Got request: { magic =3D
0x25609513, .flags =3D 0x1, .type =3D 0x1, from =3D 0, len =3D 0 }
S: 19479@1508268433.381527:nbd_co_receive_request_decode_type Decoding
type: handle =3D 93997172956880, type =3D 1 (write)
S: 19479@1508268433.381540:nbd_co_receive_request_payload_received
Payload received: handle =3D 93997172956880, len =3D 0
S: 19479@1508268433.381564:nbd_co_send_structured_error Send structured
error reply: handle =3D 93997172956880, error =3D 1 (EPERM), msg =3D ''
C: 19481@1508268433.381622:nbd_receive_structured_reply_chunk Got
structured reply chunk: { flags =3D 0x1, type =3D 32769, handle =3D
93997172956880, length =3D 6 }
C: wrote 0/0 bytes at offset 0
C: 0 bytes, 1 ops; 0.0002 sec (0 bytes/sec and 4291.8455 ops/sec)

Oops - the client claimed success, even though the server replied with
EPERM.  And the server didn't do a good job of including details on the
error message.  So there's still some tweaks needed.



> @@ -181,75 +181,486 @@ err:
>      return rc;
>  }
> =20
> -static int nbd_co_receive_reply(NBDClientSession *s,
> -                                uint64_t handle,
> -                                QEMUIOVector *qiov)
> +static inline uint16_t payload_advance16(uint8_t **payload)
> +{
> +    *payload +=3D 2;
> +    return lduw_be_p(*payload - 2);

Correct - loads a 16-bit unsigned quantity.

> +}
> +
> +static inline uint32_t payload_advance32(uint8_t **payload)
> +{
> +    *payload +=3D 4;
> +    return lduw_be_p(*payload - 4);

Oops, you want ldl_be_p(), to load a 32-bit quantity (sign not relevant).=


> +}
> +
> +static inline uint64_t payload_advance64(uint8_t **payload)
> +{
> +    *payload +=3D 8;
> +    return lduw_be_p(*payload - 8);

Oops, you want ldq_be_p(), to load a 64-bit quantity.  Peter's pending
patch "[PATCH v4] docs/devel/loads-stores.rst: Document our various load
and store APIs" goes into more details on which load/store routines to
use when.

> +
> +static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
> +                                              QEMUIOVector *qiov, Erro=
r **errp)
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
> +        error_setg(errp, "Protocol error: invalid payload for "
> +                         "NBD_REPLY_TYPE_OFFSET_DATA");
> +        return -EINVAL;
> +    }
> +
> +    if (nbd_read(s->ioc, &offset, sizeof(offset), errp) < 0) {
> +        return -EIO;
> +    }
> +    be64_to_cpus(&offset);
> +
> +    data_size =3D chunk->length - sizeof(offset);
> +    if (offset + data_size > qiov->size) {

Arithmetic overflow is possible here; it's safer to write:

if (offset > qiov->size - data_size)

Similar for hole_size earlier.

> +
> +#define NBD_MAX_MALLOC_PAYLOAD 1000
> +/* nbd_co_receive_structured_payload
> + * The resulting pointer stored in @payload requires qemu_vfree() to f=
ree it.
> + */
> +static coroutine_fn int nbd_co_receive_structured_payload(
> +        NBDClientSession *s, void **payload, Error **errp)
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

Should we assign *payload to NULL even on this short-circuit (if payload
itself is non-NULL)?  Oh, you do this in the caller [1]

> +
> +    if (payload =3D=3D NULL) {
> +        error_setg(errp, "Unexpected structured payload");
> +        return -EINVAL;
> +    }
> +
> +    if (len > NBD_MAX_MALLOC_PAYLOAD) {
> +        error_setg(errp, "Too large payload");

Grammar: Payload too large

> +        return -EINVAL;
> +    }
> +
> +    *payload =3D qemu_memalign(8, len);

Why are we bothering to read this into memalign'ed memory, seeing as how
it is packed data, and more likely than not, we will NOT be benefitting
from the alignment?  Can we get by with simpler g_new()/g_free()?

> +    ret =3D nbd_read(s->ioc, *payload, len, errp);
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
> + *
> + * The pointer stored in @payload requires qemu_vfree() to free it.
> + * If function fails @errp containts corresponding error message. If f=
unction

s/containts/contains/

> + * doesn't fail but reply contains error @request_ret is set to corres=
ponding
> + * return code and errp is set to corresponding error message.

Hmm, that feels awkward - if errp can be set even when the function does
not return a negative value, then it's tougher to tell failures apart.

> + */
> +static coroutine_fn int nbd_co_do_receive_one_chunk(
> +        NBDClientSession *s, uint64_t handle, bool only_structured,
> +        int *request_ret, QEMUIOVector *qiov, void **payload, Error **=
errp)
>  {
>      int ret;
>      int i =3D HANDLE_TO_INDEX(s, handle);
> +    void *local_payload =3D NULL;
> +    NBDStructuredReplyChunk *chunk;
> +
> +    if (payload) {
> +        *payload =3D NULL;
> +    }

[1] answer to my question above.

> +
> +/* nbd_co_receive_one_chunk
> + * Read reply, wake up read_reply_co and set s->quit if needed.
> + * Return value is a fatal error code or normal nbd reply error code
> + *
> + * The pointer stored in @payload requires qemu_vfree() to free it.
> + */
> +static coroutine_fn int nbd_co_receive_one_chunk(
> +        NBDClientSession *s, uint64_t handle, bool only_structured,
> +        QEMUIOVector *qiov, NBDReply *reply, void **payload, Error **e=
rrp)
> +{
> +    int request_ret;
> +    int ret =3D nbd_co_do_receive_one_chunk(s, handle, only_structured=
,
> +                                          &request_ret, qiov, payload,=
 errp);
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

Some things are a bit harder to test as long as our only working server
is currently hardcoded to send exactly one chunk per message; but that's
part of the testing I plan to do in the next couple of days (even if I
end up using gdb to fake packet sequences rather than actually coding a
more-complete server).

> =20
> +    return ret;
> +}
> +
> +typedef struct NBDReplyChunkIter {
> +    int ret;
> +    Error *err;
> +    bool done, only_structured;
> +} NBDReplyChunkIter;
> +
> +static void nbd_iter_error(NBDReplyChunkIter *iter, bool fatal,
> +                           int ret, Error **local_err)
> +{
> +    assert(ret < 0);
> +
> +    if (fatal || iter->ret =3D=3D 0) {
> +        if (iter->ret !=3D 0) {
> +            error_free(iter->err);
> +            iter->err =3D NULL;
> +        }
> +        iter->ret =3D ret;
> +        error_propagate(&iter->err, *local_err);

error_propagate() can be safely called more than once (only the first
call sets an error).  I guess what you're trying to do here is that if
the server sends more than one error chunk, you favor that message; but
if we fail to communicate with the server, that takes even higher priorit=
y.

> +    } else {
> +        error_free(*local_err);
> +    }
> +
> +    *local_err =3D NULL;
> +}
> +
> +/* NBD_FOREACH_REPLY_CHUNK
> + * The pointer stored in @payload requires qemu_vfree() to free it.
> + */
> +#define NBD_FOREACH_REPLY_CHUNK(s, iter, handle, structured, \
> +                                qiov, reply, payload) \
> +    for (iter =3D (NBDReplyChunkIter) { .only_structured =3D structure=
d }; \
> +         nbd_reply_chunk_iter_receive(s, &iter, handle, qiov, reply, p=
ayload);)
> +
> +/* nbd_reply_chunk_iter_receive
> + * The pointer stored in @payload requires qemu_vfree() to free it.
> + */

Maybe worth a comment documenting the return value?  Although it is
somewhat mentioned below [2]

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
> +    Error *local_err =3D NULL;
> +    if (s->quit) {
> +        error_setg(&local_err, "Connection closed");
> +        nbd_iter_error(iter, true, -EIO, &local_err);
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

> +                                   qiov, reply, payload, &local_err);
> +    if (ret < 0) {
> +        /* If it is a fatal error s->quit is set by nbd_co_receive_one=
_chunk */
> +        nbd_iter_error(iter, s->quit, ret, &local_err);
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
> +
> +    if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
> +        /* NBD_REPLY_FLAG_DONE is already checked in nbd_co_receive_on=
e_chunk */
> +        assert(chunk->flags & NBD_REPLY_FLAG_DONE);
> +        goto break_loop;
> +    }
> +
> +    if (chunk->flags & NBD_REPLY_FLAG_DONE) {
> +        /* This iteration is last. */
> +        iter->done =3D true;
> +    }
> +
> +    /* Execute the loop body */
> +    return true;
> +

[2]

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
>  }
> =20
> -static int nbd_co_request(BlockDriverState *bs,
> -                          NBDRequest *request,
> -                          QEMUIOVector *qiov)
> +static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t ha=
ndle,
> +                                      Error **errp)
> +{
> +    NBDReplyChunkIter iter;
> +
> +    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, NULL, NULL) =
{
> +        /* nbd_reply_chunk_iter_receive does all the work */
> +        ;

Do we need the empty ';'?  {} is a valid loop body.

> +    }
> +
> +    error_propagate(errp, iter.err);
> +    return iter.ret;
> +}
> +
> +static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t =
handle,
> +                                        QEMUIOVector *qiov, Error **er=
rp)
> +{
> +    NBDReplyChunkIter iter;
> +    NBDReply reply;
> +    void *payload =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,=

> +                            qiov, &reply, &payload)
> +    {
> +        int ret;
> +        NBDStructuredReplyChunk *chunk =3D &reply.structured;
> +
> +        assert(nbd_reply_is_structured(&reply));
> +
> +        switch (chunk->type) {
> +        case NBD_REPLY_TYPE_OFFSET_DATA:
> +            /* special cased in nbd_co_receive_one_chunk, data is alre=
ady
> +             * in qiov */
> +            break;
> +        case NBD_REPLY_TYPE_OFFSET_HOLE:
> +            ret =3D nbd_parse_offset_hole_payload(&reply.structured, p=
ayload,
> +                                                qiov, &local_err);
> +            if (ret < 0) {
> +                s->quit =3D true;
> +                nbd_iter_error(&iter, true, ret, &local_err);
> +            }
> +            break;
> +        default:
> +            if (!nbd_reply_type_is_error(chunk->type)) {
> +                /* not allowed reply type */
> +                s->quit =3D true;
> +                error_setg(&local_err,
> +                           "Unexpected reply type: %d (%s) for CMD_REA=
D",
> +                           chunk->type, nbd_reply_type_lookup(chunk->t=
ype));
> +                nbd_iter_error(&iter, true, -EINVAL, &local_err);

This feels a bit like action at a difference - breaking out of the loop
but making sure the loop still tracks the right error.  But I'm not
immediately seeing if it is safe to directly use 'return' here instead.

> +            }
> +        }
> +
> +        qemu_vfree(payload);
> +        payload =3D NULL;
> +    }
> +
> +    error_propagate(errp, iter.err);
> +    return iter.ret;
> +}
> +
> +static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
> +                          QEMUIOVector *write_qiov)
>  {
> -    NBDClientSession *client =3D nbd_get_client_session(bs);
>      int ret;
> +    Error *local_err =3D NULL;
> +    NBDClientSession *client =3D nbd_get_client_session(bs);
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

If we have to respin things, wiring up errp handling to existing calls
prior to adding structured reply handling would probably be worth
splitting the patch.

>      if (ret < 0) {
>          return ret;
>      }
> =20
> -    return nbd_co_receive_reply(client, request->handle,
> -                                request->type =3D=3D NBD_CMD_READ ? qi=
ov : NULL);
> +    ret =3D nbd_co_receive_return_code(client, request->handle, &local=
_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>  }
> =20
>  int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
>                           uint64_t bytes, QEMUIOVector *qiov, int flags=
)
>  {
> +    int ret;
> +    Error *local_err =3D NULL;
> +    NBDClientSession *client =3D nbd_get_client_session(bs);
>      NBDRequest request =3D {
>          .type =3D NBD_CMD_READ,
>          .from =3D offset,
> @@ -259,7 +670,16 @@ int nbd_client_co_preadv(BlockDriverState *bs, uin=
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
> +    ret =3D nbd_co_receive_cmdread_reply(client, request.handle, qiov,=
 &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>  }
> =20
>  int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
> @@ -381,6 +801,7 @@ int nbd_client_init(BlockDriverState *bs,
>      qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
> =20
>      client->info.request_sizes =3D true;
> +    client->info.structured_reply =3D true;
>      ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
>                                  tlscreds, hostname,
>                                  &client->ioc, &client->info, errp);
> diff --git a/nbd/client.c b/nbd/client.c
> index eeb23ae934..0297484264 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -684,6 +684,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const c=
har *name,
>          if (fixedNewStyle) {
>              int result;
> =20
> +            if (info->structured_reply) {
> +                result =3D nbd_request_simple_option(ioc,
> +                                                   NBD_OPT_STRUCTURED_=
REPLY,
> +                                                   errp);
> +                if (result < 0) {
> +                    goto fail;
> +                }
> +                info->structured_reply =3D result =3D=3D 1;
> +            }

Looks like the handshake is handled correctly.

> +
>              /* Try NBD_OPT_GO first - if it works, we are done (it
>               * also gives us a good message if the server requires
>               * TLS).  If it is not available, fall back to
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--j8BMSqONKrFxhrTgXu8Fi6Qd4WIQqVQtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnmc3EACgkQp6FrSiUn
Q2r2iwgAl+UdoPVHAH1QKKoK6moscii5JSmn0egIMRUtF28B5hO3oFPL/iTy7RqJ
biPDIydZDnKOkBpAEnP86XjwtYm001vH0q9J9FSfe/oqagy3gw6p0GvAJCu9oTfz
Tj3axN9hlVlgqqtdpIy6f9eOQxAPiajAkBNBbN/pf+EY2j1VE+U3mydAIXXspWPR
Y1ECbI75QlPI8Rcy6U4E2E8jt6V/6km4qho4A0S39cS8dscXDuZc7xsw0GrCQy3P
W4I+7dZzeL8EE/omM6P32qsySVqnrVEMqNJu5/Z2ah71VSoPKJq5+Oo+NMMSD09l
1jbx+D5gARj7iu8YfAkiuIXOD1f99Q==
=eIJG
-----END PGP SIGNATURE-----

--j8BMSqONKrFxhrTgXu8Fi6Qd4WIQqVQtU--
