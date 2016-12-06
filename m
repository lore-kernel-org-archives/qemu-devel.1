Received: from eggs.gnu.org ([2001:4830:134:3::10]:44490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cEGVd-0003vN-Kx
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cEGVc-00064I-C9
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cEGVc-000646-40
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:16 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BE00E9A51
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 14:14:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  6 Dec 2016 17:13:33 +0300
Message-Id: <20161206141343.28044-8-marcandre.lureau@redhat.com>
In-Reply-To: <20161206141343.28044-1-marcandre.lureau@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 07/17] qapi: use a QAPIParseError in parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                          | 13 +++++++------
 tests/qapi-schema/include-cycle.err      |  2 +-
 tests/qapi-schema/include-format-err.err |  2 +-
 tests/qapi-schema/include-no-file.err    |  2 +-
 tests/qapi-schema/include-non-file.err   |  2 +-
 tests/qapi-schema/include-self-cycle.err |  2 +-
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 5885c9e4ad..5423b64b23 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -148,19 +148,19 @@ class QAPISchemaParser(object):
             expr =3D self.get_expr(False)
             if isinstance(expr, dict) and "include" in expr:
                 if len(expr) !=3D 1:
-                    raise QAPISemError(info, "Invalid 'include' directiv=
e")
+                    raise QAPIParseError(self, "Invalid 'include' direct=
ive")
                 include =3D expr["include"]
                 if not isinstance(include, str):
-                    raise QAPISemError(info,
-                                       "Value of 'include' must be a str=
ing")
+                    raise QAPIParseError(self,
+                                         "Value of 'include' must be a s=
tring")
                 incl_abs_fname =3D os.path.join(os.path.dirname(abs_fnam=
e),
                                               include)
                 # catch inclusion cycle
                 inf =3D info
                 while inf:
                     if incl_abs_fname =3D=3D os.path.abspath(inf['file']=
):
-                        raise QAPISemError(info, "Inclusion loop for %s"
-                                           % include)
+                        raise QAPIParseError(self, "Inclusion loop for %=
s"
+                                             % include)
                     inf =3D inf['parent']
                 # skip multiple include of the same file
                 if incl_abs_fname in previously_included:
@@ -168,7 +168,8 @@ class QAPISchemaParser(object):
                 try:
                     fobj =3D open(incl_abs_fname, 'r')
                 except IOError as e:
-                    raise QAPISemError(info, '%s: %s' % (e.strerror, inc=
lude))
+                    raise QAPIParseError(self, '%s: %s' %
+                                         (e.strerror, include))
                 exprs_include =3D QAPISchemaParser(fobj, previously_incl=
uded,
                                                  info)
                 self.exprs.extend(exprs_include.exprs)
diff --git a/tests/qapi-schema/include-cycle.err b/tests/qapi-schema/incl=
ude-cycle.err
index bdcd07dce2..f96edd2eff 100644
--- a/tests/qapi-schema/include-cycle.err
+++ b/tests/qapi-schema/include-cycle.err
@@ -1,3 +1,3 @@
 In file included from tests/qapi-schema/include-cycle.json:1:
 In file included from tests/qapi-schema/include-cycle-b.json:1:
-tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cyc=
le.json
+tests/qapi-schema/include-cycle-c.json:1:36: Inclusion loop for include-=
cycle.json
diff --git a/tests/qapi-schema/include-format-err.err b/tests/qapi-schema=
/include-format-err.err
index 721ff4eccc..ac79ee4769 100644
--- a/tests/qapi-schema/include-format-err.err
+++ b/tests/qapi-schema/include-format-err.err
@@ -1 +1 @@
-tests/qapi-schema/include-format-err.json:1: Invalid 'include' directive
+tests/qapi-schema/include-format-err.json:2:17: Invalid 'include' direct=
ive
diff --git a/tests/qapi-schema/include-no-file.err b/tests/qapi-schema/in=
clude-no-file.err
index d5b9b22d85..de321ac477 100644
--- a/tests/qapi-schema/include-no-file.err
+++ b/tests/qapi-schema/include-no-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-no-file.json:1: No such file or directory: inc=
lude-no-file-sub.json
+tests/qapi-schema/include-no-file.json:1:42: No such file or directory: =
include-no-file-sub.json
diff --git a/tests/qapi-schema/include-non-file.err b/tests/qapi-schema/i=
nclude-non-file.err
index faae1eacf1..345f6803eb 100644
--- a/tests/qapi-schema/include-non-file.err
+++ b/tests/qapi-schema/include-non-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-non-file.json:1: Value of 'include' must be a =
string
+tests/qapi-schema/include-non-file.json:1:18: Value of 'include' must be=
 a string
diff --git a/tests/qapi-schema/include-self-cycle.err b/tests/qapi-schema=
/include-self-cycle.err
index 981742ae5f..abfc3ed6f3 100644
--- a/tests/qapi-schema/include-self-cycle.err
+++ b/tests/qapi-schema/include-self-cycle.err
@@ -1 +1 @@
-tests/qapi-schema/include-self-cycle.json:1: Inclusion loop for include-=
self-cycle.json
+tests/qapi-schema/include-self-cycle.json:1:41: Inclusion loop for inclu=
de-self-cycle.json
--=20
2.11.0
