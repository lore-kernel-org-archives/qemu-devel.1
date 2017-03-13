Received: from eggs.gnu.org ([2001:4830:134:3::10]:52288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0007YO-V9
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJj-0003Yp-Tv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJj-0003XP-Lp
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:51 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:05 +0100
Message-Id: <1489385927-6735-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 05/47] qapi: Have each QAPI schema
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
 docs/qapi-code-gen.txt                   | 13 +++++++------
 qapi-schema.json                         | 12 ++++++++++++
 qga/qapi-schema.json                     | 15 +++++++++++++++
 scripts/qapi.py                          | 30 +++++++++---------------------
 tests/qapi-schema/qapi-schema-test.json  |  7 +++++++
 tests/qapi-schema/returns-whitelist.err  |  2 +-
 tests/qapi-schema/returns-whitelist.json |  4 ++++
 7 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index d9c1f91..e907e57 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -315,6 +315,9 @@ The dictionary's entries are pragma names and values.
 Pragma 'doc-required' takes a boolean value.  If true, documentation
 is required.  Default is false.
 
+Pragma 'returns-whitelist' takes a list of command names that may
+violate the rules on permitted return types.  Default is none.
+
 
 === Struct types ===
 
@@ -563,12 +566,10 @@ The member is optional from the command declaration; if absent, the
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
index 29a8b77..a90b682 100644
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
@@ -317,12 +298,19 @@ class QAPISchemaParser(object):
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
