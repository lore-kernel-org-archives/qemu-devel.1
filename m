Received: from eggs.gnu.org ([2001:4830:134:3::10]:36976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXM-0007ql-Ic
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXL-0002Kl-GQ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhZXL-0002KC-7E
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 18:57:17 +0800
Message-Id: <20170815105721.31893-2-famz@redhat.com>
In-Reply-To: <20170815105721.31893-1-famz@redhat.com>
References: <20170815105721.31893-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] Makefile: Let "make check-help" work
 without running ./configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Currently if you do "make check-help" in a fresh checkout, only an error
is printed which is not nice:

    $ make check-help V=3D1
    cc -nostdlib  -o check-help.mo
    cc: fatal error: no input files
    compilation terminated.
    rules.mak:115: recipe for target 'check-help.mo' failed
    make: *** [check-help.mo] Error 1

Move the config-host.mak condition into the body of
tests/Makefile.include and always include the rule for check-help.

Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170810085025.14076-1-famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 Makefile               |  2 --
 tests/Makefile.include | 46 +++++++++++++++++++++++++-------------------=
--
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index 97a58a0f4e..81447b1f08 100644
--- a/Makefile
+++ b/Makefile
@@ -281,9 +281,7 @@ dummy :=3D $(call unnest-vars,, \
                 common-obj-m \
                 trace-obj-y)
=20
-ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/tests/Makefile.include
-endif
=20
 all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index eb4895f94a..37c1bed683 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1,3 +1,26 @@
+
+.PHONY: check-help
+check-help:
+	@echo "Regression testing targets:"
+	@echo
+	@echo " make check                Run all tests"
+	@echo " make check-qtest-TARGET   Run qtest tests for given target"
+	@echo " make check-qtest          Run qtest tests"
+	@echo " make check-unit           Run qobject tests"
+	@echo " make check-speed          Run qobject speed tests"
+	@echo " make check-qapi-schema    Run QAPI schema tests"
+	@echo " make check-block          Run block tests"
+	@echo " make check-report.html    Generates an HTML test report"
+	@echo " make check-clean          Clean the tests"
+	@echo
+	@echo "Please note that HTML reports do not regenerate if the unit test=
s"
+	@echo "has not changed."
+	@echo
+	@echo "The variable SPEED can be set to control the gtester speed setti=
ng."
+	@echo "Default options are -k and (for make V=3D1) --verbose; they can =
be"
+	@echo "changed with variable GTESTER_OPTIONS."
+
+ifneq ($(wildcard config-host.mak),)
 export SRC_PATH
=20
 qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
@@ -802,27 +825,6 @@ $(check-qtest-y): $(qtest-obj-y)
=20
 tests/test-qga: tests/test-qga.o $(qtest-obj-y)
=20
-.PHONY: check-help
-check-help:
-	@echo "Regression testing targets:"
-	@echo
-	@echo " make check                Run all tests"
-	@echo " make check-qtest-TARGET   Run qtest tests for given target"
-	@echo " make check-qtest          Run qtest tests"
-	@echo " make check-unit           Run qobject tests"
-	@echo " make check-speed          Run qobject speed tests"
-	@echo " make check-qapi-schema    Run QAPI schema tests"
-	@echo " make check-block          Run block tests"
-	@echo " make check-report.html    Generates an HTML test report"
-	@echo " make check-clean          Clean the tests"
-	@echo
-	@echo "Please note that HTML reports do not regenerate if the unit test=
s"
-	@echo "has not changed."
-	@echo
-	@echo "The variable SPEED can be set to control the gtester speed setti=
ng."
-	@echo "Default options are -k and (for make V=3D1) --verbose; they can =
be"
-	@echo "changed with variable GTESTER_OPTIONS."
-
 SPEED =3D quick
 GTESTER_OPTIONS =3D -k $(if $(V),--verbose,-q)
 GCOV_OPTIONS =3D -n $(if $(V),-f,)
@@ -917,3 +919,5 @@ all: $(QEMU_IOTESTS_HELPERS-y)
=20
 -include $(wildcard tests/*.d)
 -include $(wildcard tests/libqos/*.d)
+
+endif
--=20
2.13.4
