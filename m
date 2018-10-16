Received: from eggs.gnu.org ([2001:4830:134:3::10]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMdG-0004lA-Br
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMdF-0007Qc-Kv
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:31:22 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 16 Oct 2018 11:31:05 +0100
Message-Id: <20181016103105.30927-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] crypto: initialize sector size even when
 opening with no IO flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The qcow2 block driver expects to see a valid sector size even when it
has opened the crypto layer with QCRYPTO_BLOCK_OPEN_NO_IO.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-qcow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 4284e05167..7606231e79 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -102,6 +102,8 @@ qcrypto_block_qcow_open(QCryptoBlock *block,
                         Error **errp)
 {
     if (flags & QCRYPTO_BLOCK_OPEN_NO_IO) {
+        block->sector_size =3D QCRYPTO_BLOCK_QCOW_SECTOR_SIZE;
+        block->payload_offset =3D 0;
         return 0;
     } else {
         if (!options->u.qcow.key_secret) {
--=20
2.17.2
