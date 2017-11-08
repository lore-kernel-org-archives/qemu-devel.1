Received: from eggs.gnu.org ([2001:4830:134:3::10]:32795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCQX2-0006PV-EV
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCQWy-00028L-HC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCQWy-00027Y-Bf
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:36 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  8 Nov 2017 13:36:11 +0000
Message-Id: <20171108133612.16471-2-berrange@redhat.com>
In-Reply-To: <20171108133612.16471-1-berrange@redhat.com>
References: <20171108133612.16471-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/2] tests: Run the luks tests in
 test-crypto-block only if encryption is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The test-crypto-block currently fails if encryption has not been
compiled into QEMU:

TEST: tests/test-crypto-block... (pid=22231)
  /crypto/block/qcow:                                                  OK
  /crypto/block/luks/default:
  Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
FAIL
GTester: last random seed: R02Sbbb5b6f299c6727f41bb50ba4aa6ef5c
(pid=22237)
  /crypto/block/luks/aes-256-cbc-plain64:
  Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
FAIL
GTester: last random seed: R02S3e27992a5ab4cc95e141c4ed3c7f0d2e
(pid=22239)
  /crypto/block/luks/aes-256-cbc-essiv:
  Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
FAIL
GTester: last random seed: R02S51b52bb02a66c42d8b331fd305384f53
(pid=22241)
FAIL: tests/test-crypto-block

So run the luks test only if the required encryption support is available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-crypto-block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index bd7fe593e3..fd29a045d2 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -28,7 +28,8 @@
 #include <sys/resource.h>
 #endif
 
-#if (defined(_WIN32) || defined RUSAGE_THREAD)
+#if (defined(_WIN32) || defined RUSAGE_THREAD) && \
+    (defined(CONFIG_NETTLE_KDF) || defined(CONFIG_GCRYPT_KDF))
 #define TEST_LUKS
 #else
 #undef TEST_LUKS
-- 
2.13.6
