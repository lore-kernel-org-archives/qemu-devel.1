Received: from eggs.gnu.org ([2001:4830:134:3::10]:53561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOo-0003wh-O1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOn-0006vk-FZ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOn-0006v8-6A
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D71880050
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:52 +0200
Message-Id: <1493018820-23445-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] crypto: Make errp the last parameter of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Move opaque to 2nd instead of the 2nd to last, so that compilers help
check with the conversion.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-7-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Commit message typo corrected]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/crypto.c            | 12 ++++++------
 crypto/block-luks.c       | 21 +++++++++------------
 include/crypto/block.h    | 12 ++++++------
 tests/test-crypto-block.c | 12 ++++++------
 4 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 4a20388..34549b2 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -56,11 +56,11 @@ static int block_crypto_probe_generic(QCryptoBlockFormat format,
 
 
 static ssize_t block_crypto_read_func(QCryptoBlock *block,
+                                      void *opaque,
                                       size_t offset,
                                       uint8_t *buf,
                                       size_t buflen,
-                                      Error **errp,
-                                      void *opaque)
+                                      Error **errp)
 {
     BlockDriverState *bs = opaque;
     ssize_t ret;
@@ -83,11 +83,11 @@ struct BlockCryptoCreateData {
 
 
 static ssize_t block_crypto_write_func(QCryptoBlock *block,
+                                       void *opaque,
                                        size_t offset,
                                        const uint8_t *buf,
                                        size_t buflen,
-                                       Error **errp,
-                                       void *opaque)
+                                       Error **errp)
 {
     struct BlockCryptoCreateData *data = opaque;
     ssize_t ret;
@@ -102,9 +102,9 @@ static ssize_t block_crypto_write_func(QCryptoBlock *block,
 
 
 static ssize_t block_crypto_init_func(QCryptoBlock *block,
+                                      void *opaque,
                                       size_t headerlen,
-                                      Error **errp,
-                                      void *opaque)
+                                      Error **errp)
 {
     struct BlockCryptoCreateData *data = opaque;
     int ret;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 4530f82..d5a31bb 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -473,10 +473,10 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * then encrypted.
      */
     rv = readfunc(block,
+                  opaque,
                   slot->key_offset * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
                   splitkey, splitkeylen,
-                  errp,
-                  opaque);
+                  errp);
     if (rv < 0) {
         goto cleanup;
     }
@@ -676,11 +676,10 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 
     /* Read the entire LUKS header, minus the key material from
      * the underlying device */
-    rv = readfunc(block, 0,
+    rv = readfunc(block, opaque, 0,
                   (uint8_t *)&luks->header,
                   sizeof(luks->header),
-                  errp,
-                  opaque);
+                  errp);
     if (rv < 0) {
         ret = rv;
         goto fail;
@@ -1246,7 +1245,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
 
     /* Reserve header space to match payload offset */
-    initfunc(block, block->payload_offset, &local_err, opaque);
+    initfunc(block, opaque, block->payload_offset, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error;
@@ -1268,11 +1267,10 @@ qcrypto_block_luks_create(QCryptoBlock *block,
 
 
     /* Write out the partition header and key slot headers */
-    writefunc(block, 0,
+    writefunc(block, opaque, 0,
               (const uint8_t *)&luks->header,
               sizeof(luks->header),
-              &local_err,
-              opaque);
+              &local_err);
 
     /* Delay checking local_err until we've byte-swapped */
 
@@ -1297,12 +1295,11 @@ qcrypto_block_luks_create(QCryptoBlock *block,
 
     /* Write out the master key material, starting at the
      * sector immediately following the partition header. */
-    if (writefunc(block,
+    if (writefunc(block, opaque,
                   luks->header.key_slots[0].key_offset *
                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
                   splitkey, splitkeylen,
-                  errp,
-                  opaque) != splitkeylen) {
+                  errp) != splitkeylen) {
         goto error;
     }
 
diff --git a/include/crypto/block.h b/include/crypto/block.h
index b6971de..4a053a3 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -30,23 +30,23 @@ typedef struct QCryptoBlock QCryptoBlock;
  * and QCryptoBlockOpenOptions in qapi/crypto.json */
 
 typedef ssize_t (*QCryptoBlockReadFunc)(QCryptoBlock *block,
+                                        void *opaque,
                                         size_t offset,
                                         uint8_t *buf,
                                         size_t buflen,
-                                        Error **errp,
-                                        void *opaque);
+                                        Error **errp);
 
 typedef ssize_t (*QCryptoBlockInitFunc)(QCryptoBlock *block,
+                                        void *opaque,
                                         size_t headerlen,
-                                        Error **errp,
-                                        void *opaque);
+                                        Error **errp);
 
 typedef ssize_t (*QCryptoBlockWriteFunc)(QCryptoBlock *block,
+                                         void *opaque,
                                          size_t offset,
                                          const uint8_t *buf,
                                          size_t buflen,
-                                         Error **errp,
-                                         void *opaque);
+                                         Error **errp);
 
 /**
  * qcrypto_block_has_format:
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index 1957a86..85e6603 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -187,11 +187,11 @@ static struct QCryptoBlockTestData {
 
 
 static ssize_t test_block_read_func(QCryptoBlock *block,
+                                    void *opaque,
                                     size_t offset,
                                     uint8_t *buf,
                                     size_t buflen,
-                                    Error **errp,
-                                    void *opaque)
+                                    Error **errp)
 {
     Buffer *header = opaque;
 
@@ -204,9 +204,9 @@ static ssize_t test_block_read_func(QCryptoBlock *block,
 
 
 static ssize_t test_block_init_func(QCryptoBlock *block,
+                                    void *opaque,
                                     size_t headerlen,
-                                    Error **errp,
-                                    void *opaque)
+                                    Error **errp)
 {
     Buffer *header = opaque;
 
@@ -219,11 +219,11 @@ static ssize_t test_block_init_func(QCryptoBlock *block,
 
 
 static ssize_t test_block_write_func(QCryptoBlock *block,
+                                     void *opaque,
                                      size_t offset,
                                      const uint8_t *buf,
                                      size_t buflen,
-                                     Error **errp,
-                                     void *opaque)
+                                     Error **errp)
 {
     Buffer *header = opaque;
 
-- 
2.7.4
