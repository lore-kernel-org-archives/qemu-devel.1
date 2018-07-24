Received: from eggs.gnu.org ([2001:4830:134:3::10]:60416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0Qk-00030l-HN
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0Qj-00046G-Sq
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fi0Qj-00045l-Nw
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:57 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 24 Jul 2018 17:44:48 +0100
Message-Id: <20180724164448.7606-5-berrange@redhat.com>
In-Reply-To: <20180724164448.7606-1-berrange@redhat.com>
References: <20180724164448.7606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] tests: fix TLS handshake failure with TLS
 1.3
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

When gnutls negotiates TLS 1.3 instead of 1.2, the order of messages
sent by the handshake changes. This exposed a logic bug in the test
suite which caused us to wait for the server to see handshake
completion, but not wait for the client to see completion. The result
was the client didn't receive the certificate for verification and the
test failed.

This is exposed in Fedora 29 rawhide which has just enabled TLS 1.3 in
its GNUTLS builds.

Reviewed-by: Eric Blake <eblake@redhat.com>
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
