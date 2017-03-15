Received: from eggs.gnu.org ([2001:4830:134:3::10]:33461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ut-0001WH-7X
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uq-0000KI-CY
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Uq-0000If-4H
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:44 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:15 +0100
Message-Id: <1489582656-31133-27-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 26/47] qapi2texi: Generate reference
 to base type members
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

The generated documentation doesn't mention object type members
inherited from a base type.  Fix that.

Example change (qemu-qmp-ref.txt):

  -- Struct: VncServerInfo

      The network connection information for server

      Members:
      'auth' (optional)
	   authentication method used for the plain (non-websocket) VNC
	   server
+     The members of 'VncBasicInfo'

      Since: 2.1

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi2texi.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 993b652..7083d0c 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -143,7 +143,7 @@ def texi_member(member):
         ' (optional)' if member.optional else '')
 
 
-def texi_members(doc, what, member_func):
+def texi_members(doc, what, base, member_func):
     """Format the table of members"""
     items = ''
     for section in doc.args.itervalues():
@@ -152,6 +152,8 @@ def texi_members(doc, what, member_func):
         else:
             desc = 'Not documented'
         items += member_func(section.member) + texi_format(desc) + '\n'
+    if base:
+        items += '@item The members of @code{%s}\n' % base.doc_type()
     if not items:
         return ''
     return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
@@ -174,9 +176,9 @@ def texi_sections(doc):
     return body
 
 
-def texi_entity(doc, what, member_func=texi_member):
+def texi_entity(doc, what, base=None, member_func=texi_member):
     return (texi_body(doc)
-            + texi_members(doc, what, member_func)
+            + texi_members(doc, what, base, member_func)
             + texi_sections(doc))
 
 
@@ -205,11 +207,13 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
             typ = 'Flat Union'
         else:
             typ = 'Simple Union'
+        if base and base.is_implicit():
+            base = None
         if self.out:
             self.out += '\n'
         self.out += TYPE_FMT(type=typ,
                              name=doc.symbol,
-                             body=texi_entity(doc, 'Members'))
+                             body=texi_entity(doc, 'Members', base))
 
     def visit_alternate_type(self, name, info, variants):
         doc = self.cur_doc
-- 
2.7.4
