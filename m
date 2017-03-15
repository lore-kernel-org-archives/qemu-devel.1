Received: from eggs.gnu.org ([2001:4830:134:3::10]:33639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ux-0001b1-Ab
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0000NG-LT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Ur-0000KU-5T
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:26 +0100
Message-Id: <1489582656-31133-38-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 37/47] qapi: Fix detection of bogus
 member documentation
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

check_definition_doc() checks for member documentation without a
matching member.  It laboriously second-guesses what members
QAPISchema._def_exprs() will create.  That's a stupid game.

Move the check into QAPISchema.check(), where the members are known.
Delegate the actual checking to new QAPIDoc.check().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py                             | 38 ++++++++++-------------------
 tests/qapi-schema/doc-bad-union-member.err  |  1 +
 tests/qapi-schema/doc-bad-union-member.exit |  2 +-
 tests/qapi-schema/doc-bad-union-member.out  | 11 ---------
 4 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 648355e..ca9926b 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -249,6 +249,15 @@ class QAPIDoc(object):
             self.args[member.name] = QAPIDoc.ArgSection(member.name)
         self.args[member.name].connect(member)
 
+    def check(self):
+        bogus = [name for name, section in self.args.iteritems()
+                 if not section.member]
+        if bogus:
+            raise QAPISemError(
+                self.info,
+                "The following documented members are not in "
+                "the declaration: %s" % ", ".join(bogus))
+
 
 class QAPISchemaParser(object):
 
@@ -995,34 +1004,9 @@ def check_exprs(exprs):
 
 
 def check_definition_doc(doc, expr, info):
-    for i in ('enum', 'union', 'alternate', 'struct', 'command', 'event'):
-        if i in expr:
-            meta = i
-            break
-
     if doc.has_section('Returns') and 'command' not in expr:
         raise QAPISemError(info, "'Returns:' is only valid for commands")
 
-    if meta == 'union':
-        args = expr.get('base', [])
-    else:
-        args = expr.get('data', [])
-    if isinstance(args, str):
-        return
-    if isinstance(args, dict):
-        args = args.keys()
-    assert isinstance(args, list)
-
-    if (meta == 'alternate'
-            or (meta == 'union' and not expr.get('discriminator'))):
-        args.append('type')
-
-    doc_args = set(doc.args.keys())
-    args = set([name.strip('*') for name in args])
-    if not doc_args.issubset(args):
-        raise QAPISemError(info, "The following documented members are not in "
-                           "the declaration: %s" % ', '.join(doc_args - args))
-
 
 def check_docs(docs):
     for doc in docs:
@@ -1268,6 +1252,8 @@ class QAPISchemaObjectType(QAPISchemaType):
             self.variants.check(schema, seen)
             assert self.variants.tag_member in self.members
             self.variants.check_clash(schema, self.info, seen)
+        if self.doc:
+            self.doc.check()
 
     # Check that the members of this type do not cause duplicate JSON members,
     # and update seen to track the members seen so far. Report any errors
@@ -1437,6 +1423,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
             v.check_clash(self.info, seen)
             if self.doc:
                 self.doc.connect_member(v)
+        if self.doc:
+            self.doc.check()
 
     def c_type(self):
         return c_name(self.name) + pointer_suffix
diff --git a/tests/qapi-schema/doc-bad-union-member.err b/tests/qapi-schema/doc-bad-union-member.err
index e69de29..4b016df 100644
--- a/tests/qapi-schema/doc-bad-union-member.err
+++ b/tests/qapi-schema/doc-bad-union-member.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-bad-union-member.json:3: The following documented members are not in the declaration: a, b
diff --git a/tests/qapi-schema/doc-bad-union-member.exit b/tests/qapi-schema/doc-bad-union-member.exit
index 573541a..d00491f 100644
--- a/tests/qapi-schema/doc-bad-union-member.exit
+++ b/tests/qapi-schema/doc-bad-union-member.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/doc-bad-union-member.out b/tests/qapi-schema/doc-bad-union-member.out
index 2576ecd..e69de29 100644
--- a/tests/qapi-schema/doc-bad-union-member.out
+++ b/tests/qapi-schema/doc-bad-union-member.out
@@ -1,11 +0,0 @@
-object Base
-    member type: T optional=False
-object Empty
-object Frob
-    base Base
-    tag type
-    case nothing: Empty
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
-    prefix QTYPE
-enum T ['nothing']
-object q_empty
-- 
2.7.4
