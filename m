Received: from eggs.gnu.org ([2001:4830:134:3::10]:52362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJp-0007Zp-Tc
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0003cd-So
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJl-0003Zz-Cm
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:21 +0100
Message-Id: <1489385927-6735-22-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 21/47] qapi2texi: Present the table of
 members more clearly
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

The table of members follows the main descriptive text immediately.
Makes it hard to see what it is about.  Start a new paragraph, and
lead with a line "Members:" for object and alternate types, "Values:"
for enumeration types, and "Arguments:" for commands and events.

Example change (qemu-qmp-ref.txt):

  -- Command: set_link

      Sets the link status of a virtual network adapter.
+
+     Arguments:
      'name'
           the device name of the virtual network adapter
      'up'
           true to set the link status to be up

      Returns: Nothing on success If 'name' is not a valid network
      device, DeviceNotFound

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index ecfaeda..35e182d 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -139,7 +139,7 @@ def texi_member(member):
         member.name, ' (optional)' if member.optional else '')
 
 
-def texi_members(doc, member_func, show_undocumented):
+def texi_members(doc, what, member_func, show_undocumented):
     """Format the table of members"""
     items = ''
     for section in doc.args.itervalues():
@@ -149,7 +149,7 @@ def texi_members(doc, member_func, show_undocumented):
         items += member_func(section.member) + texi_format(desc) + '\n'
     if not items:
         return ''
-    return '@table @asis\n' + items + '@end table\n'
+    return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
 
 
 def texi_sections(doc):
@@ -169,9 +169,10 @@ def texi_sections(doc):
     return body
 
 
-def texi_entity(doc, member_func=texi_member, show_undocumented=False):
+def texi_entity(doc, what, member_func=texi_member,
+                show_undocumented=False):
     return (texi_body(doc)
-            + texi_members(doc, member_func, show_undocumented)
+            + texi_members(doc, what, member_func, show_undocumented)
             + texi_sections(doc))
 
 
@@ -189,7 +190,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
             self.out += '\n'
         self.out += TYPE_FMT(type='Enum',
                              name=doc.symbol,
-                             body=texi_entity(doc,
+                             body=texi_entity(doc, 'Values',
                                               member_func=texi_enum_value,
                                               show_undocumented=True))
 
@@ -205,7 +206,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
             self.out += '\n'
         self.out += TYPE_FMT(type=typ,
                              name=doc.symbol,
-                             body=texi_entity(doc))
+                             body=texi_entity(doc, 'Members'))
 
     def visit_alternate_type(self, name, info, variants):
         doc = self.cur_doc
@@ -213,7 +214,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
             self.out += '\n'
         self.out += TYPE_FMT(type='Alternate',
                              name=doc.symbol,
-                             body=texi_entity(doc))
+                             body=texi_entity(doc, 'Members'))
 
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
@@ -222,7 +223,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
             self.out += '\n'
         self.out += MSG_FMT(type='Command',
                             name=doc.symbol,
-                            body=texi_entity(doc))
+                            body=texi_entity(doc, 'Arguments'))
 
     def visit_event(self, name, info, arg_type, boxed):
         doc = self.cur_doc
@@ -230,7 +231,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
             self.out += '\n'
         self.out += MSG_FMT(type='Event',
                             name=doc.symbol,
-                            body=texi_entity(doc))
+                            body=texi_entity(doc, 'Arguments'))
 
     def symbol(self, doc, entity):
         self.cur_doc = doc
-- 
2.7.4
