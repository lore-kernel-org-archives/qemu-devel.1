Received: from eggs.gnu.org ([2001:4830:134:3::10]:34093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAaYu-0004x8-RA
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAaYq-0002CB-0d
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:55:00 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  3 Nov 2017 12:54:52 +0100
Message-Id: <1509710092-31645-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] tests: Run the luks tests in
 test-crypto-block only if encryption is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

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
---
 v2: Added the check to TEST_LUKS in the .c file instead of disabling
     test-crypto-block completely in the Makefile.include.

 tests/test-crypto-block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index bd7fe59..fd29a04 100644
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
1.8.3.1
