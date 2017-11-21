Received: from eggs.gnu.org ([2001:4830:134:3::10]:42340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGz8d-0007hO-0d
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGz8Z-0008Ie-Qq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:22:19 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 21 Nov 2017 00:21:19 -0300
Message-Id: <20171121032119.14442-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11] Makefile: use $(MAKE) variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

For some systems (i.e. FreeBSD) the default 'make' is not compatible with the
GNU extensions used by QEMU makefiles.

Calling the GNU make (gmake) works, however the help displayed refers to the
host 'make' and copy/paste leads to lot of unobvious errors:

  $ gmake check-help
  [...]
   make check                Run all tests

  $ make check
  make: "Makefile" line 28: Missing dependency operator
  make: "Makefile" line 37: Need an operator
  make: "Makefile" line 41: warning: duplicate script for target "git-submodule-update" ignored
  make: "rules.mak" line 70: warning: duplicate script for target "%.o" ignored
  make: Unknown modifier ' '
  make: Unclosed substitution for eval modules (= missing)
  make: "tests/Makefile.include" line 24: Variable/Value missing from "export"
  make: "tests/" line 1: warning: Zero byte read from file, skipping rest of line.
  make: "tests/" line 1: Need an operator
  make: "Makefile" line 660: warning: duplicate script for target "ifneq" ignored
  make: "Makefile" line 78: warning: using previous script for "ifneq" defined here
  make: Fatal errors encountered -- cannot continue

Using the $(MAKE) variable, the help displayed is consistent with the 'make'
program used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile               |  6 +++---
 tests/Makefile.include | 22 +++++++++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 5392cfac4d..5e8d79618c 100644
--- a/Makefile
+++ b/Makefile
@@ -53,7 +53,7 @@ ifneq ($(realpath $(SRC_PATH)),$(realpath .))
 ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
 $(error This is an out of tree build but your source tree ($(SRC_PATH)) \
 seems to have been used for an in-tree build. You can fix this by running \
-"make distclean && rm -rf *-linux-user *-softmmu" in your source tree)
+"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree)
 endif
 endif
 
@@ -306,7 +306,7 @@ endif
 	    else \
 	      echo "WARNING: $@ out of date.";\
 	    fi; \
-	    echo "Run \"make defconfig\" to regenerate."; \
+	    echo "Run \"$(MAKE) defconfig\" to regenerate."; \
 	    rm $@.tmp; \
 	  fi; \
 	 else \
@@ -940,4 +940,4 @@ ifdef QEMU_GA_MSI_ENABLED
 endif
 	@echo  ''
 endif
-	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
+	@echo  '  $(MAKE) V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c002352134..060dcd6f36 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -3,21 +3,21 @@
 check-help:
 	@echo "Regression testing targets:"
 	@echo
-	@echo " make check                Run all tests"
-	@echo " make check-qtest-TARGET   Run qtest tests for given target"
-	@echo " make check-qtest          Run qtest tests"
-	@echo " make check-unit           Run qobject tests"
-	@echo " make check-speed          Run qobject speed tests"
-	@echo " make check-qapi-schema    Run QAPI schema tests"
-	@echo " make check-block          Run block tests"
-	@echo " make check-report.html    Generates an HTML test report"
-	@echo " make check-clean          Clean the tests"
+	@echo " $(MAKE) check                Run all tests"
+	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
+	@echo " $(MAKE) check-qtest          Run qtest tests"
+	@echo " $(MAKE) check-unit           Run qobject tests"
+	@echo " $(MAKE) check-speed          Run qobject speed tests"
+	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
+	@echo " $(MAKE) check-block          Run block tests"
+	@echo " $(MAKE) check-report.html    Generates an HTML test report"
+	@echo " $(MAKE) check-clean          Clean the tests"
 	@echo
 	@echo "Please note that HTML reports do not regenerate if the unit tests"
 	@echo "has not changed."
 	@echo
 	@echo "The variable SPEED can be set to control the gtester speed setting."
-	@echo "Default options are -k and (for make V=1) --verbose; they can be"
+	@echo "Default options are -k and (for $(MAKE) V=1) --verbose; they can be"
 	@echo "changed with variable GTESTER_OPTIONS."
 
 ifneq ($(wildcard config-host.mak),)
@@ -904,7 +904,7 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
 	@diff -q $(SRC_PATH)/$*.out $*.test.out
-	@# Sanitize error messages (make them independent of build directory)
+	@# Sanitize error messages ($(MAKE) them independent of build directory)
 	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)/$*.err -
 	@diff -q $(SRC_PATH)/$*.exit $*.test.exit
 
-- 
2.15.0
