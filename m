Received: from eggs.gnu.org ([2001:4830:134:3::10]:51147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhvF-0000mf-6K
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhv9-0008Pb-Qs
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:40:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:27 +0100
Message-Id: <20181105163744.25139-20-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/36] block: Update flags in
 bdrv_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

To fully change the read-only state of a node, we must not only change
bs->read_only, but also update bs->open_flags.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block.c b/block.c
index 9d2adf7962..3132c78f01 100644
--- a/block.c
+++ b/block.c
@@ -281,6 +281,13 @@ int bdrv_set_read_only(BlockDriverState *bs, bool re=
ad_only, Error **errp)
     }
=20
     bs->read_only =3D read_only;
+
+    if (read_only) {
+        bs->open_flags &=3D ~BDRV_O_RDWR;
+    } else {
+        bs->open_flags |=3D BDRV_O_RDWR;
+    }
+
     return 0;
 }
=20
--=20
2.19.1
