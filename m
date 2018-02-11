Received: from eggs.gnu.org ([2001:4830:134:3::10]:54200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3i-00077x-Ne
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3d-0006Qw-E3
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3c-0006Pj-SZ
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:25 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:51 +0100
Message-Id: <20180211093607.27351-14-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/29] qapi: Lift error reporting from
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-gen.py            |  8 ++++++--
 scripts/qapi/common.py         | 23 +++++++++--------------
 tests/qapi-schema/test-qapi.py | 10 ++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index e5be484e3e..fea7d4589b 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -8,7 +8,7 @@ from __future__ import print_function
 import argparse
 import re
 import sys
-from qapi.common import QAPISchema
+from qapi.common import QAPIError, QAPISchema
 from qapi.types import gen_types
 from qapi.visit import gen_visit
 from qapi.commands import gen_commands
@@ -39,7 +39,11 @@ def main(argv):
               file=3Dsys.stderr)
         sys.exit(1)
=20
-    schema =3D QAPISchema(args.schema)
+    try:
+        schema =3D QAPISchema(args.schema)
+    except QAPIError as err:
+        print(err, file=3Dsys.stderr)
+        exit(1)
=20
     gen_types(schema, args.output_dir, args.prefix, args.builtins)
     gen_visit(schema, args.output_dir, args.prefix, args.builtins)
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d72c339ad5..dce289ae21 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -16,7 +16,6 @@ import errno
 import os
 import re
 import string
-import sys
 try:
     from collections import OrderedDict
 except:
@@ -1459,19 +1458,15 @@ class QAPISchemaEvent(QAPISchemaEntity):
=20
 class QAPISchema(object):
     def __init__(self, fname):
-        try:
-            parser =3D QAPISchemaParser(open(fname, 'r'))
-            exprs =3D check_exprs(parser.exprs)
-            self.docs =3D parser.docs
-            self._entity_dict =3D {}
-            self._predefining =3D True
-            self._def_predefineds()
-            self._predefining =3D False
-            self._def_exprs(exprs)
-            self.check()
-        except QAPIError as err:
-            print(err, file=3Dsys.stderr)
-            exit(1)
+        parser =3D QAPISchemaParser(open(fname, 'r'))
+        exprs =3D check_exprs(parser.exprs)
+        self.docs =3D parser.docs
+        self._entity_dict =3D {}
+        self._predefining =3D True
+        self._def_predefineds()
+        self._predefining =3D False
+        self._def_exprs(exprs)
+        self.check()
=20
     def _def_entity(self, ent):
         # Only the predefined types are allowed to not have info
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index bb1b6dd297..4da14b43af 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -12,7 +12,7 @@
=20
 from __future__ import print_function
 import sys
-from qapi.common import QAPISchema, QAPISchemaVisitor
+from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor
=20
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
@@ -52,7 +52,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             for v in variants.variants:
                 print('    case %s: %s' % (v.name, v.type.name))
=20
-schema =3D QAPISchema(sys.argv[1])
+
+try:
+    schema =3D QAPISchema(sys.argv[1])
+except QAPIError as err:
+    print(err, file=3Dsys.stderr)
+    exit(1)
+
 schema.visit(QAPISchemaTestVisitor())
=20
 for doc in schema.docs:
--=20
2.13.6
