Received: from eggs.gnu.org ([2001:4830:134:3::10]:59737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNZ-0003ZS-4S
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNW-0006hG-Ow
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:49 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 18:55:21 +0200
Message-Id: <20180509165530.29561-5-mreitz@redhat.com>
In-Reply-To: <20180509165530.29561-1-mreitz@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 04/13] qapi: Formalize qcow2 encryption probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Currently, you can give no encryption format for a qcow2 file while
still passing a key-secret.  That does not conform to the schema, so
this patch changes the schema to allow it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 71c9ab8538..092a1aba2d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -43,6 +43,19 @@
 { 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
   'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}
 
+##
+# @ImageInfoSpecificQCow2EncryptionNoInfo:
+#
+# Only used for the qcow2 encryption format "from-image" in which the
+# actual encryption format is determined from the image header.
+# Therefore, this encryption format will never be reported in
+# ImageInfoSpecificQCow2Encryption.
+#
+# Since: 2.13
+##
+{ 'struct': 'ImageInfoSpecificQCow2EncryptionNoInfo',
+  'data': { } }
+
 ##
 # @ImageInfoSpecificQCow2Encryption:
 #
@@ -52,7 +65,8 @@
   'base': 'ImageInfoSpecificQCow2EncryptionBase',
   'discriminator': 'format',
   'data': { 'aes': 'QCryptoBlockInfoQCow',
-            'luks': 'QCryptoBlockInfoLUKS' } }
+            'luks': 'QCryptoBlockInfoLUKS',
+            'from-image': 'ImageInfoSpecificQCow2EncryptionNoInfo' } }
 
 ##
 # @ImageInfoSpecificQCow2:
@@ -2739,10 +2753,30 @@
 # @BlockdevQcow2EncryptionFormat:
 # @aes: AES-CBC with plain64 initialization venctors
 #
+# @from-image:      Determine the encryption format from the image
+#                   header.  This only allows the use of the
+#                   key-secret option.  (Since: 2.13)
+#
 # Since: 2.10
 ##
 { 'enum': 'BlockdevQcow2EncryptionFormat',
-  'data': [ 'aes', 'luks' ] }
+  'data': [ 'aes', 'luks', 'from-image' ] }
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
+# Since: 2.13
+##
+{ 'struct': 'BlockdevQcow2EncryptionSecret',
+  'data': { '*key-secret': 'str' } }
 
 ##
 # @BlockdevQcow2Encryption:
@@ -2750,10 +2784,12 @@
 # Since: 2.10
 ##
 { 'union': 'BlockdevQcow2Encryption',
-  'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
+  'base': { '*format': 'BlockdevQcow2EncryptionFormat' },
   'discriminator': 'format',
+  'default-variant': 'from-image',
   'data': { 'aes': 'QCryptoBlockOptionsQCow',
-            'luks': 'QCryptoBlockOptionsLUKS'} }
+            'luks': 'QCryptoBlockOptionsLUKS',
+            'from-image': 'BlockdevQcow2EncryptionSecret' } }
 
 ##
 # @BlockdevOptionsQcow2:
-- 
2.14.3
