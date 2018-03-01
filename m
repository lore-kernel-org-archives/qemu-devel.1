Received: from eggs.gnu.org ([2001:4830:134:3::10]:40521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6q-0000qh-Ad
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6l-0007Sw-T5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6l-0007SA-Fm
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:15 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:23 -0600
Message-Id: <20180301194245.29854-9-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/30] qapi-gen: New common driver for code and
 doc generators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Whenever qapi-schema.json changes, we run six programs eleven times to
update eleven files.  Similar for qga/qapi-schema.json.  This is
silly.  Replace the six programs by a single program that spits out
all eleven files.

The programs become modules in new Python package qapi, along with the
helper library.  This requires moving them to scripts/qapi/.  While
moving them, consistently drop executable mode bits.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-9-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
[eblake: move change to one-line 'blurb' earlier in series, mention mode
bit change as intentional, update qapi-code-gen.txt to match actual
generated events.c file]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt                       | 102 ++++++++++-----=
------
 Makefile                                           |  86 ++++++++-------=
--
 qapi-schema.json                                   |   2 +-
 scripts/qapi-gen.py                                |  41 +++++++++
 scripts/qapi/__init__.py                           |   0
 scripts/{qapi-commands.py =3D> qapi/commands.py}     |  19 +---
 scripts/{qapi.py =3D> qapi/common.py}                |  18 +---
 scripts/{qapi2texi.py =3D> qapi/doc.py}              |  29 ++----
 scripts/{qapi-event.py =3D> qapi/events.py}          |  19 +---
 scripts/{qapi-introspect.py =3D> qapi/introspect.py} |  28 +-----
 scripts/{qapi-types.py =3D> qapi/types.py}           |  30 +-----
 scripts/{qapi-visit.py =3D> qapi/visit.py}           |  30 +-----
 monitor.c                                          |   2 +-
 .gitignore                                         |   2 +
 tests/Makefile.include                             |  56 +++++------
 tests/qapi-schema/test-qapi.py                     |   4 +-
 16 files changed, 191 insertions(+), 277 deletions(-)
 create mode 100755 scripts/qapi-gen.py
 create mode 100644 scripts/qapi/__init__.py
 rename scripts/{qapi-commands.py =3D> qapi/commands.py} (95%)
 rename scripts/{qapi.py =3D> qapi/common.py} (99%)
 rename scripts/{qapi2texi.py =3D> qapi/doc.py} (92%)
 mode change 100755 =3D> 100644
 rename scripts/{qapi-event.py =3D> qapi/events.py} (93%)
 rename scripts/{qapi-introspect.py =3D> qapi/introspect.py} (91%)
 rename scripts/{qapi-types.py =3D> qapi/types.py} (90%)
 rename scripts/{qapi-visit.py =3D> qapi/visit.py} (92%)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 5900b39b91b..a525ef369f4 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -899,12 +899,13 @@ the names of built-in types.  Clients should examin=
e member

 =3D=3D Code generation =3D=3D

-Schemas are fed into five scripts to generate all the code/files that,
-paired with the core QAPI libraries, comprise everything required to
-take JSON commands read in by a Client JSON Protocol server, unmarshal
-the arguments into the underlying C types, call into the corresponding
-C function, map the response back to a Client JSON Protocol response
-to be returned to the user, and introspect the commands.
+The QAPI code generator qapi-gen.py generates code and documentation
+from the schema.  Together with the core QAPI libraries, this code
+provides everything required to take JSON commands read in by a Client
+JSON Protocol server, unmarshal the arguments into the underlying C
+types, call into the corresponding C function, map the response back
+to a Client JSON Protocol response to be returned to the user, and
+introspect the commands.

 As an example, we'll use the following schema, which describes a
 single complex user-defined type, along with command which takes a
@@ -922,18 +923,23 @@ qmp_my_command(); everything else is produced by th=
e generator.

     { 'event': 'MY_EVENT' }

+We run qapi-gen.py like this:
+
+    $ python scripts/qapi-gen.py --output-dir=3D"qapi-generated" \
+    --prefix=3D"example-" example-schema.json
+
 For a more thorough look at generated code, the testsuite includes
 tests/qapi-schema/qapi-schema-tests.json that covers more examples of
 what the generator will accept, and compiles the resulting C code as
 part of 'make check-unit'.

-=3D=3D=3D scripts/qapi-types.py =3D=3D=3D
+=3D=3D=3D Code generated for QAPI types =3D=3D=3D

-Used to generate the C types defined by a schema, along with
-supporting code. The following files are created:
+The following files are created:

 $(prefix)qapi-types.h - C types corresponding to types defined in
-                        the schema you pass in
+                        the schema
+
 $(prefix)qapi-types.c - Cleanup functions for the above C types

 The $(prefix) is an optional parameter used as a namespace to keep the
@@ -943,8 +949,6 @@ created code.

 Example:

-    $ python scripts/qapi-types.py --output-dir=3D"qapi-generated" \
-    --prefix=3D"example-" example-schema.json
     $ cat qapi-generated/example-qapi-types.h
 [Uninteresting stuff omitted...]

@@ -1008,28 +1012,26 @@ Example:
         visit_free(v);
     }

-=3D=3D=3D scripts/qapi-visit.py =3D=3D=3D
+=3D=3D=3D Code generated for visiting QAPI types =3D=3D=3D

-Used to generate the visitor functions used to walk through and
-convert between a native QAPI C data structure and some other format
-(such as QObject); the generated functions are named visit_type_FOO()
-and visit_type_FOO_members().
+These are the visitor functions used to walk through and convert
+between a native QAPI C data structure and some other format (such as
+QObject); the generated functions are named visit_type_FOO() and
+visit_type_FOO_members().

 The following files are generated:

-$(prefix)qapi-visit.c: visitor function for a particular C type, used
+$(prefix)qapi-visit.c: Visitor function for a particular C type, used
                        to automagically convert QObjects into the
                        corresponding C type and vice-versa, as well
                        as for deallocating memory for an existing C
                        type

-$(prefix)qapi-visit.h: declarations for previously mentioned visitor
+$(prefix)qapi-visit.h: Declarations for previously mentioned visitor
                        functions

 Example:

-    $ python scripts/qapi-visit.py --output-dir=3D"qapi-generated"
-    --prefix=3D"example-" example-schema.json
     $ cat qapi-generated/example-qapi-visit.h
 [Uninteresting stuff omitted...]

@@ -1137,30 +1139,22 @@ Example:
         error_propagate(errp, err);
     }

-=3D=3D=3D scripts/qapi-commands.py =3D=3D=3D
+=3D=3D=3D Code generated for commands =3D=3D=3D

-Used to generate the marshaling/dispatch functions for the commands
-defined in the schema. The generated code implements
-qmp_marshal_COMMAND() (registered automatically), and declares
-qmp_COMMAND() that the user must implement.  The following files are
-generated:
+These are the marshaling/dispatch functions for the commands defined
+in the schema.  The generated code provides qmp_marshal_COMMAND(), and
+declares qmp_COMMAND() that the user must implement.

-$(prefix)qmp-marshal.c: command marshal/dispatch functions for each
-                        QMP command defined in the schema. Functions
-                        generated by qapi-visit.py are used to
-                        convert QObjects received from the wire into
-                        function parameters, and uses the same
-                        visitor functions to convert native C return
-                        values to QObjects from transmission back
-                        over the wire.
+The following files are generated:
+
+$(prefix)qmp-marshal.c: Command marshal/dispatch functions for each
+                        QMP command defined in the schema

 $(prefix)qmp-commands.h: Function prototypes for the QMP commands
-                         specified in the schema.
+                         specified in the schema

 Example:

-    $ python scripts/qapi-commands.py --output-dir=3D"qapi-generated"
-    --prefix=3D"example-" example-schema.json
     $ cat qapi-generated/example-qmp-commands.h
 [Uninteresting stuff omitted...]

@@ -1242,20 +1236,20 @@ Example:
                              qmp_marshal_my_command, QCO_NO_OPTIONS);
     }

-=3D=3D=3D scripts/qapi-event.py =3D=3D=3D
+=3D=3D=3D Code generated for events =3D=3D=3D

-Used to generate the event-related C code defined by a schema, with
-implementations for qapi_event_send_FOO(). The following files are
-created:
+This is the code related to events defined in the schema, providing
+qapi_event_send_EVENT().
+
+The following files are created:

 $(prefix)qapi-event.h - Function prototypes for each event type, plus an
                         enumeration of all event names
+
 $(prefix)qapi-event.c - Implementation of functions to send an event

 Example:

-    $ python scripts/qapi-event.py --output-dir=3D"qapi-generated"
-    --prefix=3D"example-" example-schema.json
     $ cat qapi-generated/example-qapi-event.h
 [Uninteresting stuff omitted...]

@@ -1301,24 +1295,24 @@ Example:
         QDECREF(qmp);
     }

-    const char *const example_QAPIEvent_lookup[] =3D {
-        [EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
-        [EXAMPLE_QAPI_EVENT__MAX] =3D NULL,
+    const QEnumLookup example_QAPIEvent_lookup =3D {
+        .array =3D (const char *const[]) {
+            [EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
+        },
+        .size =3D EXAMPLE_QAPI_EVENT__MAX
     };

-=3D=3D=3D scripts/qapi-introspect.py =3D=3D=3D
+=3D=3D=3D Code generated for introspection =3D=3D=3D

-Used to generate the introspection C code for a schema. The following
-files are created:
+The following files are created:

 $(prefix)qmp-introspect.c - Defines a string holding a JSON
-                            description of the schema.
-$(prefix)qmp-introspect.h - Declares the above string.
+                            description of the schema
+
+$(prefix)qmp-introspect.h - Declares the above string

 Example:

-    $ python scripts/qapi-introspect.py --output-dir=3D"qapi-generated"
-    --prefix=3D"example-" example-schema.json
     $ cat qapi-generated/example-qmp-introspect.h
 [Uninteresting stuff omitted...]

diff --git a/Makefile b/Makefile
index 90e05ac4093..53c7dc5d19e 100644
--- a/Makefile
+++ b/Makefile
@@ -94,6 +94,7 @@ GENERATED_FILES +=3D qmp-commands.h qapi-types.h qapi-v=
isit.h qapi-event.h
 GENERATED_FILES +=3D qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.=
c
 GENERATED_FILES +=3D qmp-introspect.h
 GENERATED_FILES +=3D qmp-introspect.c
+GENERATED_FILES +=3D qapi-doc.texi

 GENERATED_FILES +=3D trace/generated-tcg-tracers.h

@@ -482,25 +483,26 @@ qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-gene=
rated
 qemu-keymap$(EXESUF): LIBS +=3D $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS +=3D $(XKBCOMMON_CFLAGS)

-gen-out-type =3D $(subst .,-,$(suffix $@))
+qapi-py =3D $(SRC_PATH)/scripts/qapi/commands.py \
+$(SRC_PATH)/scripts/qapi/events.py \
+$(SRC_PATH)/scripts/qapi/introspect.py \
+$(SRC_PATH)/scripts/qapi/types.py \
+$(SRC_PATH)/scripts/qapi/visit.py \
+$(SRC_PATH)/scripts/qapi/common.py \
+$(SRC_PATH)/scripts/qapi/doc.py \
+$(SRC_PATH)/scripts/ordereddict.py \
+$(SRC_PATH)/scripts/qapi-gen.py

-qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
-
-qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
:\
-$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qap=
i-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-types.py \
-		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
-		"GEN","$@")
-qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h =
:\
-$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qap=
i-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-visit.py \
-		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
-		"GEN","$@")
-qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal=
.c :\
-$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(=
qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-commands.p=
y \
-		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
-		"GEN","$@")
+qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
\
+qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h =
\
+qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal=
.c \
+qga/qapi-generated/qga-qapi-doc.texi: \
+qga/qapi-generated/qapi-gen-timestamp ;
+qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json =
$(qapi-py)
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+		-o qga/qapi-generated -p "qga-" $<, \
+		"GEN","$(@:%-timestamp=3D%)")
+	@>$@

 qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
@@ -517,31 +519,18 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC=
_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json

-qapi-types.c qapi-types.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-types.py \
-		$(gen-out-type) -o "." -b $<, \
-		"GEN","$@")
-qapi-visit.c qapi-visit.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-visit.py \
-		$(gen-out-type) -o "." -b $<, \
-		"GEN","$@")
-qapi-event.c qapi-event.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-event.py \
-		$(gen-out-type) -o "." $<, \
-		"GEN","$@")
-qmp-commands.h qmp-marshal.c :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-commands.p=
y \
-		$(gen-out-type) -o "." $<, \
-		"GEN","$@")
-qmp-introspect.h qmp-introspect.c :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-introspect=
.py \
-		$(gen-out-type) -o "." $<, \
-		"GEN","$@")
+qapi-types.c qapi-types.h \
+qapi-visit.c qapi-visit.h \
+qmp-commands.h qmp-marshal.c \
+qapi-event.c qapi-event.h \
+qmp-introspect.h qmp-introspect.c \
+qapi-doc.texi: \
+qapi-gen-timestamp ;
+qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+		-o "." -b $<, \
+		"GEN","$(@:%-timestamp=3D%)")
+	@>$@

 QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
 $(qga-obj-y): $(QGALIB_GEN)
@@ -601,6 +590,7 @@ clean:
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
 	rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
+	rm -f qapi-gen-timestamp
 	rm -rf qapi-generated
 	rm -rf qga/qapi-generated
 	for d in $(ALL_SUBDIRS); do \
@@ -809,13 +799,11 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-in=
fo.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxt=
ool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")

-docs/interop/qemu-qmp-qapi.texi docs/interop/qemu-ga-qapi.texi: $(SRC_PA=
TH)/scripts/qapi2texi.py $(qapi-py)
+docs/interop/qemu-qmp-qapi.texi: qapi-doc.texi
+	@cp -p $< $@

-docs/interop/qemu-qmp-qapi.texi: $(qapi-modules)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi2texi.py $<=
 > $@,"GEN","$@")
-
-docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi2texi.py $<=
 > $@,"GEN","$@")
+docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
+	@cp -p $< $@

 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
 qemu.1: qemu-option-trace.texi
diff --git a/qapi-schema.json b/qapi-schema.json
index cd98a94388a..d214529547d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -72,7 +72,7 @@
         'q_obj_CpuInfo-base'    # CPU, visible through query-cpu
     ] } }

-# Documentation generated with qapi2texi.py is in source order, with
+# Documentation generated with qapi-gen.py is in source order, with
 # included sub-schemas inserted at the first include directive
 # (subsequent include directives have no effect).  To get a sane and
 # stable order, it's best to include each sub-schema just once, or
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
new file mode 100755
index 00000000000..2100ca11452
--- /dev/null
+++ b/scripts/qapi-gen.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python
+# QAPI generator
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+
+import sys
+from qapi.common import parse_command_line, QAPISchema
+from qapi.types import gen_types
+from qapi.visit import gen_visit
+from qapi.commands import gen_commands
+from qapi.events import gen_events
+from qapi.introspect import gen_introspect
+from qapi.doc import gen_doc
+
+
+def main(argv):
+    (input_file, output_dir, prefix, opts) =3D \
+        parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])
+
+    opt_builtins =3D False
+    opt_unmask =3D False
+
+    for o, a in opts:
+        if o in ('-b', '--builtins'):
+            opt_builtins =3D True
+        if o in ('-u', '--unmask-non-abi-names'):
+            opt_unmask =3D True
+
+    schema =3D QAPISchema(input_file)
+
+    gen_types(schema, output_dir, prefix, opt_builtins)
+    gen_visit(schema, output_dir, prefix, opt_builtins)
+    gen_commands(schema, output_dir, prefix)
+    gen_events(schema, output_dir, prefix)
+    gen_introspect(schema, output_dir, prefix, opt_unmask)
+    gen_doc(schema, output_dir, prefix)
+
+
+if __name__ =3D=3D '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi/__init__.py b/scripts/qapi/__init__.py
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/scripts/qapi-commands.py b/scripts/qapi/commands.py
similarity index 95%
rename from scripts/qapi-commands.py
rename to scripts/qapi/commands.py
index c20b22020ed..a744611d580 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi/commands.py
@@ -13,7 +13,7 @@ This work is licensed under the terms of the GNU GPL, v=
ersion 2.
 See the COPYING file in the top-level directory.
 """

-from qapi import *
+from qapi.common import *


 def gen_command_decl(name, arg_type, boxed, ret_type):
@@ -255,11 +255,8 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor)=
:
         self._regy +=3D gen_register_command(name, success_response)


-def main(argv):
-    (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command=
_line()
-
+def gen_commands(schema, output_dir, prefix):
     blurb =3D ' * Schema-defined QAPI/QMP commands'
-
     genc =3D QAPIGenC(blurb, __doc__)
     genh =3D QAPIGenH(blurb, __doc__)

@@ -288,17 +285,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cm=
ds);
 ''',
                    prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3D=
False)))

-    schema =3D QAPISchema(input_file)
     vis =3D QAPISchemaGenCommandVisitor(prefix)
     schema.visit(vis)
     genc.add(vis.defn)
     genh.add(vis.decl)
-
-    if do_c:
-        genc.write(output_dir, prefix + 'qmp-marshal.c')
-    if do_h:
-        genh.write(output_dir, prefix + 'qmp-commands.h')
-
-
-if __name__ =3D=3D '__main__':
-    main(sys.argv)
+    genc.write(output_dir, prefix + 'qmp-marshal.c')
+    genh.write(output_dir, prefix + 'qmp-commands.h')
diff --git a/scripts/qapi.py b/scripts/qapi/common.py
similarity index 99%
rename from scripts/qapi.py
rename to scripts/qapi/common.py
index f12cdddce64..3bc31a03ce1 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi/common.py
@@ -1932,17 +1932,15 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):

     try:
         opts, args =3D getopt.gnu_getopt(sys.argv[1:],
-                                       'chp:o:' + extra_options,
-                                       ['source', 'header', 'prefix=3D',
-                                        'output-dir=3D'] + extra_long_op=
tions)
+                                       'p:o:' + extra_options,
+                                       ['prefix=3D', 'output-dir=3D']
+                                       + extra_long_options)
     except getopt.GetoptError as err:
         print("%s: %s" % (sys.argv[0], str(err)), file=3Dsys.stderr)
         sys.exit(1)

     output_dir =3D ''
     prefix =3D ''
-    do_c =3D False
-    do_h =3D False
     extra_opts =3D []

     for oa in opts:
@@ -1956,23 +1954,15 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
             prefix =3D a
         elif o in ('-o', '--output-dir'):
             output_dir =3D a + '/'
-        elif o in ('-c', '--source'):
-            do_c =3D True
-        elif o in ('-h', '--header'):
-            do_h =3D True
         else:
             extra_opts.append(oa)

-    if not do_c and not do_h:
-        do_c =3D True
-        do_h =3D True
-
     if len(args) !=3D 1:
         print("%s: need exactly one argument" % sys.argv[0], file=3Dsys.=
stderr)
         sys.exit(1)
     fname =3D args[0]

-    return (fname, output_dir, do_c, do_h, prefix, extra_opts)
+    return (fname, output_dir, prefix, extra_opts)


 #
diff --git a/scripts/qapi2texi.py b/scripts/qapi/doc.py
old mode 100755
new mode 100644
similarity index 92%
rename from scripts/qapi2texi.py
rename to scripts/qapi/doc.py
index 8a604d86a66..cc4d5a43fb9
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi/doc.py
@@ -4,11 +4,10 @@
 # This work is licensed under the terms of the GNU LGPL, version 2+.
 # See the COPYING file in the top-level directory.
 """This script produces the documentation of a qapi schema in texinfo fo=
rmat"""
+
 from __future__ import print_function
 import re
-import sys
-
-import qapi
+import qapi.common

 MSG_FMT =3D """
 @deftypefn {type} {{}} {name}
@@ -197,7 +196,7 @@ def texi_entity(doc, what, base=3DNone, variants=3DNo=
ne,
             + texi_sections(doc))


-class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
+class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
     def __init__(self):
         self.out =3D None
         self.cur_doc =3D None
@@ -272,20 +271,8 @@ def texi_schema(schema):
     return gen.out


-def main(argv):
-    """Takes schema argument, prints result to stdout"""
-    if len(argv) !=3D 2:
-        print("%s: need exactly 1 argument: SCHEMA" % argv[0], file=3Dsy=
s.stderr)
-        sys.exit(1)
-
-    schema =3D qapi.QAPISchema(argv[1])
-    if not qapi.doc_required:
-        print("%s: need pragma 'doc-required' "
-               "to generate documentation" % argv[0], file=3Dsys.stderr)
-        sys.exit(1)
-    print('@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n')
-    print(texi_schema(schema), end=3D'')
-
-
-if __name__ =3D=3D '__main__':
-    main(sys.argv)
+def gen_doc(schema, output_dir, prefix):
+    if qapi.common.doc_required:
+        gen =3D qapi.common.QAPIGenDoc()
+        gen.add(texi_schema(schema))
+        gen.write(output_dir, prefix + 'qapi-doc.texi')
diff --git a/scripts/qapi-event.py b/scripts/qapi/events.py
similarity index 93%
rename from scripts/qapi-event.py
rename to scripts/qapi/events.py
index 1f8bf62c8b3..b7dc82004fc 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi/events.py
@@ -12,7 +12,7 @@ This work is licensed under the terms of the GNU GPL, v=
ersion 2.
 See the COPYING file in the top-level directory.
 """

-from qapi import *
+from qapi.common import *


 def build_event_send_proto(name, arg_type, boxed):
@@ -171,11 +171,8 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self._event_names.append(name)


-def main(argv):
-    (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_comman=
d_line()
-
+def gen_events(schema, output_dir, prefix):
     blurb =3D ' * Schema-defined QAPI/QMP events'
-
     genc =3D QAPIGenC(blurb, __doc__)
     genh =3D QAPIGenH(blurb, __doc__)

@@ -199,17 +196,9 @@ def main(argv):
 ''',
                    prefix=3Dprefix))

-    schema =3D QAPISchema(input_file)
     vis =3D QAPISchemaGenEventVisitor(prefix)
     schema.visit(vis)
     genc.add(vis.defn)
     genh.add(vis.decl)
-
-    if do_c:
-        genc.write(output_dir, prefix + 'qapi-event.c')
-    if do_h:
-        genh.write(output_dir, prefix + 'qapi-event.h')
-
-
-if __name__ =3D=3D '__main__':
-    main(sys.argv)
+    genc.write(output_dir, prefix + 'qapi-event.c')
+    genh.write(output_dir, prefix + 'qapi-event.h')
diff --git a/scripts/qapi-introspect.py b/scripts/qapi/introspect.py
similarity index 91%
rename from scripts/qapi-introspect.py
rename to scripts/qapi/introspect.py
index cac219b4d8f..1e4f0651643 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,7 +10,7 @@ This work is licensed under the terms of the GNU GPL, v=
ersion 2.
 See the COPYING file in the top-level directory.
 """

-from qapi import *
+from qapi.common import *


 # Caveman's json.dumps() replacement (we're stuck at Python 2.4)
@@ -168,20 +168,8 @@ const char %(c_name)s[] =3D %(c_string)s;
         self._gen_json(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})


-def main(argv):
-    # Debugging aid: unmask QAPI schema's type names
-    # We normally mask them, because they're not QMP wire ABI
-    opt_unmask =3D False
-
-    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
-        parse_command_line('u', ['unmask-non-abi-names'])
-
-    for o, a in opts:
-        if o in ('-u', '--unmask-non-abi-names'):
-            opt_unmask =3D True
-
+def gen_introspect(schema, output_dir, prefix, opt_unmask):
     blurb =3D ' * QAPI/QMP schema introspection'
-
     genc =3D QAPIGenC(blurb, __doc__)
     genh =3D QAPIGenH(blurb, __doc__)

@@ -192,17 +180,9 @@ def main(argv):
 ''',
                    prefix=3Dprefix))

-    schema =3D QAPISchema(input_file)
     vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
     schema.visit(vis)
     genc.add(vis.defn)
     genh.add(vis.decl)
-
-    if do_c:
-        genc.write(output_dir, prefix + 'qmp-introspect.c')
-    if do_h:
-        genh.write(output_dir, prefix + 'qmp-introspect.h')
-
-
-if __name__ =3D=3D '__main__':
-    main(sys.argv)
+    genc.write(output_dir, prefix + 'qmp-introspect.c')
+    genh.write(output_dir, prefix + 'qmp-introspect.h')
diff --git a/scripts/qapi-types.py b/scripts/qapi/types.py
similarity index 90%
rename from scripts/qapi-types.py
rename to scripts/qapi/types.py
index 7d23544228b..aa3c01e7508 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi/types.py
@@ -13,7 +13,7 @@ This work is licensed under the terms of the GNU GPL, v=
ersion 2.
 # See the COPYING file in the top-level directory.
 """

-from qapi import *
+from qapi.common import *


 # variants must be emitted before their container; track what has alread=
y
@@ -241,22 +241,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self._gen_type_cleanup(name)


-def main(argv):
-    # If you link code generated from multiple schemata, you want only o=
ne
-    # instance of the code for built-in types.  Generate it only when
-    # opt_builtins, enabled by command line option -b.  See also
-    # QAPISchemaGenTypeVisitor.visit_end().
-    opt_builtins =3D False
-
-    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
-        parse_command_line('b', ['builtins'])
-
-    for o, a in opts:
-        if o in ('-b', '--builtins'):
-            opt_builtins =3D True
-
+def gen_types(schema, output_dir, prefix, opt_builtins):
     blurb =3D ' * Schema-defined QAPI types'
-
     genc =3D QAPIGenC(blurb, __doc__)
     genh =3D QAPIGenH(blurb, __doc__)

@@ -272,17 +258,9 @@ def main(argv):
 #include "qapi/util.h"
 '''))

-    schema =3D QAPISchema(input_file)
     vis =3D QAPISchemaGenTypeVisitor(opt_builtins)
     schema.visit(vis)
     genc.add(vis.defn)
     genh.add(vis.decl)
-
-    if do_c:
-        genc.write(output_dir, prefix + 'qapi-types.c')
-    if do_h:
-        genh.write(output_dir, prefix + 'qapi-types.h')
-
-
-if __name__ =3D=3D '__main__':
-    main(sys.argv)
+    genc.write(output_dir, prefix + 'qapi-types.c')
+    genh.write(output_dir, prefix + 'qapi-types.h')
diff --git a/scripts/qapi-visit.py b/scripts/qapi/visit.py
similarity index 92%
rename from scripts/qapi-visit.py
rename to scripts/qapi/visit.py
index 3c23a9389d4..3ed78165d76 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi/visit.py
@@ -13,7 +13,7 @@ This work is licensed under the terms of the GNU GPL, v=
ersion 2.
 See the COPYING file in the top-level directory.
 """

-from qapi import *
+from qapi.common import *


 def gen_visit_decl(name, scalar=3DFalse):
@@ -324,22 +324,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.defn +=3D gen_visit_alternate(name, variants)


-def main(argv):
-    # If you link code generated from multiple schemata, you want only o=
ne
-    # instance of the code for built-in types.  Generate it only when
-    # opt_builtins, enabled by command line option -b.  See also
-    # QAPISchemaGenVisitVisitor.visit_end().
-    opt_builtins =3D False
-
-    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
-        parse_command_line('b', ['builtins'])
-
-    for o, a in opts:
-        if o in ('-b', '--builtins'):
-            opt_builtins =3D True
-
+def gen_visit(schema, output_dir, prefix, opt_builtins):
     blurb =3D ' * Schema-defined QAPI visitors'
-
     genc =3D QAPIGenC(blurb, __doc__)
     genh =3D QAPIGenH(blurb, __doc__)

@@ -359,17 +345,9 @@ def main(argv):
 ''',
                    prefix=3Dprefix))

-    schema =3D QAPISchema(input_file)
     vis =3D QAPISchemaGenVisitVisitor(opt_builtins)
     schema.visit(vis)
     genc.add(vis.defn)
     genh.add(vis.decl)
-
-    if do_c:
-        genc.write(output_dir, prefix + 'qapi-visit.c')
-    if do_h:
-        genh.write(output_dir, prefix + 'qapi-visit.h')
-
-
-if __name__ =3D=3D '__main__':
-    main(sys.argv)
+    genc.write(output_dir, prefix + 'qapi-visit.c')
+    genh.write(output_dir, prefix + 'qapi-visit.h')
diff --git a/monitor.c b/monitor.c
index 308a3d9b787..fc9df6253ad 100644
--- a/monitor.c
+++ b/monitor.c
@@ -951,7 +951,7 @@ EventInfoList *qmp_query_events(Error **errp)
  * visit_type_SchemaInfoList() into a SchemaInfoList, then marshal it
  * to QObject with generated output marshallers, every time.  Instead,
  * we do it in test-qobject-input-visitor.c, just to make sure
- * qapi-introspect.py's output actually conforms to the schema.
+ * qapi-gen.py's output actually conforms to the schema.
  */
 static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
                                  Error **errp)
diff --git a/.gitignore b/.gitignore
index 704b22285dc..2f9a92f6cc9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -28,9 +28,11 @@
 /linux-headers/asm
 /qga/qapi-generated
 /qapi-generated
+/qapi-gen-timestamp
 /qapi-types.[ch]
 /qapi-visit.[ch]
 /qapi-event.[ch]
+/qapi-doc.texi
 /qmp-commands.h
 /qmp-introspect.[ch]
 /qmp-marshal.c
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 937cbd874a0..5b0de376854 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -23,7 +23,16 @@ check-help:
 ifneq ($(wildcard config-host.mak),)
 export SRC_PATH

-qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
+# TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
+qapi-py =3D $(SRC_PATH)/scripts/qapi/commands.py \
+$(SRC_PATH)/scripts/qapi/events.py \
+$(SRC_PATH)/scripts/qapi/introspect.py \
+$(SRC_PATH)/scripts/qapi/types.py \
+$(SRC_PATH)/scripts/qapi/visit.py \
+$(SRC_PATH)/scripts/qapi/common.py \
+$(SRC_PATH)/scripts/qapi/doc.py \
+$(SRC_PATH)/scripts/ordereddict.py \
+$(SRC_PATH)/scripts/qapi-gen.py

 # Get the list of all supported sysemu targets
 SYSEMU_TARGET_LIST :=3D $(subst -softmmu.mak,,$(notdir \
@@ -649,34 +658,24 @@ tests/test-logging$(EXESUF): tests/test-logging.o $=
(test-util-obj-y)
 tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-ob=
j-y) \
 	$(test-block-obj-y)

-tests/test-qapi-types.c tests/test-qapi-types.h :\
-$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-types.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
-		"GEN","$@")
-tests/test-qapi-visit.c tests/test-qapi-visit.h :\
-$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-visit.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
-		"GEN","$@")
-tests/test-qmp-commands.h tests/test-qmp-marshal.c :\
-$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-commands.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
-		"GEN","$@")
-tests/test-qapi-event.c tests/test-qapi-event.h :\
-$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-event.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
-		"GEN","$@")
-tests/test-qmp-introspect.c tests/test-qmp-introspect.h :\
-$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-introspect.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
-		"GEN","$@")
+tests/test-qapi-types.c tests/test-qapi-types.h \
+tests/test-qapi-visit.c tests/test-qapi-visit.h \
+tests/test-qmp-commands.h tests/test-qmp-marshal.c \
+tests/test-qapi-event.c tests/test-qapi-event.h \
+tests/test-qmp-introspect.c tests/test-qmp-introspect.h: \
+tests/test-qapi-gen-timestamp ;
+tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema=
-test.json $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
+		-o tests -p "test-" $<, \
+		"GEN","$(@:%-timestamp=3D%)")
+	@>$@

-tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
+tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
+		-o tests/qapi-schema -p "doc-good-" $<, \
+		"GEN","$@")
+	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
+	@rm -f tests/qapi-schema/doc-good-qapi-*.[ch] tests/qapi-schema/doc-goo=
d-qmp-*.[ch]

 tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visi=
tor.o $(test-qapi-obj-y)
 tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visito=
r.o $(test-qapi-obj-y)
@@ -954,6 +953,7 @@ check-clean:
 	$(MAKE) -C tests/tcg clean
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
+	rm -f tests/test-qapi-gen-timestamp

 clean: check-clean

diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index ac43d3458ea..bb1b6dd2974 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -11,10 +11,8 @@
 #

 from __future__ import print_function
-from qapi import *
-from pprint import pprint
-import os
 import sys
+from qapi.common import QAPISchema, QAPISchemaVisitor


 class QAPISchemaTestVisitor(QAPISchemaVisitor):
--=20
2.14.3
