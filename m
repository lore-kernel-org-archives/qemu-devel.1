Received: from eggs.gnu.org ([209.51.188.92]:60013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYu-0001yA-S7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYm-0005Rc-EU
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvjYk-0005OU-7A
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2162C0BF2BD
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 867F7600C8
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 15:05:53 +0100
Message-Id: <20190218140607.31998-5-armbru@redhat.com>
In-Reply-To: <20190218140607.31998-1-armbru@redhat.com>
References: <20190218140607.31998-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/18] qapi: Prepare for system modules other
 than 'builtin'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The next commit wants to generate qapi-emit-events.{c.h}.  To enable
that, extend QAPISchemaModularCVisitor to support additional "system
modules", i.e. modules that don't correspond to a (user-defined) QAPI
schema module.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190214152251.2073-5-armbru@redhat.com>
---
 scripts/qapi/common.py | 35 +++++++++++++++++++++++++----------
 scripts/qapi/types.py  |  2 +-
 scripts/qapi/visit.py  |  2 +-
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 0e3ec598a4..c327ae5036 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2327,27 +2327,42 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor=
):
         self._module =3D {}
         self._main_module =3D None
=20
+    @staticmethod
+    def _is_user_module(name):
+        return name and not name.startswith('./')
+
     @staticmethod
     def _is_builtin_module(name):
         return not name
=20
     def _module_basename(self, what, name):
-        if name is None:
-            return re.sub(r'-', '-builtin-', what)
-        basename =3D os.path.join(os.path.dirname(name),
-                                self._prefix + what)
-        if name =3D=3D self._main_module:
-            return basename
-        return basename + '-' + os.path.splitext(os.path.basename(name))=
[0]
+        ret =3D '' if self._is_builtin_module(name) else self._prefix
+        if self._is_user_module(name):
+            dirname, basename =3D os.path.split(name)
+            ret +=3D what
+            if name !=3D self._main_module:
+                ret +=3D '-' + os.path.splitext(basename)[0]
+            ret =3D os.path.join(dirname, ret)
+        else:
+            name =3D name[2:] if name else 'builtin'
+            ret +=3D re.sub(r'-', '-' + name + '-', what)
+        return ret
=20
     def _add_module(self, name, blurb):
-        if self._main_module is None and not self._is_builtin_module(nam=
e):
-            self._main_module =3D name
         genc =3D QAPIGenC(blurb, self._pydoc)
         genh =3D QAPIGenH(blurb, self._pydoc)
         self._module[name] =3D (genc, genh)
         self._set_module(name)
=20
+    def _add_user_module(self, name, blurb):
+        assert self._is_user_module(name)
+        if self._main_module is None:
+            self._main_module =3D name
+        self._add_module(name, blurb)
+
+    def _add_system_module(self, name, blurb):
+        self._add_module(name and './' + name, blurb)
+
     def _set_module(self, name):
         self._genc, self._genh =3D self._module[name]
=20
@@ -2372,7 +2387,7 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
             self._genc =3D None
             self._genh =3D None
         else:
-            self._add_module(name, self._blurb)
+            self._add_user_module(name, self._blurb)
             self._begin_user_module(name)
=20
     def visit_include(self, name, info):
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 9fa510f7df..2bd6fcd44f 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -183,7 +183,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
         QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-types', ' * Schema-defined QAPI types',
             __doc__)
-        self._add_module(None, ' * Built-in QAPI types')
+        self._add_system_module(None, ' * Built-in QAPI types')
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index ca86009398..826b8066e1 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -284,7 +284,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
         QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-visit', ' * Schema-defined QAPI visitors=
',
             __doc__)
-        self._add_module(None, ' * Built-in QAPI visitors')
+        self._add_system_module(None, ' * Built-in QAPI visitors')
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
--=20
2.17.2
