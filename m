Received: from eggs.gnu.org ([2001:4830:134:3::10]:51852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXA-0008C7-4Y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkX8-0006Je-M7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkX8-0006GT-DG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:10 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:40 +0100
Message-Id: <20180111213250.16511-42-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 41/51] qapi: add -i/--include filename.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Add a new option to add user-specified #include lines in the generated
headers. This will help to split a schema, where one generated header
will depend on another.

Fix some pycodestyle on the way.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py            | 15 ++++++++++-----
 scripts/qapi-commands.py   |  7 +++++--
 scripts/qapi-event.py      |  6 ++++--
 scripts/qapi-introspect.py |  6 ++++--
 scripts/qapi-types.py      |  7 +++++--
 scripts/qapi-visit.py      |  6 ++++--
 tests/Makefile.include     |  4 +++-
 7 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1668a6da6c..f56460d028 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -2125,10 +2125,10 @@ def build_params(arg_type, boxed, extra):
 def parse_command_line(extra_options=3D'', extra_long_options=3D[]):
=20
     try:
-        opts, args =3D getopt.gnu_getopt(sys.argv[1:],
-                                       'chp:o:' + extra_options,
-                                       ['source', 'header', 'prefix=3D',
-                                        'output-dir=3D'] + extra_long_op=
tions)
+        opts, args =3D getopt.gnu_getopt(
+            sys.argv[1:], 'chp:o:i:' + extra_options,
+            ['source', 'header', 'prefix=3D', 'output-dir=3D',
+             'include=3D'] + extra_long_options)
     except getopt.GetoptError as err:
         print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
         sys.exit(1)
@@ -2137,6 +2137,7 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
     prefix =3D ''
     do_c =3D False
     do_h =3D False
+    includes =3D []
     extra_opts =3D []
=20
     for oa in opts:
@@ -2155,6 +2156,8 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
             do_c =3D True
         elif o in ('-h', '--header'):
             do_h =3D True
+        elif o in ('-i', '--include'):
+            includes.append(a)
         else:
             extra_opts.append(oa)
=20
@@ -2167,7 +2170,9 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
         sys.exit(1)
     fname =3D args[0]
=20
-    return (fname, output_dir, do_c, do_h, prefix, extra_opts)
+    includes =3D "\n".join(['#include "%s"' % inc for inc in includes])
+
+    return (fname, output_dir, do_c, do_h, prefix, includes, extra_opts)
=20
 #
 # Generate output files with boilerplate
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 7455d2b8bb..4841f4d9a1 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -253,7 +253,8 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._regy +=3D gen_register_command(name, success_response)
=20
=20
-(input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command_lin=
e()
+(input_file, output_dir, do_c, do_h, prefix, includes, opts) =3D \
+        parse_command_line()
=20
 c_comment =3D '''
 /*
@@ -305,6 +306,7 @@ fdef.write(mcgen('''
                  prefix=3Dprefix))
=20
 fdecl.write(mcgen('''
+%(includes)s
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/dispatch.h"
@@ -312,7 +314,8 @@ fdecl.write(mcgen('''
=20
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                  prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DF=
alse)))
+                  includes=3Dincludes, prefix=3Dprefix,
+                  c_prefix=3Dc_name(prefix, protect=3DFalse)))
=20
 schema =3D QAPISchema(input_file)
 gen =3D QAPISchemaGenCommandVisitor()
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 60c6f7030d..0aba866dc8 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -171,7 +171,8 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self._event_names.append(QAPISchemaMember(name, ifcond))
=20
=20
-(input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()
+(input_file, output_dir, do_c, do_h, prefix, includes, dummy) =3D \
+        parse_command_line()
=20
 c_comment =3D '''
 /*
@@ -218,13 +219,14 @@ fdef.write(mcgen('''
                  prefix=3Dprefix))
=20
 fdecl.write(mcgen('''
+%(includes)s
 #include "qapi/error.h"
 #include "qapi/util.h"
 #include "qapi/qmp/qdict.h"
 #include "%(prefix)sqapi-types.h"
=20
 ''',
-                  prefix=3Dprefix))
+                  includes=3Dincludes, prefix=3Dprefix))
=20
 event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
=20
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 6a66047243..65277e98fd 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -192,11 +192,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
                        ifcond)
=20
+
 # Debugging aid: unmask QAPI schema's type names
 # We normally mask them, because they're not QMP wire ABI
 opt_unmask =3D False
=20
-(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
+(input_file, output_dir, do_c, do_h, prefix, includes, opts) =3D \
     parse_command_line('u', ['unmask-non-abi-names'])
=20
 for o, a in opts:
@@ -239,10 +240,11 @@ fdef.write(mcgen('''
                  prefix=3Dprefix))
=20
 fdecl.write(mcgen('''
+%(includes)s
 #include "qemu/osdep.h"
 #include "qapi/qmp/qlit.h"
=20
-'''))
+''', includes=3Dincludes))
=20
 schema =3D QAPISchema(input_file)
 gen =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 312685c295..cc42447bc4 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -260,13 +260,14 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self._gen_object(name, info, ifcond, None,
                          [variants.tag_member], variants)
=20
+
 # If you link code generated from multiple schemata, you want only one
 # instance of the code for built-in types.  Generate it only when
 # do_builtins, enabled by command line option -b.  See also
 # QAPISchemaGenTypeVisitor.visit_end().
 do_builtins =3D False
=20
-(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
+(input_file, output_dir, do_c, do_h, prefix, includes, opts) =3D \
     parse_command_line('b', ['builtins'])
=20
 for o, a in opts:
@@ -317,7 +318,9 @@ fdef.write(mcgen('''
=20
 fdecl.write(mcgen('''
 #include "qapi/util.h"
-'''))
+%(includes)s
+''',
+                  includes=3Dincludes))
=20
 schema =3D QAPISchema(input_file)
 gen =3D QAPISchemaGenTypeVisitor()
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 48ac1c9a42..bcbd62b32d 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -332,13 +332,14 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl +=3D gen_visit_decl(name)
         self.defn +=3D gen_visit_alternate(name, variants)
=20
+
 # If you link code generated from multiple schemata, you want only one
 # instance of the code for built-in types.  Generate it only when
 # do_builtins, enabled by command line option -b.  See also
 # QAPISchemaGenVisitVisitor.visit_end().
 do_builtins =3D False
=20
-(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
+(input_file, output_dir, do_c, do_h, prefix, includes, opts) =3D \
     parse_command_line('b', ['builtins'])
=20
 for o, a in opts:
@@ -387,12 +388,13 @@ fdef.write(mcgen('''
                  prefix=3Dprefix))
=20
 fdecl.write(mcgen('''
+%(includes)s
 #include "qapi/visitor.h"
 #include "qapi/qmp/qerror.h"
 #include "%(prefix)sqapi-types.h"
=20
 ''',
-                  prefix=3Dprefix))
+                  includes=3Dincludes, prefix=3Dprefix))
=20
 schema =3D QAPISchema(input_file)
 gen =3D QAPISchemaGenVisitVisitor()
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3aec5b0874..2b83f05954 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -648,8 +648,10 @@ tests/test-replication$(EXESUF): tests/test-replicat=
ion.o $(test-util-obj-y) \
 tests/test-qapi-types.c tests/test-qapi-types.h :\
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
+		$(gen-out-type) -o tests -p "test-" -i tests/test-qapi-types.h $<, \
 		"GEN","$@")
+# check that -i includes worked with a silly self-include
+	$(call quiet-command,[ $(gen-out-type) =3D=3D -c ] || grep -q '#include=
 "tests/test-qapi-types.h"' $@,"TEST","$@")
 tests/test-qapi-visit.c tests/test-qapi-visit.h :\
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-visit.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
--=20
2.16.0.rc1.1.gef27df75a1
