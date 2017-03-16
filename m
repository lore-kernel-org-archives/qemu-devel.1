Received: from eggs.gnu.org ([2001:4830:134:3::10]:54637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00065S-9X
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtN-0006zW-9w
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtN-0006xd-1Y
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1615080469
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE0A5C3FA
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:20 +0100
Message-Id: <1489645685-4750-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 04/49] qapi: Make doc comments optional
 where we don't need them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since we added the documentation generator in commit 3313b61, doc
comments are mandatory.  That's a very good idea for a schema that
needs to be documented, but has proven to be annoying for testing.

Make doc comments optional again, but add a new directive

    { 'pragma': { 'doc-required': true } }

to let a QAPI schema require them.

Add test cases for the new pragma directive.  While there, plug a
minor hole in includ directive test coverage.

Require documentation in the schemas we actually want documented:
qapi-schema.json and qga/qapi-schema.json.

We could probably make qapi2texi.py cope with incomplete
documentation, but for now, simply make it refuse to run unless the
schema has 'doc-required': true.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1489582656-31133-3-git-send-email-armbru@redhat.com>
[qapi-code-gen.txt wording tweaked]
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/qapi-code-gen.txt                          | 43 +++++++++++++++++--------
 qapi-schema.json                                |  2 ++
 qga/qapi-schema.json                            |  2 ++
 scripts/qapi.py                                 | 24 +++++++++++++-
 scripts/qapi2texi.py                            |  3 ++
 tests/Makefile.include                          |  5 +++
 tests/qapi-schema/doc-missing.err               |  1 +
 tests/qapi-schema/doc-missing.exit              |  1 +
 tests/qapi-schema/doc-missing.json              |  5 +++
 tests/qapi-schema/doc-missing.out               |  0
 tests/qapi-schema/include-extra-junk.err        |  1 +
 tests/qapi-schema/include-extra-junk.exit       |  1 +
 tests/qapi-schema/include-extra-junk.json       |  3 ++
 tests/qapi-schema/include-extra-junk.out        |  0
 tests/qapi-schema/pragma-doc-required-crap.err  |  1 +
 tests/qapi-schema/pragma-doc-required-crap.exit |  1 +
 tests/qapi-schema/pragma-doc-required-crap.json |  3 ++
 tests/qapi-schema/pragma-doc-required-crap.out  |  0
 tests/qapi-schema/pragma-extra-junk.err         |  1 +
 tests/qapi-schema/pragma-extra-junk.exit        |  1 +
 tests/qapi-schema/pragma-extra-junk.json        |  3 ++
 tests/qapi-schema/pragma-extra-junk.out         |  0
 tests/qapi-schema/pragma-non-dict.err           |  1 +
 tests/qapi-schema/pragma-non-dict.exit          |  1 +
 tests/qapi-schema/pragma-non-dict.json          |  3 ++
 tests/qapi-schema/pragma-non-dict.out           |  0
 26 files changed, 92 insertions(+), 14 deletions(-)
 create mode 100644 tests/qapi-schema/doc-missing.err
 create mode 100644 tests/qapi-schema/doc-missing.exit
 create mode 100644 tests/qapi-schema/doc-missing.json
 create mode 100644 tests/qapi-schema/doc-missing.out
 create mode 100644 tests/qapi-schema/include-extra-junk.err
 create mode 100644 tests/qapi-schema/include-extra-junk.exit
 create mode 100644 tests/qapi-schema/include-extra-junk.json
 create mode 100644 tests/qapi-schema/include-extra-junk.out
 create mode 100644 tests/qapi-schema/pragma-doc-required-crap.err
 create mode 100644 tests/qapi-schema/pragma-doc-required-crap.exit
 create mode 100644 tests/qapi-schema/pragma-doc-required-crap.json
 create mode 100644 tests/qapi-schema/pragma-doc-required-crap.out
 create mode 100644 tests/qapi-schema/pragma-extra-junk.err
 create mode 100644 tests/qapi-schema/pragma-extra-junk.exit
 create mode 100644 tests/qapi-schema/pragma-extra-junk.json
 create mode 100644 tests/qapi-schema/pragma-extra-junk.out
 create mode 100644 tests/qapi-schema/pragma-non-dict.err
 create mode 100644 tests/qapi-schema/pragma-non-dict.exit
 create mode 100644 tests/qapi-schema/pragma-non-dict.json
 create mode 100644 tests/qapi-schema/pragma-non-dict.out

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 9514d93..4b64ee7 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -117,10 +117,13 @@ Example:
 
 ==== Expression documentation ====
 
-Each expression that isn't an include directive must be preceded by a
+Each expression that isn't an include directive may be preceded by a
 documentation block.  Such blocks are called expression documentation
 blocks.
 
+When documentation is required (see pragma 'doc-required'), expression
+documentation blocks are mandatory.
+
 The documentation block consists of a first line naming the
 expression, an optional overview, a description of each argument (for
 commands and events) or member (for structs, unions and alternates),
@@ -204,17 +207,17 @@ once.  It is permissible for the schema to contain additional types
 not used by any commands or events in the Client JSON Protocol, for
 the side effect of generated C code used internally.
 
-There are seven top-level expressions recognized by the parser:
-'include', 'command', 'struct', 'enum', 'union', 'alternate', and
-'event'.  There are several groups of types: simple types (a number of
-built-in types, such as 'int' and 'str'; as well as enumerations),
-complex types (structs and two flavors of unions), and alternate types
-(a choice between other types).  The 'command' and 'event' expressions
-can refer to existing types by name, or list an anonymous type as a
-dictionary. Listing a type name inside an array refers to a
-single-dimension array of that type; multi-dimension arrays are not
-directly supported (although an array of a complex struct that
-contains an array member is possible).
+There are eight top-level expressions recognized by the parser:
+'include', 'pragma', 'command', 'struct', 'enum', 'union',
+'alternate', and 'event'.  There are several groups of types: simple
+types (a number of built-in types, such as 'int' and 'str'; as well as
+enumerations), complex types (structs and two flavors of unions), and
+alternate types (a choice between other types).  The 'command' and
+'event' expressions can refer to existing types by name, or list an
+anonymous type as a dictionary. Listing a type name inside an array
+refers to a single-dimension array of that type; multi-dimension
+arrays are not directly supported (although an array of a complex
+struct that contains an array member is possible).
 
 All names must begin with a letter, and contain only ASCII letters,
 digits, hyphen, and underscore.  There are two exceptions: enum values
@@ -282,7 +285,7 @@ The following types are predefined, and map to C as follows:
   QType     QType      JSON string matching enum QType values
 
 
-=== Includes ===
+=== Include directives ===
 
 Usage: { 'include': STRING }
 
@@ -302,6 +305,20 @@ an outer file.  The parser may be made stricter in the future to
 prevent incomplete include files.
 
 
+=== Pragma directives ===
+
+Usage: { 'pragma': DICT }
+
+The pragma directive lets you control optional generator behavior.
+The dictionary's entries are pragma names and values.
+
+Pragma's scope is currently the complete schema.  Setting the same
+pragma to different values in parts of the schema doesn't work.
+
+Pragma 'doc-required' takes a boolean value.  If true, documentation
+is required.  Default is false.
+
+
 === Struct types ===
 
 Usage: { 'struct': STRING, 'data': DICT, '*base': STRUCT-NAME }
diff --git a/qapi-schema.json b/qapi-schema.json
index 32b4a4b..d5438ee 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -49,6 +49,8 @@
 #
 ##
 
+{ 'pragma': { 'doc-required': true } }
+
 # QAPI common definitions
 { 'include': 'qapi/common.json' }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d421609..3f3d428 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -11,6 +11,8 @@
 #
 ##
 
+{ 'pragma': { 'doc-required': true } }
+
 ##
 # @guest-sync-delimited:
 #
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 345cde1..fe9d3cf 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -37,6 +37,9 @@ builtin_types = {
     'QType':    'QTYPE_QSTRING',
 }
 
+# Are documentation comments required?
+doc_required = False
+
 # Whitelist of commands allowed to return a non-dictionary
 returns_whitelist = [
     # From QMP:
@@ -277,6 +280,15 @@ class QAPISchemaParser(object):
                                        "Value of 'include' must be a string")
                 self._include(include, info, os.path.dirname(abs_fname),
                               previously_included)
+            elif "pragma" in expr:
+                if len(expr) != 1:
+                    raise QAPISemError(info, "Invalid 'pragma' directive")
+                pragma = expr['pragma']
+                if not isinstance(pragma, dict):
+                    raise QAPISemError(
+                        info, "Value of 'pragma' must be a dictionary")
+                for name, value in pragma.iteritems():
+                    self._pragma(name, value, info)
             else:
                 expr_elem = {'expr': expr,
                              'info': info}
@@ -308,6 +320,16 @@ class QAPISchemaParser(object):
         self.exprs.extend(exprs_include.exprs)
         self.docs.extend(exprs_include.docs)
 
+    def _pragma(self, name, value, info):
+        global doc_required
+        if name == 'doc-required':
+            if not isinstance(value, bool):
+                raise QAPISemError(info,
+                                   "Pragma 'doc-required' must be boolean")
+            doc_required = value
+        else:
+            raise QAPISemError(info, "Unknown pragma '%s'" % name)
+
     def accept(self, skip_comment=True):
         while True:
             self.tok = self.src[self.cursor]
@@ -863,7 +885,7 @@ def check_exprs(exprs):
         expr = expr_elem['expr']
         info = expr_elem['info']
 
-        if 'doc' not in expr_elem:
+        if 'doc' not in expr_elem and doc_required:
             raise QAPISemError(info,
                                "Expression missing documentation comment")
 
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 69f5edc..06d6abf 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -254,6 +254,9 @@ def main(argv):
         sys.exit(1)
 
     schema = qapi.QAPISchema(argv[1])
+    if not qapi.doc_required:
+        print >>sys.stderr, ("%s: need pragma 'doc-required' "
+                             "to generate documentation" % argv[0])
     print texi(schema.docs)
 
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 346345e..7a58c12 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -381,6 +381,7 @@ qapi-schema += doc-invalid-end2.json
 qapi-schema += doc-invalid-return.json
 qapi-schema += doc-invalid-section.json
 qapi-schema += doc-invalid-start.json
+qapi-schema += doc-missing.json
 qapi-schema += doc-missing-colon.json
 qapi-schema += doc-missing-expr.json
 qapi-schema += doc-missing-space.json
@@ -422,6 +423,7 @@ qapi-schema += funny-char.json
 qapi-schema += ident-with-escape.json
 qapi-schema += include-before-err.json
 qapi-schema += include-cycle.json
+qapi-schema += include-extra-junk.json
 qapi-schema += include-format-err.json
 qapi-schema += include-nested-err.json
 qapi-schema += include-no-file.json
@@ -439,6 +441,9 @@ qapi-schema += missing-comma-object.json
 qapi-schema += missing-type.json
 qapi-schema += nested-struct-data.json
 qapi-schema += non-objects.json
+qapi-schema += pragma-doc-required-crap.json
+qapi-schema += pragma-extra-junk.json
+qapi-schema += pragma-non-dict.json
 qapi-schema += qapi-schema-test.json
 qapi-schema += quoted-structural-chars.json
 qapi-schema += redefined-builtin.json
diff --git a/tests/qapi-schema/doc-missing.err b/tests/qapi-schema/doc-missing.err
new file mode 100644
index 0000000..7f2f326
--- /dev/null
+++ b/tests/qapi-schema/doc-missing.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-missing.json:5: Expression missing documentation comment
diff --git a/tests/qapi-schema/doc-missing.exit b/tests/qapi-schema/doc-missing.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/doc-missing.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-missing.json b/tests/qapi-schema/doc-missing.json
new file mode 100644
index 0000000..5956709
--- /dev/null
+++ b/tests/qapi-schema/doc-missing.json
@@ -0,0 +1,5 @@
+# Expression documentation required
+
+{ 'pragma': { 'doc-required': true } }
+
+{ 'command': 'undocumented' }
diff --git a/tests/qapi-schema/doc-missing.out b/tests/qapi-schema/doc-missing.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/include-extra-junk.err b/tests/qapi-schema/include-extra-junk.err
new file mode 100644
index 0000000..e6ef2a3
--- /dev/null
+++ b/tests/qapi-schema/include-extra-junk.err
@@ -0,0 +1 @@
+tests/qapi-schema/include-extra-junk.json:3: Invalid 'include' directive
diff --git a/tests/qapi-schema/include-extra-junk.exit b/tests/qapi-schema/include-extra-junk.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/include-extra-junk.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/include-extra-junk.json b/tests/qapi-schema/include-extra-junk.json
new file mode 100644
index 0000000..25fe850
--- /dev/null
+++ b/tests/qapi-schema/include-extra-junk.json
@@ -0,0 +1,3 @@
+# 'include' must be the sole member
+
+{ 'include': 'comments.json', 'junk': true }
diff --git a/tests/qapi-schema/include-extra-junk.out b/tests/qapi-schema/include-extra-junk.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/pragma-doc-required-crap.err b/tests/qapi-schema/pragma-doc-required-crap.err
new file mode 100644
index 0000000..39cd56c
--- /dev/null
+++ b/tests/qapi-schema/pragma-doc-required-crap.err
@@ -0,0 +1 @@
+tests/qapi-schema/pragma-doc-required-crap.json:3: Pragma 'doc-required' must be boolean
diff --git a/tests/qapi-schema/pragma-doc-required-crap.exit b/tests/qapi-schema/pragma-doc-required-crap.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/pragma-doc-required-crap.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/pragma-doc-required-crap.json b/tests/qapi-schema/pragma-doc-required-crap.json
new file mode 100644
index 0000000..ed763c5
--- /dev/null
+++ b/tests/qapi-schema/pragma-doc-required-crap.json
@@ -0,0 +1,3 @@
+# 'doc-required' must be bool
+
+{ 'pragma': { 'doc-required': {} } }
diff --git a/tests/qapi-schema/pragma-doc-required-crap.out b/tests/qapi-schema/pragma-doc-required-crap.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/pragma-extra-junk.err b/tests/qapi-schema/pragma-extra-junk.err
new file mode 100644
index 0000000..4481688
--- /dev/null
+++ b/tests/qapi-schema/pragma-extra-junk.err
@@ -0,0 +1 @@
+tests/qapi-schema/pragma-extra-junk.json:3: Invalid 'pragma' directive
diff --git a/tests/qapi-schema/pragma-extra-junk.exit b/tests/qapi-schema/pragma-extra-junk.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/pragma-extra-junk.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/pragma-extra-junk.json b/tests/qapi-schema/pragma-extra-junk.json
new file mode 100644
index 0000000..ba38ef2
--- /dev/null
+++ b/tests/qapi-schema/pragma-extra-junk.json
@@ -0,0 +1,3 @@
+# 'pragma' must be the sole member
+
+{ 'pragma': { 'doc-required': true }, 'junk': true }
diff --git a/tests/qapi-schema/pragma-extra-junk.out b/tests/qapi-schema/pragma-extra-junk.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/pragma-non-dict.err b/tests/qapi-schema/pragma-non-dict.err
new file mode 100644
index 0000000..75bc335
--- /dev/null
+++ b/tests/qapi-schema/pragma-non-dict.err
@@ -0,0 +1 @@
+tests/qapi-schema/pragma-non-dict.json:3: Value of 'pragma' must be a dictionary
diff --git a/tests/qapi-schema/pragma-non-dict.exit b/tests/qapi-schema/pragma-non-dict.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/pragma-non-dict.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/pragma-non-dict.json b/tests/qapi-schema/pragma-non-dict.json
new file mode 100644
index 0000000..60fcc79
--- /dev/null
+++ b/tests/qapi-schema/pragma-non-dict.json
@@ -0,0 +1,3 @@
+# Value of 'pragma' must be a dictionary
+
+{ 'pragma': [] }
diff --git a/tests/qapi-schema/pragma-non-dict.out b/tests/qapi-schema/pragma-non-dict.out
new file mode 100644
index 0000000..e69de29
-- 
2.7.4
