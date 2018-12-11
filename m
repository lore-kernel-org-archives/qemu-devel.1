Received: from eggs.gnu.org ([2001:4830:134:3::10]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPM-0008PM-B3
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPJ-0007fr-Tt
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:24 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:27 +0100
Message-Id: <20181211180352.19644-6-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/30] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

Adding a new qapi module had some rather tedious repetition to
wire it into Makefile, Makefile.objs, and .gitignore (for example,
see commit bf42508f and its followup b61acdec). For make, add some
indirection by taking advantage of GNU Make string processing to
expand a list of module names into all the required artifacts, so
that future additions of a new module need only touch the list of
module names.  And for gitignore, use globs to cover all generated
file names.

The list has to live in Makefile.objs, due to the way that
our unnest-vars macro slirps in that file without remembering
any definition of $(QAPI_MODULES) from Makefile.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20181116200016.2080785-1-eblake@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .gitignore    |  72 ++-----------------
 Makefile      | 194 +++++++-------------------------------------------
 Makefile.objs |  75 ++-----------------
 3 files changed, 35 insertions(+), 306 deletions(-)

diff --git a/.gitignore b/.gitignore
index 64efdfd929..0430257313 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,78 +30,14 @@
 /qapi-gen-timestamp
 /qapi/qapi-builtin-types.[ch]
 /qapi/qapi-builtin-visit.[ch]
-/qapi/qapi-commands-block-core.[ch]
-/qapi/qapi-commands-block.[ch]
-/qapi/qapi-commands-char.[ch]
-/qapi/qapi-commands-common.[ch]
-/qapi/qapi-commands-crypto.[ch]
-/qapi/qapi-commands-introspect.[ch]
-/qapi/qapi-commands-job.[ch]
-/qapi/qapi-commands-migration.[ch]
-/qapi/qapi-commands-misc.[ch]
-/qapi/qapi-commands-net.[ch]
-/qapi/qapi-commands-rocker.[ch]
-/qapi/qapi-commands-run-state.[ch]
-/qapi/qapi-commands-sockets.[ch]
-/qapi/qapi-commands-tpm.[ch]
-/qapi/qapi-commands-trace.[ch]
-/qapi/qapi-commands-transaction.[ch]
-/qapi/qapi-commands-ui.[ch]
+/qapi/qapi-commands-*.[ch]
 /qapi/qapi-commands.[ch]
-/qapi/qapi-events-block-core.[ch]
-/qapi/qapi-events-block.[ch]
-/qapi/qapi-events-char.[ch]
-/qapi/qapi-events-common.[ch]
-/qapi/qapi-events-crypto.[ch]
-/qapi/qapi-events-introspect.[ch]
-/qapi/qapi-events-job.[ch]
-/qapi/qapi-events-migration.[ch]
-/qapi/qapi-events-misc.[ch]
-/qapi/qapi-events-net.[ch]
-/qapi/qapi-events-rocker.[ch]
-/qapi/qapi-events-run-state.[ch]
-/qapi/qapi-events-sockets.[ch]
-/qapi/qapi-events-tpm.[ch]
-/qapi/qapi-events-trace.[ch]
-/qapi/qapi-events-transaction.[ch]
-/qapi/qapi-events-ui.[ch]
+/qapi/qapi-events-*.[ch]
 /qapi/qapi-events.[ch]
 /qapi/qapi-introspect.[ch]
-/qapi/qapi-types-block-core.[ch]
-/qapi/qapi-types-block.[ch]
-/qapi/qapi-types-char.[ch]
-/qapi/qapi-types-common.[ch]
-/qapi/qapi-types-crypto.[ch]
-/qapi/qapi-types-introspect.[ch]
-/qapi/qapi-types-job.[ch]
-/qapi/qapi-types-migration.[ch]
-/qapi/qapi-types-misc.[ch]
-/qapi/qapi-types-net.[ch]
-/qapi/qapi-types-rocker.[ch]
-/qapi/qapi-types-run-state.[ch]
-/qapi/qapi-types-sockets.[ch]
-/qapi/qapi-types-tpm.[ch]
-/qapi/qapi-types-trace.[ch]
-/qapi/qapi-types-transaction.[ch]
-/qapi/qapi-types-ui.[ch]
+/qapi/qapi-types-*.[ch]
 /qapi/qapi-types.[ch]
-/qapi/qapi-visit-block-core.[ch]
-/qapi/qapi-visit-block.[ch]
-/qapi/qapi-visit-char.[ch]
-/qapi/qapi-visit-common.[ch]
-/qapi/qapi-visit-crypto.[ch]
-/qapi/qapi-visit-introspect.[ch]
-/qapi/qapi-visit-job.[ch]
-/qapi/qapi-visit-migration.[ch]
-/qapi/qapi-visit-misc.[ch]
-/qapi/qapi-visit-net.[ch]
-/qapi/qapi-visit-rocker.[ch]
-/qapi/qapi-visit-run-state.[ch]
-/qapi/qapi-visit-sockets.[ch]
-/qapi/qapi-visit-tpm.[ch]
-/qapi/qapi-visit-trace.[ch]
-/qapi/qapi-visit-transaction.[ch]
-/qapi/qapi-visit-ui.[ch]
+/qapi/qapi-visit-*.[ch]
 /qapi/qapi-visit.[ch]
 /qapi/qapi-doc.texi
 /qemu-doc.html
diff --git a/Makefile b/Makefile
index f2947186a4..c8b9efdad4 100644
--- a/Makefile
+++ b/Makefile
@@ -88,82 +88,26 @@ endif
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
+#see Makefile.objs for the definition of QAPI_MODULES
+GENERATED_QAPI_FILES = qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
+GENERATED_QAPI_FILES += qapi/qapi-types.h qapi/qapi-types.c
+GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.h)
+GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.c)
+GENERATED_QAPI_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
+GENERATED_QAPI_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
+GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.h)
+GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.c)
+GENERATED_QAPI_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
+GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.h)
+GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.c)
+GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
+GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
+GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
+GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
+GENERATED_QAPI_FILES += qapi/qapi-doc.texi
+
+GENERATED_FILES += $(GENERATED_QAPI_FILES)
 
 GENERATED_FILES += trace/generated-tcg-tracers.h
 
@@ -583,100 +527,10 @@ qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-p
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
-
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
+qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json \
+               $(QAPI_MODULES:%=$(SRC_PATH)/qapi/%.json)
+
+$(GENERATED_QAPI_FILES): qapi-gen-timestamp ;
 qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o "qapi" -b $<, \
diff --git a/Makefile.objs b/Makefile.objs
index 1e1ff387d7..56af0347d3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,63 +1,18 @@
+QAPI_MODULES = block-core block char common crypto introspect job migration
+QAPI_MODULES += misc net rocker run-state sockets tpm trace transaction ui
+
 #######################################################################
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
 util-obj-y += qapi/qapi-builtin-types.o
 util-obj-y += qapi/qapi-types.o
-util-obj-y += qapi/qapi-types-block-core.o
-util-obj-y += qapi/qapi-types-block.o
-util-obj-y += qapi/qapi-types-char.o
-util-obj-y += qapi/qapi-types-common.o
-util-obj-y += qapi/qapi-types-crypto.o
-util-obj-y += qapi/qapi-types-introspect.o
-util-obj-y += qapi/qapi-types-job.o
-util-obj-y += qapi/qapi-types-migration.o
-util-obj-y += qapi/qapi-types-misc.o
-util-obj-y += qapi/qapi-types-net.o
-util-obj-y += qapi/qapi-types-rocker.o
-util-obj-y += qapi/qapi-types-run-state.o
-util-obj-y += qapi/qapi-types-sockets.o
-util-obj-y += qapi/qapi-types-tpm.o
-util-obj-y += qapi/qapi-types-trace.o
-util-obj-y += qapi/qapi-types-transaction.o
-util-obj-y += qapi/qapi-types-ui.o
+util-obj-y += $(QAPI_MODULES:%=qapi/qapi-types-%.o)
 util-obj-y += qapi/qapi-builtin-visit.o
 util-obj-y += qapi/qapi-visit.o
-util-obj-y += qapi/qapi-visit-block-core.o
-util-obj-y += qapi/qapi-visit-block.o
-util-obj-y += qapi/qapi-visit-char.o
-util-obj-y += qapi/qapi-visit-common.o
-util-obj-y += qapi/qapi-visit-crypto.o
-util-obj-y += qapi/qapi-visit-introspect.o
-util-obj-y += qapi/qapi-visit-job.o
-util-obj-y += qapi/qapi-visit-migration.o
-util-obj-y += qapi/qapi-visit-misc.o
-util-obj-y += qapi/qapi-visit-net.o
-util-obj-y += qapi/qapi-visit-rocker.o
-util-obj-y += qapi/qapi-visit-run-state.o
-util-obj-y += qapi/qapi-visit-sockets.o
-util-obj-y += qapi/qapi-visit-tpm.o
-util-obj-y += qapi/qapi-visit-trace.o
-util-obj-y += qapi/qapi-visit-transaction.o
-util-obj-y += qapi/qapi-visit-ui.o
+util-obj-y += $(QAPI_MODULES:%=qapi/qapi-visit-%.o)
 util-obj-y += qapi/qapi-events.o
-util-obj-y += qapi/qapi-events-block-core.o
-util-obj-y += qapi/qapi-events-block.o
-util-obj-y += qapi/qapi-events-char.o
-util-obj-y += qapi/qapi-events-common.o
-util-obj-y += qapi/qapi-events-crypto.o
-util-obj-y += qapi/qapi-events-introspect.o
-util-obj-y += qapi/qapi-events-job.o
-util-obj-y += qapi/qapi-events-migration.o
-util-obj-y += qapi/qapi-events-misc.o
-util-obj-y += qapi/qapi-events-net.o
-util-obj-y += qapi/qapi-events-rocker.o
-util-obj-y += qapi/qapi-events-run-state.o
-util-obj-y += qapi/qapi-events-sockets.o
-util-obj-y += qapi/qapi-events-tpm.o
-util-obj-y += qapi/qapi-events-trace.o
-util-obj-y += qapi/qapi-events-transaction.o
-util-obj-y += qapi/qapi-events-ui.o
+util-obj-y += $(QAPI_MODULES:%=qapi/qapi-events-%.o)
 util-obj-y += qapi/qapi-introspect.o
 
 chardev-obj-y = chardev/
@@ -138,23 +93,7 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 # qapi
 
 common-obj-y += qapi/qapi-commands.o
-common-obj-y += qapi/qapi-commands-block-core.o
-common-obj-y += qapi/qapi-commands-block.o
-common-obj-y += qapi/qapi-commands-char.o
-common-obj-y += qapi/qapi-commands-common.o
-common-obj-y += qapi/qapi-commands-crypto.o
-common-obj-y += qapi/qapi-commands-introspect.o
-common-obj-y += qapi/qapi-commands-job.o
-common-obj-y += qapi/qapi-commands-migration.o
-common-obj-y += qapi/qapi-commands-misc.o
-common-obj-y += qapi/qapi-commands-net.o
-common-obj-y += qapi/qapi-commands-rocker.o
-common-obj-y += qapi/qapi-commands-run-state.o
-common-obj-y += qapi/qapi-commands-sockets.o
-common-obj-y += qapi/qapi-commands-tpm.o
-common-obj-y += qapi/qapi-commands-trace.o
-common-obj-y += qapi/qapi-commands-transaction.o
-common-obj-y += qapi/qapi-commands-ui.o
+common-obj-y += $(QAPI_MODULES:%=qapi/qapi-commands-%.o)
 common-obj-y += qapi/qapi-introspect.o
 common-obj-y += qmp.o hmp.o
 endif
-- 
2.19.2
