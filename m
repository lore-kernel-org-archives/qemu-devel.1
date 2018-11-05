Received: from eggs.gnu.org ([2001:4830:134:3::10]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtZ-0007Ej-Ky
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtJ-0003dC-88
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:16 +0100
Message-Id: <20181105163744.25139-9-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/36] qcow2: Get the request alignment for
 encrypted images from QCryptoBlock
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

From: Alberto Garcia <berto@igalia.com>

This doesn't have any practical effect at the moment because the
values of BDRV_SECTOR_SIZE, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE and
QCRYPTO_BLOCK_QCOW_SECTOR_SIZE are all the same (512 bytes), but
future encryption methods could have different requirements.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index de94b290e6..991d6ac91b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1677,7 +1677,7 @@ static void qcow2_refresh_limits(BlockDriverState *=
bs, Error **errp)
=20
     if (bs->encrypted) {
         /* Encryption works on a sector granularity */
-        bs->bl.request_alignment =3D BDRV_SECTOR_SIZE;
+        bs->bl.request_alignment =3D qcrypto_block_get_sector_size(s->cr=
ypto);
     }
     bs->bl.pwrite_zeroes_alignment =3D s->cluster_size;
     bs->bl.pdiscard_alignment =3D s->cluster_size;
--=20
2.19.1
