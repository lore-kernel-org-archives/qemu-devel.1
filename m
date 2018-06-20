Received: from eggs.gnu.org ([2001:4830:134:3::10]:44465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVcWX-0003jm-PC
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVcWW-0006Hq-TR
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVcWW-0006Hk-Oi
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:44 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Jun 2018 14:47:42 +0200
Message-Id: <20180620124742.16979-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] qapi/introspect: Eliminate pointless variable
 in .visit_end()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Commit 1a9a507b2e3 "qapi-introspect: Hide type names" added local
variable @jsons to improve sorting, but also removed the sorting.  It
was part of a big series that went to v8, and it made sense until v2
or so...

Commit 7d0f982bfbb replaced @jsons by @qlits, preserving the
uselessness.

Get rid of it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 5b6c72c7b2..6ad198ae5b 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -75,13 +75,10 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
 
     def visit_end(self):
         # visit the types that are actually used
-        qlits = self._qlits
-        self._qlits = []
         for typ in self._used_types:
             typ.visit(self)
         # generate C
         # TODO can generate awfully long lines
-        qlits.extend(self._qlits)
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
         self._genh.add(mcgen('''
 #include "qapi/qmp/qlit.h"
@@ -93,7 +90,7 @@ extern const QLitObject %(c_name)s;
 const QLitObject %(c_name)s = %(c_string)s;
 ''',
                              c_name=c_name(name),
-                             c_string=to_qlit(qlits)))
+                             c_string=to_qlit(self._qlits)))
         self._schema = None
         self._qlits = []
         self._used_types = []
-- 
2.17.1
