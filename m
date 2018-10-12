Received: from eggs.gnu.org ([2001:4830:134:3::10]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2x-0007eV-0t
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2w-0005vu-7M
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:55:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 12 Oct 2018 13:55:28 +0200
Message-Id: <20181012115532.12645-5-kwolf@redhat.com>
In-Reply-To: <20181012115532.12645-1-kwolf@redhat.com>
References: <20181012115532.12645-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/8] nbd: Support auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If read-only=3Doff, but auto-read-only=3Don is given, open a read-write N=
BD
connection if the server provides a read-write export, but instead of
erroring out for read-only exports, just degrade to read-only.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nbd-client.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9686ecbd5e..76e9ca3abe 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -992,11 +992,11 @@ int nbd_client_init(BlockDriverState *bs,
         logout("Failed to negotiate with the NBD server\n");
         return ret;
     }
-    if (client->info.flags & NBD_FLAG_READ_ONLY &&
-        !bdrv_is_read_only(bs)) {
-        error_setg(errp,
-                   "request for write access conflicts with read-only ex=
port");
-        return -EACCES;
+    if (client->info.flags & NBD_FLAG_READ_ONLY) {
+        ret =3D bdrv_apply_auto_read_only(bs, "NBD export is read-only",=
 errp);
+        if (ret < 0) {
+            return ret;
+        }
     }
     if (client->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags =3D BDRV_REQ_FUA;
--=20
2.19.1
