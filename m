Received: from eggs.gnu.org ([2001:4830:134:3::10]:46797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z7C-0000Kz-EY
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z7B-0006Rm-Ep
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:38 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z7B-0006R5-7M
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:37 -0400
Received: by mail-wm0-x243.google.com with SMTP id x82so25426771wmg.1
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:19 +0100
Message-Id: <20180410193919.28026-25-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 24/24] tests/Makefile.include: add
 (clean-)check-tcg targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This will ensure all linux-user targets build their guest test
programs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3d2f0458ab..c402de901e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -10,6 +10,7 @@ check-help:
 	@echo " $(MAKE) check-speed          Run qobject speed tests"
 	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 	@echo " $(MAKE) check-block          Run block tests"
+	@echo " $(MAKE) check-tcg            Run TCG tests"
 	@echo " $(MAKE) check-report.html    Generates an HTML test report"
 	@echo " $(MAKE) check-clean          Clean the tests"
 	@echo
@@ -916,6 +917,23 @@ check-report.xml: $(patsubst %,check-report-qtest-%.xml, $(QTEST_TARGETS)) check
 check-report.html: check-report.xml
 	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
 
+# Per guest TCG tests
+
+LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_LIST))
+BUILD_TCG_TARGET_RULES=$(patsubst %,tcg-tests-%, $(LINUX_USER_TARGETS))
+CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
+
+tcg-tests-%:
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
+
+clean-tcg-tests-%:
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
+
+.PHONY: check-tcg
+check-tcg: $(BUILD_TCG_TARGET_RULES)
+
+.PHONY: clean-tcg
+clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 # Other tests
 
@@ -958,7 +976,6 @@ check-speed: $(patsubst %,check-%, $(check-speed-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-qapi-schema check-unit check-qtest check-decodetree
 check-clean:
-	$(MAKE) -C tests/tcg clean
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
-- 
2.16.2
