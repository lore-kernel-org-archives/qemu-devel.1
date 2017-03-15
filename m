Received: from eggs.gnu.org ([2001:4830:134:3::10]:33301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uq-0001V9-1v
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Un-0000Gj-TJ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Un-0000GE-LU
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:56:54 +0100
Message-Id: <1489582656-31133-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 05/47] qapi: Have each QAPI schema
 declare its returns white-list
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

qapi.py has a hardcoded white-list of command names that may violate
the rules on permitted return types.  Add a new pragma directive
'returns-whitelist', and use it to replace the hard-coded white-list.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/qapi-code-gen.txt                             | 13 +++++-----
 qapi-schema.json                                   | 12 +++++++++
 qga/qapi-schema.json                               | 15 +++++++++++
 scripts/qapi.py                                    | 30 +++++++---------------
 tests/Makefile.include                             |  1 +
 .../qapi-schema/pragma-returns-whitelist-crap.err  |  1 +
 .../qapi-schema/pragma-returns-whitelist-crap.exit |  1 +
 .../qapi-schema/pragma-returns-whitelist-crap.json |  3 +++
 .../qapi-schema/pragma-returns-whitelist-crap.out  |  0
 tests/qapi-schema/qapi-schema-test.json            |  7 +++++
 tests/qapi-schema/returns-whitelist.err            |  2 +-
 tests/qapi-schema/returns-whitelist.json           |  4 +++
 12 files changed, 61 insertions(+), 28 deletions(-)
 create mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.err
 create mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.exit
 create mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.json
 create mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.out

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 31fa35b..0a04419 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -318,6 +318,9 @@ different values in parts of the schema doesn't work.
 Pragma 'doc-required' takes a boolean value.  If true, documentation
 is required.  Default is false.
 
+Pragma 'returns-whitelist' takes a list of command names that may
+violate the rules on permitted return types.  Default is none.
+
 
 === Struct types ===
 
@@ -566,12 +569,10 @@ The member is optional from the command declaration; if absent, the
 "return" member will be an empty dictionary.  If 'returns' is present,
 it must be the string name of a complex or built-in type, a
 one-element array containing the name of a complex or built-in type.
-Although it is permitted to have the 'returns' member name a built-in
-type or an array of built-in types, any command that does this cannot
-be extended to return additional information in the future; thus, new
-commands should strongly consider returning a dictionary-based type or
-an array of dictionaries, even if the dictionary only contains one
-member at the present.
+To return anything else, you have to list the command in pragma
+'returns-whitelist'.  If you do this, the command cannot be extended
+to return additional information in the future.  Use of
+'returns-whitelist' for new commands is strongly discouraged.
 
 All commands in Client JSON Protocol use a dictionary to report
 failure, with no way to specify that in QAPI.  Where the error return
diff --git a/qapi-schema.json b/qapi-schema.json
index d5438ee..93e9e98 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -51,6 +51,18 @@
 
 { 'pragma': { 'doc-required': true } }
 
+# Whitelists to permit QAPI rule violations; think twice before you
+# add to them!
+{ 'pragma': {
+    # Commands allowed to return a non-dictionary:
+    'returns-whitelist': [
+        'human-monitor-command',
+        'qom-get',
+        'query-migrate-cache-size',
+        'query-tpm-models',
+        'query-tpm-types',
+        'ringbuf-read' ] } }
+
 # QAPI common definitions
 { 'include': 'qapi/common.json' }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 3f3d428..a8e4bda 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -13,6 +13,21 @@
 
 { 'pragma': { 'doc-required': true } }
 
+# Whitelists to permit QAPI rule violations; think twice before you
+# add to them!
+{ 'pragma': {
+    # Commands allowed to return a non-dictionary:
+    'returns-whitelist': [
+        'guest-file-open',
+        'guest-fsfreeze-freeze',
+        'guest-fsfreeze-freeze-list',
+        'guest-fsfreeze-status',
+        'guest-fsfreeze-thaw',
+        'guest-get-time',
+        'guest-set-vcpus',
+        'guest-sync',
+        'guest-sync-delimited' ] } }
+
 ##
 # @guest-sync-delimited:
 #
diff --git a/scripts/qapi.py b/scripts/qapi.py
index fe9d3cf..1d86d85 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -41,26 +41,7 @@ builtin_types = {
 doc_required = False
 
 # Whitelist of commands allowed to return a non-dictionary
-returns_whitelist = [
-    # From QMP:
-    'human-monitor-command',
-    'qom-get',
-    'query-migrate-cache-size',
-    'query-tpm-models',
-    'query-tpm-types',
-    'ringbuf-read',
-
-    # From QGA:
-    'guest-file-open',
-    'guest-fsfreeze-freeze',
-    'guest-fsfreeze-freeze-list',
-    'guest-fsfreeze-status',
-    'guest-fsfreeze-thaw',
-    'guest-get-time',
-    'guest-set-vcpus',
-    'guest-sync',
-    'guest-sync-delimited',
-]
+returns_whitelist = []
 
 # Whitelist of entities allowed to violate case conventions
 case_whitelist = [
@@ -321,12 +302,19 @@ class QAPISchemaParser(object):
         self.docs.extend(exprs_include.docs)
 
     def _pragma(self, name, value, info):
-        global doc_required
+        global doc_required, returns_whitelist
         if name == 'doc-required':
             if not isinstance(value, bool):
                 raise QAPISemError(info,
                                    "Pragma 'doc-required' must be boolean")
             doc_required = value
+        elif name == 'returns-whitelist':
+            if (not isinstance(value, list)
+                    or any([not isinstance(elt, str) for elt in value])):
+                raise QAPISemError(info,
+                                   "Pragma returns-whitelist must be"
+                                   " a list of strings")
+            returns_whitelist = value
         else:
             raise QAPISemError(info, "Unknown pragma '%s'" % name)
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7a58c12..f9da3aa 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -444,6 +444,7 @@ qapi-schema += non-objects.json
 qapi-schema += pragma-doc-required-crap.json
 qapi-schema += pragma-extra-junk.json
 qapi-schema += pragma-non-dict.json
+qapi-schema += pragma-returns-whitelist-crap.json
 qapi-schema += qapi-schema-test.json
 qapi-schema += quoted-structural-chars.json
 qapi-schema += redefined-builtin.json
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.err b/tests/qapi-schema/pragma-returns-whitelist-crap.err
new file mode 100644
index 0000000..5d77021
--- /dev/null
+++ b/tests/qapi-schema/pragma-returns-whitelist-crap.err
@@ -0,0 +1 @@
+tests/qapi-schema/pragma-returns-whitelist-crap.json:3: Pragma returns-whitelist must be a list of strings
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.exit b/tests/qapi-schema/pragma-returns-whitelist-crap.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/pragma-returns-whitelist-crap.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.json b/tests/qapi-schema/pragma-returns-whitelist-crap.json
new file mode 100644
index 0000000..f6b81b0
--- /dev/null
+++ b/tests/qapi-schema/pragma-returns-whitelist-crap.json
@@ -0,0 +1,3 @@
+# 'returns-whitelist' must be list of strings
+
+{ 'pragma': { 'returns-whitelist': [ 'good', [ 'bad' ] ] } }
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.out b/tests/qapi-schema/pragma-returns-whitelist-crap.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 1719463..842ea3c 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -3,6 +3,13 @@
 # This file is a stress test of supported qapi constructs that must
 # parse and compile correctly.
 
+# Whitelists to permit QAPI rule violations
+{ 'pragma': {
+    # Commands allowed to return a non-dictionary:
+    'returns-whitelist': [
+        'guest-get-time',
+        'guest-sync' ] } }
+
 { 'struct': 'TestStruct',
   'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
 
diff --git a/tests/qapi-schema/returns-whitelist.err b/tests/qapi-schema/returns-whitelist.err
index f47c1ee..b2ba7a9 100644
--- a/tests/qapi-schema/returns-whitelist.err
+++ b/tests/qapi-schema/returns-whitelist.err
@@ -1 +1 @@
-tests/qapi-schema/returns-whitelist.json:10: 'returns' for command 'no-way-this-will-get-whitelisted' cannot use built-in type 'int'
+tests/qapi-schema/returns-whitelist.json:14: 'returns' for command 'no-way-this-will-get-whitelisted' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/returns-whitelist.json b/tests/qapi-schema/returns-whitelist.json
index e8b3cea..da20932 100644
--- a/tests/qapi-schema/returns-whitelist.json
+++ b/tests/qapi-schema/returns-whitelist.json
@@ -1,4 +1,8 @@
 # we enforce that 'returns' be a dict or array of dict unless whitelisted
+
+{ 'pragma': { 'returns-whitelist': [
+    'human-monitor-command', 'query-tpm-models', 'guest-get-time' ] } }
+
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
   'returns': 'str' }
-- 
2.7.4
