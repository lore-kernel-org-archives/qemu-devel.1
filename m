Received: from eggs.gnu.org ([2001:4830:134:3::10]:55473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtso-0004BD-Qd
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsn-0002iG-UY
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:02 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsn-0002hi-QZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:01 -0400
Received: by mail-qt0-x242.google.com with SMTP id w1so11250834qtg.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:14:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:27 -0300
Message-Id: <20170616161334.7492-5-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/11] tests: add rule to compile many objects
 used by tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

all those objects can get compiled simultaneously

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/Makefile.include | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f42f3dfa72..3773f9d8d2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -804,6 +804,7 @@ check-help:
 	@echo " make check-qapi-schema    Run QAPI schema tests"
 	@echo " make check-block          Run block tests"
 	@echo " make check-report.html    Generates an HTML test report"
+	@echo " make check-compile        Compile objects used by tests"
 	@echo " make check-clean          Clean the tests"
 	@echo
 	@echo "Please note that HTML reports do not regenerate if the unit tests"
@@ -887,7 +888,7 @@ check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
 
 # Consolidated targets
 
-.PHONY: check-qapi-schema check-qtest check-unit check check-clean
+.PHONY: check-qapi-schema check-qtest check-unit check check-clean check-compile
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-unit: $(patsubst %,check-%, $(check-unit-y))
@@ -897,7 +898,10 @@ check-clean:
 	$(MAKE) -C tests/tcg clean
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
-
+check-compile: $(check-qtest-generic-y) $(check-unit-y) $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) $(chardev-obj-y) $(QEMU_IOTESTS_HELPERS-y)
+ifeq ($(CONFIG_SOFTMMU),y)
+check-compile: $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)))
+endif
 clean: check-clean
 
 # Build the help program automatically
-- 
2.11.0
