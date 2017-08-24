Received: from eggs.gnu.org ([2001:4830:134:3::10]:37147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmO-0003PN-J0
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmM-0000OG-6u
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmL-0000N1-T8
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:18 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:46:04 +0200
Message-Id: <1503564371-26090-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 09/16] crypto: Use qapi_enum_parse() in
 qcrypto_block_luks_name_lookup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, "Daniel P. Berrange" <berrange@redhat.com>

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 crypto/block-luks.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index afb8543..c3cacdb 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu/bswap.h"
 
 #include "crypto/block-luks.h"
@@ -265,39 +266,33 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherAlgorithm alg,
  * make that function emit a more friendly error message */
 static int qcrypto_block_luks_name_lookup(const char *name,
                                           const char *const *map,
-                                          size_t maplen,
                                           const char *type,
                                           Error **errp)
 {
-    size_t i;
-    for (i = 0; i < maplen; i++) {
-        if (g_str_equal(map[i], name)) {
-            return i;
-        }
-    }
+    int ret = qapi_enum_parse(map, name, -1, NULL);
 
-    error_setg(errp, "%s %s not supported", type, name);
-    return 0;
+    if (ret < 0) {
+        error_setg(errp, "%s %s not supported", type, name);
+        return 0;
+    }
+    return ret;
 }
 
 #define qcrypto_block_luks_cipher_mode_lookup(name, errp)               \
     qcrypto_block_luks_name_lookup(name,                                \
                                    QCryptoCipherMode_lookup,            \
-                                   QCRYPTO_CIPHER_MODE__MAX,            \
                                    "Cipher mode",                       \
                                    errp)
 
 #define qcrypto_block_luks_hash_name_lookup(name, errp)                 \
     qcrypto_block_luks_name_lookup(name,                                \
                                    QCryptoHashAlgorithm_lookup,         \
-                                   QCRYPTO_HASH_ALG__MAX,               \
                                    "Hash algorithm",                    \
                                    errp)
 
 #define qcrypto_block_luks_ivgen_name_lookup(name, errp)                \
     qcrypto_block_luks_name_lookup(name,                                \
                                    QCryptoIVGenAlgorithm_lookup,        \
-                                   QCRYPTO_IVGEN_ALG__MAX,              \
                                    "IV generator",                      \
                                    errp)
 
-- 
2.7.5
