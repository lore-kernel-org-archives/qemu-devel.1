Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Us-0001Vv-Qe
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uq-0000KZ-GJ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Uq-0000Ip-63
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:44 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:12 +0100
Message-Id: <1489582656-31133-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 23/47] qapi2texi: Don't hide
 undocumented members and arguments
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

Show undocumented object, alternate type members and command, event
arguments exactly like undocumented enumeration type values.

Example change (qemu-qmp-ref.txt):

  -- Command: query-rocker

      Return rocker switch information.

+     Arguments:
+     'name'
+          Not documented
+
      Returns: 'Rocker' information

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi2texi.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 1f01817..df87441 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -139,12 +139,10 @@ def texi_member(member):
         member.name, ' (optional)' if member.optional else '')
 
 
-def texi_members(doc, what, member_func, show_undocumented):
+def texi_members(doc, what, member_func):
     """Format the table of members"""
     items = ''
     for section in doc.args.itervalues():
-        if not section.content and not show_undocumented:
-            continue          # Undocumented TODO require doc and drop
         if section.content:
             desc = str(section)
         else:
@@ -172,10 +170,9 @@ def texi_sections(doc):
     return body
 
 
-def texi_entity(doc, what, member_func=texi_member,
-                show_undocumented=False):
+def texi_entity(doc, what, member_func=texi_member):
     return (texi_body(doc)
-            + texi_members(doc, what, member_func, show_undocumented)
+            + texi_members(doc, what, member_func)
             + texi_sections(doc))
 
 
@@ -194,8 +191,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
         self.out += TYPE_FMT(type='Enum',
                              name=doc.symbol,
                              body=texi_entity(doc, 'Values',
-                                              member_func=texi_enum_value,
-                                              show_undocumented=True))
+                                              member_func=texi_enum_value))
 
     def visit_object_type(self, name, info, base, members, variants):
         doc = self.cur_doc
-- 
2.7.4
