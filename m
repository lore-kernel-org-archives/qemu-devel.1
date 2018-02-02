Received: from eggs.gnu.org ([208.118.235.92]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdRw-000868-O7
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdQs-0003uG-EI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:40:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdK2-0002uP-Sw
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:32:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:25 +0100
Message-Id: <20180202130336.24719-11-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 10/21] qapi/common: Eliminate
 QAPISchema.exprs
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 6c6962a364..78e960d07c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1457,13 +1457,13 @@ class QAPISchema(object):
     def __init__(self, fname):
         try:
             parser = QAPISchemaParser(open(fname, 'r'))
-            self.exprs = check_exprs(parser.exprs)
+            exprs = check_exprs(parser.exprs)
             self.docs = parser.docs
             self._entity_dict = {}
             self._predefining = True
             self._def_predefineds()
             self._predefining = False
-            self._def_exprs()
+            self._def_exprs(exprs)
             self.check()
         except QAPIError as err:
             print >>sys.stderr, err
@@ -1648,8 +1648,8 @@ class QAPISchema(object):
                 name, info, doc, 'arg', self._make_members(data, info))
         self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
 
-    def _def_exprs(self):
-        for expr_elem in self.exprs:
+    def _def_exprs(self, exprs):
+        for expr_elem in exprs:
             expr = expr_elem['expr']
             info = expr_elem['info']
             doc = expr_elem.get('doc')
-- 
2.13.6
