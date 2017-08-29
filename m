Received: from eggs.gnu.org ([2001:4830:134:3::10]:39438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmjMZ-0006MS-Nw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmjMU-0006iJ-PJ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:27:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dmjMU-0006hp-Ir
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 653A38535D
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 16:27:33 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 29 Aug 2017 17:27:27 +0100
Message-Id: <20170829162727.13081-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] crypto: fix test cert generation to not use
 SHA1 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

GNUTLS 3.6.0 marked SHA1 as untrusted for certificates.
Unfortunately the gnutls_x509_crt_sign() method we are
using to create certificates in the test suite is fixed
to always use SHA1. We must switch to a different method
and explicitly ask for SHA256.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/crypto-tls-x509-helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-helpers.c
index 64073d3bd3..173d4e28fb 100644
--- a/tests/crypto-tls-x509-helpers.c
+++ b/tests/crypto-tls-x509-helpers.c
@@ -406,7 +406,8 @@ test_tls_generate_cert(QCryptoTLSTestCertReq *req,
      * If no 'ca' is set then we are self signing
      * the cert. This is done for the root CA certs
      */
-    err = gnutls_x509_crt_sign(crt, ca ? ca : crt, privkey);
+    err = gnutls_x509_crt_sign2(crt, ca ? ca : crt, privkey,
+                                GNUTLS_DIG_SHA256, 0);
     if (err < 0) {
         g_critical("Failed to sign certificate %s",
                    gnutls_strerror(err));
-- 
2.13.5
