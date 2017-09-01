Received: from eggs.gnu.org ([2001:4830:134:3::10]:54120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUs-0000Ta-T5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUl-0007P3-0s
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUk-0007Ns-N0
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F570285B5
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:56:04 +0200
Message-Id: <20170901125611.29295-41-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/47] crypto: Use qapi_enum_parse() in
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

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-10-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/block-luks.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index afb8543108..c3cacdb1ed 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu/bswap.h"
=20
 #include "crypto/block-luks.h"
@@ -265,39 +266,33 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherA=
lgorithm alg,
  * make that function emit a more friendly error message */
 static int qcrypto_block_luks_name_lookup(const char *name,
                                           const char *const *map,
-                                          size_t maplen,
                                           const char *type,
                                           Error **errp)
 {
-    size_t i;
-    for (i =3D 0; i < maplen; i++) {
-        if (g_str_equal(map[i], name)) {
-            return i;
-        }
-    }
+    int ret =3D qapi_enum_parse(map, name, -1, NULL);
=20
-    error_setg(errp, "%s %s not supported", type, name);
-    return 0;
+    if (ret < 0) {
+        error_setg(errp, "%s %s not supported", type, name);
+        return 0;
+    }
+    return ret;
 }
=20
 #define qcrypto_block_luks_cipher_mode_lookup(name, errp)               =
\
     qcrypto_block_luks_name_lookup(name,                                =
\
                                    QCryptoCipherMode_lookup,            =
\
-                                   QCRYPTO_CIPHER_MODE__MAX,            =
\
                                    "Cipher mode",                       =
\
                                    errp)
=20
 #define qcrypto_block_luks_hash_name_lookup(name, errp)                 =
\
     qcrypto_block_luks_name_lookup(name,                                =
\
                                    QCryptoHashAlgorithm_lookup,         =
\
-                                   QCRYPTO_HASH_ALG__MAX,               =
\
                                    "Hash algorithm",                    =
\
                                    errp)
=20
 #define qcrypto_block_luks_ivgen_name_lookup(name, errp)                =
\
     qcrypto_block_luks_name_lookup(name,                                =
\
                                    QCryptoIVGenAlgorithm_lookup,        =
\
-                                   QCRYPTO_IVGEN_ALG__MAX,              =
\
                                    "IV generator",                      =
\
                                    errp)
=20
--=20
2.13.5
