Received: from eggs.gnu.org ([2001:4830:134:3::10]:41347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQm32-0005p1-9F
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQm2z-00014J-9j
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:25:00 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:16 +0300
Message-Id: <b7f6cf3a80a318b218e6b4ae3bfb323d2cc612d3.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/61] Makefile: use $(MAKE) variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

For some systems (i.e. FreeBSD) the default 'make' is not compatible with=
 the
GNU extensions used by QEMU makefiles.

Calling the GNU make (gmake) works, however the help displayed refers to =
the
host 'make' and copy/paste leads to lot of unobvious errors:

  $ gmake check-help
  [...]
   make check                Run all tests

  $ make check
  make: "Makefile" line 28: Missing dependency operator
  make: "Makefile" line 37: Need an operator
  make: "Makefile" line 41: warning: duplicate script for target "git-sub=
module-update" ignored
  make: "rules.mak" line 70: warning: duplicate script for target "%.o" i=
gnored
  make: Unknown modifier ' '
  make: Unclosed substitution for eval modules (=3D missing)
  make: "tests/Makefile.include" line 24: Variable/Value missing from "ex=
port"
  make: "tests/" line 1: warning: Zero byte read from file, skipping rest=
 of line.
  make: "tests/" line 1: Need an operator
  make: "Makefile" line 660: warning: duplicate script for target "ifneq"=
 ignored
  make: "Makefile" line 78: warning: using previous script for "ifneq" de=
fined here
  make: Fatal errors encountered -- cannot continue

Using the $(MAKE) variable, the help displayed is consistent with the 'ma=
ke'
program used.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 Makefile               |  6 +++---
 tests/Makefile.include | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 0331c182ed..1f93515677 100644
--- a/Makefile
+++ b/Makefile
@@ -50,7 +50,7 @@ ifneq ($(realpath $(SRC_PATH)),$(realpath .))
 ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
 $(error This is an out of tree build but your source tree ($(SRC_PATH)) =
\
 seems to have been used for an in-tree build. You can fix this by runnin=
g \
-"make distclean && rm -rf *-linux-user *-softmmu" in your source tree)
+"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree=
)
 endif
 endif
=20
@@ -304,7 +304,7 @@ endif
 	    else \
 	      echo "WARNING: $@ out of date.";\
 	    fi; \
-	    echo "Run \"make defconfig\" to regenerate."; \
+	    echo "Run \"$(MAKE) defconfig\" to regenerate."; \
 	    rm $@.tmp; \
 	  fi; \
 	 else \
@@ -934,4 +934,4 @@ ifdef QEMU_GA_MSI_ENABLED
 endif
 	@echo  ''
 endif
-	@echo  '  make V=3D0|1 [targets] 0 =3D> quiet build (default), 1 =3D> v=
erbose build'
+	@echo  '  $(MAKE) V=3D0|1 [targets] 0 =3D> quiet build (default), 1 =3D=
> verbose build'
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c002352134..b4bcc872f2 100644
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
 	@echo "Please note that HTML reports do not regenerate if the unit test=
s"
 	@echo "has not changed."
 	@echo
 	@echo "The variable SPEED can be set to control the gtester speed setti=
ng."
-	@echo "Default options are -k and (for make V=3D1) --verbose; they can =
be"
+	@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; they c=
an be"
 	@echo "changed with variable GTESTER_OPTIONS."
=20
 ifneq ($(wildcard config-host.mak),)
--=20
2.11.0
