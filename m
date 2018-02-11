Received: from eggs.gnu.org ([2001:4830:134:3::10]:54331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3n-0007DZ-8U
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3X-0006LB-FH
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3X-0006KH-32
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:36:05 +0100
Message-Id: <20180211093607.27351-28-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 27/29] qapi: Move qapi-schema.json to qapi/,
 rename generated files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

Move qapi-schema.json to qapi/, so it's next to its modules, and all
files get generated to qapi/, not just the ones generated for modules.

Consistently name the generated files qapi-MODULE.EXT:
qmp-commands.[ch] become qapi-commands.[ch], qapi-event.[ch] become
qapi-events.[ch], and qmp-introspect.[ch] become qapi-introspect.[ch].
This gets rid of the temporary hacks in scripts/qapi/commands.py and
scripts/qapi/events.py.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore                                | 16 ++++++------
 Makefile                                  | 42 +++++++++++++++----------------
 Makefile.objs                             | 21 ++++++++--------
 backends/hostmem.c                        |  2 +-
 docs/devel/qapi-code-gen.txt              | 30 +++++++++++-----------
 docs/devel/writing-qmp-commands.txt       |  2 +-
 docs/interop/qmp-intro.txt                |  2 +-
 hmp.c                                     |  2 +-
 include/qapi/qmp/qobject.h                |  2 +-
 include/qapi/visitor.h                    |  2 +-
 include/qom/object.h                      |  2 +-
 monitor.c                                 |  6 ++---
 net/filter-buffer.c                       |  2 +-
 qapi/misc.json                            |  4 +--
 qapi-schema.json => qapi/qapi-schema.json | 32 +++++++++++------------
 qga/Makefile.objs                         |  2 +-
 qga/commands-posix.c                      |  2 +-
 qga/commands-win32.c                      |  2 +-
 qga/commands.c                            |  2 +-
 qga/main.c                                |  2 +-
 qom/object.c                              |  2 +-
 scripts/qapi/commands.py                  |  7 ------
 scripts/qapi/events.py                    |  9 +------
 scripts/qapi/introspect.py                |  4 +--
 scripts/qapi/types.py                     |  6 ++---
 scripts/qapi/visit.py                     |  6 ++---
 tests/.gitignore                          |  6 ++---
 tests/Makefile.include                    | 14 +++++------
 tests/test-qmp-cmds.c                     |  2 +-
 tests/test-qmp-event.c                    |  2 +-
 tests/test-qobject-input-visitor.c        |  6 ++---
 tpm.c                                     |  1 -
 ui/cocoa.m                                |  2 +-
 ui/vnc.c                                  |  2 +-
 34 files changed, 116 insertions(+), 130 deletions(-)
 rename qapi-schema.json => qapi/qapi-schema.json (85%)

diff --git a/.gitignore b/.gitignore
index 7f162e862f..dabfe6bea8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,8 +29,8 @@
 /qga/qapi-generated
 /qapi-generated
 /qapi-gen-timestamp
-/qapi-builtin-types.[ch]
-/qapi-builtin-visit.[ch]
+/qapi/qapi-builtin-types.[ch]
+/qapi/qapi-builtin-visit.[ch]
 /qapi/qapi-commands-block-core.[ch]
 /qapi/qapi-commands-block.[ch]
 /qapi/qapi-commands-char.[ch]
@@ -47,6 +47,7 @@
 /qapi/qapi-commands-trace.[ch]
 /qapi/qapi-commands-transaction.[ch]
 /qapi/qapi-commands-ui.[ch]
+/qapi/qapi-commands.[ch]
 /qapi/qapi-events-block-core.[ch]
 /qapi/qapi-events-block.[ch]
 /qapi/qapi-events-char.[ch]
@@ -63,6 +64,8 @@
 /qapi/qapi-events-trace.[ch]
 /qapi/qapi-events-transaction.[ch]
 /qapi/qapi-events-ui.[ch]
+/qapi/qapi-events.[ch]
+/qapi/qapi-introspect.[ch]
 /qapi/qapi-types-block-core.[ch]
 /qapi/qapi-types-block.[ch]
 /qapi/qapi-types-char.[ch]
@@ -79,7 +82,7 @@
 /qapi/qapi-types-trace.[ch]
 /qapi/qapi-types-transaction.[ch]
 /qapi/qapi-types-ui.[ch]
-/qapi-types.[ch]
+/qapi/qapi-types.[ch]
 /qapi/qapi-visit-block-core.[ch]
 /qapi/qapi-visit-block.[ch]
 /qapi/qapi-visit-char.[ch]
@@ -96,11 +99,8 @@
 /qapi/qapi-visit-trace.[ch]
 /qapi/qapi-visit-transaction.[ch]
 /qapi/qapi-visit-ui.[ch]
-/qapi-visit.[ch]
-/qapi-event.[ch]
-/qapi-doc.texi
-/qmp-commands.[ch]
-/qmp-introspect.[ch]
+/qapi/qapi-visit.[ch]
+/qapi/qapi-doc.texi
 /qemu-doc.html
 /qemu-doc.info
 /qemu-doc.txt
diff --git a/Makefile b/Makefile
index 50eb194877..84411ee6ab 100644
--- a/Makefile
+++ b/Makefile
@@ -90,8 +90,8 @@ endif
 include $(SRC_PATH)/rules.mak
 
 GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
-GENERATED_FILES += qapi-builtin-types.h qapi-builtin-types.c
-GENERATED_FILES += qapi-types.h qapi-types.c
+GENERATED_FILES += qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
+GENERATED_FILES += qapi/qapi-types.h qapi/qapi-types.c
 GENERATED_FILES += qapi/qapi-types-block-core.h qapi/qapi-types-block-core.c
 GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
 GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
@@ -108,8 +108,8 @@ GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
 GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
 GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
 GENERATED_FILES += qapi/qapi-types-ui.h qapi/qapi-types-ui.c
-GENERATED_FILES += qapi-builtin-visit.h qapi-builtin-visit.c
-GENERATED_FILES += qapi-visit.h qapi-visit.c
+GENERATED_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
+GENERATED_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
 GENERATED_FILES += qapi/qapi-visit-block-core.h qapi/qapi-visit-block-core.c
 GENERATED_FILES += qapi/qapi-visit-block.h qapi/qapi-visit-block.c
 GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
@@ -126,7 +126,7 @@ GENERATED_FILES += qapi/qapi-visit-tpm.h qapi/qapi-visit-tpm.c
 GENERATED_FILES += qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
 GENERATED_FILES += qapi/qapi-visit-transaction.h qapi/qapi-visit-transaction.c
 GENERATED_FILES += qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
-GENERATED_FILES += qmp-commands.h qmp-commands.c
+GENERATED_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_FILES += qapi/qapi-commands-block-core.h qapi/qapi-commands-block-core.c
 GENERATED_FILES += qapi/qapi-commands-block.h qapi/qapi-commands-block.c
 GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
@@ -143,7 +143,7 @@ GENERATED_FILES += qapi/qapi-commands-tpm.h qapi/qapi-commands-tpm.c
 GENERATED_FILES += qapi/qapi-commands-trace.h qapi/qapi-commands-trace.c
 GENERATED_FILES += qapi/qapi-commands-transaction.h qapi/qapi-commands-transaction.c
 GENERATED_FILES += qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
-GENERATED_FILES += qapi-event.h qapi-event.c
+GENERATED_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_FILES += qapi/qapi-events-block-core.h qapi/qapi-events-block-core.c
 GENERATED_FILES += qapi/qapi-events-block.h qapi/qapi-events-block.c
 GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
@@ -160,8 +160,8 @@ GENERATED_FILES += qapi/qapi-events-tpm.h qapi/qapi-events-tpm.c
 GENERATED_FILES += qapi/qapi-events-trace.h qapi/qapi-events-trace.c
 GENERATED_FILES += qapi/qapi-events-transaction.h qapi/qapi-events-transaction.c
 GENERATED_FILES += qapi/qapi-events-ui.h qapi/qapi-events-ui.c
-GENERATED_FILES += qmp-introspect.c qmp-introspect.h
-GENERATED_FILES += qapi-doc.texi
+GENERATED_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
+GENERATED_FILES += qapi/qapi-doc.texi
 
 GENERATED_FILES += trace/generated-tcg-tracers.h
 
@@ -563,7 +563,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
 
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
-qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-commands.c \
+qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-commands.c \
 qga/qapi-generated/qga-qapi-doc.texi: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
@@ -572,7 +572,7 @@ qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-p
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
 
-qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
+qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
@@ -588,8 +588,8 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
 
-qapi-builtin-types.c qapi-builtin-types.h \
-qapi-types.c qapi-types.h \
+qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
+qapi/qapi-types.c qapi/qapi-types.h \
 qapi/qapi-types-block-core.c qapi/qapi-types-block-core.h \
 qapi/qapi-types-block.c qapi/qapi-types-block.h \
 qapi/qapi-types-char.c qapi/qapi-types-char.h \
@@ -606,8 +606,8 @@ qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
-qapi-builtin-visit.c qapi-builtin-visit.h \
-qapi-visit.c qapi-visit.h \
+qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
+qapi/qapi-visit.c qapi/qapi-visit.h \
 qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
 qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
 qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
@@ -624,7 +624,7 @@ qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
-qmp-commands.h qmp-commands.c \
+qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
 qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
 qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
@@ -641,7 +641,7 @@ qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
-qapi-event.c qapi-event.h \
+qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
 qapi/qapi-events-block.c qapi/qapi-events-block.h \
 qapi/qapi-events-char.c qapi/qapi-events-char.h \
@@ -658,16 +658,16 @@ qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
-qmp-introspect.h qmp-introspect.c \
-qapi-doc.texi: \
+qapi/qapi-introspect.h qapi/qapi-introspect.c \
+qapi/qapi-doc.texi: \
 qapi-gen-timestamp ;
 qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o "." -b $<, \
+		-o "qapi" -b $<, \
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
 
-QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qmp-commands.h)
+QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qapi-commands.h)
 $(qga-obj-y): $(QGALIB_GEN)
 
 qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
@@ -934,7 +934,7 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-docs/interop/qemu-qmp-qapi.texi: qapi-doc.texi
+docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
 docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
diff --git a/Makefile.objs b/Makefile.objs
index a7986bbf0b..9aa1024c34 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,8 +2,8 @@
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
-util-obj-y += qapi-builtin-types.o
-util-obj-y += qapi-types.o
+util-obj-y += qapi/qapi-builtin-types.o
+util-obj-y += qapi/qapi-types.o
 util-obj-y += qapi/qapi-types-block-core.o
 util-obj-y += qapi/qapi-types-block.o
 util-obj-y += qapi/qapi-types-char.o
@@ -20,8 +20,8 @@ util-obj-y += qapi/qapi-types-tpm.o
 util-obj-y += qapi/qapi-types-trace.o
 util-obj-y += qapi/qapi-types-transaction.o
 util-obj-y += qapi/qapi-types-ui.o
-util-obj-y += qapi-builtin-visit.o
-util-obj-y += qapi-visit.o
+util-obj-y += qapi/qapi-builtin-visit.o
+util-obj-y += qapi/qapi-visit.o
 util-obj-y += qapi/qapi-visit-block-core.o
 util-obj-y += qapi/qapi-visit-block.o
 util-obj-y += qapi/qapi-visit-char.o
@@ -38,7 +38,7 @@ util-obj-y += qapi/qapi-visit-tpm.o
 util-obj-y += qapi/qapi-visit-trace.o
 util-obj-y += qapi/qapi-visit-transaction.o
 util-obj-y += qapi/qapi-visit-ui.o
-util-obj-y += qapi-event.o
+util-obj-y += qapi/qapi-events.o
 util-obj-y += qapi/qapi-events-block-core.o
 util-obj-y += qapi/qapi-events-block.o
 util-obj-y += qapi/qapi-events-char.o
@@ -55,7 +55,7 @@ util-obj-y += qapi/qapi-events-tpm.o
 util-obj-y += qapi/qapi-events-trace.o
 util-obj-y += qapi/qapi-events-transaction.o
 util-obj-y += qapi/qapi-events-ui.o
-util-obj-y += qmp-introspect.o
+util-obj-y += qapi/qapi-introspect.o
 
 chardev-obj-y = chardev/
 
@@ -131,7 +131,7 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 ######################################################################
 # qapi
 
-common-obj-y += qmp-commands.o
+common-obj-y += qapi/qapi-commands.o
 common-obj-y += qapi/qapi-commands-block-core.o
 common-obj-y += qapi/qapi-commands-block.o
 common-obj-y += qapi/qapi-commands-char.o
@@ -148,7 +148,7 @@ common-obj-y += qapi/qapi-commands-tpm.o
 common-obj-y += qapi/qapi-commands-trace.o
 common-obj-y += qapi/qapi-commands-transaction.o
 common-obj-y += qapi/qapi-commands-ui.o
-common-obj-y += qmp-introspect.o
+common-obj-y += qapi/qapi-introspect.o
 common-obj-y += qmp.o hmp.o
 endif
 
@@ -171,8 +171,9 @@ target-obj-y += trace/
 ######################################################################
 # guest agent
 
-# FIXME: a few definitions from qapi-types.o/qapi-visit.o are needed
-# by libqemuutil.a.  These should be moved to a separate .json schema.
+# FIXME: a few definitions from qapi/qapi-types.o and
+# qapi/qapi-visit.o are needed by libqemuutil.a.  These should be
+# extracted into a QAPI schema module, or perhaps a separate schema.
 qga-obj-y = qga/
 qga-vss-dll-obj-y = qga/
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 0afaf7160a..1292a9da1e 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -14,7 +14,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index ba1dc73298..0c4fc342fe 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -647,7 +647,7 @@ name an event 'MAX', since the generator also produces a C enumeration
 of all event names with a generated _MAX value at the end.  When
 'data' is also specified, additional info will be included in the
 event, with similar semantics to a 'struct' expression.  Finally there
-will be C API generated in qapi-event.h; when called by QEMU code, a
+will be C API generated in qapi-events.h; when called by QEMU code, a
 message with timestamp will be emitted on the wire.
 
 An example event is:
@@ -1147,15 +1147,15 @@ declares qmp_COMMAND() that the user must implement.
 
 The following files are generated:
 
-$(prefix)qmp-commands.c: Command marshal/dispatch functions for each
-                         QMP command defined in the schema
+$(prefix)qapi-commands.c: Command marshal/dispatch functions for each
+                          QMP command defined in the schema
 
-$(prefix)qmp-commands.h: Function prototypes for the QMP commands
-                         specified in the schema
+$(prefix)qapi-commands.h: Function prototypes for the QMP commands
+                          specified in the schema
 
 Example:
 
-    $ cat qapi-generated/example-qmp-commands.h
+    $ cat qapi-generated/example-qapi-commands.h
 [Uninteresting stuff omitted...]
 
     #ifndef EXAMPLE_QMP_COMMANDS_H
@@ -1170,7 +1170,7 @@ Example:
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp);
 
     #endif
-    $ cat qapi-generated/example-qmp-commands.c
+    $ cat qapi-generated/example-qapi-commands.c
 [Uninteresting stuff omitted...]
 
     static void qmp_marshal_output_UserDefOne(UserDefOne *ret_in, QObject **ret_out, Error **errp)
@@ -1243,14 +1243,14 @@ qapi_event_send_EVENT().
 
 The following files are created:
 
-$(prefix)qapi-event.h - Function prototypes for each event type, plus an
+$(prefix)qapi-events.h - Function prototypes for each event type, plus an
                         enumeration of all event names
 
-$(prefix)qapi-event.c - Implementation of functions to send an event
+$(prefix)qapi-events.c - Implementation of functions to send an event
 
 Example:
 
-    $ cat qapi-generated/example-qapi-event.h
+    $ cat qapi-generated/example-qapi-events.h
 [Uninteresting stuff omitted...]
 
     #ifndef EXAMPLE_QAPI_EVENT_H
@@ -1273,7 +1273,7 @@ Example:
     extern const char *const example_QAPIEvent_lookup[];
 
     #endif
-    $ cat qapi-generated/example-qapi-event.c
+    $ cat qapi-generated/example-qapi-events.c
 [Uninteresting stuff omitted...]
 
     void qapi_event_send_my_event(Error **errp)
@@ -1305,14 +1305,14 @@ Example:
 
 The following files are created:
 
-$(prefix)qmp-introspect.c - Defines a string holding a JSON
+$(prefix)qapi-introspect.c - Defines a string holding a JSON
                             description of the schema
 
-$(prefix)qmp-introspect.h - Declares the above string
+$(prefix)qapi-introspect.h - Declares the above string
 
 Example:
 
-    $ cat qapi-generated/example-qmp-introspect.h
+    $ cat qapi-generated/example-qapi-introspect.h
 [Uninteresting stuff omitted...]
 
     #ifndef EXAMPLE_QMP_INTROSPECT_H
@@ -1321,7 +1321,7 @@ Example:
     extern const char example_qmp_schema_json[];
 
     #endif
-    $ cat qapi-generated/example-qmp-introspect.c
+    $ cat qapi-generated/example-qapi-introspect.c
 [Uninteresting stuff omitted...]
 
     const char example_qmp_schema_json[] = "["
diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
index 50385eff27..9dfc62bf5a 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -419,7 +419,7 @@ There are a number of things to be noticed:
    allocated by the implementation. This is so because the QAPI also generates
    a function to free its types and it cannot distinguish between dynamically
    or statically allocated strings
-6. You have to include "qapi/qmp-commands-misc.h" in qemu-timer.c
+6. You have to include "qapi/qapi-commands-misc.h" in qemu-timer.c
 
 Time to test the new command. Build qemu, run it as described in the "Testing"
 section and try this:
diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index 430fe1b747..900d69d612 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -79,7 +79,7 @@ Escape character is '^]'.
 }
 
 Please refer to docs/interop/qemu-qmp-ref.* for a complete command
-reference, generated from qapi-schema.json.
+reference, generated from qapi/qapi-schema.json.
 
 QMP wiki page
 -------------
diff --git a/hmp.c b/hmp.c
index c86946866b..1f31de3217 100644
--- a/hmp.c
+++ b/hmp.c
@@ -28,7 +28,7 @@
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-commands-migration.h"
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index a2964fbf25..012439a2e3 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -32,7 +32,7 @@
 #ifndef QOBJECT_H
 #define QOBJECT_H
 
-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"
 
 struct QObject {
     QType type;
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 9e57508446..5b2ed3f202 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -15,7 +15,7 @@
 #ifndef QAPI_VISITOR_H
 #define QAPI_VISITOR_H
 
-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"
 
 /*
  * The QAPI schema defines both a set of C data types, and a QMP wire
diff --git a/include/qom/object.h b/include/qom/object.h
index 5b5c016d8f..30db296af4 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_OBJECT_H
 #define QEMU_OBJECT_H
 
-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"
 #include "qemu/queue.h"
 
 struct TypeImpl;
diff --git a/monitor.c b/monitor.c
index df670f3e15..d0e8d350fd 100644
--- a/monitor.c
+++ b/monitor.c
@@ -69,14 +69,14 @@
 #include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
-#include "qmp-commands.h"
 #include "hmp.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
+#include "qapi/qapi-commands.h"
+#include "qapi/qapi-events.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
-#include "qapi-event.h"
-#include "qmp-introspect.h"
+#include "qapi/qapi-introspect.h"
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 7c487629f9..f7265c50a8 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -13,7 +13,7 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
 #include "qom/object.h"
 
diff --git a/qapi/misc.json b/qapi/misc.json
index 225631bf7d..506f2b9371 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1618,7 +1618,7 @@
 #
 # Emitted when background dump has completed
 #
-# @result: DumpQueryResult type described in qapi-schema.json.
+# @result: final dump status
 #
 # @error: human-readable error string that provides
 #         hint on why dump failed. Only presents on failure. The
@@ -2833,7 +2833,7 @@
 #
 # Emitted when guest executes ACPI _OST method.
 #
-# @info: ACPIOSTInfo type as described in qapi-schema.json
+# @info: OSPM Status Indication
 #
 # Since: 2.1
 #
diff --git a/qapi-schema.json b/qapi/qapi-schema.json
similarity index 85%
rename from qapi-schema.json
rename to qapi/qapi-schema.json
index 689d06c530..25bce78352 100644
--- a/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -76,20 +76,20 @@
 # included sub-schemas inserted at the first include directive
 # (subsequent include directives have no effect).  To get a sane and
 # stable order, it's best to include each sub-schema just once, or
-# include it first in qapi-schema.json.
+# include it first right here.
 
-{ 'include': 'qapi/common.json' }
-{ 'include': 'qapi/sockets.json' }
-{ 'include': 'qapi/run-state.json' }
-{ 'include': 'qapi/crypto.json' }
-{ 'include': 'qapi/block.json' }
-{ 'include': 'qapi/char.json' }
-{ 'include': 'qapi/net.json' }
-{ 'include': 'qapi/rocker.json' }
-{ 'include': 'qapi/tpm.json' }
-{ 'include': 'qapi/ui.json' }
-{ 'include': 'qapi/migration.json' }
-{ 'include': 'qapi/transaction.json' }
-{ 'include': 'qapi/trace.json' }
-{ 'include': 'qapi/introspect.json' }
-{ 'include': 'qapi/misc.json' }
+{ 'include': 'common.json' }
+{ 'include': 'sockets.json' }
+{ 'include': 'run-state.json' }
+{ 'include': 'crypto.json' }
+{ 'include': 'block.json' }
+{ 'include': 'char.json' }
+{ 'include': 'net.json' }
+{ 'include': 'rocker.json' }
+{ 'include': 'tpm.json' }
+{ 'include': 'ui.json' }
+{ 'include': 'migration.json' }
+{ 'include': 'transaction.json' }
+{ 'include': 'trace.json' }
+{ 'include': 'introspect.json' }
+{ 'include': 'misc.json' }
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 6151378ae4..ed08c5917c 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -3,6 +3,6 @@ qga-obj-$(CONFIG_POSIX) += commands-posix.o channel-posix.o
 qga-obj-$(CONFIG_WIN32) += commands-win32.o channel-win32.o service-win32.o
 qga-obj-$(CONFIG_WIN32) += vss-win32.o
 qga-obj-y += qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-visit.o
-qga-obj-y += qapi-generated/qga-qmp-commands.o
+qga-obj-y += qapi-generated/qga-qapi-commands.o
 
 qga-vss-dll-obj-$(CONFIG_QGA_VSS) += vss-win32/
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 88807f3c78..417a50ce5f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -17,7 +17,7 @@
 #include <sys/wait.h>
 #include <dirent.h>
 #include "qga/guest-agent-core.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/queue.h"
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index bedae32957..2d48394748 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -34,7 +34,7 @@
 
 #include "qga/guest-agent-core.h"
 #include "qga/vss-win32.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/queue.h"
diff --git a/qga/commands.c b/qga/commands.c
index 6d710dbb20..a64b34ccab 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qga/guest-agent-core.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/base64.h"
diff --git a/qga/main.c b/qga/main.c
index cb434d8c46..f9c83050c5 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -25,7 +25,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qga/guest-agent-core.h"
 #include "qemu/module.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
 #include "qga/channel.h"
diff --git a/qom/object.c b/qom/object.c
index 81b4f7ac48..f70a75c308 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -18,7 +18,7 @@
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
 
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 953449171b..21a7e0dbe6 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -232,13 +232,6 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
         self._regy = ''
         self._visited_ret_types = {}
 
-    # Temporary HACK:
-    def _module_basename(self, what, name):
-        basename = QAPISchemaModularCVisitor._module_basename(self, what, name)
-        if name == self._main_module:
-            return re.sub(r'qapi-commands', 'qmp-commands', basename)
-        return basename
-
     def _begin_module(self, name):
         self._visited_ret_types[self._genc] = set()
         commands = self._module_basename('qapi-commands', name)
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 5ad6708491..3dc523cf39 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -157,20 +157,13 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
         self._enum_name = c_name(prefix + 'QAPIEvent', protect=False)
         self._event_names = []
 
-    # Temporary HACK:
-    def _module_basename(self, what, name):
-        basename = QAPISchemaModularCVisitor._module_basename(self, what, name)
-        if name == self._main_module:
-            return re.sub(r'qapi-events', 'qapi-event', basename)
-        return basename
-
     def _begin_module(self, name):
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "%(prefix)sqapi-event.h"
+#include "%(prefix)sqapi-events.h"
 #include "%(visit)s.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f571cc134c..f66c397fb0 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -44,7 +44,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
 
     def __init__(self, prefix, unmask):
         QAPISchemaMonolithicCVisitor.__init__(
-            self, prefix, 'qmp-introspect',
+            self, prefix, 'qapi-introspect',
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
         self._schema = None
@@ -53,7 +53,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
         self._name_map = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
-#include "%(prefix)sqmp-introspect.h"
+#include "%(prefix)sqapi-introspect.h"
 
 ''',
                              prefix=prefix))
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 2a3c502cf6..64d9c0fb37 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -177,8 +177,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
-#include "qapi-builtin-types.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-types.h"
+#include "qapi/qapi-builtin-visit.h"
 '''))
         self._genh.preamble_add(mcgen('''
 #include "qapi/util.h"
@@ -195,7 +195,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
 ''',
                                       types=types, visit=visit))
         self._genh.preamble_add(mcgen('''
-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"
 '''))
 
     def visit_begin(self, schema):
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index de09966643..5d72d8936c 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -274,11 +274,11 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 '''))
         self._genh.preamble_add(mcgen('''
 #include "qapi/visitor.h"
-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"
 
 ''',
                                       prefix=prefix))
@@ -295,7 +295,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
 ''',
                                       visit=visit, prefix=self._prefix))
         self._genh.preamble_add(mcgen('''
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "%(types)s.h"
 
 ''',
diff --git a/tests/.gitignore b/tests/.gitignore
index 2629cfc2f9..18e58b2183 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -60,7 +60,8 @@ test-keyval
 test-logging
 test-mul64
 test-opts-visitor
-test-qapi-event.[ch]
+test-qapi-commands.[ch]
+test-qapi-events.[ch]
 test-qapi-types.[ch]
 test-qapi-util
 test-qapi-visit.[ch]
@@ -71,11 +72,10 @@ test-qga
 test-qht
 test-qht-par
 test-qmp-cmds
-test-qmp-commands.[ch]
 test-qmp-event
 test-qobject-input-strict
 test-qobject-input-visitor
-test-qmp-introspect.[ch]
+test-qapi-introspect.[ch]
 test-qobject-output-visitor
 test-rcu-list
 test-replication
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9a21ed7ee9..d71adf3996 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -566,8 +566,8 @@ qapi-schema += unknown-expr-key.json
 check-qapi-schema-y := $(addprefix tests/qapi-schema/, $(qapi-schema))
 
 GENERATED_FILES += tests/test-qapi-types.h tests/test-qapi-visit.h \
-	tests/test-qmp-commands.h tests/test-qapi-event.h \
-	tests/test-qmp-introspect.h
+	tests/test-qapi-commands.h tests/test-qapi-events.h \
+	tests/test-qapi-introspect.h
 
 test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
 	tests/check-qlist.o tests/check-qnull.o tests/check-qobject.o \
@@ -592,7 +592,7 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 test-util-obj-y = libqemuutil.a
 test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
-	tests/test-qapi-event.o tests/test-qmp-introspect.o \
+	tests/test-qapi-events.o tests/test-qapi-introspect.o \
 	$(test-qom-obj-y)
 benchmark-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
 test-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
@@ -656,9 +656,9 @@ tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-y) \
 
 tests/test-qapi-types.c tests/test-qapi-types.h \
 tests/test-qapi-visit.c tests/test-qapi-visit.h \
-tests/test-qmp-commands.h tests/test-qmp-commands.c \
-tests/test-qapi-event.c tests/test-qapi-event.h \
-tests/test-qmp-introspect.c tests/test-qmp-introspect.h: \
+tests/test-qapi-commands.h tests/test-qapi-commands.c \
+tests/test-qapi-events.c tests/test-qapi-events.h \
+tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
 tests/test-qapi-gen-timestamp ;
 tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
@@ -679,7 +679,7 @@ tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visitor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-obj-y)
 tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visitor.o $(test-qapi-obj-y)
-tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qmp-commands.o $(test-qapi-obj-y)
+tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qapi-commands.o $(test-qapi-obj-y)
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
 
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 24660d0868..5b1cee6912 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -3,12 +3,12 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "test-qmp-commands.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
 #include "tests/test-qapi-types.h"
 #include "tests/test-qapi-visit.h"
+#include "test-qapi-commands.h"
 
 static QmpCommandList qmp_commands;
 
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 5fbe7e551f..31f35b3e66 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -14,13 +14,13 @@
 #include "qemu/osdep.h"
 
 #include "qemu-common.h"
-#include "test-qapi-event.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
+#include "test-qapi-events.h"
 
 typedef struct TestEventData {
     QDict *expect;
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index d3a56bd071..79b1a8cb17 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -24,8 +24,8 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-#include "test-qmp-introspect.h"
-#include "qmp-introspect.h"
+#include "test-qapi-introspect.h"
+#include "qapi/qapi-introspect.h"
 
 typedef struct TestInputVisitorData {
     QObject *obj;
@@ -1376,7 +1376,7 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_fail_alternate);
     input_visitor_test_add("/visitor/input/fail/union-native-list",
                            NULL, test_visitor_in_fail_union_native_list);
-    input_visitor_test_add("/visitor/input/qmp-introspect",
+    input_visitor_test_add("/visitor/input/qapi-introspect",
                            NULL, test_visitor_in_qmp_introspect);
 
     g_test_run();
diff --git a/tpm.c b/tpm.c
index 2db03a09b2..ac580e6d47 100644
--- a/tpm.c
+++ b/tpm.c
@@ -182,7 +182,6 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
 
 /*
  * Walk the list of active TPM backends and collect information about them
- * following the schema description in qapi-schema.json.
  */
 TPMInfoList *qmp_query_tpm(Error **errp)
 {
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 51db47cd71..de6af6fbb9 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -32,7 +32,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qmp-commands.h"
+#include "qapi/qapi-commands.h"
 #include "sysemu/blockdev.h"
 #include "qemu-version.h"
 #include <Carbon/Carbon.h>
diff --git a/ui/vnc.c b/ui/vnc.c
index d6329c8bd5..20cd9bb63d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -35,10 +35,10 @@
 #include "qemu/timer.h"
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
+#include "qapi/qapi-events.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "ui/input.h"
-#include "qapi-event.h"
 #include "crypto/hash.h"
 #include "crypto/tlscredsanon.h"
 #include "crypto/tlscredsx509.h"
-- 
2.13.6
