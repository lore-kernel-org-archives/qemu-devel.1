Received: from eggs.gnu.org ([2001:4830:134:3::10]:33458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ut-0001W7-22
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Up-0000JG-Qz
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Up-0000HR-CA
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:43 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:04 +0100
Message-Id: <1489582656-31133-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 15/47] qapi: Conjure up
 QAPIDoc.ArgSection for undocumented members
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

qapi2texi.py already conjures up ArgSections for undocumented
enumeration values, in texi_enum.  Drop that, and conjure them up for
all kinds of "arguments" (enumeration values, object and alternate
type members) in qapi.py instead.

Take care to keep generated documentation exactly the same for now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py      |  5 ++---
 scripts/qapi2texi.py | 31 ++++++++++++++++---------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index c1e0bed..f4c8eac 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -224,9 +224,8 @@ class QAPIDoc(object):
     def connect_member(self, member):
         if member.name not in self.args:
             # Undocumented TODO outlaw
-            pass
-        else:
-            self.args[member.name].connect(member)
+            self.args[member.name] = QAPIDoc.ArgSection(member.name)
+        self.args[member.name].connect(member)
 
 
 class QAPISchemaParser(object):
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 0aaf45c..299dcf9 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -123,7 +123,7 @@ def texi_format(doc):
     return "\n".join(lines)
 
 
-def texi_body(doc):
+def texi_body(doc, only_documented=False):
     """
     Format the body of a symbol documentation:
     - main body
@@ -131,17 +131,21 @@ def texi_body(doc):
     - followed by "Returns/Notes/Since/Example" sections
     """
     body = texi_format(str(doc.body)) + "\n"
-    if doc.args:
+
+    args = ''
+    for name, section in doc.args.iteritems():
+        if not section.content and not only_documented:
+            continue        # Undocumented TODO require doc and drop
+        desc = str(section)
+        opt = ''
+        if section.optional:
+            desc = re.sub(r'^ *#optional *\n?|\n? *#optional *$|#optional',
+                          '', desc)
+            opt = ' (optional)'
+        args += "@item @code{'%s'}%s\n%s\n" % (name, opt, texi_format(desc))
+    if args:
         body += "@table @asis\n"
-        for arg, section in doc.args.iteritems():
-            desc = str(section)
-            opt = ''
-            if section.optional:
-                desc = re.sub(r'^ *#optional *\n?|\n? *#optional *$|#optional',
-                              '', desc)
-                opt = ' (optional)'
-            body += "@item @code{'%s'}%s\n%s\n" % (arg, opt,
-                                                   texi_format(desc))
+        body += args
         body += "@end table\n"
 
     for section in doc.sections:
@@ -183,10 +187,7 @@ def texi_union(expr, doc):
 
 def texi_enum(expr, doc):
     """Format an enum to texi"""
-    for i in expr['data']:
-        if i not in doc.args:
-            doc.args[i] = qapi.QAPIDoc.ArgSection(i)
-    body = texi_body(doc)
+    body = texi_body(doc, True)
     return TYPE_FMT(type="Enum",
                     name=doc.symbol,
                     body=body)
-- 
2.7.4
