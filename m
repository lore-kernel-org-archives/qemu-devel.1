Received: from eggs.gnu.org ([2001:4830:134:3::10]:54847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtW-00068T-2q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtR-00077W-36
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtQ-00073X-Nf
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B011180467
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E82D19E04
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:45 +0100
Message-Id: <1489645685-4750-30-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 29/49] qapi2texi: Generate documentation
 for variant members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A flat union's branch brings in the members of another type.  Generate
a suitable reference to that type.

Example change (qemu-qmp-ref.txt):

  -- Flat Union: QCryptoBlockOpenOptions

      The options that are available for all encryption formats when
      opening an existing volume

      Members:
      The members of 'QCryptoBlockOptionsBase'
+     The members of 'QCryptoBlockOptionsQCow' when 'format' is "qcow"
+     The members of 'QCryptoBlockOptionsLUKS' when 'format' is "luks"

      Since: 2.6

A simple union's branch adds a member 'data' of some other type.
Generate documentation for that member.

Example change (qemu-qmp-ref.txt):

  -- Simple Union: SocketAddress

      Captures the address of a socket, which could also be a named file
      descriptor

      Members:
      'type'
	   Not documented
+     'data: InetSocketAddress' when 'type' is "inet"
+     'data: UnixSocketAddress' when 'type' is "unix"
+     'data: VsockSocketAddress' when 'type' is "vsock"
+     'data: String' when 'type' is "fd"

      Since: 1.3

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-28-git-send-email-armbru@redhat.com>
---
 scripts/qapi2texi.py | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 7083d0c..ab6b6cd 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -133,17 +133,18 @@ def texi_enum_value(value):
     return '@item @code{%s}\n' % value.name
 
 
-def texi_member(member):
+def texi_member(member, suffix=''):
     """Format a table of members item for an object type member"""
     typ = member.type.doc_type()
-    return '@item @code{%s%s%s}%s\n' % (
+    return '@item @code{%s%s%s}%s%s\n' % (
         member.name,
         ': ' if typ else '',
         typ if typ else '',
-        ' (optional)' if member.optional else '')
+        ' (optional)' if member.optional else '',
+        suffix)
 
 
-def texi_members(doc, what, base, member_func):
+def texi_members(doc, what, base, variants, member_func):
     """Format the table of members"""
     items = ''
     for section in doc.args.itervalues():
@@ -154,6 +155,17 @@ def texi_members(doc, what, base, member_func):
         items += member_func(section.member) + texi_format(desc) + '\n'
     if base:
         items += '@item The members of @code{%s}\n' % base.doc_type()
+    if variants:
+        for v in variants.variants:
+            when = ' when @code{%s} is @t{"%s"}' % (
+                variants.tag_member.name, v.name)
+            if v.type.is_implicit():
+                assert not v.type.base and not v.type.variants
+                for m in v.type.local_members:
+                    items += member_func(m, when)
+            else:
+                items += '@item The members of @code{%s}%s\n' % (
+                    v.type.doc_type(), when)
     if not items:
         return ''
     return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
@@ -176,9 +188,10 @@ def texi_sections(doc):
     return body
 
 
-def texi_entity(doc, what, base=None, member_func=texi_member):
+def texi_entity(doc, what, base=None, variants=None,
+                member_func=texi_member):
     return (texi_body(doc)
-            + texi_members(doc, what, base, member_func)
+            + texi_members(doc, what, base, variants, member_func)
             + texi_sections(doc))
 
 
@@ -213,7 +226,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
             self.out += '\n'
         self.out += TYPE_FMT(type=typ,
                              name=doc.symbol,
-                             body=texi_entity(doc, 'Members', base))
+                             body=texi_entity(doc, 'Members', base, variants))
 
     def visit_alternate_type(self, name, info, variants):
         doc = self.cur_doc
-- 
2.7.4
