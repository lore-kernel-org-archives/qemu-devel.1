Received: from eggs.gnu.org ([2001:4830:134:3::10]:38924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bh-000839-T5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bb-0007xA-Gr
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007vm-6n
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:39 +0200
Message-Id: <20171002152552.27999-20-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 19/32] qapi: Accept double-quoted strings
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

The QAPI schema parser has always accepted only single-quoted strings,
even though JSON strings are double-quoted.  Accept double-quoted
strings as well, so you can write strings containing single quotes
without backslash escapes.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt            | 2 +-
 scripts/qapi.py                         | 8 +++++---
 tests/qapi-schema/qapi-schema-test.json | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 3186c36460..835c641ea8 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -32,7 +32,7 @@ differences:
 
 * No JSON numbers
 
-* Strings use 'single quotes' instead of "double quotes"
+* Strings can use 'single quotes' in addition to "double quotes"
 
 * The input character set is plain ASCII
 
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 477402b7f8..18c8175866 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -382,14 +382,15 @@ class QAPISchemaParser(object):
                     return
             elif self.tok in '{}:,[]':
                 return
-            elif self.tok == "'":
+            elif self.tok == "'" or self.tok == '"':
                 string = ''
                 esc = False
                 while True:
                     ch = self.src[self.cursor]
                     self.cursor += 1
                     if ch == '\n':
-                        raise QAPIParseError(self, 'Missing terminating "\'"')
+                        raise QAPIParseError(
+                            self, 'Missing terminating %r' % self.tok)
                     if esc:
                         if ch == 'b':
                             string += '\b'
@@ -429,8 +430,9 @@ class QAPISchemaParser(object):
                         esc = False
                     elif ch == '\\':
                         esc = True
-                    elif ch == "'":
+                    elif ch == self.tok:
                         self.val = string
+                        self.tok = "'"
                         return
                     else:
                         string += ch
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index ac8aefc924..c74d5632a5 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -11,7 +11,7 @@
         'guest-sync' ] } }
 
 { 'struct': 'TestStruct',
-  'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
+  'data': { 'integer': 'int', 'boolean': 'bool', 'string': "str" } }
 
 # for testing enums
 { 'struct': 'NestedEnumsOne',
-- 
2.13.6
