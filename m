Received: from eggs.gnu.org ([2001:4830:134:3::10]:49966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqn-0004MN-4R
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqj-0001Ul-5j
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:54:05 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 27 Sep 2017 13:53:36 +0100
Message-Id: <20170927125340.12360-3-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-1-berrange@redhat.com>
References: <20170927125340.12360-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/6] crypto: expose encryption sector size
 in APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

While current encryption schemes all have a fixed sector size of
512 bytes, this is not guaranteed to be the case in future. Expose
the sector size in the APIs so the block layer can remove assumptions
about fixed 512 byte sectors.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/block-luks.c    |  6 ++++--
 crypto/block-qcow.c    |  1 +
 crypto/block.c         |  6 ++++++
 crypto/blockpriv.h     |  1 +
 include/crypto/block.h | 15 +++++++++++++++
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 36bc856084..a9062bb0f2 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -846,8 +846,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         }
     }
 
+    block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset = luks->header.payload_offset *
-        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+        block->sector_size;
 
     luks->cipher_alg = cipheralg;
     luks->cipher_mode = ciphermode;
@@ -1240,8 +1241,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
                    QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) *
          QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
 
+    block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset = luks->header.payload_offset *
-        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+        block->sector_size;
 
     /* Reserve header space to match payload offset */
     initfunc(block, block->payload_offset, opaque, &local_err);
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index a456fe338b..4dd594a9ba 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -80,6 +80,7 @@ qcrypto_block_qcow_init(QCryptoBlock *block,
         goto fail;
     }
 
+    block->sector_size = QCRYPTO_BLOCK_QCOW_SECTOR_SIZE;
     block->payload_offset = 0;
 
     return 0;
diff --git a/crypto/block.c b/crypto/block.c
index c382393d9a..a7a9ad240e 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -170,6 +170,12 @@ uint64_t qcrypto_block_get_payload_offset(QCryptoBlock *block)
 }
 
 
+uint64_t qcrypto_block_get_sector_size(QCryptoBlock *block)
+{
+    return block->sector_size;
+}
+
+
 void qcrypto_block_free(QCryptoBlock *block)
 {
     if (!block) {
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 0edb810e22..d227522d88 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -36,6 +36,7 @@ struct QCryptoBlock {
     QCryptoHashAlgorithm kdfhash;
     size_t niv;
     uint64_t payload_offset; /* In bytes */
+    uint64_t sector_size; /* In bytes */
 };
 
 struct QCryptoBlockDriver {
diff --git a/include/crypto/block.h b/include/crypto/block.h
index f0e543bee1..13232b2472 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -241,6 +241,21 @@ QCryptoHashAlgorithm qcrypto_block_get_kdf_hash(QCryptoBlock *block);
 uint64_t qcrypto_block_get_payload_offset(QCryptoBlock *block);
 
 /**
+ * qcrypto_block_get_sector_size:
+ * @block: the block encryption object
+ *
+ * Get the size of sectors used for payload encryption. A new
+ * IV is used at the start of each sector. The encryption
+ * sector size is not required to match the sector size of the
+ * underlying storage. For example LUKS will always use a 512
+ * byte sector size, even if the volume is on a disk with 4k
+ * sectors.
+ *
+ * Returns: the sector in bytes
+ */
+uint64_t qcrypto_block_get_sector_size(QCryptoBlock *block);
+
+/**
  * qcrypto_block_free:
  * @block: the block encryption object
  *
-- 
2.13.5
