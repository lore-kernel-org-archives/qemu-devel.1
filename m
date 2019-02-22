Received: from eggs.gnu.org ([209.51.188.92]:37917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV8-0002EE-Re
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV3-0001g0-DU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:32 +0000
Message-Id: <20190222140756.29834-4-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/27] block/block-backend: use
 QEMU_IOVEC_INIT_BUF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use new QEMU_IOVEC_INIT_BUF() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-4-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-4-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f6ea824308..6cc25569ef 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1204,17 +1204,8 @@ static int blk_prw(BlockBackend *blk, int64_t offs=
et, uint8_t *buf,
                    int64_t bytes, CoroutineEntry co_entry,
                    BdrvRequestFlags flags)
 {
-    QEMUIOVector qiov;
-    struct iovec iov;
-    BlkRwCo rwco;
-
-    iov =3D (struct iovec) {
-        .iov_base =3D buf,
-        .iov_len =3D bytes,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
-    rwco =3D (BlkRwCo) {
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+    BlkRwCo rwco =3D {
         .blk    =3D blk,
         .offset =3D offset,
         .iobuf  =3D &qiov,
--=20
2.20.1
