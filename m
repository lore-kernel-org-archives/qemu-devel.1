Received: from eggs.gnu.org ([2001:4830:134:3::10]:52253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0007Y3-Dm
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJk-0003Yw-0d
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJj-0003Xq-R4
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:51 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:11 +0100
Message-Id: <1489385927-6735-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 11/47] qapi: Avoid unwanted blank lines
 in QAPIDoc
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

We silently fix missing #optional tags for QAPIDoc by appending a line
"#optional" to the section's .content.  However, this interferes with
.__repr__ stripping trailing blank lines from .content.

Use new ArgSection instance variable .optional instead, and leave
.content alone.

To permit testing .optional in texi_body(), clean up texi_enum()'s
hack to add empty documentation for undocumented enum values: add an
ArgSection instead of ''.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py      | 5 +++--
 scripts/qapi2texi.py | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index eec7bfb..e6d023f 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -107,6 +107,7 @@ class QAPIDoc(object):
             self.name = name
             # the list of lines for this section
             self.content = []
+            self.optional = False
 
         def append(self, line):
             self.content.append(line)
@@ -978,15 +979,15 @@ def check_definition_doc(doc, expr, info):
             desc = doc.args.get(arg)
         if not desc:
             continue
+        desc.optional = opt
         desc_opt = "#optional" in str(desc)
         if desc_opt and not opt:
             raise QAPISemError(info, "Description has #optional, "
                                "but the declaration doesn't")
         if not desc_opt and opt:
-            # silently fix the doc
             # TODO either fix the schema and make this an error,
             # or drop #optional entirely
-            desc.append("#optional")
+            pass
 
     doc_args = set(doc.args.keys())
     args = set([name.strip('*') for name in args])
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 0f3e573..0aaf45c 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -136,7 +136,7 @@ def texi_body(doc):
         for arg, section in doc.args.iteritems():
             desc = str(section)
             opt = ''
-            if "#optional" in desc:
+            if section.optional:
                 desc = re.sub(r'^ *#optional *\n?|\n? *#optional *$|#optional',
                               '', desc)
                 opt = ' (optional)'
@@ -185,7 +185,7 @@ def texi_enum(expr, doc):
     """Format an enum to texi"""
     for i in expr['data']:
         if i not in doc.args:
-            doc.args[i] = ''
+            doc.args[i] = qapi.QAPIDoc.ArgSection(i)
     body = texi_body(doc)
     return TYPE_FMT(type="Enum",
                     name=doc.symbol,
-- 
2.7.4
