Received: from eggs.gnu.org ([2001:4830:134:3::10]:54774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er6nb-0004iD-6f
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er6nY-00063p-68
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:49:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1er6nY-00063f-1W
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:49:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9356440FB659
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 18:49:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 28 Feb 2018 18:49:47 +0000
Message-Id: <20180228184947.12317-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] crypto: ensure we use a predictable TLS
 priority setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The TLS test cert generation relies on a fixed set of algorithms that are
only usable under GNUTLS' default priority setting. When building QEMU
with a custom distro specific priority setting, this can cause the TLS
tests to fail. By forcing the tests to always use "NORMAL" priority we
can make them more robust.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

Changed in v2:

 - Fix both test cases which use TLS creds !

 tests/test-crypto-tlssession.c | 1 +
 tests/test-io-channel-tls.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssessio=
n.c
index 1a4a066d76..82f21c27f2 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -75,6 +75,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTL=
SCredsEndpoint endpoint,
                      "server" : "client"),
         "dir", certdir,
         "verify-peer", "yes",
+        "priority", "NORMAL",
         /* We skip initial sanity checks here because we
          * want to make sure that problems are being
          * detected at the TLS session validation stage,
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index a210d01ba5..47ba603e8d 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -78,6 +78,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTL=
SCredsEndpoint endpoint,
                      "server" : "client"),
         "dir", certdir,
         "verify-peer", "yes",
+        "priority", "NORMAL",
         /* We skip initial sanity checks here because we
          * want to make sure that problems are being
          * detected at the TLS session validation stage,
--=20
2.14.3
