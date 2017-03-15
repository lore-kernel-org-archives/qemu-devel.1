Received: from eggs.gnu.org ([2001:4830:134:3::10]:33537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uv-0001YD-3T
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0000MI-76
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Uq-0000Jt-UJ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:22 +0100
Message-Id: <1489582656-31133-34-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 33/47] qapi: Improve error message
 on @NAME: in free-form doc
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py                           | 17 ++++++-----------
 tests/qapi-schema/doc-invalid-section.err |  2 +-
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 9a1d830..4edcea1 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -219,6 +219,11 @@ class QAPIDoc(object):
         if (in_arg or not self.section.name
                 or not self.section.name.startswith('Example')):
             line = line.strip()
+        match = re.match(r'(@\S+:)', line)
+        if match:
+            raise QAPIParseError(self.parser,
+                                 "'%s' not allowed in free-form documentation"
+                                 % match.group(1))
         # TODO Drop this once the dust has settled
         if (isinstance(self.section, QAPIDoc.ArgSection)
                 and '#optional' in line):
@@ -975,14 +980,6 @@ def check_exprs(exprs):
     return exprs
 
 
-def check_freeform_doc(doc):
-    body = str(doc.body)
-    if re.search(r'@\S+:', body, re.MULTILINE):
-        raise QAPISemError(doc.info,
-                           "Free-form documentation block must not contain"
-                           " @NAME: sections")
-
-
 def check_definition_doc(doc, expr, info):
     for i in ('enum', 'union', 'alternate', 'struct', 'command', 'event'):
         if i in expr:
@@ -1021,9 +1018,7 @@ def check_docs(docs):
                 raise QAPISemError(doc.info,
                                    "Empty doc section '%s'" % section.name)
 
-        if not doc.expr:
-            check_freeform_doc(doc)
-        else:
+        if doc.expr:
             check_definition_doc(doc, doc.expr, doc.info)
 
     return docs
diff --git a/tests/qapi-schema/doc-invalid-section.err b/tests/qapi-schema/doc-invalid-section.err
index 85bb67b..bda93b4 100644
--- a/tests/qapi-schema/doc-invalid-section.err
+++ b/tests/qapi-schema/doc-invalid-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-section.json:3: Free-form documentation block must not contain @NAME: sections
+tests/qapi-schema/doc-invalid-section.json:5:1: '@note:' not allowed in free-form documentation
-- 
2.7.4
