Received: from eggs.gnu.org ([209.51.188.92]:37688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXm-0001ms-86
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXi-0007Jz-4V
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  8 Apr 2019 14:02:31 -0500
Message-Id: <20190408190233.10321-3-eblake@redhat.com>
In-Reply-To: <20190408190233.10321-1-eblake@redhat.com>
References: <20190408190233.10321-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] nbd/server: Trace client noncompliance on
 unaligned requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

We've recently added traces for clients to flag server non-compliance;
let's do the same for servers to flag client non-compliance. According
to the spec, if the client requests NBD_INFO_BLOCK_SIZE, it is
promising to send all requests aligned to those boundaries.  Of
course, if the client does not request NBD_INFO_BLOCK_SIZE, then it
made no promises so we shouldn't flag anything; and because we are
willing to handle clients that made no promises (the spec allows us to
use NBD_REP_ERR_BLOCK_SIZE_REQD if we had been unwilling), we already
have to handle unaligned requests (which the block layer already does
on our behalf).  So even though the spec allows us to return EINVAL
for clients that promised to behave, it's easier to always answer
unaligned requests.  Still, flagging non-compliance can be useful in
debugging a client that is trying to be maximally portable.

Qemu as client used to have one spot where it sent non-compliant
requests: if the server sends an unaligned reply to
NBD_CMD_BLOCK_STATUS, and the client was iterating over the entire
disk, the next request would start at that unaligned point; this was
fixed in commit a39286dd when the client was taught to work around
server non-compliance; but is equally fixed if the server is patched
to not send unaligned replies in the first place (yes, qemu 4.0 as
server still has few such bugs, although they will be patched in
4.1). Fortunately, I did not find any more spots where qemu as client
was non-compliant. I was able to test the patch by using the following
hack to convince qemu-io to run various unaligned commands, coupled
with serving 512-byte alignment by intentionally omitting '-f raw' on
the server while viewing server traces.

| diff --git i/nbd/client.c w/nbd/client.c
| index 427980bdd22..1858b2aac35 100644
| --- i/nbd/client.c
| +++ w/nbd/client.c
| @@ -449,6 +449,7 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint=
32_t opt,
|                  nbd_send_opt_abort(ioc);
|                  return -1;
|              }
| +            info->min_block =3D 1;//hack
|              if (!is_power_of_2(info->min_block)) {
|                  error_setg(errp, "server minimum block size %" PRIu32
|                             " is not a power of two", info->min_block);

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190403030526.12258-3-eblake@redhat.com>
[eblake: address minor review nits]
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c     | 17 ++++++++++++++++-
 nbd/trace-events |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 1b8c8619896..1c4c5474ad4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -124,6 +124,8 @@ struct NBDClient {
     int nb_requests;
     bool closing;

+    uint32_t check_align; /* If non-zero, check for aligned client reque=
sts */
+
     bool structured_reply;
     NBDExportMetaContexts export_meta;

@@ -533,6 +535,7 @@ static int nbd_negotiate_handle_info(NBDClient *clien=
t, uint16_t myflags,
     bool blocksize =3D false;
     uint32_t sizes[3];
     char buf[sizeof(uint64_t) + sizeof(uint16_t)];
+    uint32_t check_align =3D 0;

     /* Client sends:
         4 bytes: L, name length (can be 0)
@@ -609,7 +612,7 @@ static int nbd_negotiate_handle_info(NBDClient *clien=
t, uint16_t myflags,
      * whether this is OPT_INFO or OPT_GO. */
     /* minimum - 1 for back-compat, or actual if client will obey it. */
     if (client->opt =3D=3D NBD_OPT_INFO || blocksize) {
-        sizes[0] =3D blk_get_request_alignment(exp->blk);
+        check_align =3D sizes[0] =3D blk_get_request_alignment(exp->blk)=
;
     } else {
         sizes[0] =3D 1;
     }
@@ -660,6 +663,7 @@ static int nbd_negotiate_handle_info(NBDClient *clien=
t, uint16_t myflags,

     if (client->opt =3D=3D NBD_OPT_GO) {
         client->exp =3D exp;
+        client->check_align =3D check_align;
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
         nbd_export_get(client->exp);
         nbd_check_meta_export(client);
@@ -2126,6 +2130,17 @@ static int nbd_co_receive_request(NBDRequestData *=
req, NBDRequest *request,
         return (request->type =3D=3D NBD_CMD_WRITE ||
                 request->type =3D=3D NBD_CMD_WRITE_ZEROES) ? -ENOSPC : -=
EINVAL;
     }
+    if (client->check_align && !QEMU_IS_ALIGNED(request->from | request-=
>len,
+                                                client->check_align)) {
+        /*
+         * The block layer gracefully handles unaligned requests, but
+         * it's still worth tracing client non-compliance
+         */
+        trace_nbd_co_receive_align_compliance(nbd_cmd_lookup(request->ty=
pe),
+                                              request->from,
+                                              request->len,
+                                              client->check_align);
+    }
     valid_flags =3D NBD_CMD_FLAG_FUA;
     if (request->type =3D=3D NBD_CMD_READ && client->structured_reply) {
         valid_flags |=3D NBD_CMD_FLAG_DF;
diff --git a/nbd/trace-events b/nbd/trace-events
index a6cca8fdf83..7ab6b3788cb 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -71,4 +71,5 @@ nbd_co_send_extents(uint64_t handle, unsigned int exten=
ts, uint32_t id, uint64_t
 nbd_co_send_structured_error(uint64_t handle, int err, const char *errna=
me, const char *msg) "Send structured error reply: handle =3D %" PRIu64 "=
, error =3D %d (%s), msg =3D '%s'"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const=
 char *name) "Decoding type: handle =3D %" PRIu64 ", type =3D %" PRIu16 "=
 (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "=
Payload received: handle =3D %" PRIu64 ", len =3D %" PRIu32
+nbd_co_receive_align_compliance(const char *op, uint64_t from, uint32_t =
len, uint32_t align) "client sent non-compliant unaligned %s request: fro=
m=3D0x%" PRIx64 ", len=3D0x%" PRIx32 ", align=3D0x%" PRIx32
 nbd_trip(void) "Reading request"
--=20
2.20.1
