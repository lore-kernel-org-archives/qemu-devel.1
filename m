Received: from eggs.gnu.org ([2001:4830:134:3::10]:49965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eSA-0004iF-TL
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eS9-00050L-3s
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5eS8-0004ys-Q8
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  2 May 2017 17:31:12 -0300
Message-Id: <20170502203115.22233-2-ehabkost@redhat.com>
In-Reply-To: <20170502203115.22233-1-ehabkost@redhat.com>
References: <20170502203115.22233-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] visitor: Add 'supported_qtypes' parameter
 to visit_start_alternate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This will allow visitors to make decisions based on the supported qtypes
of a given alternate type. The new parameter can replace the old
'promote_int' argument, as qobject-input-visitor can simply check if
QTYPE_QINT is set in supported_qtypes.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qapi/visitor.h       |  5 +++--
 include/qapi/visitor-impl.h  |  2 +-
 scripts/qapi-visit.py        | 14 ++++++++------
 qapi/qapi-visit-core.c       |  7 ++++---
 qapi/qapi-clone-visitor.c    |  3 ++-
 qapi/qapi-dealloc-visitor.c  |  3 ++-
 qapi/qobject-input-visitor.c |  6 ++++--
 qapi/trace-events            |  2 +-
 8 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 1a1b62012b..8c2bff4a05 100644
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
+                           unsigned long supported_qtypes, Error **errp);
 
 /*
  * Finish visiting an alternate type.
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index e87709db5c..50c2b2feef 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -71,7 +71,7 @@ struct Visitor
      * optional for output visitors. */
     void (*start_alternate)(Visitor *v, const char *name,
                             GenericAlternate **obj, size_t size,
-                            bool promote_int, Error **errp);
+                            unsigned long supported_qtypes, Error **errp);
 
     /* Optional, needed for dealloc visitor */
     void (*end_alternate)(Visitor *v, void **obj);
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 5737aefa05..ebf7e67109 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -161,20 +161,21 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error
 
 
 def gen_visit_alternate(name, variants):
-    promote_int = 'true'
+    qtypes = ['BIT(%s)' % (var.type.alternate_qtype())
+              for var in variants.variants]
+    supported_qtypes = '|'.join(qtypes)
     ret = ''
-    for var in variants.variants:
-        if var.type.alternate_qtype() == 'QTYPE_QINT':
-            promote_int = 'false'
 
     ret += mcgen('''
 
 void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
 {
     Error *err = NULL;
+    unsigned long supported_qtypes = %(supported_qtypes)s;
 
+    assert(QTYPE__MAX < BITS_PER_LONG);
     visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**obj),
-                          %(promote_int)s, &err);
+                          supported_qtypes, &err);
     if (err) {
         goto out;
     }
@@ -183,7 +184,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     }
     switch ((*obj)->type) {
 ''',
-                 c_name=c_name(name), promote_int=promote_int)
+                 c_name=c_name(name), supported_qtypes=supported_qtypes)
 
     for var in variants.variants:
         ret += mcgen('''
@@ -375,6 +376,7 @@ h_comment = '''
 
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
+#include "qemu/bitmap.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "%(prefix)sqapi-visit.h"
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 43a09d147d..784ba1b756 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -106,15 +106,16 @@ void visit_end_list(Visitor *v, void **obj)
 
 void visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
-                           bool promote_int, Error **errp)
+                           unsigned long supported_qtypes,
+                           Error **errp)
 {
     Error *err = NULL;
 
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
index 34086cbfc0..5550871488 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -70,7 +70,8 @@ static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
 
 static void qapi_clone_start_alternate(Visitor *v, const char *name,
                                        GenericAlternate **obj, size_t size,
-                                       bool promote_int, Error **errp)
+                                       unsigned long supported_qtypes,
+                                       Error **errp)
 {
     qapi_clone_start_struct(v, name, (void **)obj, size, errp);
 }
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index e39457bc79..ef83d1420b 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -38,7 +38,8 @@ static void qapi_dealloc_end_struct(Visitor *v, void **obj)
 
 static void qapi_dealloc_start_alternate(Visitor *v, const char *name,
                                          GenericAlternate **obj, size_t size,
-                                         bool promote_int, Error **errp)
+                                         unsigned long supported_qtypes,
+                                         Error **errp)
 {
 }
 
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 865e948ac0..393220b3a6 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/cutils.h"
+#include "qemu/bitops.h"
 #include "qemu/option.h"
 
 typedef struct StackObject {
@@ -338,7 +339,8 @@ static void qobject_input_check_list(Visitor *v, Error **errp)
 
 static void qobject_input_start_alternate(Visitor *v, const char *name,
                                           GenericAlternate **obj, size_t size,
-                                          bool promote_int, Error **errp)
+                                          unsigned long supported_qtypes,
+                                          Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     QObject *qobj = qobject_input_get_object(qiv, name, false, errp);
@@ -349,7 +351,7 @@ static void qobject_input_start_alternate(Visitor *v, const char *name,
     }
     *obj = g_malloc0(size);
     (*obj)->type = qobject_type(qobj);
-    if (promote_int && (*obj)->type == QTYPE_QINT) {
+    if (!(supported_qtypes & BIT(QTYPE_QINT)) && (*obj)->type == QTYPE_QINT) {
         (*obj)->type = QTYPE_QFLOAT;
     }
 }
diff --git a/qapi/trace-events b/qapi/trace-events
index 339cacf0ad..db42dd8353 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -11,7 +11,7 @@ visit_next_list(void *v, void *tail, size_t size) "v=%p tail=%p size=%zu"
 visit_check_list(void *v) "v=%p"
 visit_end_list(void *v, void *obj) "v=%p obj=%p"
 
-visit_start_alternate(void *v, const char *name, void *obj, size_t size, bool promote_int) "v=%p name=%s obj=%p size=%zu promote_int=%d"
+visit_start_alternate(void *v, const char *name, void *obj, size_t size, unsigned long supported_qtypes) "v=%p name=%s obj=%p size=%zu supported_qtypes=0x%lx"
 visit_end_alternate(void *v, void *obj) "v=%p obj=%p"
 
 visit_optional(void *v, const char *name, bool *present) "v=%p name=%s present=%p"
-- 
2.11.0.259.g40922b1
