Received: from eggs.gnu.org ([2001:4830:134:3::10]:50417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jZh-0003jx-JR
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jZe-0001hI-14
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6jZd-0001gI-Nt
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  5 May 2017 17:11:26 -0300
Message-Id: <20170505201128.12099-2-ehabkost@redhat.com>
In-Reply-To: <20170505201128.12099-1-ehabkost@redhat.com>
References: <20170505201128.12099-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] visitor: Add 'supported_qtypes'
 parameter to visit_start_alternate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This will allow visitors to make decisions based on the supported qtypes
of a given alternate type. The new parameter can replace the old
'promote_int' argument, as qobject-input-visitor can simply check if
QTYPE_QINT is set in supported_qtypes.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Change supported_qtypes to uint32_t (Eric Blake)
* Replace assert() on all generated visitor functions with a
  single QEMU_BUILD_BUG_ON() on visit_start_alternate()
* Extra spaces around "|" on generated visitor code
  (Eric Blake)
* Don't use bitops.h and just use (1U << QTYPE_FOO)
  (Markus Armbruster)
---
 include/qapi/visitor.h       |  5 +++--
 include/qapi/visitor-impl.h  |  2 +-
 scripts/qapi-visit.py        | 12 ++++++------
 qapi/qapi-visit-core.c       |  9 ++++++---
 qapi/qapi-clone-visitor.c    |  3 ++-
 qapi/qapi-dealloc-visitor.c  |  3 ++-
 qapi/qobject-input-visitor.c |  6 ++++--
 qapi/trace-events            |  2 +-
 8 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 1a1b62012b..8f5a223714 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -408,7 +408,8 @@ void visit_end_list(Visitor *v, void **list);
  * the qtype of the next thing to be visited, stored in (*@obj)->type.
  * Other visitors will leave @obj unchanged.
  *
- * If @promote_int, treat integers as QTYPE_FLOAT.
+ * @supported_qtypes is a bit mask indicating which QTypes are supported
+ * by the alternate.
  *
  * If successful, this must be paired with visit_end_alternate() with
  * the same @obj to clean up, even if visiting the contents of the
@@ -416,7 +417,7 @@ void visit_end_list(Visitor *v, void **list);
  */
 void visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
-                           bool promote_int, Error **errp);
+                           uint32_t supported_qtypes, Error **errp);
 
 /*
  * Finish visiting an alternate type.
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index e87709db5c..8afcde0f5d 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -71,7 +71,7 @@ struct Visitor
      * optional for output visitors. */
     void (*start_alternate)(Visitor *v, const char *name,
                             GenericAlternate **obj, size_t size,
-                            bool promote_int, Error **errp);
+                            uint32_t supported_qtypes, Error **errp);
 
     /* Optional, needed for dealloc visitor */
     void (*end_alternate)(Visitor *v, void **obj);
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 5737aefa05..41c54982e2 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -161,20 +161,20 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error
 
 
 def gen_visit_alternate(name, variants):
-    promote_int = 'true'
+    qtypes = ['(1U << %s)' % (var.type.alternate_qtype())
+              for var in variants.variants]
+    supported_qtypes = ' | '.join(qtypes)
     ret = ''
-    for var in variants.variants:
-        if var.type.alternate_qtype() == 'QTYPE_QINT':
-            promote_int = 'false'
 
     ret += mcgen('''
 
 void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
 {
     Error *err = NULL;
+    uint32_t supported_qtypes = %(supported_qtypes)s;
 
     visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**obj),
-                          %(promote_int)s, &err);
+                          supported_qtypes, &err);
     if (err) {
         goto out;
     }
@@ -183,7 +183,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     }
     switch ((*obj)->type) {
 ''',
-                 c_name=c_name(name), promote_int=promote_int)
+                 c_name=c_name(name), supported_qtypes=supported_qtypes)
 
     for var in variants.variants:
         ret += mcgen('''
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 43a09d147d..8d62914393 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -106,15 +106,18 @@ void visit_end_list(Visitor *v, void **obj)
 
 void visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
-                           bool promote_int, Error **errp)
+                           uint32_t supported_qtypes,
+                           Error **errp)
 {
     Error *err = NULL;
 
+    QEMU_BUILD_BUG_ON(QTYPE__MAX > 32);
+
     assert(obj && size >= sizeof(GenericAlternate));
     assert(!(v->type & VISITOR_OUTPUT) || *obj);
-    trace_visit_start_alternate(v, name, obj, size, promote_int);
+    trace_visit_start_alternate(v, name, obj, size, supported_qtypes);
     if (v->start_alternate) {
-        v->start_alternate(v, name, obj, size, promote_int, &err);
+        v->start_alternate(v, name, obj, size, supported_qtypes, &err);
     }
     if (v->type & VISITOR_INPUT) {
         assert(v->start_alternate && !err != !*obj);
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index 34086cbfc0..2e40da5981 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -70,7 +70,8 @@ static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
 
 static void qapi_clone_start_alternate(Visitor *v, const char *name,
                                        GenericAlternate **obj, size_t size,
-                                       bool promote_int, Error **errp)
+                                       uint32_t supported_qtypes,
+                                       Error **errp)
 {
     qapi_clone_start_struct(v, name, (void **)obj, size, errp);
 }
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index e39457bc79..23b64c21a4 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -38,7 +38,8 @@ static void qapi_dealloc_end_struct(Visitor *v, void **obj)
 
 static void qapi_dealloc_start_alternate(Visitor *v, const char *name,
                                          GenericAlternate **obj, size_t size,
-                                         bool promote_int, Error **errp)
+                                         uint32_t supported_qtypes,
+                                         Error **errp)
 {
 }
 
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 865e948ac0..25997ee816 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -338,7 +338,8 @@ static void qobject_input_check_list(Visitor *v, Error **errp)
 
 static void qobject_input_start_alternate(Visitor *v, const char *name,
                                           GenericAlternate **obj, size_t size,
-                                          bool promote_int, Error **errp)
+                                          uint32_t supported_qtypes,
+                                          Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     QObject *qobj = qobject_input_get_object(qiv, name, false, errp);
@@ -349,7 +350,8 @@ static void qobject_input_start_alternate(Visitor *v, const char *name,
     }
     *obj = g_malloc0(size);
     (*obj)->type = qobject_type(qobj);
-    if (promote_int && (*obj)->type == QTYPE_QINT) {
+    if (!(supported_qtypes & (1U << QTYPE_QINT)) &&
+        (*obj)->type == QTYPE_QINT) {
         (*obj)->type = QTYPE_QFLOAT;
     }
 }
diff --git a/qapi/trace-events b/qapi/trace-events
index 339cacf0ad..b15a55b797 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -11,7 +11,7 @@ visit_next_list(void *v, void *tail, size_t size) "v=%p tail=%p size=%zu"
 visit_check_list(void *v) "v=%p"
 visit_end_list(void *v, void *obj) "v=%p obj=%p"
 
-visit_start_alternate(void *v, const char *name, void *obj, size_t size, bool promote_int) "v=%p name=%s obj=%p size=%zu promote_int=%d"
+visit_start_alternate(void *v, const char *name, void *obj, size_t size, uint32_t supported_qtypes) "v=%p name=%s obj=%p size=%zu supported_qtypes=0x%x"
 visit_end_alternate(void *v, void *obj) "v=%p obj=%p"
 
 visit_optional(void *v, const char *name, bool *present) "v=%p name=%s present=%p"
-- 
2.11.0.259.g40922b1
