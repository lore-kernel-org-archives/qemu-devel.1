Received: from eggs.gnu.org ([2001:4830:134:3::10]:38425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGJ-0000gu-GT
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGG-0003ZN-HN
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGG-0003Y4-6h
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BA1CC04B92E
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:46:51 +0200
Message-Id: <1497016045-6009-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/41] qapi: Remove visit_start_alternate()
 parameter promote_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Before the previous commit, parameter promote_int =3D true made
visit_start_alternate() with an input visitor avoid QTYPE_QINT
variants and create QTYPE_QFLOAT variants instead.  This was used
where QTYPE_QINT variants were invalid.

The previous commit fused QTYPE_QINT with QTYPE_QFLOAT, rendering
promote_int useless and unused.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170607163635.17635-8-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/visitor-impl.h        |  2 +-
 include/qapi/visitor.h             |  4 +---
 qapi/qapi-clone-visitor.c          |  2 +-
 qapi/qapi-dealloc-visitor.c        |  2 +-
 qapi/qapi-visit-core.c             |  6 +++---
 qapi/qobject-input-visitor.c       |  2 +-
 qapi/trace-events                  |  2 +-
 scripts/qapi-visit.py              | 12 +++---------
 tests/test-qobject-input-visitor.c |  2 +-
 9 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index e87709d..dcd656a 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -71,7 +71,7 @@ struct Visitor
      * optional for output visitors. */
     void (*start_alternate)(Visitor *v, const char *name,
                             GenericAlternate **obj, size_t size,
-                            bool promote_int, Error **errp);
+                            Error **errp);
=20
     /* Optional, needed for dealloc visitor */
     void (*end_alternate)(Visitor *v, void **obj);
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 4721c39..74768aa 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -410,15 +410,13 @@ void visit_end_list(Visitor *v, void **list);
  * the qtype of the next thing to be visited, stored in (*@obj)->type.
  * Other visitors will leave @obj unchanged.
  *
- * If @promote_int, treat integers as QTYPE_FLOAT.
- *
  * If successful, this must be paired with visit_end_alternate() with
  * the same @obj to clean up, even if visiting the contents of the
  * alternate fails.
  */
 void visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
-                           bool promote_int, Error **errp);
+                           Error **errp);
=20
 /*
  * Finish visiting an alternate type.
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index de756bf..ed16d3a 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -70,7 +70,7 @@ static GenericList *qapi_clone_next_list(Visitor *v, Ge=
nericList *tail,
=20
 static void qapi_clone_start_alternate(Visitor *v, const char *name,
                                        GenericAlternate **obj, size_t si=
ze,
-                                       bool promote_int, Error **errp)
+                                       Error **errp)
 {
     qapi_clone_start_struct(v, name, (void **)obj, size, errp);
 }
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index e39457b..fd6f9fb 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -38,7 +38,7 @@ static void qapi_dealloc_end_struct(Visitor *v, void **=
obj)
=20
 static void qapi_dealloc_start_alternate(Visitor *v, const char *name,
                                          GenericAlternate **obj, size_t =
size,
-                                         bool promote_int, Error **errp)
+                                         Error **errp)
 {
 }
=20
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 43a09d1..935a2c5 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -106,15 +106,15 @@ void visit_end_list(Visitor *v, void **obj)
=20
 void visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
-                           bool promote_int, Error **errp)
+                           Error **errp)
 {
     Error *err =3D NULL;
=20
     assert(obj && size >=3D sizeof(GenericAlternate));
     assert(!(v->type & VISITOR_OUTPUT) || *obj);
-    trace_visit_start_alternate(v, name, obj, size, promote_int);
+    trace_visit_start_alternate(v, name, obj, size);
     if (v->start_alternate) {
-        v->start_alternate(v, name, obj, size, promote_int, &err);
+        v->start_alternate(v, name, obj, size, &err);
     }
     if (v->type & VISITOR_INPUT) {
         assert(v->start_alternate && !err !=3D !*obj);
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index b24f99d..539b3b8 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -367,7 +367,7 @@ static void qobject_input_end_list(Visitor *v, void *=
*obj)
=20
 static void qobject_input_start_alternate(Visitor *v, const char *name,
                                           GenericAlternate **obj, size_t=
 size,
-                                          bool promote_int, Error **errp=
)
+                                          Error **errp)
 {
     QObjectInputVisitor *qiv =3D to_qiv(v);
     QObject *qobj =3D qobject_input_get_object(qiv, name, false, errp);
diff --git a/qapi/trace-events b/qapi/trace-events
index 339cacf..3b57aba 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -11,7 +11,7 @@ visit_next_list(void *v, void *tail, size_t size) "v=3D=
%p tail=3D%p size=3D%zu"
 visit_check_list(void *v) "v=3D%p"
 visit_end_list(void *v, void *obj) "v=3D%p obj=3D%p"
=20
-visit_start_alternate(void *v, const char *name, void *obj, size_t size,=
 bool promote_int) "v=3D%p name=3D%s obj=3D%p size=3D%zu promote_int=3D%d=
"
+visit_start_alternate(void *v, const char *name, void *obj, size_t size)=
 "v=3D%p name=3D%s obj=3D%p size=3D%zu"
 visit_end_alternate(void *v, void *obj) "v=3D%p obj=3D%p"
=20
 visit_optional(void *v, const char *name, bool *present) "v=3D%p name=3D=
%s present=3D%p"
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index cc447ec..bd0b742 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -161,20 +161,14 @@ void visit_type_%(c_name)s(Visitor *v, const char *=
name, %(c_name)s *obj, Error
=20
=20
 def gen_visit_alternate(name, variants):
-    promote_int =3D 'true'
-    ret =3D ''
-    for var in variants.variants:
-        if var.type.alternate_qtype() =3D=3D 'QTYPE_QNUM':
-            promote_int =3D 'false'
-
-    ret +=3D mcgen('''
+    ret =3D mcgen('''
=20
 void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **ob=
j, Error **errp)
 {
     Error *err =3D NULL;
=20
     visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**ob=
j),
-                          %(promote_int)s, &err);
+                          &err);
     if (err) {
         goto out;
     }
@@ -183,7 +177,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
     }
     switch ((*obj)->type) {
 ''',
-                 c_name=3Dc_name(name), promote_int=3Dpromote_int)
+                 c_name=3Dc_name(name))
=20
     for var in variants.variants:
         ret +=3D mcgen('''
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 6890ce5..928cc26 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -1105,7 +1105,7 @@ static void test_visitor_in_fail_struct_missing(Tes=
tInputVisitorData *data,
     error_free_or_abort(&err);
     visit_start_list(v, "list", NULL, 0, &err);
     error_free_or_abort(&err);
-    visit_start_alternate(v, "alternate", &alt, sizeof(*alt), false, &er=
r);
+    visit_start_alternate(v, "alternate", &alt, sizeof(*alt), &err);
     error_free_or_abort(&err);
     visit_optional(v, "optional", &present);
     g_assert(!present);
--=20
2.7.5
