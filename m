Received: from eggs.gnu.org ([2001:4830:134:3::10]:35210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e32OA-0001hj-CI
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e32O7-0005KS-1U
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:00:42 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46e3f2c3-695d-3fe2-eefb-fcbf4a2a0555@redhat.com>
Date: Fri, 13 Oct 2017 11:00:23 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="whlmfjPRK7AhmxhQTrXA3geaJUPQrMrlv"
Subject: Re: [Qemu-devel] [PATCH v3 09/13] nbd: Minimal structured read for
 server
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
--whlmfjPRK7AhmxhQTrXA3geaJUPQrMrlv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <46e3f2c3-695d-3fe2-eefb-fcbf4a2a0555@redhat.com>
Subject: Re: [PATCH v3 09/13] nbd: Minimal structured read for server
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-10-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal implementation of structured read: one structured reply chunk,
> no segmentation.
> Minimal structured error implementation: no text message.
> Support DF flag, but just ignore it, as there is no segmentation any
> way.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  33 +++++++++++++++++
>  nbd/nbd-internal.h  |   1 +
>  nbd/server.c        | 100 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
>  3 files changed, 128 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index a6df5ce8b5..dd261f66f0 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -69,6 +69,25 @@ typedef struct NBDSimpleReply {
>      uint64_t handle;
>  } QEMU_PACKED NBDSimpleReply;
> =20
> +typedef struct NBDStructuredReplyChunk {
> +    uint32_t magic;  /* NBD_STRUCTURED_REPLY_MAGIC */
> +    uint16_t flags;  /* combination of NBD_SREP_FLAG_* */

The NBD spec proposal [1] names these NBD_REPLY_FLAG_*. Your naming
NBD_SREP_FLAG_ is not bad, but consistency between the two may be
desirable; on the other hand, since this is the first implementation of
the spec, it is also a possibility that we could rewrite the NBD spec to
use your naming.

[1]
https://github.com/NetworkBlockDevice/nbd/blob/extension-blockstatus/doc/=
proto.md

> +    uint16_t type;   /* NBD_SREP_TYPE_* */

Ditto for the spec naming it NBD_REPLY_TYPE_* instead of NBD_SREP_TYPE_*.=


> +    uint64_t handle; /* request handle */
> +    uint32_t length; /* length of payload */
> +} QEMU_PACKED NBDStructuredReplyChunk;
> +
> +typedef struct NBDStructuredRead {
> +    NBDStructuredReplyChunk h;
> +    uint64_t offset;
> +} QEMU_PACKED NBDStructuredRead;

Worth a comment that this type is used with NBD_SREP_TYPE_OFFSET_DATA
(but without the additional data payload), and is also usable with
NBD_SREP_TYPE_OFFSET_HOLE (no additional payload required)?

> +
> +typedef struct NBDStructuredError {
> +    NBDStructuredReplyChunk h;
> +    uint32_t error;
> +    uint16_t message_length;
> +} QEMU_PACKED NBDStructuredError;

Worth a comment that this type is a common prefix to all
NBD_REPLY_TYPE_ERROR* chunks?

> +++ b/nbd/server.c
> @@ -98,6 +98,8 @@ struct NBDClient {
>      QTAILQ_ENTRY(NBDClient) next;
>      int nb_requests;
>      bool closing;
> +
> +    bool structured_reply;
>  };
> =20
>  /* That's all folks */
> @@ -760,6 +762,20 @@ static int nbd_negotiate_options(NBDClient *client=
, uint16_t myflags,
>                      return ret;
>                  }
>                  break;
> +
> +            case NBD_OPT_STRUCTURED_REPLY:
> +                if (client->structured_reply) {
> +                    error_setg(errp, "Double negotiation of structured=
 reply");
> +                    return -EINVAL;
> +                }

That's rather harsh, to hang up on the client without even replying.  At
the very least, we should try to be nice and tell the client about their
buggy handshake before pulling the plug; or we could be generous and
ignore the request as a no-op (by returning success again).  The spec is
currently silent on whether we have to silently tolerate this condition
or if we can reply with an error; but I would lean towards updating the
spec to permit a reply of NBD_REP_ERR_INVALID in this situation.  I can
tweak the code along those lines.

Writing this makes me remember another thing.  I know that nbdkit has a
finite limit on the number of NBD_OPT_* it is willing to accept from a
client before it kills the connection on the grounds that a client that
doesn't eventually move into transmission phase is more likely trying to
act as a denial of service by consuming server CPU - maybe we should
consider a followup patch to qemu to do likewise, so that an infinite
string of NBD_OPT_STRUCTURED_REPLY doesn't let us spin forever with a
client that got stuck sending the same option.

> @@ -1233,6 +1249,61 @@ static int nbd_co_send_simple_reply(NBDClient *c=
lient,
>      return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
>  }
> =20
> +static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16=
_t flags,
> +                                uint16_t type, uint64_t handle, uint32=
_t length)
> +{

Might be nice to place this function near set_be_simple_reply(),

> +
> +static inline int coroutine_fn nbd_co_send_buf(NBDClient *client, void=
 *buf,
> +                                               size_t size, Error **er=
rp)
> +{
> +    struct iovec iov[] =3D {
> +        {.iov_base =3D buf, .iov_len =3D size}
> +    };
> +
> +    return nbd_co_send_iov(client, iov, 1, errp);
> +}

and to place this near nbd_co_send_iov().  But see below, at [1]

> +
> +static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,=

> +                                                    uint64_t handle,
> +                                                    uint64_t offset,
> +                                                    void *data,
> +                                                    size_t size,
> +                                                    Error **errp)
> +{
> +    NBDStructuredRead chunk;
> +    struct iovec iov[] =3D {
> +        {.iov_base =3D &chunk, .iov_len =3D sizeof(chunk)},
> +        {.iov_base =3D data, .iov_len =3D size}
> +    };
> +
> +    set_be_chunk(&chunk.h, NBD_SREP_FLAG_DONE, NBD_SREP_TYPE_OFFSET_DA=
TA,
> +                 handle, sizeof(chunk) - sizeof(chunk.h) + size);
> +    stq_be_p(&chunk.offset, offset);

This is indeed a bare minimum implementation (it doesn't try to
recognize holes at all) - but that's reasonable for the first cut. We
can add hole support on top as later patches.

> +
> +    return nbd_co_send_iov(client, iov, 2, errp);
> +}
> +
> +static int coroutine_fn nbd_co_send_structured_error(NBDClient *client=
,
> +                                                     uint64_t handle,
> +                                                     uint32_t error,
> +                                                     Error **errp)

It would be trivial to support a human-readable error message as a const
char * parameter. But I'm also okay doing that as a followup patch.

> +{
> +    NBDStructuredError chunk;
> +
> +    set_be_chunk(&chunk.h, NBD_SREP_FLAG_DONE, NBD_SREP_TYPE_ERROR, ha=
ndle,
> +                 sizeof(chunk) - sizeof(chunk.h));
> +    stl_be_p(&chunk.error, error);

We could get away with assert(error), to prove our server is following sp=
ec.

Ouch - I don't think you converted the host errno to the NBD wire value
at any point along the chain.  You also lack a trace message for
anything sent by these two new functions.  Those belong in this patch.

> +    stw_be_p(&chunk.message_length, 0);
> +
> +    return nbd_co_send_buf(client, &chunk, sizeof(chunk), errp);

[1] If we send an optional human-readable message, then we have to use
nbd_co_send_iov anyways; at which point, we have no clients of
nbd_co_send_buf.  If I do a followup that adds the error message, then
it feels like churn if I have to delete something added here; so maybe
the best course is for this patch to just drop the helper function, and
inline nbd_co_send_buf()'s actions here, to make the followup patch
easier to write.

> @@ -1304,10 +1375,17 @@ static int nbd_co_receive_request(NBDRequestDat=
a *req, NBDRequest *request,
>                     (uint64_t)client->exp->size);
>          return request->type =3D=3D NBD_CMD_WRITE ? -ENOSPC : -EINVAL;=

>      }
> -    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE)) {=

> +    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE |
> +                           NBD_CMD_FLAG_DF))

This says we accept the client sending NBD_CMD_FLAG_DF, but where did we
advertise it?  I see no reason to advertise it unless a client
negotiates structured replies, at which point the obvious place to set
it is when we reply to the negotiation (and NBD_OPT_INFO prior to that
point won't see the flag, but the NBD_OPT_GO will see it).

> @@ -1374,7 +1452,6 @@ static coroutine_fn void nbd_trip(void *opaque)
>          }
> =20
>          reply_data_len =3D request.len;
> -
>          break;

Spurious whitespace change hunk.

So, here's what I'm squashing, before adding:

Reviewed-by: Eric Blake <eblake@redhat.com>

diff --git i/include/block/nbd.h w/include/block/nbd.h
index dd261f66f0..f1b8c28f58 100644
--- i/include/block/nbd.h
+++ w/include/block/nbd.h
@@ -69,6 +69,7 @@ typedef struct NBDSimpleReply {
     uint64_t handle;
 } QEMU_PACKED NBDSimpleReply;

+/* Header of all structured replies */
 typedef struct NBDStructuredReplyChunk {
     uint32_t magic;  /* NBD_STRUCTURED_REPLY_MAGIC */
     uint16_t flags;  /* combination of NBD_SREP_FLAG_* */
@@ -77,11 +78,13 @@ typedef struct NBDStructuredReplyChunk {
     uint32_t length; /* length of payload */
 } QEMU_PACKED NBDStructuredReplyChunk;

+/* Header of NBD_SREP_TYPE_OFFSET_DATA, complete
NBD_SREP_TYPE_OFFSET_HOLE */
 typedef struct NBDStructuredRead {
     NBDStructuredReplyChunk h;
     uint64_t offset;
 } QEMU_PACKED NBDStructuredRead;

+/* Header of all NBD_SREP_TYPE_ERROR* errors */
 typedef struct NBDStructuredError {
     NBDStructuredReplyChunk h;
     uint32_t error;
diff --git i/nbd/server.c w/nbd/server.c
index e55825cc91..b4966ed8b1 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -765,15 +765,18 @@ static int nbd_negotiate_options(NBDClient
*client, uint16_t myflags,

             case NBD_OPT_STRUCTURED_REPLY:
                 if (client->structured_reply) {
-                    error_setg(errp, "Double negotiation of structured
reply");
-                    return -EINVAL;
+                    ret =3D nbd_negotiate_send_rep_err(
+                        client->ioc, NBD_REP_ERR_INVALID, option, errp,
+                        "structured reply already negotiated");
+                } else {
+                    ret =3D nbd_negotiate_send_rep(client->ioc, NBD_REP_=
ACK,
+                                                 option, errp);
                 }
-                ret =3D nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,=

option,
-                                             errp);
                 if (ret < 0) {
                     return ret;
                 }
                 client->structured_reply =3D true;
+                myflags |=3D NBD_CMD_FLAG_DF;
                 break;

             default:
@@ -1259,16 +1262,6 @@ static inline void
set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
     stl_be_p(&chunk->length, length);
 }

-static inline int coroutine_fn nbd_co_send_buf(NBDClient *client, void
*buf,
-                                               size_t size, Error **errp=
)
-{
-    struct iovec iov[] =3D {
-        {.iov_base =3D buf, .iov_len =3D size}
-    };
-
-    return nbd_co_send_iov(client, iov, 1, errp);
-}
-
 static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
                                                     uint64_t handle,
                                                     uint64_t offset,
@@ -1282,6 +1275,7 @@ static int coroutine_fn
nbd_co_send_structured_read(NBDClient *client,
         {.iov_base =3D data, .iov_len =3D size}
     };

+    trace_nbd_co_send_structured_read(handle, offset, data, size);
     set_be_chunk(&chunk.h, NBD_SREP_FLAG_DONE, NBD_SREP_TYPE_OFFSET_DATA=
,
                  handle, sizeof(chunk) - sizeof(chunk.h) + size);
     stq_be_p(&chunk.offset, offset);
@@ -1295,13 +1289,20 @@ static int coroutine_fn
nbd_co_send_structured_error(NBDClient *client,
                                                      Error **errp)
 {
     NBDStructuredError chunk;
+    int nbd_err =3D system_errno_to_nbd_errno(error);
+    struct iovec iov[] =3D {
+        {.iov_base =3D &chunk, .iov_len =3D sizeof(chunk)},
+        /* FIXME: Support human-readable error message */
+    };

+    assert(nbd_err);
+    trace_nbd_co_send_structured_error(handle, nbd_err);
     set_be_chunk(&chunk.h, NBD_SREP_FLAG_DONE, NBD_SREP_TYPE_ERROR, hand=
le,
                  sizeof(chunk) - sizeof(chunk.h));
-    stl_be_p(&chunk.error, error);
+    stl_be_p(&chunk.error, nbd_err);
     stw_be_p(&chunk.message_length, 0);

-    return nbd_co_send_buf(client, &chunk, sizeof(chunk), errp);
+    return nbd_co_send_iov(client, iov, 1, errp);
 }

 /* nbd_co_receive_request
@@ -1452,6 +1453,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         }

         reply_data_len =3D request.len;
+
         break;
     case NBD_CMD_WRITE:
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
diff --git i/nbd/trace-events w/nbd/trace-events
index e27614f050..0d7c3b4887 100644
--- i/nbd/trace-events
+++ w/nbd/trace-events
@@ -54,6 +54,8 @@ nbd_receive_request(uint32_t magic, uint16_t flags,
uint16_t type, uint64_t from
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching
clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching
clients from AIO context %p\n"
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, int len)
"Send simple reply: handle =3D %" PRIu64 ", error =3D %" PRIu32 ", len =3D=
 %d"
+nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void
*data, size_t size) "Send structured read data reply: handle =3D %" PRIu6=
4
", offset =3D %" PRIu64 ", data =3D %p, len =3D %zu"
+nbd_co_send_structured_error(uint64_t handle, int err) "Send structured
error reply: handle =3D %" PRIu64 ", error =3D %d"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type,
const char *name) "Decoding type: handle =3D %" PRIu64 ", type =3D %" PRI=
u16
" (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len)
"Payload received: handle =3D %" PRIu64 ", len =3D %" PRIu32
 nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 "
byte(s)"



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--whlmfjPRK7AhmxhQTrXA3geaJUPQrMrlv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlng4xcACgkQp6FrSiUn
Q2pfzwf9FXUQoBcKqUXsuQRyp9NB0Ddx7bsO8YejHskbZ52Fb5ej5LAjKJpNlEd/
LXuDtKmXaA1tlbbwQcnFbWsTX7jWj2GBEpQ4AtQhpKqeer0JsVzslECofyq0AuLz
tIosC061lrNLARiBDfW8vLfMcSy8fdZ3SlVSIGehynKWSoEfafEPJXr4xJs0/WEu
3/VhjudKQwRbEZLUIQOpIx1TOT7hEHdczd55QzXenBVWqKYj2Ta/1FHSCi9dY/jw
tJf0CASwtUVz5Wqix+tpboItVmf9gn1IeBodhEcR975o+q70cpgCnio9KB3gSaAH
IGkEj56S1kNewHuc6zb7pvX3LWZRhw==
=eb7S
-----END PGP SIGNATURE-----

--whlmfjPRK7AhmxhQTrXA3geaJUPQrMrlv--
