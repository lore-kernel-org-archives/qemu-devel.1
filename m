Received: from eggs.gnu.org ([2001:4830:134:3::10]:52158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0007Wp-AL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJi-0003WT-2u
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJh-0003Vn-QU
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:49 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:01 +0100
Message-Id: <1489385927-6735-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 01/47] qapi: Factor
 QAPISchemaParser._include() out of .__init__()
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
 scripts/qapi.py | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 53a4477..345cde1 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -268,34 +268,15 @@ class QAPISchemaParser(object):
                 continue
 
             expr = self.get_expr(False)
-            if isinstance(expr, dict) and "include" in expr:
+            if 'include' in expr:
                 if len(expr) != 1:
                     raise QAPISemError(info, "Invalid 'include' directive")
                 include = expr["include"]
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a string")
-                incl_abs_fname = os.path.join(os.path.dirname(abs_fname),
-                                              include)
-                # catch inclusion cycle
-                inf = info
-                while inf:
-                    if incl_abs_fname == os.path.abspath(inf['file']):
-                        raise QAPISemError(info, "Inclusion loop for %s"
-                                           % include)
-                    inf = inf['parent']
-
-                # skip multiple include of the same file
-                if incl_abs_fname in previously_included:
-                    continue
-                try:
-                    fobj = open(incl_abs_fname, 'r')
-                except IOError as e:
-                    raise QAPISemError(info, '%s: %s' % (e.strerror, include))
-                exprs_include = QAPISchemaParser(fobj, previously_included,
-                                                 info)
-                self.exprs.extend(exprs_include.exprs)
-                self.docs.extend(exprs_include.docs)
+                self._include(include, info, os.path.dirname(abs_fname),
+                              previously_included)
             else:
                 expr_elem = {'expr': expr,
                              'info': info}
@@ -307,6 +288,26 @@ class QAPISchemaParser(object):
 
                 self.exprs.append(expr_elem)
 
+    def _include(self, include, info, base_dir, previously_included):
+        incl_abs_fname = os.path.join(base_dir, include)
+        # catch inclusion cycle
+        inf = info
+        while inf:
+            if incl_abs_fname == os.path.abspath(inf['file']):
+                raise QAPISemError(info, "Inclusion loop for %s" % include)
+            inf = inf['parent']
+
+        # skip multiple include of the same file
+        if incl_abs_fname in previously_included:
+            return
+        try:
+            fobj = open(incl_abs_fname, 'r')
+        except IOError as e:
+            raise QAPISemError(info, '%s: %s' % (e.strerror, include))
+        exprs_include = QAPISchemaParser(fobj, previously_included, info)
+        self.exprs.extend(exprs_include.exprs)
+        self.docs.extend(exprs_include.docs)
+
     def accept(self, skip_comment=True):
         while True:
             self.tok = self.src[self.cursor]
-- 
2.7.4
