Received: from eggs.gnu.org ([2001:4830:134:3::10]:59977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eGphR-00089U-2P
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eGphN-0005Nz-RH
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:17:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eGphN-0005NP-Kp
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:17:33 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 20 Nov 2017 17:17:28 +0000
Message-Id: <20171120171728.31266-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] build: disarm the TCG unit test trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Developers sometimes mistakenly run 'make test' instead of 'make check'.
'make test' triggers the ancient, unmaintained tcg unit tests in
tests/tcg/Makefile which have long since ceased compiling.

Even if someone fixes the TCG tests, it makes little sense to put
them in a 'make test' target, rather they should be 'make check-tcg',
possibly wired up as a dependency of 'make check'.

In the meantime, this patch disarms the 'make test' trap by turning
it into a synonym for 'make check'.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/Makefile.include | 1 +
 tests/tcg/Makefile     | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 434a2ce868..55fd99f451 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -919,6 +919,7 @@ check-unit: $(patsubst %,check-%, $(check-unit-y))
 check-speed: $(patsubst %,check-%, $(check-speed-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-qapi-schema check-unit check-qtest
+test: check
 check-clean:
 	$(MAKE) -C tests/tcg clean
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 89e3342f3d..4b5d196326 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -36,9 +36,6 @@ ifneq ($(call find-in-path, $(CC_I386)),)
 TESTS += $(I386_TESTS)
 endif
 
-all: $(patsubst %,run-%,$(TESTS))
-test: all
-
 # rules to run tests
 
 .PHONY: $(patsubst %,run-%,$(TESTS))
-- 
2.14.3
