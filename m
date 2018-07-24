Received: from eggs.gnu.org ([2001:4830:134:3::10]:60334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0Qg-0002y2-Cw
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0Qf-00040b-3R
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fi0Qe-00040N-UF
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:53 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 24 Jul 2018 17:44:45 +0100
Message-Id: <20180724164448.7606-2-berrange@redhat.com>
In-Reply-To: <20180724164448.7606-1-berrange@redhat.com>
References: <20180724164448.7606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] tests: call qcrypto_init instead of
 gnutls_global_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Calling qcrypto_init ensures that all relevant initialization is
done. In particular this honours the debugging settings and thread
settings.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/crypto/init.h           | 2 ++
 tests/crypto-tls-x509-helpers.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/crypto/init.h b/include/crypto/init.h
index 04c1edf770..f79c02266b 100644
--- a/include/crypto/init.h
+++ b/include/crypto/init.h
@@ -21,6 +21,8 @@
 #ifndef QCRYPTO_INIT_H
 #define QCRYPTO_INIT_H
=20
+#include "qapi/error.h"
+
 int qcrypto_init(Error **errp);
=20
 #endif /* QCRYPTO_INIT_H */
diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-help=
ers.c
index 173d4e28fb..9b669c2a4b 100644
--- a/tests/crypto-tls-x509-helpers.c
+++ b/tests/crypto-tls-x509-helpers.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
=20
 #include "crypto-tls-x509-helpers.h"
+#include "crypto/init.h"
 #include "qemu/sockets.h"
=20
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
@@ -95,7 +96,7 @@ static gnutls_x509_privkey_t test_tls_load_key(void)
=20
 void test_tls_init(const char *keyfile)
 {
-    gnutls_global_init();
+    qcrypto_init(&error_abort);
=20
     if (asn1_array2tree(pkix_asn1_tab, &pkix_asn1, NULL) !=3D ASN1_SUCCE=
SS) {
         abort();
--=20
2.17.1
