Received: from eggs.gnu.org ([2001:4830:134:3::10]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtV-000687-Ht
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtR-00078Y-R4
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtR-00076i-Fk
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61E77C04B30E
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E57553CC1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:47 +0100
Message-Id: <1489645685-4750-32-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 31/49] qapi2texi: Use category "Object"
 for all object types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

At the protocol level, the distinction between struct, flat union and
simple union is meaningless, they are all JSON objects.  Document them
that way.

Example change (qemu-qmp-ref.txt):

- -- Simple Union: InputEvent
+ -- Object: InputEvent

      Input event union.

This also fixes the completely broken headings for flat and simple
unions in qemu-qmp-ref.7 and qemu-ga-ref.7, by sidestepping a bug in
texi2pod.pl.  For instance, it mistranslates "@deftp {Simple Union}
InputEvent" to "B<Union> (Simple)", but translates "@deftp Object
InputEvent" to "B<SocketAddress> (Object)".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-30-git-send-email-armbru@redhat.com>
---
 scripts/qapi2texi.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 282adf4..8eed11a 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -219,17 +219,11 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
 
     def visit_object_type(self, name, info, base, members, variants):
         doc = self.cur_doc
-        if not variants:
-            typ = 'Struct'
-        elif variants._tag_name:        # TODO unclean member access
-            typ = 'Flat Union'
-        else:
-            typ = 'Simple Union'
         if base and base.is_implicit():
             base = None
         if self.out:
             self.out += '\n'
-        self.out += TYPE_FMT(type=typ,
+        self.out += TYPE_FMT(type='Object',
                              name=doc.symbol,
                              body=texi_entity(doc, 'Members', base, variants))
 
-- 
2.7.4
