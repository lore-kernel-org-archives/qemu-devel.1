Received: from eggs.gnu.org ([209.51.188.92]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8s-0004Mh-BF
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8o-00017Y-J4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggu8k-0000bo-GX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:09 -0500
Received: by mail-wm1-x344.google.com with SMTP id y139so4666121wmc.5
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:22:01 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  8 Jan 2019 16:21:54 +0000
Message-Id: <20190108162154.22259-7-alex.bennee@linaro.org>
In-Reply-To: <20190108162154.22259-1-alex.bennee@linaro.org>
References: <20190108162154.22259-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 6/6] tests/Makfile: add check-softfloat rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This adds a rule to run all of our softfloat tests. It is included as
a pre-requisite to check-tcg and check-unit as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 69610c0ed1..efbfe7708a 100644
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
@@ -959,6 +960,18 @@ SF_MATH_RULES=$(patsubst %,check-softfloat-%, $(SF_MATH_OPS))
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
@@ -991,7 +1004,7 @@ clean-tcg-tests-%:
 build-tcg: $(BUILD_TCG_TARGET_RULES)
 
 .PHONY: check-tcg
-check-tcg: $(RUN_TCG_TARGET_RULES)
+check-tcg: check-softfloat $(RUN_TCG_TARGET_RULES)
 
 .PHONY: clean-tcg
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
@@ -1072,7 +1085,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
-check-unit: $(patsubst %,check-%, $(check-unit-y))
+check-unit: $(patsubst %,check-%, $(check-unit-y)) check-softfloat
 check-speed: $(patsubst %,check-%, $(check-speed-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-qapi-schema check-unit check-qtest check-decodetree
-- 
2.17.1
