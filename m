Received: from eggs.gnu.org ([208.118.235.92]:59855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdNm-0004cN-PK
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdMi-0006NP-LE
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdMh-0006LD-TQ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:27 +0100
Message-Id: <20180202130336.24719-13-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 12/21] qapi: Concentrate
 QAPISchemaParser.exprs updates in .__init__()
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
 scripts/qapi/common.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d334e1db5a..7a327bfe9f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -286,8 +286,12 @@ class QAPISchemaParser(object):
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a string")
-                self._include(include, info, os.path.dirname(self.fname),
-                              previously_included)
+                exprs_include = self._include(include, info,
+                                              os.path.dirname(self.fname),
+                                              previously_included)
+                if exprs_include:
+                    self.exprs.extend(exprs_include.exprs)
+                    self.docs.extend(exprs_include.docs)
             elif "pragma" in expr:
                 self.reject_expr_doc(cur_doc)
                 if len(expr) != 1:
@@ -330,14 +334,13 @@ class QAPISchemaParser(object):
 
         # skip multiple include of the same file
         if incl_abs_fname in previously_included:
-            return
+            return None
+
         try:
             fobj = open(incl_fname, 'r')
         except IOError as e:
             raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname))
-        exprs_include = QAPISchemaParser(fobj, previously_included, info)
-        self.exprs.extend(exprs_include.exprs)
-        self.docs.extend(exprs_include.docs)
+        return QAPISchemaParser(fobj, previously_included, info)
 
     def _pragma(self, name, value, info):
         global doc_required, returns_whitelist, name_case_whitelist
-- 
2.13.6
