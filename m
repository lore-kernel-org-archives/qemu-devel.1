Received: from eggs.gnu.org ([2001:4830:134:3::10]:54277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3l-0007Bu-Pj
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3d-0006RY-OW
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36023 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3d-0006Pm-0i
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:25 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:56 +0100
Message-Id: <20180211093607.27351-19-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/29] qapi: Rename generated qmp-marshal.c
 to qmp-commands.c
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

All generated .c are named like their .h, except for qmp-marshal.c and
qmp-commands.h.  To add to the confusion, tests-qmp-commands.c falsely
matches generated test-qmp-commands.h.

Get rid of this unnecessary complication.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore                                     |  3 +--
 Makefile                                       |  6 +++---
 Makefile.objs                                  |  2 +-
 docs/devel/qapi-code-gen.txt                   |  6 +++---
 qga/Makefile.objs                              |  2 +-
 scripts/qapi/commands.py                       |  2 +-
 tests/.gitignore                               |  5 ++---
 tests/Makefile.include                         | 10 +++++-----
 tests/{test-qmp-commands.c => test-qmp-cmds.c} |  0
 9 files changed, 17 insertions(+), 19 deletions(-)
 rename tests/{test-qmp-commands.c => test-qmp-cmds.c} (100%)

diff --git a/.gitignore b/.gitignore
index 2f9a92f6cc..7d783e6e66 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,9 +33,8 @@
 /qapi-visit.[ch]
 /qapi-event.[ch]
 /qapi-doc.texi
-/qmp-commands.h
+/qmp-commands.[ch]
 /qmp-introspect.[ch]
-/qmp-marshal.c
 /qemu-doc.html
 /qemu-doc.info
 /qemu-doc.txt
diff --git a/Makefile b/Makefile
index bd781c6aad..164a38578e 100644
--- a/Makefile
+++ b/Makefile
@@ -91,7 +91,7 @@ include $(SRC_PATH)/rules.mak
 
 GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
 GENERATED_FILES += qmp-commands.h qapi-types.h qapi-visit.h qapi-event.h
-GENERATED_FILES += qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
+GENERATED_FILES += qmp-commands.c qapi-types.c qapi-visit.c qapi-event.c
 GENERATED_FILES += qmp-introspect.h
 GENERATED_FILES += qmp-introspect.c
 GENERATED_FILES += qapi-doc.texi
@@ -496,7 +496,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
 
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
-qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal.c \
+qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-commands.c \
 qga/qapi-generated/qga-qapi-doc.texi: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
@@ -522,7 +522,7 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
 
 qapi-types.c qapi-types.h \
 qapi-visit.c qapi-visit.h \
-qmp-commands.h qmp-marshal.c \
+qmp-commands.h qmp-commands.c \
 qapi-event.c qapi-event.h \
 qmp-introspect.h qmp-introspect.c \
 qapi-doc.texi: \
diff --git a/Makefile.objs b/Makefile.objs
index 2efba6d768..d255aaf194 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -78,7 +78,7 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 ######################################################################
 # qapi
 
-common-obj-y += qmp-marshal.o
+common-obj-y += qmp-commands.o
 common-obj-y += qmp-introspect.o
 common-obj-y += qmp.o hmp.o
 endif
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 1a1cbaea7b..ba1dc73298 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1147,8 +1147,8 @@ declares qmp_COMMAND() that the user must implement.
 
 The following files are generated:
 
-$(prefix)qmp-marshal.c: Command marshal/dispatch functions for each
-                        QMP command defined in the schema
+$(prefix)qmp-commands.c: Command marshal/dispatch functions for each
+                         QMP command defined in the schema
 
 $(prefix)qmp-commands.h: Function prototypes for the QMP commands
                          specified in the schema
@@ -1170,7 +1170,7 @@ Example:
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp);
 
     #endif
-    $ cat qapi-generated/example-qmp-marshal.c
+    $ cat qapi-generated/example-qmp-commands.c
 [Uninteresting stuff omitted...]
 
     static void qmp_marshal_output_UserDefOne(UserDefOne *ret_in, QObject **ret_out, Error **errp)
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 1c5986c0bb..6151378ae4 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -3,6 +3,6 @@ qga-obj-$(CONFIG_POSIX) += commands-posix.o channel-posix.o
 qga-obj-$(CONFIG_WIN32) += commands-win32.o channel-win32.o service-win32.o
 qga-obj-$(CONFIG_WIN32) += vss-win32.o
 qga-obj-y += qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-visit.o
-qga-obj-y += qapi-generated/qga-qmp-marshal.o
+qga-obj-y += qapi-generated/qga-qmp-commands.o
 
 qga-vss-dll-obj-$(CONFIG_QGA_VSS) += vss-win32/
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index a744611d58..05fe33a03b 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -289,5 +289,5 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
     schema.visit(vis)
     genc.add(vis.defn)
     genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qmp-marshal.c')
+    genc.write(output_dir, prefix + 'qmp-commands.c')
     genh.write(output_dir, prefix + 'qmp-commands.h')
diff --git a/tests/.gitignore b/tests/.gitignore
index e5c744b7ed..2629cfc2f9 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -70,13 +70,12 @@ test-qdist
 test-qga
 test-qht
 test-qht-par
-test-qmp-commands
-test-qmp-commands.h
+test-qmp-cmds
+test-qmp-commands.[ch]
 test-qmp-event
 test-qobject-input-strict
 test-qobject-input-visitor
 test-qmp-introspect.[ch]
-test-qmp-marshal.c
 test-qobject-output-visitor
 test-rcu-list
 test-replication
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b406531b34..9a21ed7ee9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -61,8 +61,8 @@ check-unit-y += tests/test-clone-visitor$(EXESUF)
 gcov-files-test-clone-visitor-y = qapi/qapi-clone-visitor.c
 check-unit-y += tests/test-qobject-input-visitor$(EXESUF)
 gcov-files-test-qobject-input-visitor-y = qapi/qobject-input-visitor.c
-check-unit-y += tests/test-qmp-commands$(EXESUF)
-gcov-files-test-qmp-commands-y = qapi/qmp-dispatch.c
+check-unit-y += tests/test-qmp-cmds$(EXESUF)
+gcov-files-test-qmp-cmds-y = qapi/qmp-dispatch.c
 check-unit-y += tests/test-string-input-visitor$(EXESUF)
 gcov-files-test-string-input-visitor-y = qapi/string-input-visitor.c
 check-unit-y += tests/test-string-output-visitor$(EXESUF)
@@ -576,7 +576,7 @@ test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
 	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o \
 	tests/test-clone-visitor.o \
 	tests/test-qobject-input-visitor.o \
-	tests/test-qmp-commands.o tests/test-visitor-serialization.o \
+	tests/test-qmp-cmds.o tests/test-visitor-serialization.o \
 	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
 	tests/test-opts-visitor.o tests/test-qmp-event.o \
 	tests/rcutorture.o tests/test-rcu-list.o \
@@ -656,7 +656,7 @@ tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-y) \
 
 tests/test-qapi-types.c tests/test-qapi-types.h \
 tests/test-qapi-visit.c tests/test-qapi-visit.h \
-tests/test-qmp-commands.h tests/test-qmp-marshal.c \
+tests/test-qmp-commands.h tests/test-qmp-commands.c \
 tests/test-qapi-event.c tests/test-qapi-event.h \
 tests/test-qmp-introspect.c tests/test-qmp-introspect.h: \
 tests/test-qapi-gen-timestamp ;
@@ -679,7 +679,7 @@ tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visitor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-obj-y)
 tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visitor.o $(test-qapi-obj-y)
-tests/test-qmp-commands$(EXESUF): tests/test-qmp-commands.o tests/test-qmp-marshal.o $(test-qapi-obj-y)
+tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qmp-commands.o $(test-qapi-obj-y)
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
 
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-cmds.c
similarity index 100%
rename from tests/test-qmp-commands.c
rename to tests/test-qmp-cmds.c
-- 
2.13.6
