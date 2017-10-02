Received: from eggs.gnu.org ([2001:4830:134:3::10]:38675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007xj-ML
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bZ-0007uW-IW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bZ-0007tj-Cc
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:36 +0200
Message-Id: <20171002152552.27999-17-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 16/32] qapi: Factor out
 _make_implicit_wrapper_type()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 248d650858..4871eb7740 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1552,6 +1552,11 @@ class QAPISchema(object):
                                                   members, None))
         return name
 
+    def _make_implicit_wrapper_type(self, typ, info):
+        return self._make_implicit_object_type(
+            typ, info, None, 'wrapper',
+            [self._make_member('data', typ, info)])
+
     def _def_enum_type(self, expr, info, doc):
         name = expr['enum']
         data = expr['data']
@@ -1588,8 +1593,7 @@ class QAPISchema(object):
         if isinstance(typ, list):
             assert len(typ) == 1
             typ = self._make_array_type(typ[0], info)
-        typ = self._make_implicit_object_type(
-            typ, info, None, 'wrapper', [self._make_member('data', typ, info)])
+        typ = self._make_implicit_wrapper_type(typ, info)
         return QAPISchemaObjectTypeVariant(case, typ)
 
     def _def_union_type(self, expr, info, doc):
-- 
2.13.6
