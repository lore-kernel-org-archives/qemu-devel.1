Received: from eggs.gnu.org ([2001:4830:134:3::10]:51604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@kyomu.43-1.org>) id 1fTUQB-00067c-Tp
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@kyomu.43-1.org>) id 1fTUQA-0001nK-PE
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:23 -0400
Received: from tsukuyomi.43-1.org ([188.40.248.50]:46759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@kyomu.43-1.org>)
	id 1fTUQA-0001my-Hw
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:22 -0400
From: Matthias Maier <tamiko@43-1.org>
Date: Thu, 14 Jun 2018 10:43:56 -0500
Message-Id: <20180614154357.20132-2-tamiko@43-1.org>
In-Reply-To: <20180614154357.20132-1-tamiko@43-1.org>
References: <20180614154357.20132-1-tamiko@43-1.org>
Subject: [Qemu-devel] [PATCH 1/2] Partially revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>, Matthias Maier <tamiko@43-1.org>

From: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>

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
---
 Makefile               | 6 ++----
 tests/Makefile.include | 6 +++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 6c6664d9a3..9f7fd9e5dc 100644
--- a/Makefile
+++ b/Makefile
@@ -20,8 +20,6 @@ ifneq ($(wildcard config-host.mak),)
 all:
 include config-host.mak
 
-PYTHON_UTF8 = LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8 $(PYTHON)
-
 git-submodule-update:
 
 .PHONY: git-submodule-update
@@ -575,7 +573,7 @@ qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-commands.c \
 qga/qapi-generated/qga-qapi-doc.texi: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
@@ -675,7 +673,7 @@ qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
 qapi-gen-timestamp ;
 qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o "qapi" -b $<, \
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
diff --git a/tests/Makefile.include b/tests/Makefile.include
index bb08e37b9d..618ed36cbb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -674,13 +674,13 @@ tests/test-qapi-events.c tests/test-qapi-events.h \
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
@@ -938,7 +938,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF)
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
 $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
-		$(PYTHON_UTF8) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
+		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
 		$^ >$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
-- 
2.16.4
