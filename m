Received: from eggs.gnu.org ([2001:4830:134:3::10]:56699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO38-0000pg-8w
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO35-0000It-Nt
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWO35-0000IN-Ic
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DB8D68801
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-237.ams2.redhat.com
	[10.36.117.237])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 095462027EA0
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 22 Jun 2018 17:32:27 +0200
Message-Id: <20180622153228.23594-10-armbru@redhat.com>
In-Reply-To: <20180622153228.23594-1-armbru@redhat.com>
References: <20180622153228.23594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/10] qapi/introspect: Eliminate pointless
 variable in .visit_end()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 1a9a507b2e3 "qapi-introspect: Hide type names" added local
variable @jsons to improve sorting, but also removed the sorting.  It
was part of a big series that went to v8, and it made sense until v2
or so...

Commit 7d0f982bfbb replaced @jsons by @qlits, preserving the
uselessness.

Get rid of it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180620124742.16979-1-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 5b6c72c7b2..6ad198ae5b 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -75,13 +75,10 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonoli=
thicCVisitor):
=20
     def visit_end(self):
         # visit the types that are actually used
-        qlits =3D self._qlits
-        self._qlits =3D []
         for typ in self._used_types:
             typ.visit(self)
         # generate C
         # TODO can generate awfully long lines
-        qlits.extend(self._qlits)
         name =3D c_name(self._prefix, protect=3DFalse) + 'qmp_schema_qli=
t'
         self._genh.add(mcgen('''
 #include "qapi/qmp/qlit.h"
@@ -93,7 +90,7 @@ extern const QLitObject %(c_name)s;
 const QLitObject %(c_name)s =3D %(c_string)s;
 ''',
                              c_name=3Dc_name(name),
-                             c_string=3Dto_qlit(qlits)))
+                             c_string=3Dto_qlit(self._qlits)))
         self._schema =3D None
         self._qlits =3D []
         self._used_types =3D []
--=20
2.17.1
