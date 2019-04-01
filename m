Received: from eggs.gnu.org ([209.51.188.92]:45786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcf-0001v4-Gb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxce-0004jJ-Cv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:53 -0500
Message-Id: <20190401140903.19186-5-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/14] nbd: Permit simple error to
 NBD_CMD_BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec is clear that when structured replies are active, a
simple error reply is acceptable to any command except for
NBD_CMD_READ.  However, we were mistakenly requiring structured errors
for NBD_CMD_BLOCK_STATUS, and hanging up on a server that gave a
simple error (since qemu does not behave as such a server, we didn't
notice the problem until now).  Broken since its introduction in
commit 78a33ab5 (v2.12).

Noticed while debugging a separate failure reported by nbdkit while
working out its initial implementation of BLOCK_STATUS, although it
turns out that nbdkit also chose to send structured error replies for
BLOCK_STATUS, so I had to manually provoke the situation by hacking
qemu's server to send a simple error reply:

| diff --git i/nbd/server.c w/nbd/server.c
| index fd013a2817a..833288d7c45 100644
| 00--- i/nbd/server.c
| +++ w/nbd/server.c
| @@ -2269,6 +2269,8 @@ static coroutine_fn int nbd_handle_request(NBDCli=
ent *client,
|                                        "discard failed", errp);
|
|      case NBD_CMD_BLOCK_STATUS:
| +        return nbd_co_send_simple_reply(client, request->handle, ENOME=
M,
| +                                        NULL, 0, errp);
|          if (!request->len) {
|              return nbd_send_generic_reply(client, request->handle, -EI=
NVAL,
|                                            "need non-zero length", errp=
);
|

Signed-off-by: Eric Blake <eblake@redhat.com>
Acked-by: Richard W.M. Jones <rjones@redhat.com>
Message-Id: <20190325190104.30213-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index b37a5963013..a3b70d14004 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -729,9 +729,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClient=
Session *s,
     bool received =3D false;

     assert(!extent->length);
-    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
-                            NULL, &reply, &payload)
-    {
+    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &paylo=
ad) {
         int ret;
         NBDStructuredReplyChunk *chunk =3D &reply.structured;

--=20
2.20.1
