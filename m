Received: from eggs.gnu.org ([209.51.188.92]:45885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxck-00021Q-V4
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcj-0004o3-0i
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:55 -0500
Message-Id: <20190401140903.19186-7-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/14] nbd-client: Work around server
 BLOCK_STATUS misalignment at EOF
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

The NBD spec is clear that a server that advertises a minimum block
size should reply to NBD_CMD_BLOCK_STATUS with extents aligned
accordingly. However, we know that the qemu NBD server implementation
has had a corner-case bug where it is not compliant with the spec,
present since the introduction of NBD_CMD_BLOCK_STATUS in qemu 2.12
(and unlikely to be patched in time for 4.0). Namely, when qemu is
serving a file that is not a multiple of 512 bytes, it rounds the size
advertised over NBD up to the next sector boundary (someday, I'd like
to fix that to be byte-accurate, but it's a much bigger audit not
appropriate for this release); yet if the final sector contains data
prior to EOF, lseek(SEEK_HOLE) will point to the implicit hole
mid-sector which qemu then reported over NBD.

We are well within our rights to hang up on a server that can't follow
the spec, but it is more useful to try and keep the connection alive
in spite of the problem. Do so by tracing a message about the problem,
and then either truncating the request back to an aligned boundary (if
it covered more than the final sector) or widening it out to the full
boundary with a forced status of data (since truncating would result
in 0 bytes, but we have to make progress, and valid since data is a
default-safe answer). And in practice, since the problem only happens
on a sector that starts with data and ends with a hole, we are going
to want to read that full sector anyway (where qemu as the server
fills in the tail beyond EOF with appropriate NUL bytes).

Easy reproduction:
$ printf %1000d 1 > file
$ qemu-nbd -f raw -t file & pid=3D$!
$ qemu-img map --output=3Djson -f raw nbd://localhost:10809
qemu-img: Could not read file metadata: Invalid argument
$ kill $pid

where the patched version instead succeeds with:
[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true}]

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190326171317.4036-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index a3b70d14004..150af9cc46f 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -269,14 +269,36 @@ static int nbd_parse_blockstatus_payload(NBDClientS=
ession *client,
     extent->length =3D payload_advance32(&payload);
     extent->flags =3D payload_advance32(&payload);

-    if (extent->length =3D=3D 0 ||
-        (client->info.min_block && !QEMU_IS_ALIGNED(extent->length,
-                                                    client->info.min_blo=
ck))) {
+    if (extent->length =3D=3D 0) {
         error_setg(errp, "Protocol error: server sent status chunk with =
"
-                   "invalid length");
+                   "zero length");
         return -EINVAL;
     }

+    /*
+     * A server sending unaligned block status is in violation of the
+     * protocol, but as qemu-nbd 3.1 is such a server (at least for
+     * POSIX files that are not a multiple of 512 bytes, since qemu
+     * rounds files up to 512-byte multiples but lseek(SEEK_HOLE)
+     * still sees an implicit hole beyond the real EOF), it's nicer to
+     * work around the misbehaving server. If the request included
+     * more than the final unaligned block, truncate it back to an
+     * aligned result; if the request was only the final block, round
+     * up to the full block and change the status to fully-allocated
+     * (always a safe status, even if it loses information).
+     */
+    if (client->info.min_block && !QEMU_IS_ALIGNED(extent->length,
+                                                   client->info.min_bloc=
k)) {
+        trace_nbd_parse_blockstatus_compliance("extent length is unalign=
ed");
+        if (extent->length > client->info.min_block) {
+            extent->length =3D QEMU_ALIGN_DOWN(extent->length,
+                                             client->info.min_block);
+        } else {
+            extent->length =3D client->info.min_block;
+            extent->flags =3D 0;
+        }
+    }
+
     /*
      * We used NBD_CMD_FLAG_REQ_ONE, so the server should not have
      * sent us any more than one extent, nor should it have included
--=20
2.20.1
