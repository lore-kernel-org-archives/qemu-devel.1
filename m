Received: from eggs.gnu.org ([2001:4830:134:3::10]:50341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdP-0000Bn-8p
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdO-0006ug-Fe
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOdO-0006uR-AW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:58 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:27 -0300
Message-Id: <20180309202827.12085-9-ehabkost@redhat.com>
In-Reply-To: <20180309202827.12085-1-ehabkost@redhat.com>
References: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 8/8] tests: Run device-crash-test on "make
 check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>

Run a subset of tests using device-crash-test on "make check", to
help us catch device crashes earlier.

This also add a "check-device-crash-test-full" rule, that will
check all machine/device combinations.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/Makefile.include | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ef9b88c369..0ba641b8d4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -942,6 +942,17 @@ check-decodetree:
           ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
           TEST, decodetree.py)
 
+CRASH_TEST = $(SRC_PATH)/scripts/device-crash-test
+CRASH_TEST_OPTIONS = $(if $(V),-v,-q)
+CRASH_TEST_BINARIES = $(foreach TARGET,$(TARGETS), $(TARGET)-softmmu/qemu-system-$(TARGET))
+
+.PHONY: check-device-crash-quick
+check-device-crash-quick:
+	$(CRASH_TEST) $(CRASH_TEST_OPTIONS) -t machine=DEFAULT accel=tcg -- $(CRASH_TEST_BINARIES)
+
+check-device-crash-full:
+	$(CRASH_TEST) $(CRASH_TEST_OPTIONS) -F $(CRASH_TEST_BINARIES)
+
 # Consolidated targets
 
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
@@ -950,7 +961,7 @@ check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-unit: $(patsubst %,check-%, $(check-unit-y))
 check-speed: $(patsubst %,check-%, $(check-speed-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
-check: check-qapi-schema check-unit check-qtest check-decodetree
+check: check-qapi-schema check-unit check-qtest check-decodetree check-device-crash-quick
 check-clean:
 	$(MAKE) -C tests/tcg clean
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
-- 
2.14.3
