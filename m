Received: from eggs.gnu.org ([2001:4830:134:3::10]:37464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDXfe-0002zu-6Q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDXfd-0002DN-4j
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:30:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 19 Oct 2018 18:30:07 +0200
Message-Id: <20181019163013.11787-4-kwolf@redhat.com>
In-Reply-To: <20181019163013.11787-1-kwolf@redhat.com>
References: <20181019163013.11787-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 03/11] rbd: Close image in qemu_rbd_open()
 error path
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

Commit e2b8247a322 introduced an error path in qemu_rbd_open() after
calling rbd_open(), but neglected to close the image again in this error
path. The error path should contain everything that the regular close
function qemu_rbd_close() contains.

This adds the missing rbd_close() call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/rbd.c b/block/rbd.c
index 014c68d629..27c9a1e81c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -787,6 +787,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict =
*options, int flags,
                          "automatically marking the image read-only.");
             r =3D bdrv_set_read_only(bs, true, &local_err);
             if (r < 0) {
+                rbd_close(s->image);
                 error_propagate(errp, local_err);
                 goto failed_open;
             }
--=20
2.19.1
