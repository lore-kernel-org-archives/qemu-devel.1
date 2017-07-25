Received: from eggs.gnu.org ([2001:4830:134:3::10]:36475)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da125-0001r7-6a
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da124-0000wp-FB
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:57 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:37270 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da124-0000v4-6E
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:56 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:39 +0200
Message-Id: <1500993699-19299-11-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 10/10] block/qcow2: add compress info to
 image specific info
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
 block/qcow2.c        | 7 +++++++
 qapi/block-core.json | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0e9c2b8..7e03877 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3968,6 +3968,13 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
         spec_info->u.qcow2.data->encrypt = qencrypt;
     }
 
+    if (s->incompatible_features & QCOW2_INCOMPAT_COMPRESS) {
+        spec_info->u.qcow2.data->compress = g_new0(Qcow2Compress, 1);
+        memcpy(spec_info->u.qcow2.data->compress, &s->compress,
+               sizeof(Qcow2Compress));
+        spec_info->u.qcow2.data->has_compress = true;
+    }
+
     return spec_info;
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d655bb1..3b338d5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -68,6 +68,9 @@
 # @encrypt: details about encryption parameters; only set if image
 #           is encrypted (since 2.10)
 #
+# @compress: details about parameters for compressed clusters; only set if
+#            the compress format header extension is present (since 2.11)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -76,7 +79,8 @@
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
-      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
+      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
+      '*compress': 'Qcow2Compress'
   } }
 
 ##
-- 
1.9.1
