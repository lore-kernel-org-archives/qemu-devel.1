Received: from eggs.gnu.org ([2001:4830:134:3::10]:51644)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8d-00071t-A8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8a-0007zp-2r
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:29 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:49001 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8Z-0007vC-Qy
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:28 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:05 +0200
Message-Id: <1498733831-15254-3-git-send-email-pl@kamp.de>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 2/8] qapi: add compress parameters to Qcow2
 Blockdev options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, Peter Lieven <pl@kamp.de>

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 qapi/block-core.json | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f85c223..1574ffb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2282,6 +2282,43 @@
             'mode':  'Qcow2OverlapCheckMode' } }
 
 ##
+# @Qcow2CompressFormat:
+# @zlib: standard zlib deflate compression
+#
+# Since: 2.10
+##
+{ 'enum': 'Qcow2CompressFormat',
+  'data': [ 'zlib' ] }
+
+##
+# @Qcow2CompressZLib:
+#
+# Since: 2.10
+##
+{ 'struct': 'Qcow2CompressZLib',
+  'data': { } }
+
+##
+# @Qcow2Compress:
+#
+# Specifies the compression format and compression level that should
+# be used for compressed Qcow2 clusters.
+#
+# @format: specifies the compression format to use. (defaults to zlib)
+#
+# @level: specifies the compression level. 0 = default compression,
+#         1 = fastest compression, x = highest compresion (x may very between
+#         different compression formats)
+#
+# Since: 2.10
+##
+{ 'union': 'Qcow2Compress',
+  'base': { 'format': 'Qcow2CompressFormat',
+            'level': 'uint8' },
+  'discriminator': 'format',
+  'data': { 'zlib': 'Qcow2CompressZLib' } }
+
+##
 # @BlockdevOptionsQcow2:
 #
 # Driver specific block device options for qcow2.
@@ -2316,6 +2353,10 @@
 #                         caches. The interval is in seconds. The default value
 #                         is 0 and it disables this feature (since 2.5)
 #
+# @compress:              which format and compression level to use for
+#                         compressed clusters. Defaults to zlib with default
+#                         compression level (since 2.10)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsQcow2',
@@ -2328,7 +2369,8 @@
             '*cache-size': 'int',
             '*l2-cache-size': 'int',
             '*refcount-cache-size': 'int',
-            '*cache-clean-interval': 'int' } }
+            '*cache-clean-interval': 'int',
+            '*compress': 'Qcow2Compress' } }
 
 
 ##
-- 
1.9.1
