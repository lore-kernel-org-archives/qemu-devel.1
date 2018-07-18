Received: from eggs.gnu.org ([2001:4830:134:3::10]:50375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffiue-0003V9-24
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffiud-0001E2-AR
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffiud-0001Do-60
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C31F8814F0A5
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 09:38:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 18 Jul 2018 10:38:15 +0100
Message-Id: <20180718093815.8104-5-berrange@redhat.com>
In-Reply-To: <20180718093815.8104-1-berrange@redhat.com>
References: <20180718093815.8104-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for 3.0 4/4] tests: fix TLS handshake failure
 with TLS 1.3
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

When gnutls negotiates TLS 1.3 instead of 1.2, the order of messages
sent by the handshake changes. This exposed a logic bug in the test
suite which caused us to wait for the server to see handshake
completion, but not wait for the client to see completion. The result
was the client didn't receive the certificate for verification and the
test failed.

This is exposed in Fedora 29 rawhide which has just enabled TLS 1.3 in
its GNUTLS builds.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-crypto-tlssession.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssessio=
n.c
index fd9acf9067..6fa9950afb 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -151,7 +151,7 @@ static void test_crypto_tls_session_psk(void)
                 clientShake =3D true;
             }
         }
-    } while (!clientShake && !serverShake);
+    } while (!clientShake || !serverShake);
=20
=20
     /* Finally make sure the server & client validation is successful. *=
/
@@ -341,7 +341,7 @@ static void test_crypto_tls_session_x509(const void *=
opaque)
                 clientShake =3D true;
             }
         }
-    } while (!clientShake && !serverShake);
+    } while (!clientShake || !serverShake);
=20
=20
     /* Finally make sure the server validation does what
--=20
2.17.1
