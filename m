Received: from eggs.gnu.org ([2001:4830:134:3::10]:60104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAYRc-0001xy-Nw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAYRZ-0003Sa-KH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:39:20 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  3 Nov 2017 10:39:13 +0100
Message-Id: <1509701953-8995-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: Run the test-crypto-block only if
 encryption is available
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

So run this test only if the required encryption support is available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 434a2ce..ac46aea 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -145,7 +145,7 @@ check-unit-$(if $(CONFIG_NETTLE_KDF),y,$(CONFIG_GCRYPT_KDF)) += tests/test-crypt
 check-unit-y += tests/test-crypto-ivgen$(EXESUF)
 check-unit-y += tests/test-crypto-afsplit$(EXESUF)
 check-unit-y += tests/test-crypto-xts$(EXESUF)
-check-unit-y += tests/test-crypto-block$(EXESUF)
+check-unit-$(call lor,$(CONFIG_NETTLE_KDF),$(CONFIG_GCRYPT_KDF)) += tests/test-crypto-block$(EXESUF)
 check-unit-y += tests/test-logging$(EXESUF)
 gcov-files-test-logging-y = util/log.c
 check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
-- 
1.8.3.1
