Received: from eggs.gnu.org ([2001:4830:134:3::10]:38949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bj-00084N-3P
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bf-000819-7Q
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2be-000805-UY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:43 +0200
Message-Id: <20171002152552.27999-24-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 23/32] qapi-options: Command line option
 backend
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

New qapi generator qapi-options.py generates code for parsing command
line options into an array of QAPIOption.

TODO negative tests

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile                  |  11 ++-
 Makefile.objs             |   1 +
 scripts/qapi-options.py   | 199 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include    |  16 +++-
 tests/test-qapi-options.c |  74 +++++++++++++++++
 5 files changed, 297 insertions(+), 4 deletions(-)
 create mode 100644 scripts/qapi-options.py
 create mode 100644 tests/test-qapi-options.c

diff --git a/Makefile b/Makefile
index 421e65d833..5e858f7295 100644
--- a/Makefile
+++ b/Makefile
@@ -56,8 +56,8 @@ GENERATED_FILES += builtin-qapi-types.h builtin-qapi-types.c
 GENERATED_FILES += builtin-qapi-visit.h builtin-qapi-visit.c
 GENERATED_FILES += qmp-commands.h qapi-types.h qapi-visit.h qapi-event.h
 GENERATED_FILES += qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
-GENERATED_FILES += qmp-introspect.h
-GENERATED_FILES += qmp-introspect.c
+GENERATED_FILES += qapi-options.h qmp-introspect.h
+GENERATED_FILES += qapi-options.c qmp-introspect.c
 
 GENERATED_FILES += trace/generated-tcg-tracers.h
 
@@ -470,6 +470,13 @@ qapi-commands-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-p
 		$<, \
 		"GEN","$@")
 
+.INTERMEDIATE: qapi-options-gen
+qapi-options.h qapi-options.c: qapi-options-gen
+qapi-options-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-options.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-options.py \
+		$<, \
+		"GEN","$@")
+
 .INTERMEDIATE: qapi-introspect-gen
 qmp-introspect.h qmp-introspect.c: qapi-introspect-gen
 qapi-introspect-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
diff --git a/Makefile.objs b/Makefile.objs
index c2c62cb462..908ec053fe 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -80,6 +80,7 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 # qapi
 
 common-obj-y += qmp-marshal.o
+common-obj-y += qapi-options.o
 common-obj-y += qmp-introspect.o
 common-obj-y += qmp.o hmp.o
 endif
diff --git a/scripts/qapi-options.py b/scripts/qapi-options.py
new file mode 100644
index 0000000000..240c9021c7
--- /dev/null
+++ b/scripts/qapi-options.py
@@ -0,0 +1,199 @@
+#
+# QAPI option generator
+#
+# Copyright (C) 2017 Red Hat, Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+from qapi import *
+
+
+class QAPISchemaGenOptionVisitor(QAPISchemaVisitor):
+    def __init__(self):
+        self.decl = None
+        self.defn = None
+        self._shortopts = None
+        self._longopts = None
+        self._cases = None
+
+    def visit_begin(self, schema):
+        self.decl = ''
+        self.defn = ''
+        self._shortopts = ''
+        self._longopts = ''
+        self._cases = ''
+
+    def visit_end(self):
+        if self._cases:
+            c_max = c_enum_const(args.prefix + 'QAPIOptionKind', '_MAX')
+            self.decl += mcgen('''
+%(c_prefix)sQAPIOption *%(c_prefix)sqapi_options_parse(int argc, char *argv[]);
+''',
+                               c_prefix=c_name(args.prefix, protect=False))
+            self.defn += mcgen('''
+%(c_prefix)sQAPIOption *%(c_prefix)sqapi_options_parse(int argc, char *argv[])
+{
+    static const struct option longopts[] = {
+%(longopts)s        {0}
+    };
+    %(c_prefix)sQAPIOption *opt = g_new(%(c_prefix)sQAPIOption, argc);
+    int nopt, longidx, ret;
+    Visitor *v;
+
+    optind = 0;
+
+    for (nopt = 0, opt[nopt].idx = 1;
+         (ret = getopt_long_only(argc, argv, %(c_shortopts)s,
+                                 longopts, &longidx)) >= 0;
+         opt[++nopt].idx = optind) {
+        if (ret > 255) {
+            opt[nopt].type = longopts[longidx].val - 256;
+        }
+        opt[nopt].cnt = optind - opt[nopt].idx;
+        loc_set_cmdline(argv, opt[nopt].idx, opt[nopt].cnt);
+
+        switch(ret) {
+%(cases)s
+        case '?':
+            exit(1);
+        default:
+            abort();
+        }
+    }
+
+    opt[nopt].type = %(c_max)s;
+    opt[nopt].cnt = 0;
+
+    return g_renew(%(c_prefix)sQAPIOption, opt, nopt + 1);
+}
+''',
+                               c_prefix=c_name(args.prefix, protect=False),
+                               c_shortopts=c_string(self._shortopts),
+                               longopts=self._longopts,
+                               cases=self._cases,
+                               c_max=c_max)
+        self._shortopts = None
+        self._longopts = None
+        self._cases = None
+
+    def visit_option(self, name, info, arg_type, short, implied_key,
+                     boxed, help_):
+        name = name[2:]
+        enum_val = c_enum_const(args.prefix + 'QAPIOptionKind', name)
+
+        push_indent(8)
+
+        self._longopts += mcgen('''
+{
+    .name = "%(name)s",
+    .has_arg = %(has_arg)s,
+    .val = %(val)s
+},
+''',
+                                name=name,
+                                has_arg='required_argument'
+                                if arg_type else 'no_argument',
+                                val='256 + ' + enum_val)
+        if short:
+            self._shortopts += short
+            if arg_type:
+                self._shortopts += ':'
+            self._cases += mcgen('''
+case '%(char)s':
+    opt[nopt].type = %(case)s;
+    /* fall through */
+''',
+                                 char=short, case=enum_val)
+
+        self._cases += mcgen('''
+case 256 + %(case)s:
+''',
+                             case=enum_val)
+        if arg_type is None:
+            pass
+        elif isinstance(arg_type, QAPISchemaObjectType):
+            self._cases += mcgen('''
+    v = qobject_input_visitor_new_str(optarg, %(c_implied_key)s, &error_fatal);
+    visit_start_struct(v, NULL, NULL, 0, &error_fatal);
+    visit_type_%(c_type)s_members(v, &opt[nopt].u.%(c_name)s, &error_fatal);
+    visit_check_struct(v, &error_fatal);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+''',
+                                 c_name=c_name(name), c_type=arg_type.c_name(),
+                                 c_implied_key=c_string(implied_key))
+        else:
+            assert isinstance(arg_type,
+                              (QAPISchemaBuiltinType, QAPISchemaEnumType))
+            self._cases += mcgen('''
+    v = qobject_input_visitor_new_keyval(QOBJECT(qstring_from_str(optarg)));
+    visit_type_%(c_type)s(v, NULL, &opt[nopt].u.%(c_name)s.data, &error_fatal);
+    visit_free(v);
+''',
+                                 c_name=c_name(name), c_type=arg_type.c_name())
+        self._cases += mcgen('''
+    break;
+''')
+
+        pop_indent(8)
+
+
+args = common_argument_parser().parse_args()
+
+c_comment = '''
+/*
+ * QAPI command line options
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+'''
+h_comment = '''
+/*
+ * QAPI command line options
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+'''
+
+(fdef, fdecl) = open_output(args.output_dir, args.prefix,
+                            'qapi-options.c', 'qapi-options.h',
+                            c_comment, h_comment)
+
+fdef.write(mcgen('''
+#include "qemu/osdep.h"
+#include <getopt.h>
+#include "%(prefix)sqapi-options.h"
+#include "%(prefix)sqapi-visit.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qemu/error-report.h"
+
+''',
+                 prefix=args.prefix))
+
+fdecl.write(mcgen('''
+#include "%(prefix)sqapi-types.h"
+
+''',
+                  prefix=args.prefix))
+
+schema = QAPISchema(args.schema, args.prefix)
+gen = QAPISchemaGenOptionVisitor()
+schema.visit(gen)
+fdef.write(gen.defn)
+fdecl.write(gen.decl)
+
+close_output(fdef, fdecl)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2ef5dc51f1..442de4e0aa 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -59,6 +59,7 @@ check-unit-y += tests/test-string-output-visitor$(EXESUF)
 gcov-files-test-string-output-visitor-y = qapi/string-output-visitor.c
 check-unit-y += tests/test-qmp-event$(EXESUF)
 gcov-files-test-qmp-event-y += qapi/qmp-event.c
+check-unit-y += tests/test-qapi-options(EXESUF)
 check-unit-y += tests/test-opts-visitor$(EXESUF)
 gcov-files-test-opts-visitor-y = qapi/opts-visitor.c
 check-unit-y += tests/test-coroutine$(EXESUF)
@@ -542,7 +543,7 @@ check-qapi-schema-y := $(addprefix tests/qapi-schema/, $(qapi-schema))
 
 GENERATED_FILES += tests/test-qapi-types.h tests/test-qapi-visit.h \
 	tests/test-qmp-commands.h tests/test-qapi-event.h \
-	tests/test-qmp-introspect.h
+	tests/test-qapi-options.h tests/test-qmp-introspect.h
 
 test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
 	tests/check-qlist.o tests/check-qnull.o \
@@ -567,7 +568,8 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 test-util-obj-y = libqemuutil.a
 test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
-	tests/test-qapi-event.o tests/test-qmp-introspect.o \
+	tests/test-qapi-event.o tests/test-qapi-options.o \
+	tests/test-qmp-introspect.o \
 	$(test-qom-obj-y)
 benchmark-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
 test-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
@@ -651,6 +653,15 @@ $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-com
 		-o tests -p "test-" $<, \
 		"GEN","$@")
 
+.INTERMEDIATE: tests/test-qapi-options-gen
+tests/test-qapi-options.c tests/test-qapi-options.h: tests/test-qapi-options-gen
+tests/test-qapi-options-gen: \
+$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-options.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-options.py \
+		-o tests -p "test-" $<, \
+		"GEN","$@")
+tests/test-qmp-introspect.c tests/test-qmp-introspect.h :\
+
 .INTERMEDIATE: tests/test-qapi-event-gen
 tests/test-qapi-event.c tests/test-qapi-event.h: tests/test-qapi-event-gen ;
 tests/test-qapi-event-gen: \
@@ -673,6 +684,7 @@ tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.jso
 tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visitor.o $(test-qapi-obj-y)
 tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.o $(test-qapi-obj-y)
 tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
+tests/test-qapi-options(EXESUF): tests/test-qapi-options.o $(test-qapi-obj-y)
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visitor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-obj-y)
 tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visitor.o $(test-qapi-obj-y) qmp-introspect.o
diff --git a/tests/test-qapi-options.c b/tests/test-qapi-options.c
new file mode 100644
index 0000000000..aa4394abdb
--- /dev/null
+++ b/tests/test-qapi-options.c
@@ -0,0 +1,74 @@
+#include "qemu/osdep.h"
+#include "qapi/qmp/qlit.h"
+#include "test-qapi-options.h"
+
+static void test_qapi_options_parse(void)
+{
+    static const char *argv[] = {
+        "progname",
+        "--help",
+        "-h",
+        "--opt-str", "hello",
+        "--opt-int", "123",
+        "--opt-enum", "value1",
+        "--opt-any", "hello",
+        "--opt-any", "123",
+        "--opt-struct", "sval,i=1",
+        "--opt-boxed", "integer=42",
+        NULL
+    };
+    static QLitObject qlit_hello = QLIT_QSTR("hello");
+    static QLitObject qlit_123 = QLIT_QSTR("123");
+    test_QAPIOption *opt;
+
+    opt = test_qapi_options_parse(ARRAY_SIZE(argv) - 1, (char **)argv);
+    g_assert_cmpint(opt[0].type, ==, TEST_QAPI_OPTION_KIND_HELP);
+    g_assert_cmpint(opt[0].idx, ==, 1);
+    g_assert_cmpint(opt[0].cnt, ==, 1);
+    g_assert_cmpint(opt[1].type, ==, TEST_QAPI_OPTION_KIND_HELP);
+    g_assert_cmpint(opt[1].idx, ==, 2);
+    g_assert_cmpint(opt[1].cnt, ==, 1);
+    g_assert_cmpint(opt[2].type, ==, TEST_QAPI_OPTION_KIND_OPT_STR);
+    g_assert_cmpint(opt[2].idx, ==, 3);
+    g_assert_cmpint(opt[2].cnt, ==, 2);
+    g_assert_cmpstr(opt[2].u.opt_str.data, ==, "hello");
+    g_assert_cmpint(opt[3].type, ==, TEST_QAPI_OPTION_KIND_OPT_INT);
+    g_assert_cmpint(opt[3].idx, ==, 5);
+    g_assert_cmpint(opt[3].cnt, ==, 2);
+    g_assert_cmpint(opt[3].u.opt_int.data, ==, 123);
+    g_assert_cmpint(opt[4].type, ==, TEST_QAPI_OPTION_KIND_OPT_ENUM);
+    g_assert_cmpint(opt[4].idx, ==, 7);
+    g_assert_cmpint(opt[4].cnt, ==, 2);
+    g_assert_cmpint(opt[4].u.opt_enum.data, ==, ENUM_ONE_VALUE1);
+    g_assert_cmpint(opt[5].type, ==, TEST_QAPI_OPTION_KIND_OPT_ANY);
+    g_assert_cmpint(opt[5].idx, ==, 9);
+    g_assert_cmpint(opt[5].cnt, ==, 2);
+    g_assert(qlit_equal_qobject(&qlit_hello, opt[5].u.opt_any.data));
+    g_assert_cmpint(opt[6].type, ==, TEST_QAPI_OPTION_KIND_OPT_ANY);
+    g_assert_cmpint(opt[6].idx, ==, 11);
+    g_assert_cmpint(opt[6].cnt, ==, 2);
+    g_assert(qlit_equal_qobject(&qlit_123, opt[6].u.opt_any.data));
+    g_assert_cmpint(opt[7].type, ==, TEST_QAPI_OPTION_KIND_OPT_STRUCT);
+    g_assert_cmpint(opt[7].idx, ==, 13);
+    g_assert_cmpint(opt[7].cnt, ==, 2);
+    g_assert_cmpstr(opt[7].u.opt_struct.s, ==, "sval");
+    g_assert_cmpint(opt[8].type, ==, TEST_QAPI_OPTION_KIND_OPT_BOXED);
+    g_assert_cmpint(opt[8].idx, ==, 15);
+    g_assert_cmpint(opt[8].cnt, ==, 2);
+    g_assert_cmpint(opt[8].u.opt_boxed.integer, ==, 42);
+    g_assert_cmpint(opt[9].type, ==, TEST_QAPI_OPTION_KIND__MAX);
+    g_assert_cmpint(opt[9].idx, ==, 17);
+    g_assert_cmpint(opt[9].cnt, ==, 0);
+    g_free(opt);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/qapi/options-parse", test_qapi_options_parse);
+
+    g_test_run();
+
+    return 0;
+}
-- 
2.13.6
