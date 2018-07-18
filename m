Received: from eggs.gnu.org ([2001:4830:134:3::10]:50344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffiuc-0003UF-P1
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffiuZ-0001Br-Eh
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffiuZ-0001BL-9S
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB36E7D84D
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 09:38:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 18 Jul 2018 10:38:12 +0100
Message-Id: <20180718093815.8104-2-berrange@redhat.com>
In-Reply-To: <20180718093815.8104-1-berrange@redhat.com>
References: <20180718093815.8104-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for 3.0 1/4] tests: call qcrypto_init instead
 of gnutls_global_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Calling qcrypto_init ensures that all relevant initialization is
done. In particular this honours the debugging settings and thread
settings.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/crypto-tls-x509-helpers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-help=
ers.c
index 173d4e28fb..70df68f5df 100644
--- a/tests/crypto-tls-x509-helpers.c
+++ b/tests/crypto-tls-x509-helpers.c
@@ -21,6 +21,8 @@
 #include "qemu/osdep.h"
=20
 #include "crypto-tls-x509-helpers.h"
+#include "crypto/init.h"
+#include "qapi/error.h"
 #include "qemu/sockets.h"
=20
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
@@ -95,7 +97,7 @@ static gnutls_x509_privkey_t test_tls_load_key(void)
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
