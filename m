Received: from eggs.gnu.org ([2001:4830:134:3::10]:52155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0007Wm-AI
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJi-0003Wj-69
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJh-0003Vr-UB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:50 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:02 +0100
Message-Id: <1489385927-6735-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 02/47] qapi: Make doc comments optional
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Since we added the documentation generator in commit 3313b61, doc
comments are mandatory.  That's a very good idea for a schema that
needs to be documented, but has proven to be annoying for testing.

Make doc comments optional again, but add a new directive

    { 'pragma': { 'doc-required': true } }

to let a QAPI schema require them.

Require documentation in the schemas we actually want documented:
qapi-schema.json and qga/qapi-schema.json.

We could probably make qapi2texi.py cope with incomplete
documentation, but for now, simply make it refuse to run unless the
schema has 'doc-required': true.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/qapi-code-gen.txt             | 40 +++++++++++++++++++++++++-------------
 qapi-schema.json                   |  2 ++
 qga/qapi-schema.json               |  2 ++
 scripts/qapi.py                    | 20 ++++++++++++++++++-
 scripts/qapi2texi.py               |  3 +++
 tests/Makefile.include             |  1 +
 tests/qapi-schema/doc-missing.err  |  1 +
 tests/qapi-schema/doc-missing.exit |  1 +
 tests/qapi-schema/doc-missing.json |  5 +++++
 tests/qapi-schema/doc-missing.out  |  0
 10 files changed, 61 insertions(+), 14 deletions(-)
 create mode 100644 tests/qapi-schema/doc-missing.err
 create mode 100644 tests/qapi-schema/doc-missing.exit
 create mode 100644 tests/qapi-schema/doc-missing.json
 create mode 100644 tests/qapi-schema/doc-missing.out

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 9514d93..88de5c7 100644
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
 
@@ -302,6 +305,17 @@ an outer file.  The parser may be made stricter in the future to
 prevent incomplete include files.
 
 
+=== Pragma directives ===
+
+Usage: { 'pragma': DICT }
+
+The pragma directive lets you control optional generator behavior.
+The dictionary's entries are pragma names and values.
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
index 345cde1..29a8b77 100644
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
@@ -277,6 +280,11 @@ class QAPISchemaParser(object):
                                        "Value of 'include' must be a string")
                 self._include(include, info, os.path.dirname(abs_fname),
                               previously_included)
+            elif "pragma" in expr:
+                if len(expr) != 1:
+                    raise QAPISemError(info, "Invalid 'pragma' directive")
+                for name, value in expr['pragma'].iteritems():
+                    self._pragma(name, value, info)
             else:
                 expr_elem = {'expr': expr,
                              'info': info}
@@ -308,6 +316,16 @@ class QAPISchemaParser(object):
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
@@ -863,7 +881,7 @@ def check_exprs(exprs):
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
index 346345e..736dd15 100644
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
-- 
2.7.4
