Received: from eggs.gnu.org ([209.51.188.92]:41716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDb-0000H5-55
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDZ-000562-Np
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  2 Apr 2019 22:05:21 -0500
Message-Id: <20190403030526.12258-3-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-1-eblake@redhat.com>
References: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/7] nbd/server: Trace server noncompliance on
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
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

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
to not send unaligned replies in the first place (the next few patches
will address that). Fortunately, I did not find any more spots where
qemu as client was non-compliant. I was able to test the patch by
using the following hack to convince qemu-io to run various unaligned
commands, coupled with serving 512-byte alignment by intentionally
omitting '-f raw' on the server while viewing server traces.

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
---
 nbd/server.c     | 12 ++++++++++++
 nbd/trace-events |  1 +
 2 files changed, 13 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 1b8c8619896..3040ceb5606 100644
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

@@ -660,6 +662,8 @@ static int nbd_negotiate_handle_info(NBDClient *clien=
t, uint16_t myflags,

     if (client->opt =3D=3D NBD_OPT_GO) {
         client->exp =3D exp;
+        client->check_align =3D blocksize ?
+            blk_get_request_alignment(exp->blk) : 0;
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
         nbd_export_get(client->exp);
         nbd_check_meta_export(client);
@@ -2126,6 +2130,14 @@ static int nbd_co_receive_request(NBDRequestData *=
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
pe));
+    }
     valid_flags =3D NBD_CMD_FLAG_FUA;
     if (request->type =3D=3D NBD_CMD_READ && client->structured_reply) {
         valid_flags |=3D NBD_CMD_FLAG_DF;
diff --git a/nbd/trace-events b/nbd/trace-events
index a6cca8fdf83..87a2b896c35 100644
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
+nbd_co_receive_align_compliance(const char *op) "client sent non-complia=
nt unaligned %s request"
 nbd_trip(void) "Reading request"
--=20
2.20.1
