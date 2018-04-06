Received: from eggs.gnu.org ([2001:4830:134:3::10]:34082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f4RSF-0006IW-0G
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f4RSC-00037G-DL
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:30:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f4RSC-00036w-6B
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:30:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0756818B126
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 13:30:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  6 Apr 2018 14:30:46 +0100
Message-Id: <20180406133046.5682-4-berrange@redhat.com>
In-Reply-To: <20180406133046.5682-1-berrange@redhat.com>
References: <20180406133046.5682-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] crypto: ensure we use a predictable TLS
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
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
index 32743b2c96..bb88ee870f 100644
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
