Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RN-0000jI-DZ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RK-0005uy-Au
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1el8RK-0005to-2j
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 12 Feb 2018 08:21:56 +0100
Message-Id: <20180212072207.9367-4-armbru@redhat.com>
In-Reply-To: <20180212072207.9367-1-armbru@redhat.com>
References: <20180212072207.9367-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 03/14] qapi/introspect: Simplify WIP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

---
 scripts/qapi/introspect.py | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f66c397fb0..6c86673a09 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -51,36 +51,32 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
         self._jsons = []
         self._used_types = []
         self._name_map = {}
+        var = c_name(self._prefix, protect=False) + 'qmp_schema_json'
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
 
+const char %(var)s[] = ''',
+                             var=var, prefix=prefix))
+        self._genh.add(mcgen('''
+extern const char %(var)s[];
 ''',
-                             prefix=prefix))
+                             var=var))
 
     def visit_begin(self, schema):
         self._schema = schema
 
     def visit_end(self):
         # visit the types that are actually used
-        jsons = self._jsons
-        self._jsons = []
         for typ in self._used_types:
             typ.visit(self)
         # generate C
         # TODO can generate awfully long lines
-        jsons.extend(self._jsons)
-        name = c_name(self._prefix, protect=False) + 'qmp_schema_json'
-        self._genh.add(mcgen('''
-extern const char %(c_name)s[];
-''',
-                             c_name=c_name(name)))
-        lines = to_json(jsons).split('\n')
+        lines = to_json(self._jsons).split('\n')
         c_string = '\n    '.join([to_c_string(line) for line in lines])
         self._genc.add(mcgen('''
-const char %(c_name)s[] = %(c_string)s;
+%(c_string)s;
 ''',
-                             c_name=c_name(name),
                              c_string=c_string))
         self._schema = None
         self._jsons = []
-- 
2.13.6
