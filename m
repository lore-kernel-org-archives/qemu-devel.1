Received: from eggs.gnu.org ([2001:4830:134:3::10]:43680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnY-0001lv-W1
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnX-00086v-SC
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:21 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:51:57 +0200
Message-Id: <20180611205203.2624-5-mreitz@redhat.com>
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/10] qapi: Formalize qcow2 encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

Currently, you can give no encryption format for a qcow2 file while
still passing a key-secret.  That does not conform to the schema, so
this patch changes the schema to allow it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 44 ++++++++++++++++++++++++++++++++++++++++----
 block/qcow2.c        |  3 +++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4bd85dd1bb..295ace42ae 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -44,6 +44,19 @@
 { 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
   'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}
 
+##
+# @ImageInfoSpecificQCow2EncryptionNoInfo:
+#
+# Only used for the qcow2 encryption format "auto" in which the actual
+# encryption format is determined from the image header.  Therefore,
+# this encryption format will never be reported in
+# ImageInfoSpecificQCow2Encryption.
+#
+# Since: 3.0
+##
+{ 'struct': 'ImageInfoSpecificQCow2EncryptionNoInfo',
+  'data': { } }
+
 ##
 # @ImageInfoSpecificQCow2Encryption:
 #
@@ -53,7 +66,8 @@
   'base': 'ImageInfoSpecificQCow2EncryptionBase',
   'discriminator': 'format',
   'data': { 'aes': 'QCryptoBlockInfoQCow',
-            'luks': 'QCryptoBlockInfoLUKS' } }
+            'luks': 'QCryptoBlockInfoLUKS',
+            'auto': 'ImageInfoSpecificQCow2EncryptionNoInfo' } }
 
 ##
 # @ImageInfoSpecificQCow2:
@@ -2658,10 +2672,30 @@
 # @BlockdevQcow2EncryptionFormat:
 # @aes: AES-CBC with plain64 initialization venctors
 #
+# @auto:            Determine the encryption format from the image
+#                   header.  This only allows the use of the
+#                   key-secret option.  (Since: 3.0)
+#
 # Since: 2.10
 ##
 { 'enum': 'BlockdevQcow2EncryptionFormat',
-  'data': [ 'aes', 'luks' ] }
+  'data': [ 'aes', 'luks', 'auto' ] }
+
+##
+# @BlockdevQcow2EncryptionSecret:
+#
+# Allows specifying a key-secret without specifying the exact
+# encryption format, which is determined automatically from the image
+# header.
+#
+# @key-secret:      The ID of a QCryptoSecret object providing the
+#                   decryption key.  Mandatory except when probing
+#                   image for metadata only.
+#
+# Since: 3.0
+##
+{ 'struct': 'BlockdevQcow2EncryptionSecret',
+  'data': { '*key-secret': 'str' } }
 
 ##
 # @BlockdevQcow2Encryption:
@@ -2669,10 +2703,12 @@
 # Since: 2.10
 ##
 { 'union': 'BlockdevQcow2Encryption',
-  'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
+  'base': { '*format': 'BlockdevQcow2EncryptionFormat' },
   'discriminator': 'format',
+  'default-variant': 'auto',
   'data': { 'aes': 'QCryptoBlockOptionsQCow',
-            'luks': 'QCryptoBlockOptionsLUKS'} }
+            'luks': 'QCryptoBlockOptionsLUKS',
+            'auto': 'BlockdevQcow2EncryptionSecret' } }
 
 ##
 # @BlockdevOptionsQcow2:
diff --git a/block/qcow2.c b/block/qcow2.c
index 945132f692..6bfcba4ee1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -868,6 +868,9 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
 
     qdict_extract_subqdict(options, &encryptopts, "encrypt.");
     encryptfmt = qdict_get_try_str(encryptopts, "format");
+    if (!g_strcmp0(encryptfmt, "auto")) {
+        encryptfmt = NULL;
+    }
 
     opts = qemu_opts_create(&qcow2_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
-- 
2.17.1
