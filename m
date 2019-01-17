Received: from eggs.gnu.org ([209.51.188.92]:58770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk7mC-0000aV-Nr
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk7i5-0003V5-8D
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:27:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gk7i4-0002aD-VV
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:27:53 -0500
Received: by mail-wr1-x444.google.com with SMTP id j2so11066981wrw.1
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 05:27:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Jan 2019 13:27:03 +0000
Message-Id: <20190117132703.17790-8-alex.bennee@linaro.org>
In-Reply-To: <20190117132703.17790-1-alex.bennee@linaro.org>
References: <20190117132703.17790-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/7] tests/Makfile: add check-softfloat rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This adds a rule to run all of our softfloat tests. It is included as
a pre-requisite to check-tcg and check-unit as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 43888f3ad5..1de4f1b7dd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -11,6 +11,7 @@ check-help:
 	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 	@echo " $(MAKE) check-block          Run block tests"
 	@echo " $(MAKE) check-tcg            Run TCG tests"
+	@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
 	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) tests"
 	@echo " $(MAKE) check-report.html    Generates an HTML test report"
 	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
@@ -993,6 +994,18 @@ SF_MATH_RULES=$(patsubst %,check-softfloat-%, $(SF_MATH_OPS))
 .PHONY: check-softfloat-ops
 check-softfloat-ops: $(SF_MATH_RULES)
 
+# Finally a generic rule to test all of softfoat. If TCG isnt't
+# enabled we define a null operation which skips the tests.
+
+.PHONY: check-softfloat
+ifeq ($(CONFIG_TCG),y)
+check-softfloat: check-softfloat-conv check-softfloat-compare check-softfloat-ops
+else
+check-softfloat:
+	$(call quiet-command, /bin/true, "FLOAT TEST", \
+		"SKIPPED for non-TCG builds")
+endif
+
 # Per guest TCG tests
 
 LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_DIRS))
@@ -1025,7 +1038,7 @@ clean-tcg-tests-%:
 build-tcg: $(BUILD_TCG_TARGET_RULES)
 
 .PHONY: check-tcg
-check-tcg: $(RUN_TCG_TARGET_RULES)
+check-tcg: check-softfloat $(RUN_TCG_TARGET_RULES)
 
 .PHONY: clean-tcg
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
@@ -1107,7 +1120,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-check: check-qapi-schema check-unit check-qtest check-decodetree
+check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
-- 
2.17.1
