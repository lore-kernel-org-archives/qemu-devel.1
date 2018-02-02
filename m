Received: from eggs.gnu.org ([208.118.235.92]:55457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdLH-0002Uf-5v
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdKD-00037L-31
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdKC-00035C-57
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:32:24 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:24 +0100
Message-Id: <20180202130336.24719-10-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 09/21] qapi: Don't absolutize include file
 name in error messages
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

Error messages print absolute filenames of included files even gave a
relative one on the command line:

     PYTHONPATH=scripts python -B tests/qapi-schema/test-qapi.py tests/qapi-schema/include-cycle.json
    In file included from tests/qapi-schema/include-cycle.json:1:
    In file included from /work/armbru/qemu/tests/qapi-schema/include-cycle-b.json:1:
    /work/armbru/qemu/tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cycle.json

Improve this to

    In file included from tests/qapi-schema/include-cycle.json:1:
    In file included from tests/qapi-schema/include-cycle-b.json:1:
    tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cycle.json

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                | 12 ++++++------
 tests/qapi-schema/include-no-file.err |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index be0fcc548a..6c6962a364 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -255,9 +255,8 @@ class QAPIDoc(object):
 class QAPISchemaParser(object):
 
     def __init__(self, fp, previously_included=[], incl_info=None):
-        abs_fname = os.path.abspath(fp.name)
         self.fname = fp.name
-        previously_included.append(abs_fname)
+        previously_included.append(os.path.abspath(fp.name))
         self.incl_info = incl_info
         self.src = fp.read()
         if self.src == '' or self.src[-1] != '\n':
@@ -288,7 +287,7 @@ class QAPISchemaParser(object):
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a string")
-                self._include(include, info, os.path.dirname(abs_fname),
+                self._include(include, info, os.path.dirname(self.fname),
                               previously_included)
             elif "pragma" in expr:
                 self.reject_expr_doc(cur_doc)
@@ -321,7 +320,8 @@ class QAPISchemaParser(object):
                 % doc.symbol)
 
     def _include(self, include, info, base_dir, previously_included):
-        incl_abs_fname = os.path.join(base_dir, include)
+        incl_fname = os.path.join(base_dir, include)
+        incl_abs_fname = os.path.abspath(incl_fname)
         # catch inclusion cycle
         inf = info
         while inf:
@@ -333,9 +333,9 @@ class QAPISchemaParser(object):
         if incl_abs_fname in previously_included:
             return
         try:
-            fobj = open(incl_abs_fname, 'r')
+            fobj = open(incl_fname, 'r')
         except IOError as e:
-            raise QAPISemError(info, '%s: %s' % (e.strerror, include))
+            raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname))
         exprs_include = QAPISchemaParser(fobj, previously_included, info)
         self.exprs.extend(exprs_include.exprs)
         self.docs.extend(exprs_include.docs)
diff --git a/tests/qapi-schema/include-no-file.err b/tests/qapi-schema/include-no-file.err
index d5b9b22d85..e42bcf4bc1 100644
--- a/tests/qapi-schema/include-no-file.err
+++ b/tests/qapi-schema/include-no-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-no-file.json:1: No such file or directory: include-no-file-sub.json
+tests/qapi-schema/include-no-file.json:1: No such file or directory: tests/qapi-schema/include-no-file-sub.json
-- 
2.13.6
