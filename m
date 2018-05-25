Received: from eggs.gnu.org ([2001:4830:134:3::10]:45544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDeN-0005o0-Oc
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDeM-0003x9-NT
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:24:59 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMDeM-0003wP-Gw
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:24:58 -0400
Received: by mail-wr0-x236.google.com with SMTP id a15-v6so9587462wrm.0
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:24:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 May 2018 15:19:13 +0100
Message-Id: <20180525141915.6497-8-alex.bennee@linaro.org>
In-Reply-To: <20180525141915.6497-1-alex.bennee@linaro.org>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141915.6497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 47/49] tests/Makefile.include: add
 [build|clean|check]-tcg targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This will ensure all linux-user targets build their guest test
programs and ensure check-tcg will run the respective tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2
  - use -include instead of complex macro stuff
  - also include TARGET_BASE_ARCH/Makefile
v3
  - add build-tcg, make check-tcg actually run tests
---
 tests/Makefile.include | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3d2f0458ab..310ccefdd9 100644
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
@@ -916,6 +917,30 @@ check-report.xml: $(patsubst %,check-report-qtest-%.xml, $(QTEST_TARGETS)) check
 check-report.html: check-report.xml
 	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
 
+# Per guest TCG tests
+
+LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_LIST))
+BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
+CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
+RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
+
+build-tcg-tests-%:
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
+
+run-tcg-tests-%: build-tcg-tests-%
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" run-guest-tests,)
+
+clean-tcg-tests-%:
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
+
+.PHONY: build-tcg
+build-tcg: $(BUILD_TCG_TARGET_RULES)
+
+.PHONY: check-tcg
+check-tcg: $(RUN_TCG_TARGET_RULES)
+
+.PHONY: clean-tcg
+clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 # Other tests
 
@@ -958,7 +983,6 @@ check-speed: $(patsubst %,check-%, $(check-speed-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-qapi-schema check-unit check-qtest check-decodetree
 check-clean:
-	$(MAKE) -C tests/tcg clean
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
-- 
2.17.0
