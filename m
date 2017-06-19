Received: from eggs.gnu.org ([2001:4830:134:3::10]:45569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dN0b0-0004nq-R5
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dN0az-0001VC-Q3
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:36:14 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 19 Jun 2017 18:34:54 +0100
Message-Id: <20170619173455.18805-20-berrange@redhat.com>
In-Reply-To: <20170619173455.18805-1-berrange@redhat.com>
References: <20170619173455.18805-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v9 19/20] qcow2: report encryption specific
 image information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently 'qemu-img info' reports a simple "encrypted: yes"
field. This is not very useful now that qcow2 can support
multiple encryption formats. Users want to know which format
is in use and some data related to it.

Wire up usage of the qcrypto_block_get_info() method so that
'qemu-img info' can report about the encryption format
and parameters in use

  $ qemu-img create \
      --object secret,id=sec0,data=123456 \
      -o encrypt.format=luks,encrypt.key-secret=sec0 \
      -f qcow2 demo.qcow2 1G
  Formatting 'demo.qcow2', fmt=qcow2 size=1073741824 \
  encryption=off encrypt.format=luks encrypt.key-secret=sec0 \
  cluster_size=65536 lazy_refcounts=off refcount_bits=16

  $ qemu-img info demo.qcow2
  image: demo.qcow2
  file format: qcow2
  virtual size: 1.0G (1073741824 bytes)
  disk size: 480K
  encrypted: yes
  cluster_size: 65536
  Format specific information:
      compat: 1.1
      lazy refcounts: false
      refcount bits: 16
      encrypt:
          ivgen alg: plain64
          hash alg: sha256
          cipher alg: aes-256
          uuid: 3fa930c4-58c8-4ef7-b3c5-314bb5af21f3
          format: luks
          cipher mode: xts
          slots:
              [0]:
                  active: true
                  iters: 1839058
                  key offset: 4096
                  stripes: 4000
              [1]:
                  active: false
                  key offset: 262144
              [2]:
                  active: false
                  key offset: 520192
              [3]:
                  active: false
                  key offset: 778240
              [4]:
                  active: false
                  key offset: 1036288
              [5]:
                  active: false
                  key offset: 1294336
              [6]:
                  active: false
                  key offset: 1552384
              [7]:
                  active: false
                  key offset: 1810432
          payload offset: 2068480
          master key iters: 438487
      corrupt: false

With the legacy "AES" encryption we just report the format
name

  $ qemu-img create \
      --object secret,id=sec0,data=123456 \
      -o encrypt.format=aes,encrypt.key-secret=sec0 \
      -f qcow2 demo.qcow2 1G
  Formatting 'demo.qcow2', fmt=qcow2 size=1073741824 \
  encryption=off encrypt.format=aes encrypt.key-secret=sec0 \
  cluster_size=65536 lazy_refcounts=off refcount_bits=16

  $ ./qemu-img info demo.qcow2
  image: demo.qcow2
  file format: qcow2
  virtual size: 1.0G (1073741824 bytes)
  disk size: 196K
  encrypted: yes
  cluster_size: 65536
  Format specific information:
      compat: 1.1
      lazy refcounts: false
      refcount bits: 16
      encrypt:
          format: aes
      corrupt: false

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow2.c        | 32 +++++++++++++++++++++++++++++++-
 qapi/block-core.json | 27 ++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 19bc69c..a9d0b55 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3199,8 +3199,14 @@ static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
-    ImageInfoSpecific *spec_info = g_new(ImageInfoSpecific, 1);
+    ImageInfoSpecific *spec_info;
+    QCryptoBlockInfo *encrypt_info = NULL;
 
+    if (s->crypto != NULL) {
+        encrypt_info = qcrypto_block_get_info(s->crypto, &error_abort);
+    }
+
+    spec_info = g_new(ImageInfoSpecific, 1);
     *spec_info = (ImageInfoSpecific){
         .type  = IMAGE_INFO_SPECIFIC_KIND_QCOW2,
         .u.qcow2.data = g_new(ImageInfoSpecificQCow2, 1),
@@ -3227,6 +3233,30 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
         assert(false);
     }
 
+    if (encrypt_info) {
+        ImageInfoSpecificQCow2Encryption *qencrypt =
+            g_new(ImageInfoSpecificQCow2Encryption, 1);
+        switch (encrypt_info->format) {
+        case Q_CRYPTO_BLOCK_FORMAT_QCOW:
+            qencrypt->format = BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_AES;
+            qencrypt->u.aes = encrypt_info->u.qcow;
+            break;
+        case Q_CRYPTO_BLOCK_FORMAT_LUKS:
+            qencrypt->format = BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_LUKS;
+            qencrypt->u.luks = encrypt_info->u.luks;
+            break;
+        default:
+            abort();
+        }
+        /* Since we did shallow copy above, erase any pointers
+         * in the original info */
+        memset(&encrypt_info->u, 0, sizeof(encrypt_info->u));
+        qapi_free_QCryptoBlockInfo(encrypt_info);
+
+        spec_info->u.qcow2.data->has_encrypt = true;
+        spec_info->u.qcow2.data->encrypt = qencrypt;
+    }
+
     return spec_info;
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d04d277..9570963 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -33,6 +33,27 @@
             'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
 
 ##
+# @ImageInfoSpecificQCow2EncryptionBase:
+#
+# @format: The encryption format
+#
+# Since: 2.10
+##
+{ 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
+  'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}
+
+##
+# @ImageInfoSpecificQCow2Encryption:
+#
+# Since: 2.10
+##
+{ 'union': 'ImageInfoSpecificQCow2Encryption',
+  'base': 'ImageInfoSpecificQCow2EncryptionBase',
+  'discriminator': 'format',
+  'data': { 'aes': 'QCryptoBlockInfoQCow',
+            'luks': 'QCryptoBlockInfoLUKS' } }
+
+##
 # @ImageInfoSpecificQCow2:
 #
 # @compat: compatibility level
@@ -44,6 +65,9 @@
 #
 # @refcount-bits: width of a refcount entry in bits (since 2.3)
 #
+# @encrypt: details about encryption parameters; only set if image
+#           is encrypted (since 2.10)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -51,7 +75,8 @@
       'compat': 'str',
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
-      'refcount-bits': 'int'
+      'refcount-bits': 'int',
+      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
   } }
 
 ##
-- 
2.9.3
