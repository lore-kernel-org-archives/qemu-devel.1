Received: from eggs.gnu.org ([2001:4830:134:3::10]:59620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdM-0001a2-5W
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdI-0004i3-KG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:40 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:47 +0100
Message-Id: <20180313161803.1814-26-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/41] luks: Turn invalid assertion into check
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

The .bdrv_getlength implementation of the crypto block driver asserted
that the payload offset isn't after EOF. This is an invalid assertion to
make as the image file could be corrupted. Instead, check it and return
-EIO if the file is too small for the payload offset.

Zero length images are fine, so trigger -EIO only on offset > len, not
on offset >=3D len as the assertion did before.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index a1139b6f09..00fb40c631 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -518,7 +518,10 @@ static int64_t block_crypto_getlength(BlockDriverSta=
te *bs)
=20
     uint64_t offset =3D qcrypto_block_get_payload_offset(crypto->block);
     assert(offset < INT64_MAX);
-    assert(offset < len);
+
+    if (offset > len) {
+        return -EIO;
+    }
=20
     len -=3D offset;
=20
--=20
2.13.6
