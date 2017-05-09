Received: from eggs.gnu.org ([2001:4830:134:3::10]:35462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85TW-0008IR-T0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85TS-0008Jc-Ta
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d85TS-0008Ib-Jt
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E2F440F1A
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 13:46:45 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  9 May 2017 14:46:22 +0100
Message-Id: <20170509134623.13120-4-berrange@redhat.com>
In-Reply-To: <20170509134623.13120-1-berrange@redhat.com>
References: <20170509134623.13120-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 3/4] crypto: move 'opaque' parameter to
 (nearly) the end of parameter list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Previous commit moved 'opaque' to be the 2nd parameter in the list:

  commit 375092332eeaa6e47561ce47fd36144cdaf964d0
  Author: Fam Zheng <famz@redhat.com>
  Date:   Fri Apr 21 20:27:02 2017 +0800

    crypto: Make errp the last parameter of functions

    Move opaque to 2nd instead of the 2nd to last, so that compilers help
    check with the conversion.

this puts it back to the 2nd to last position.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c            |  6 +++---
 crypto/block-luks.c       | 13 ++++++++-----
 include/crypto/block.h    |  6 +++---
 tests/test-crypto-block.c |  6 +++---
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 6828180..10e5ddc 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -56,10 +56,10 @@ static int block_crypto_probe_generic(QCryptoBlockFormat format,
 
 
 static ssize_t block_crypto_read_func(QCryptoBlock *block,
-                                      void *opaque,
                                       size_t offset,
                                       uint8_t *buf,
                                       size_t buflen,
+                                      void *opaque,
                                       Error **errp)
 {
     BlockDriverState *bs = opaque;
@@ -83,10 +83,10 @@ struct BlockCryptoCreateData {
 
 
 static ssize_t block_crypto_write_func(QCryptoBlock *block,
-                                       void *opaque,
                                        size_t offset,
                                        const uint8_t *buf,
                                        size_t buflen,
+                                       void *opaque,
                                        Error **errp)
 {
     struct BlockCryptoCreateData *data = opaque;
@@ -102,8 +102,8 @@ static ssize_t block_crypto_write_func(QCryptoBlock *block,
 
 
 static ssize_t block_crypto_init_func(QCryptoBlock *block,
-                                      void *opaque,
                                       size_t headerlen,
+                                      void *opaque,
                                       Error **errp)
 {
     struct BlockCryptoCreateData *data = opaque;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index d5a31bb..2b97d89 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -473,9 +473,9 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * then encrypted.
      */
     rv = readfunc(block,
-                  opaque,
                   slot->key_offset * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
                   splitkey, splitkeylen,
+                  opaque,
                   errp);
     if (rv < 0) {
         goto cleanup;
@@ -676,9 +676,10 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 
     /* Read the entire LUKS header, minus the key material from
      * the underlying device */
-    rv = readfunc(block, opaque, 0,
+    rv = readfunc(block, 0,
                   (uint8_t *)&luks->header,
                   sizeof(luks->header),
+                  opaque,
                   errp);
     if (rv < 0) {
         ret = rv;
@@ -1245,7 +1246,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
 
     /* Reserve header space to match payload offset */
-    initfunc(block, opaque, block->payload_offset, &local_err);
+    initfunc(block, block->payload_offset, opaque, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error;
@@ -1267,9 +1268,10 @@ qcrypto_block_luks_create(QCryptoBlock *block,
 
 
     /* Write out the partition header and key slot headers */
-    writefunc(block, opaque, 0,
+    writefunc(block, 0,
               (const uint8_t *)&luks->header,
               sizeof(luks->header),
+              opaque,
               &local_err);
 
     /* Delay checking local_err until we've byte-swapped */
@@ -1295,10 +1297,11 @@ qcrypto_block_luks_create(QCryptoBlock *block,
 
     /* Write out the master key material, starting at the
      * sector immediately following the partition header. */
-    if (writefunc(block, opaque,
+    if (writefunc(block,
                   luks->header.key_slots[0].key_offset *
                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
                   splitkey, splitkeylen,
+                  opaque,
                   errp) != splitkeylen) {
         goto error;
     }
diff --git a/include/crypto/block.h b/include/crypto/block.h
index 4a053a3..013a435 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -30,22 +30,22 @@ typedef struct QCryptoBlock QCryptoBlock;
  * and QCryptoBlockOpenOptions in qapi/crypto.json */
 
 typedef ssize_t (*QCryptoBlockReadFunc)(QCryptoBlock *block,
-                                        void *opaque,
                                         size_t offset,
                                         uint8_t *buf,
                                         size_t buflen,
+                                        void *opaque,
                                         Error **errp);
 
 typedef ssize_t (*QCryptoBlockInitFunc)(QCryptoBlock *block,
-                                        void *opaque,
                                         size_t headerlen,
+                                        void *opaque,
                                         Error **errp);
 
 typedef ssize_t (*QCryptoBlockWriteFunc)(QCryptoBlock *block,
-                                         void *opaque,
                                          size_t offset,
                                          const uint8_t *buf,
                                          size_t buflen,
+                                         void *opaque,
                                          Error **errp);
 
 /**
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index 85e6603..95c4bd5 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -187,10 +187,10 @@ static struct QCryptoBlockTestData {
 
 
 static ssize_t test_block_read_func(QCryptoBlock *block,
-                                    void *opaque,
                                     size_t offset,
                                     uint8_t *buf,
                                     size_t buflen,
+                                    void *opaque,
                                     Error **errp)
 {
     Buffer *header = opaque;
@@ -204,8 +204,8 @@ static ssize_t test_block_read_func(QCryptoBlock *block,
 
 
 static ssize_t test_block_init_func(QCryptoBlock *block,
-                                    void *opaque,
                                     size_t headerlen,
+                                    void *opaque,
                                     Error **errp)
 {
     Buffer *header = opaque;
@@ -219,10 +219,10 @@ static ssize_t test_block_init_func(QCryptoBlock *block,
 
 
 static ssize_t test_block_write_func(QCryptoBlock *block,
-                                     void *opaque,
                                      size_t offset,
                                      const uint8_t *buf,
                                      size_t buflen,
+                                     void *opaque,
                                      Error **errp)
 {
     Buffer *header = opaque;
-- 
2.9.3
