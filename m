Received: from eggs.gnu.org ([2001:4830:134:3::10]:54809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtU-00067s-KQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-000765-KS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtQ-00072Y-AB
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DA1F64478
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 18D5A1837E
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:43 +0100
Message-Id: <1489645685-4750-28-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for 2.9 27/49] qapi2texi: Include member type in
 generated documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The recent merge of docs/qmp-commands.txt and docs/qmp-events.txt into
the schema lost type information.  Fix this documentation regression.

Example change (qemu-qmp-ref.txt):

  -- Struct: InputKeyEvent

      Keyboard input event.

      Members:
-     'button'
+     'button: InputButton'
           Which button this event is for.
-     'down'
+     'down: boolean'
           True for key-down and false for key-up events.

      Since: 2.0

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-26-git-send-email-armbru@redhat.com>
---
 scripts/qapi.py      | 14 ++++++++++++++
 scripts/qapi2texi.py |  8 ++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8b7377e..21a1591 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1105,6 +1105,11 @@ class QAPISchemaType(QAPISchemaEntity):
         }
         return json2qtype.get(self.json_type())
=20
+    def doc_type(self):
+        if self.is_implicit():
+            return None
+        return self.name
+
=20
 class QAPISchemaBuiltinType(QAPISchemaType):
     def __init__(self, name, json_type, c_type):
@@ -1129,6 +1134,9 @@ class QAPISchemaBuiltinType(QAPISchemaType):
     def json_type(self):
         return self._json_type_name
=20
+    def doc_type(self):
+        return self.json_type()
+
     def visit(self, visitor):
         visitor.visit_builtin_type(self.name, self.info, self.json_type(=
))
=20
@@ -1188,6 +1196,12 @@ class QAPISchemaArrayType(QAPISchemaType):
     def json_type(self):
         return 'array'
=20
+    def doc_type(self):
+        elt_doc_type =3D self.element_type.doc_type()
+        if not elt_doc_type:
+            return None
+        return 'array of ' + elt_doc_type
+
     def visit(self, visitor):
         visitor.visit_array_type(self.name, self.info, self.element_type=
)
=20
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 3dd0146..993b652 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -135,8 +135,12 @@ def texi_enum_value(value):
=20
 def texi_member(member):
     """Format a table of members item for an object type member"""
-    return '@item @code{%s}%s\n' % (
-        member.name, ' (optional)' if member.optional else '')
+    typ =3D member.type.doc_type()
+    return '@item @code{%s%s%s}%s\n' % (
+        member.name,
+        ': ' if typ else '',
+        typ if typ else '',
+        ' (optional)' if member.optional else '')
=20
=20
 def texi_members(doc, what, member_func):
--=20
2.7.4
