Received: from eggs.gnu.org ([2001:4830:134:3::10]:51906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXG-0008Hl-SI
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXC-0006Vk-It
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkXC-0006U4-AF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:14 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:41 +0100
Message-Id: <20180111213250.16511-43-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 42/51] qapi: add a 'unit' pragma
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

Add a pragma that allows to tag the following expressions in the
schema with a unit name. By default, an expression has no unit name.

See the docs/devel/qapi-code-gen.txt for more details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                            | 22 +++++++++++++++++++---
 docs/devel/qapi-code-gen.txt               |  4 ++++
 tests/Makefile.include                     |  7 ++++++-
 tests/qapi-schema/pragma-unit-invalid.err  |  1 +
 tests/qapi-schema/pragma-unit-invalid.exit |  1 +
 tests/qapi-schema/pragma-unit-invalid.json |  3 +++
 tests/qapi-schema/pragma-unit-invalid.out  |  0
 tests/qapi-schema/qapi-schema-test.json    |  6 +++++-
 tests/qapi-schema/qapi-schema-test.out     |  2 ++
 9 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100644 tests/qapi-schema/pragma-unit-invalid.err
 create mode 100644 tests/qapi-schema/pragma-unit-invalid.exit
 create mode 100644 tests/qapi-schema/pragma-unit-invalid.json
 create mode 100644 tests/qapi-schema/pragma-unit-invalid.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index f56460d028..07e738c3f1 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -47,6 +47,9 @@ returns_whitelist =3D []
 # Whitelist of entities allowed to violate case conventions
 name_case_whitelist =3D []
=20
+# Unit names to include for the visit (default to all units)
+visit_units =3D []
+
 enum_types =3D {}
 struct_types =3D {}
 union_types =3D {}
@@ -269,11 +272,12 @@ class QAPISchemaParser(object):
         self.exprs =3D []
         self.docs =3D []
         self.accept()
+        self.unit =3D None
         cur_doc =3D None
=20
         while self.tok is not None:
             info =3D {'file': self.fname, 'line': self.line,
-                    'parent': self.incl_info}
+                    'parent': self.incl_info, 'unit': self.unit}
             if self.tok =3D=3D '#':
                 self.reject_expr_doc(cur_doc)
                 cur_doc =3D self.get_doc(info)
@@ -362,6 +366,11 @@ class QAPISchemaParser(object):
                                    "Pragma name-case-whitelist must be"
                                    " a list of strings")
             name_case_whitelist =3D value
+        elif name =3D=3D 'unit':
+            if not isinstance(value, str):
+                raise QAPISemError(info,
+                                   "Pragma 'unit' must be string")
+            self.unit =3D value
         else:
             raise QAPISemError(info, "Unknown pragma '%s'" % name)
=20
@@ -1827,6 +1836,10 @@ class QAPISchema(object):
     def visit(self, visitor):
         visitor.visit_begin(self)
         for (name, entity) in sorted(self._entity_dict.items()):
+            # FIXME: implicit array types should use element type unit
+            unit =3D entity.info and entity.info.get('unit')
+            if visit_units and unit not in visit_units:
+                continue
             if visitor.visit_needed(entity):
                 entity.visit(visitor)
         visitor.visit_end()
@@ -2126,13 +2139,14 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
=20
     try:
         opts, args =3D getopt.gnu_getopt(
-            sys.argv[1:], 'chp:o:i:' + extra_options,
+            sys.argv[1:], 'chp:o:u:i:' + extra_options,
             ['source', 'header', 'prefix=3D', 'output-dir=3D',
-             'include=3D'] + extra_long_options)
+             'unit=3D', 'include=3D'] + extra_long_options)
     except getopt.GetoptError as err:
         print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
         sys.exit(1)
=20
+    global visit_units
     output_dir =3D ''
     prefix =3D ''
     do_c =3D False
@@ -2152,6 +2166,8 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
             prefix =3D a
         elif o in ('-o', '--output-dir'):
             output_dir =3D a + '/'
+        elif o in ('-u', '--unit'):
+            visit_units.append(a)
         elif o in ('-c', '--source'):
             do_c =3D True
         elif o in ('-h', '--header'):
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 479b755609..31bcbdac58 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -326,6 +326,10 @@ violate the rules on permitted return types.  Defaul=
t is none.
 Pragma 'name-case-whitelist' takes a list of names that may violate
 rules on use of upper- vs. lower-case letters.  Default is none.
=20
+Pragma 'unit' takes a string value.  It will set the unit name for the
+following expressions in the schema.  Most code generators can filter
+based on a unit name.  This allows to select a subset of the
+expressions.  Default is none.
=20
 =3D=3D=3D Struct types =3D=3D=3D
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2b83f05954..2f39e2d5aa 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -510,6 +510,7 @@ qapi-schema +=3D pragma-extra-junk.json
 qapi-schema +=3D pragma-name-case-whitelist-crap.json
 qapi-schema +=3D pragma-non-dict.json
 qapi-schema +=3D pragma-returns-whitelist-crap.json
+qapi-schema +=3D pragma-unit-invalid.json
 qapi-schema +=3D qapi-schema-test.json
 qapi-schema +=3D quoted-structural-chars.json
 qapi-schema +=3D redefined-builtin.json
@@ -665,13 +666,17 @@ $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json=
 $(SRC_PATH)/scripts/qapi-com
 tests/test-qapi-event.c tests/test-qapi-event.h :\
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-event.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
-		$(gen-out-type) -o tests -p "test-" $<, \
+		$(gen-out-type) -o tests -p "test-" -u test-unit $<, \
 		"GEN","$@")
+# check that another-unit is not included
+	$(call quiet-command,[ $(gen-out-type) =3D=3D -h ] || grep -v -q ANOTHE=
R_EVENT $@,"TEST","$@")
 tests/test-qmp-introspect.c tests/test-qmp-introspect.h :\
 $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-introspect.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
 		$(gen-out-type) -o tests -p "test-" $<, \
 		"GEN","$@")
+# check all units are included
+	$(call quiet-command,[ $(gen-out-type) =3D=3D -h ] || grep -q ANOTHER_E=
VENT $@,"TEST","$@")
=20
 tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
diff --git a/tests/qapi-schema/pragma-unit-invalid.err b/tests/qapi-schem=
a/pragma-unit-invalid.err
new file mode 100644
index 0000000000..e22176d42e
--- /dev/null
+++ b/tests/qapi-schema/pragma-unit-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/pragma-unit-invalid.json:3: Pragma 'unit' must be stri=
ng
diff --git a/tests/qapi-schema/pragma-unit-invalid.exit b/tests/qapi-sche=
ma/pragma-unit-invalid.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/pragma-unit-invalid.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/pragma-unit-invalid.json b/tests/qapi-sche=
ma/pragma-unit-invalid.json
new file mode 100644
index 0000000000..636b53939a
--- /dev/null
+++ b/tests/qapi-schema/pragma-unit-invalid.json
@@ -0,0 +1,3 @@
+# Value of 'unit' pragma must be a string
+
+{ 'pragma': { 'unit': {} } }
diff --git a/tests/qapi-schema/pragma-unit-invalid.out b/tests/qapi-schem=
a/pragma-unit-invalid.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index cd33c084cb..2fb1d3449c 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -8,7 +8,8 @@
     # Commands allowed to return a non-dictionary:
     'returns-whitelist': [
         'guest-get-time',
-        'guest-sync' ] } }
+        'guest-sync' ],
+    'unit': 'test-unit' } }
=20
 { 'struct': 'TestStruct',
   'data': { 'integer': {'type': 'int'}, 'boolean': 'bool', 'string': 'st=
r' } }
@@ -224,3 +225,6 @@
   { 'foo': 'TestIfStruct',
     'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_EVT_BAR)' } },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
+
+{ 'pragma': { 'unit': 'another-unit' } }
+{ 'event': 'ANOTHER_EVENT' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 7215aeb4a6..cbc61fc3a2 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,3 +1,5 @@
+event ANOTHER_EVENT None
+   boxed=3DFalse
 alternate AltEnumBool
     tag type
     case e: EnumOne
--=20
2.16.0.rc1.1.gef27df75a1
