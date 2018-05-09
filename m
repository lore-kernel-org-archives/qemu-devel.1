Received: from eggs.gnu.org ([2001:4830:134:3::10]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNa-0003aU-4f
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNZ-0006ma-Bd
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:50 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 18:55:22 +0200
Message-Id: <20180509165530.29561-6-mreitz@redhat.com>
In-Reply-To: <20180509165530.29561-1-mreitz@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 05/13] qapi: Formalize qcow encryption probing
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

Currently, you can give no encryption format for a qcow file while still
passing a key-secret.  That does not conform to the schema, so this
patch changes the schema to allow it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 092a1aba2d..d98af0a71d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2712,15 +2712,35 @@
   'data': { 'flags': 'Qcow2OverlapCheckFlags',
             'mode':  'Qcow2OverlapCheckMode' } }
 
+##
+# @BlockdevQcowEncryptionSecret:
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
+{ 'struct': 'BlockdevQcowEncryptionSecret',
+  'data': { '*key-secret': 'str' } }
+
 ##
 # @BlockdevQcowEncryptionFormat:
 #
 # @aes: AES-CBC with plain64 initialization vectors
 #
+# @from-image:      Determine the encryption format from the image
+#                   header.  This only allows the use of the
+#                   key-secret option.  (Since: 2.13)
+#
 # Since: 2.10
 ##
 { 'enum': 'BlockdevQcowEncryptionFormat',
-  'data': [ 'aes' ] }
+  'data': [ 'aes', 'from-image' ] }
 
 ##
 # @BlockdevQcowEncryption:
@@ -2728,9 +2748,11 @@
 # Since: 2.10
 ##
 { 'union': 'BlockdevQcowEncryption',
-  'base': { 'format': 'BlockdevQcowEncryptionFormat' },
+  'base': { '*format': 'BlockdevQcowEncryptionFormat' },
   'discriminator': 'format',
-  'data': { 'aes': 'QCryptoBlockOptionsQCow' } }
+  'default-variant': 'from-image',
+  'data': { 'aes': 'QCryptoBlockOptionsQCow',
+            'from-image': 'BlockdevQcowEncryptionSecret' } }
 
 ##
 # @BlockdevOptionsQcow:
-- 
2.14.3
