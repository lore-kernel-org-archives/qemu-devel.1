Received: from eggs.gnu.org ([2001:4830:134:3::10]:56879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er2Nr-00050e-Fe
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er2Nl-0002PZ-Rx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:07:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1er2Nl-0002PT-N6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:06:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61C588182D01
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:06:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 28 Feb 2018 14:06:52 +0000
Message-Id: <20180228140652.31933-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] crypto: ensure we use a predictable TLS
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
 tests/test-crypto-tlssession.c | 1 +
 1 file changed, 1 insertion(+)

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
--=20
2.14.3
