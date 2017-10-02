Received: from eggs.gnu.org ([2001:4830:134:3::10]:38897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bg-00081j-OE
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007vq-Gz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2ba-0007ub-61
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:30 +0200
Message-Id: <20171002152552.27999-11-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 10/32] qapi: Don't run generators twice
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

The generators always generate both .c and .h, but they can route one
of them to the bit bucket.  We run them twice, once to generate .c,
and once to generate .h.  Probably because the naive make rule

    FOO.c FOO.h: qapi-schema.json
	RECIPE

runs RECIPE twice, once to generate FOO.c and once to generate FOO.h.

Employ the usual make trick to generate multiple files in one rule:

    .INTERMEDIATE: FOO-gen
    FOO.c FOO.h: FOO-gen ;
    FOO-gen: qapi-schema.json
        RECIPE

When make needs FOO.c or FOO.h, it runs RECIPE once to generate
intermediate target FOO-gen, then considers both FOO.c and FOO.h
updated.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile               | 58 +++++++++++++++++++++++++++++++++-----------------
 Makefile.objs          |  2 +-
 tests/Makefile.include | 36 +++++++++++++++++++++----------
 3 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/Makefile b/Makefile
index cee6e28659..784b601247 100644
--- a/Makefile
+++ b/Makefile
@@ -384,24 +384,33 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 qemu-ga$(EXESUF): LIBS = $(LIBS_QGA)
 qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
 
-gen-out-type = $(subst .,-,$(suffix $@))
-
 qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
 
+.INTERMEDIATE: qga/qapi-generated/qga-qapi-types-gen
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h :\
+qga/qapi-generated/qga-qapi-types-gen ;
+qga/qapi-generated/qga-qapi-types-gen: \
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
-		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
+		-o $(dir $@) -p "qga-" $<, \
 		"GEN","$@")
+
+.INTERMEDIATE: qga/qapi-generated/qga-qapi-visit-gen
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h :\
+qga/qapi-generated/qga-qapi-visit-gen ;
+qga/qapi-generated/qga-qapi-visit-gen: \
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
-		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
+		-o $(dir $@) -p "qga-" $<, \
 		"GEN","$@")
+
+.INTERMEDIATE: qga/qapi-generated/qga-qapi-commands-gen
 qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal.c :\
+qga/qapi-generated/qga-qapi-commands-gen ;
+qga/qapi-generated/qga-qapi-commands-gen: \
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
-		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
+		-o $(dir $@) -p "qga-" $<, \
 		"GEN","$@")
 
 qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
@@ -419,30 +428,39 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
 
-qapi-types.c qapi-types.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
+.INTERMEDIATE: qapi-types-gen
+qapi-types.c qapi-types.h: qapi-types-gen ;
+qapi-types-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
-		$(gen-out-type) -o "." -b $<, \
+		-b $<, \
 		"GEN","$@")
-qapi-visit.c qapi-visit.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
+
+.INTERMEDIATE: qapi-visit-gen
+qapi-visit.c qapi-visit.h: qapi-visit-gen ;
+qapi-visit-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
-		$(gen-out-type) -o "." -b $<, \
+		-b $<, \
 		"GEN","$@")
-qapi-event.c qapi-event.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
+
+.INTERMEDIATE: qapi-event-gen
+qapi-event.c qapi-event.h: qapi-event-gen
+qapi-event-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
-		$(gen-out-type) -o "." $<, \
+		$<, \
 		"GEN","$@")
-qmp-commands.h qmp-marshal.c :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
+
+.INTERMEDIATE: qapi-commands-gen
+qmp-commands.h qmp-marshal.c: qapi-commands-gen
+qapi-commands-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
-		$(gen-out-type) -o "." $<, \
+		$<, \
 		"GEN","$@")
-qmp-introspect.h qmp-introspect.c :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
+
+.INTERMEDIATE: qapi-introspect-gen
+qmp-introspect.h qmp-introspect.c: qapi-introspect-gen
+qapi-introspect-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
-		$(gen-out-type) -o "." $<, \
+		$<, \
 		"GEN","$@")
 
 QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qmp-commands.h)
diff --git a/Makefile.objs b/Makefile.objs
index bdfa3b6177..cc4f94d77a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,7 +2,7 @@
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
-util-obj-y += qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
+util-obj-y += qapi-types.o qapi-visit.o qapi-event.o
 
 chardev-obj-y = chardev/
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index de4a713c25..5d53c58506 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -626,30 +626,44 @@ tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
 tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-y) \
 	$(test-block-obj-y)
 
-tests/test-qapi-types.c tests/test-qapi-types.h :\
+.INTERMEDIATE: tests/test-qapi-types-gen
+tests/test-qapi-types.c tests/test-qapi-types.h: tests/test-qapi-types-gen ;
+tests/test-qapi-types-gen: \
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
+		-o tests -p "test-" $<, \
 		"GEN","$@")
-tests/test-qapi-visit.c tests/test-qapi-visit.h :\
+
+.INTERMEDIATE: tests/test-qapi-visit-gen
+tests/test-qapi-visit.c tests/test-qapi-visit.h: tests/test-qapi-visit-gen ;
+tests/test-qapi-visit-gen: \
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
+		-o tests -p "test-" $<, \
 		"GEN","$@")
-tests/test-qmp-commands.h tests/test-qmp-marshal.c :\
+
+.INTERMEDIATE: tests/test-qapi-commands-gen
+tests/test-qmp-commands.h tests/test-qmp-marshal.c: tests/test-qapi-commands-gen ;
+tests/test-qapi-commands-gen: \
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
+		-o tests -p "test-" $<, \
 		"GEN","$@")
-tests/test-qapi-event.c tests/test-qapi-event.h :\
+
+.INTERMEDIATE: tests/test-qapi-event-gen
+tests/test-qapi-event.c tests/test-qapi-event.h: tests/test-qapi-event-gen ;
+tests/test-qapi-event-gen: \
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
+		-o tests -p "test-" $<, \
 		"GEN","$@")
-tests/test-qmp-introspect.c tests/test-qmp-introspect.h :\
+
+.INTERMEDIATE: tests/test-qapi-introspect-gen
+tests/test-qmp-introspect.c tests/test-qmp-introspect.h: tests/test-qapi-introspect-gen ;
+tests/test-qapi-introspect-gen: \
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
+		-o tests -p "test-" $<, \
 		"GEN","$@")
 
 tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.json $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
@@ -660,7 +674,7 @@ tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.o $(te
 tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visitor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-obj-y)
-tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visitor.o $(test-qapi-obj-y)
+tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visitor.o $(test-qapi-obj-y) qmp-introspect.o
 tests/test-qmp-commands$(EXESUF): tests/test-qmp-commands.o tests/test-qmp-marshal.o $(test-qapi-obj-y)
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
-- 
2.13.6
