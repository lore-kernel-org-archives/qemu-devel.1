Received: from eggs.gnu.org ([2001:4830:134:3::10]:56416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic3-00026f-La
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-0008Kx-IT
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ic0-0008Iz-8Y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45E7561E78
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6B97EDBB
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:24:00 +0200
Message-Id: <1493911445-19568-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/28] qobject-input-visitor: Catch misuse of
 end_struct vs. end_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493282486-28338-5-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[More elaborate assertions for clarity]
---
 qapi/qobject-input-visitor.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 2530959..d0f0002 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -291,6 +291,15 @@ static void qobject_input_start_struct(Visitor *v, c=
onst char *name, void **obj,
     }
 }
=20
+static void qobject_input_end_struct(Visitor *v, void **obj)
+{
+    QObjectInputVisitor *qiv =3D to_qiv(v);
+    StackObject *tos =3D QSLIST_FIRST(&qiv->stack);
+
+    assert(qobject_type(tos->obj) =3D=3D QTYPE_QDICT && tos->h);
+    qobject_input_pop(v, obj);
+}
+
=20
 static void qobject_input_start_list(Visitor *v, const char *name,
                                      GenericList **list, size_t size,
@@ -346,6 +355,14 @@ static void qobject_input_check_list(Visitor *v, Err=
or **errp)
     }
 }
=20
+static void qobject_input_end_list(Visitor *v, void **obj)
+{
+    QObjectInputVisitor *qiv =3D to_qiv(v);
+    StackObject *tos =3D QSLIST_FIRST(&qiv->stack);
+
+    assert(qobject_type(tos->obj) =3D=3D QTYPE_QLIST && !tos->h);
+    qobject_input_pop(v, obj);
+}
=20
 static void qobject_input_start_alternate(Visitor *v, const char *name,
                                           GenericAlternate **obj, size_t=
 size,
@@ -645,11 +662,11 @@ static QObjectInputVisitor *qobject_input_visitor_b=
ase_new(QObject *obj)
     v->visitor.type =3D VISITOR_INPUT;
     v->visitor.start_struct =3D qobject_input_start_struct;
     v->visitor.check_struct =3D qobject_input_check_struct;
-    v->visitor.end_struct =3D qobject_input_pop;
+    v->visitor.end_struct =3D qobject_input_end_struct;
     v->visitor.start_list =3D qobject_input_start_list;
     v->visitor.next_list =3D qobject_input_next_list;
     v->visitor.check_list =3D qobject_input_check_list;
-    v->visitor.end_list =3D qobject_input_pop;
+    v->visitor.end_list =3D qobject_input_end_list;
     v->visitor.start_alternate =3D qobject_input_start_alternate;
     v->visitor.optional =3D qobject_input_optional;
     v->visitor.free =3D qobject_input_free;
--=20
2.7.4
