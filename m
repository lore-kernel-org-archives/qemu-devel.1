Received: from eggs.gnu.org ([2001:4830:134:3::10]:47806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evOyK-0004eV-BL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evOyJ-0002u8-KA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:02:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Mar 2018 16:02:17 +0100
Message-Id: <20180312150218.1314-6-kwolf@redhat.com>
In-Reply-To: <20180312150218.1314-1-kwolf@redhat.com>
References: <20180312150218.1314-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/6] luks: Catch integer overflow for huge
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

When you request an image size close to UINT64_MAX, the addition of the
crypto header may cause an integer overflow. Catch it instead of
silently truncating the image size.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 16c371ec9c..9dac08c6c5 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -102,6 +102,11 @@ static ssize_t block_crypto_init_func(QCryptoBlock *=
block,
 {
     struct BlockCryptoCreateData *data =3D opaque;
=20
+    if (data->size > INT64_MAX || headerlen > INT64_MAX - data->size) {
+        error_setg(errp, "The requested file size is too large");
+        return -EFBIG;
+    }
+
     /* User provided size should reflect amount of space made
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
--=20
2.13.6
