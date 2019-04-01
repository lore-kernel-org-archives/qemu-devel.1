Received: from eggs.gnu.org ([209.51.188.92]:45770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxce-0001tj-QD
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcd-0004iz-N7
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:52 -0500
Message-Id: <20190401140903.19186-4-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/14] nbd: Don't lose server's error to
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

When the server replies with a (structured [*]) error to
NBD_CMD_BLOCK_STATUS, without any extent information sent first, the
client code was blindly throwing away the server's error code and
instead telling the caller that EIO occurred.  This has been broken
since its introduction in 78a33ab5 (v2.12, where we should have called:
   error_setg(&local_err, "Server did not reply with any status extents")=
;
   nbd_iter_error(&iter, false, -EIO, &local_err);
to declare the situation as a non-fatal error if no earlier error had
already been flagged, rather than just blindly slamming iter.err and
iter.ret), although it is more noticeable since commit 7f86068d, which
actually tries hard to preserve the server's code thanks to a separate
iter.request_ret.

[*] The spec is clear that the server is also permitted to reply with
a simple error, but that's a separate fix.

I was able to provoke this scenario with a hack to the server, then
seeing whether ENOMEM makes it back to the caller:

| diff --git a/nbd/server.c b/nbd/server.c
| index fd013a2817a..29c7995de02 100644
| --- a/nbd/server.c
| +++ b/nbd/server.c
| @@ -2269,6 +2269,8 @@ static coroutine_fn int nbd_handle_request(NBDCli=
ent *client,
|                                        "discard failed", errp);
|
|      case NBD_CMD_BLOCK_STATUS:
| +        return nbd_send_generic_reply(client, request->handle, -ENOMEM=
,
| +                                      "no status for you today", errp)=
;
|          if (!request->len) {
|              return nbd_send_generic_reply(client, request->handle, -EI=
NVAL,
|                                            "need non-zero length", errp=
);
| --

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190325190104.30213-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 8fe660b6093..b37a5963013 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -769,12 +769,9 @@ static int nbd_co_receive_blockstatus_reply(NBDClien=
tSession *s,
         payload =3D NULL;
     }

-    if (!extent->length && !iter.err) {
-        error_setg(&iter.err,
-                   "Server did not reply with any status extents");
-        if (!iter.ret) {
-            iter.ret =3D -EIO;
-        }
+    if (!extent->length && !iter.request_ret) {
+        error_setg(&local_err, "Server did not reply with any status ext=
ents");
+        nbd_iter_channel_error(&iter, -EIO, &local_err);
     }

     error_propagate(errp, iter.err);
--=20
2.20.1
