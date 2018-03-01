Received: from eggs.gnu.org ([2001:4830:134:3::10]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6p-0000pk-Cs
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6o-0007Xl-Dh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6o-0007WV-5D
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:18 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:26 -0600
Message-Id: <20180301194245.29854-12-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/30] qapi: Improve include file name reporting
 in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Markus Armbruster <armbru@redhat.com>

Error messages print absolute file names of included files even if the
user gave a relative one on the command line:

    $ PYTHONPATH=3Dscripts python -B tests/qapi-schema/test-qapi.py tests=
/qapi-schema/include-cycle.json
    In file included from tests/qapi-schema/include-cycle.json:1:
    In file included from /work/armbru/qemu/tests/qapi-schema/include-cyc=
le-b.json:1:
    /work/armbru/qemu/tests/qapi-schema/include-cycle-c.json:1: Inclusion=
 loop for include-cycle.json

Improve this to

    In file included from tests/qapi-schema/include-cycle.json:1:
    In file included from tests/qapi-schema/include-cycle-b.json:1:
    tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-=
cycle.json

The error message when an include file can't be opened prints the
include directive's file name, which is relative to the including
file.  Change this to print the file name relative to the working
directory.  Visible in tests/qapi-schema/include-no-file.err.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-12-armbru@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py                | 12 ++++++------
 tests/qapi-schema/include-no-file.err |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 47673928dcc..bfa9bfec01d 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -259,9 +259,8 @@ class QAPIDoc(object):
 class QAPISchemaParser(object):

     def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
-        abs_fname =3D os.path.abspath(fp.name)
         self.fname =3D fp.name
-        previously_included.append(abs_fname)
+        previously_included.append(os.path.abspath(fp.name))
         self.incl_info =3D incl_info
         self.src =3D fp.read()
         if self.src =3D=3D '' or self.src[-1] !=3D '\n':
@@ -292,7 +291,7 @@ class QAPISchemaParser(object):
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a str=
ing")
-                self._include(include, info, os.path.dirname(abs_fname),
+                self._include(include, info, os.path.dirname(self.fname)=
,
                               previously_included)
             elif "pragma" in expr:
                 self.reject_expr_doc(cur_doc)
@@ -325,7 +324,8 @@ class QAPISchemaParser(object):
                 % doc.symbol)

     def _include(self, include, info, base_dir, previously_included):
-        incl_abs_fname =3D os.path.join(base_dir, include)
+        incl_fname =3D os.path.join(base_dir, include)
+        incl_abs_fname =3D os.path.abspath(incl_fname)
         # catch inclusion cycle
         inf =3D info
         while inf:
@@ -337,9 +337,9 @@ class QAPISchemaParser(object):
         if incl_abs_fname in previously_included:
             return
         try:
-            fobj =3D open(incl_abs_fname, 'r')
+            fobj =3D open(incl_fname, 'r')
         except IOError as e:
-            raise QAPISemError(info, '%s: %s' % (e.strerror, include))
+            raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname)=
)
         exprs_include =3D QAPISchemaParser(fobj, previously_included, in=
fo)
         self.exprs.extend(exprs_include.exprs)
         self.docs.extend(exprs_include.docs)
diff --git a/tests/qapi-schema/include-no-file.err b/tests/qapi-schema/in=
clude-no-file.err
index d5b9b22d85d..e42bcf4bc1a 100644
--- a/tests/qapi-schema/include-no-file.err
+++ b/tests/qapi-schema/include-no-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-no-file.json:1: No such file or directory: inc=
lude-no-file-sub.json
+tests/qapi-schema/include-no-file.json:1: No such file or directory: tes=
ts/qapi-schema/include-no-file-sub.json
--=20
2.14.3
