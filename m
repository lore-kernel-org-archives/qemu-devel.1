Received: from eggs.gnu.org ([2001:4830:134:3::10]:35099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNPbJ-0007ue-Py
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNPbH-0003bm-TH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:55:01 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Nov 2018 15:54:49 -0600
Message-Id: <20181115215449.1300769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, xiezhide@huawei.com, qemu-trivial@nongnu.org

Adding a new qapi module had some rather tedious repetition to
wire it into Makefile. Add some indirection by taking advantage
of GNU Make string processing to expand a list of module names
into all the required artifacts, so that future additions of a
new module need only touch the list of module names.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

I finally found time to follow through with my threats to make it
MUCH easier to add a new qapi/FOO.json file.

Should be no semantic change, but as it is not fixing an actual
bug, I don't care if it goes in 3.1 or 4.0.

 Makefile | 194 +++++++------------------------------------------------
 1 file changed, 25 insertions(+), 169 deletions(-)

diff --git a/Makefile b/Makefile
index f2947186a4c..e343722c71d 100644
--- a/Makefile
+++ b/Makefile
@@ -88,82 +88,28 @@ endif
 include $(SRC_PATH)/rules.mak

 GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
-GENERATED_FILES += qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
-GENERATED_FILES += qapi/qapi-types.h qapi/qapi-types.c
-GENERATED_FILES += qapi/qapi-types-block-core.h qapi/qapi-types-block-core.c
-GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
-GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
-GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
-GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
-GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
-GENERATED_FILES += qapi/qapi-types-job.h qapi/qapi-types-job.c
-GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
-GENERATED_FILES += qapi/qapi-types-misc.h qapi/qapi-types-misc.c
-GENERATED_FILES += qapi/qapi-types-net.h qapi/qapi-types-net.c
-GENERATED_FILES += qapi/qapi-types-rocker.h qapi/qapi-types-rocker.c
-GENERATED_FILES += qapi/qapi-types-run-state.h qapi/qapi-types-run-state.c
-GENERATED_FILES += qapi/qapi-types-sockets.h qapi/qapi-types-sockets.c
-GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
-GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
-GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
-GENERATED_FILES += qapi/qapi-types-ui.h qapi/qapi-types-ui.c
-GENERATED_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
-GENERATED_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
-GENERATED_FILES += qapi/qapi-visit-block-core.h qapi/qapi-visit-block-core.c
-GENERATED_FILES += qapi/qapi-visit-block.h qapi/qapi-visit-block.c
-GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
-GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
-GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
-GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
-GENERATED_FILES += qapi/qapi-visit-job.h qapi/qapi-visit-job.c
-GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
-GENERATED_FILES += qapi/qapi-visit-misc.h qapi/qapi-visit-misc.c
-GENERATED_FILES += qapi/qapi-visit-net.h qapi/qapi-visit-net.c
-GENERATED_FILES += qapi/qapi-visit-rocker.h qapi/qapi-visit-rocker.c
-GENERATED_FILES += qapi/qapi-visit-run-state.h qapi/qapi-visit-run-state.c
-GENERATED_FILES += qapi/qapi-visit-sockets.h qapi/qapi-visit-sockets.c
-GENERATED_FILES += qapi/qapi-visit-tpm.h qapi/qapi-visit-tpm.c
-GENERATED_FILES += qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
-GENERATED_FILES += qapi/qapi-visit-transaction.h qapi/qapi-visit-transaction.c
-GENERATED_FILES += qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
-GENERATED_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
-GENERATED_FILES += qapi/qapi-commands-block-core.h qapi/qapi-commands-block-core.c
-GENERATED_FILES += qapi/qapi-commands-block.h qapi/qapi-commands-block.c
-GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
-GENERATED_FILES += qapi/qapi-commands-common.h qapi/qapi-commands-common.c
-GENERATED_FILES += qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto.c
-GENERATED_FILES += qapi/qapi-commands-introspect.h qapi/qapi-commands-introspect.c
-GENERATED_FILES += qapi/qapi-commands-job.h qapi/qapi-commands-job.c
-GENERATED_FILES += qapi/qapi-commands-migration.h qapi/qapi-commands-migration.c
-GENERATED_FILES += qapi/qapi-commands-misc.h qapi/qapi-commands-misc.c
-GENERATED_FILES += qapi/qapi-commands-net.h qapi/qapi-commands-net.c
-GENERATED_FILES += qapi/qapi-commands-rocker.h qapi/qapi-commands-rocker.c
-GENERATED_FILES += qapi/qapi-commands-run-state.h qapi/qapi-commands-run-state.c
-GENERATED_FILES += qapi/qapi-commands-sockets.h qapi/qapi-commands-sockets.c
-GENERATED_FILES += qapi/qapi-commands-tpm.h qapi/qapi-commands-tpm.c
-GENERATED_FILES += qapi/qapi-commands-trace.h qapi/qapi-commands-trace.c
-GENERATED_FILES += qapi/qapi-commands-transaction.h qapi/qapi-commands-transaction.c
-GENERATED_FILES += qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
-GENERATED_FILES += qapi/qapi-events.h qapi/qapi-events.c
-GENERATED_FILES += qapi/qapi-events-block-core.h qapi/qapi-events-block-core.c
-GENERATED_FILES += qapi/qapi-events-block.h qapi/qapi-events-block.c
-GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
-GENERATED_FILES += qapi/qapi-events-common.h qapi/qapi-events-common.c
-GENERATED_FILES += qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
-GENERATED_FILES += qapi/qapi-events-introspect.h qapi/qapi-events-introspect.c
-GENERATED_FILES += qapi/qapi-events-job.h qapi/qapi-events-job.c
-GENERATED_FILES += qapi/qapi-events-migration.h qapi/qapi-events-migration.c
-GENERATED_FILES += qapi/qapi-events-misc.h qapi/qapi-events-misc.c
-GENERATED_FILES += qapi/qapi-events-net.h qapi/qapi-events-net.c
-GENERATED_FILES += qapi/qapi-events-rocker.h qapi/qapi-events-rocker.c
-GENERATED_FILES += qapi/qapi-events-run-state.h qapi/qapi-events-run-state.c
-GENERATED_FILES += qapi/qapi-events-sockets.h qapi/qapi-events-sockets.c
-GENERATED_FILES += qapi/qapi-events-tpm.h qapi/qapi-events-tpm.c
-GENERATED_FILES += qapi/qapi-events-trace.h qapi/qapi-events-trace.c
-GENERATED_FILES += qapi/qapi-events-transaction.h qapi/qapi-events-transaction.c
-GENERATED_FILES += qapi/qapi-events-ui.h qapi/qapi-events-ui.c
-GENERATED_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
-GENERATED_FILES += qapi/qapi-doc.texi
+
+QAPI_MODULES = block-core block char common crypto introspect job migration
+QAPI_MODULES += misc net rocker run-state sockets tpm trace transaction ui
+
+GENERATED_QAPI_FILES = qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
+GENERATED_QAPI_FILES += qapi/qapi-types.h qapi/qapi-types.c
+GENERATED_QAPI_FILES += $(patsubst %,qapi/qapi-types-%.h,$(QAPI_MODULES))
+GENERATED_QAPI_FILES += $(patsubst %,qapi/qapi-types-%.c,$(QAPI_MODULES))
+GENERATED_QAPI_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
+GENERATED_QAPI_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
+GENERATED_QAPI_FILES += $(patsubst %,qapi/qapi-visit-%.h,$(QAPI_MODULES))
+GENERATED_QAPI_FILES += $(patsubst %,qapi/qapi-visit-%.c,$(QAPI_MODULES))
+GENERATED_QAPI_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
+GENERATED_QAPI_FILES += $(patsubst %,qapi/qapi-commands-%.h,$(QAPI_MODULES))
+GENERATED_QAPI_FILES += $(patsubst %,qapi/qapi-commands-%.c,$(QAPI_MODULES))
+GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
+GENERATED_QAPI_FILES += $(patsubst %,qapi/qapi-events-%.h,$(QAPI_MODULES))
+GENERATED_QAPI_FILES += $(patsubst %,qapi/qapi-events-%.c,$(QAPI_MODULES))
+GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
+GENERATED_QAPI_FILES += qapi/qapi-doc.texi
+
+GENERATED_FILES += $(GENERATED_QAPI_FILES)

 GENERATED_FILES += trace/generated-tcg-tracers.h

@@ -583,100 +529,10 @@ qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-p
 		"GEN","$(@:%-timestamp=%)")
 	@>$@

-qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
-               $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
-               $(SRC_PATH)/qapi/char.json \
-               $(SRC_PATH)/qapi/crypto.json \
-               $(SRC_PATH)/qapi/introspect.json \
-               $(SRC_PATH)/qapi/job.json \
-               $(SRC_PATH)/qapi/migration.json \
-               $(SRC_PATH)/qapi/misc.json \
-               $(SRC_PATH)/qapi/net.json \
-               $(SRC_PATH)/qapi/rocker.json \
-               $(SRC_PATH)/qapi/run-state.json \
-               $(SRC_PATH)/qapi/sockets.json \
-               $(SRC_PATH)/qapi/tpm.json \
-               $(SRC_PATH)/qapi/trace.json \
-               $(SRC_PATH)/qapi/transaction.json \
-               $(SRC_PATH)/qapi/ui.json
+qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json \
+               $(patsubst %,$(SRC_PATH)/qapi/%.json,$(QAPI_MODULES))

-qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
-qapi/qapi-types.c qapi/qapi-types.h \
-qapi/qapi-types-block-core.c qapi/qapi-types-block-core.h \
-qapi/qapi-types-block.c qapi/qapi-types-block.h \
-qapi/qapi-types-char.c qapi/qapi-types-char.h \
-qapi/qapi-types-common.c qapi/qapi-types-common.h \
-qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
-qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
-qapi/qapi-types-job.c qapi/qapi-types-job.h \
-qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
-qapi/qapi-types-misc.c qapi/qapi-types-misc.h \
-qapi/qapi-types-net.c qapi/qapi-types-net.h \
-qapi/qapi-types-rocker.c qapi/qapi-types-rocker.h \
-qapi/qapi-types-run-state.c qapi/qapi-types-run-state.h \
-qapi/qapi-types-sockets.c qapi/qapi-types-sockets.h \
-qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
-qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
-qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
-qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
-qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
-qapi/qapi-visit.c qapi/qapi-visit.h \
-qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
-qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
-qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
-qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
-qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
-qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
-qapi/qapi-visit-job.c qapi/qapi-visit-job.h \
-qapi/qapi-visit-migration.c qapi/qapi-visit-migration.h \
-qapi/qapi-visit-misc.c qapi/qapi-visit-misc.h \
-qapi/qapi-visit-net.c qapi/qapi-visit-net.h \
-qapi/qapi-visit-rocker.c qapi/qapi-visit-rocker.h \
-qapi/qapi-visit-run-state.c qapi/qapi-visit-run-state.h \
-qapi/qapi-visit-sockets.c qapi/qapi-visit-sockets.h \
-qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
-qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
-qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
-qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
-qapi/qapi-commands.h qapi/qapi-commands.c \
-qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
-qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
-qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
-qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
-qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
-qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
-qapi/qapi-commands-job.c qapi/qapi-commands-job.h \
-qapi/qapi-commands-migration.c qapi/qapi-commands-migration.h \
-qapi/qapi-commands-misc.c qapi/qapi-commands-misc.h \
-qapi/qapi-commands-net.c qapi/qapi-commands-net.h \
-qapi/qapi-commands-rocker.c qapi/qapi-commands-rocker.h \
-qapi/qapi-commands-run-state.c qapi/qapi-commands-run-state.h \
-qapi/qapi-commands-sockets.c qapi/qapi-commands-sockets.h \
-qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
-qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
-qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
-qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
-qapi/qapi-events.c qapi/qapi-events.h \
-qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
-qapi/qapi-events-block.c qapi/qapi-events-block.h \
-qapi/qapi-events-char.c qapi/qapi-events-char.h \
-qapi/qapi-events-common.c qapi/qapi-events-common.h \
-qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
-qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
-qapi/qapi-events-job.c qapi/qapi-events-job.h \
-qapi/qapi-events-migration.c qapi/qapi-events-migration.h \
-qapi/qapi-events-misc.c qapi/qapi-events-misc.h \
-qapi/qapi-events-net.c qapi/qapi-events-net.h \
-qapi/qapi-events-rocker.c qapi/qapi-events-rocker.h \
-qapi/qapi-events-run-state.c qapi/qapi-events-run-state.h \
-qapi/qapi-events-sockets.c qapi/qapi-events-sockets.h \
-qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
-qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
-qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
-qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
-qapi/qapi-introspect.h qapi/qapi-introspect.c \
-qapi/qapi-doc.texi: \
-qapi-gen-timestamp ;
+$(GENERATED_QAPI_FILES): qapi-gen-timestamp ;
 qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o "qapi" -b $<, \
-- 
2.17.2
