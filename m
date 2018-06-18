Received: from eggs.gnu.org ([2001:4830:134:3::10]:49482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUyRf-0007WP-L5
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUyRc-0004sr-Le
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:00:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUyRc-0004rs-Gh
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:00:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Jun 2018 19:59:58 +0200
Message-Id: <20180618175958.29073-3-armbru@redhat.com>
In-Reply-To: <20180618175958.29073-1-armbru@redhat.com>
References: <20180618175958.29073-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/2] Revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tamiko@43-1.org, arfrever.fta@gmail.com

From: Matthias Maier <tamiko@43-1.org>

This commit removes the PYTHON_UTF8 workaround. The problem with setting

  LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8

is that the en_US.UTF-8 locale might not be available. In this case
setting above locales results in build errors even though another UTF-8
locale was originally set [1]. The only stable way of fixing the
encoding problem is by explicitly annotating encoding/decoding in the
python script.

[1] https://bugs.gentoo.org/657766

Signed-off-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
Signed-off-by: Matthias Maier <tamiko@43-1.org>
Message-Id: <20180615220205.6929-3-tamiko@43-1.org>
---
 Makefile               | 6 ++----
 tests/Makefile.include | 6 +++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index e46f2b625a..7ed9cc4a21 100644
--- a/Makefile
+++ b/Makefile
@@ -20,8 +20,6 @@ ifneq ($(wildcard config-host.mak),)
 all:
 include config-host.mak
 
-PYTHON_UTF8 = LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8 $(PYTHON)
-
 git-submodule-update:
 
 .PHONY: git-submodule-update
@@ -576,7 +574,7 @@ qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-commands.c \
 qga/qapi-generated/qga-qapi-doc.texi: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
@@ -676,7 +674,7 @@ qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
 qapi-gen-timestamp ;
 qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o "qapi" -b $<, \
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ca91da26cb..88f1bc1242 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -678,13 +678,13 @@ tests/test-qapi-events.c tests/test-qapi-events.h \
 tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
 tests/test-qapi-gen-timestamp ;
 tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests -p "test-" $<, \
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
 
 tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.json $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests/qapi-schema -p "doc-good-" $<, \
 		"GEN","$@")
 	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
@@ -942,7 +942,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF)
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
 $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
-		$(PYTHON_UTF8) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
+		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
 		$^ >$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
-- 
2.17.1
