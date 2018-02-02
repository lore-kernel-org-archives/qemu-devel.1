Received: from eggs.gnu.org ([208.118.235.92]:57117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdNI-0003Ev-FJ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdMC-0005ZV-La
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdMB-0005Xj-Rg
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:28 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:26 +0100
Message-Id: <20180202130336.24719-12-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 11/21] qapi: Lift error reporting from
 QAPISchema.__init__() to callers
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
 scripts/qapi-gen.py            |  8 ++++++--
 scripts/qapi/common.py         | 23 +++++++++--------------
 tests/qapi-schema/test-qapi.py |  8 +++++++-
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 6302fd0d55..ba82ca92cc 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -7,7 +7,7 @@
 import getopt
 import re
 import sys
-from qapi.common import QAPISchema
+from qapi.common import QAPIError, QAPISchema
 from qapi.types import gen_types
 from qapi.visit import gen_visit
 from qapi.commands import gen_commands
@@ -77,7 +77,11 @@ def main(argv):
         if o in ('-u', '--unmask-non-abi-names'):
             opt_unmask = True
 
-    schema = QAPISchema(input_file)
+    try:
+        schema = QAPISchema(input_file)
+    except QAPIError as err:
+        print >>sys.stderr, err
+        exit(1)
 
     gen_types(schema, output_dir, prefix, opt_builtins)
     gen_visit(schema, output_dir, prefix, opt_builtins)
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 78e960d07c..d334e1db5a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -15,7 +15,6 @@ import errno
 import os
 import re
 import string
-import sys
 from ordereddict import OrderedDict
 
 builtin_types = {
@@ -1455,19 +1454,15 @@ class QAPISchemaEvent(QAPISchemaEntity):
 
 class QAPISchema(object):
     def __init__(self, fname):
-        try:
-            parser = QAPISchemaParser(open(fname, 'r'))
-            exprs = check_exprs(parser.exprs)
-            self.docs = parser.docs
-            self._entity_dict = {}
-            self._predefining = True
-            self._def_predefineds()
-            self._predefining = False
-            self._def_exprs(exprs)
-            self.check()
-        except QAPIError as err:
-            print >>sys.stderr, err
-            exit(1)
+        parser = QAPISchemaParser(open(fname, 'r'))
+        exprs = check_exprs(parser.exprs)
+        self.docs = parser.docs
+        self._entity_dict = {}
+        self._predefining = True
+        self._def_predefineds()
+        self._predefining = False
+        self._def_exprs(exprs)
+        self.check()
 
     def _def_entity(self, ent):
         # Only the predefined types are allowed to not have info
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 7772d09919..d6bb8ec6a4 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -53,7 +53,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             for v in variants.variants:
                 print '    case %s: %s' % (v.name, v.type.name)
 
-schema = QAPISchema(sys.argv[1])
+
+try:
+    schema = QAPISchema(sys.argv[1])
+except QAPIError as err:
+    print >>sys.stderr, err
+    exit(1)
+
 schema.visit(QAPISchemaTestVisitor())
 
 for doc in schema.docs:
-- 
2.13.6
