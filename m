Received: from eggs.gnu.org ([209.51.188.92]:43010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrjD-0006xg-O7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrjA-0006LA-NL
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:58 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjrjA-0006Dz-FM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:56 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so8485957wra.6
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 12:23:56 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 16 Jan 2019 20:23:49 +0000
Message-Id: <20190116202349.29272-8-alex.bennee@linaro.org>
In-Reply-To: <20190116202349.29272-1-alex.bennee@linaro.org>
References: <20190116202349.29272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 7/7] tests/Makfile: add check-softfloat rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This adds a rule to run all of our softfloat tests. It is included as
a pre-requisite to check-tcg and check-unit as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

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
