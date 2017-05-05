Received: from eggs.gnu.org ([2001:4830:134:3::10]:50441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jZi-0003kf-RS
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jZh-0001kz-Jl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6jZh-0001jx-AD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  5 May 2017 17:11:27 -0300
Message-Id: <20170505201128.12099-3-ehabkost@redhat.com>
In-Reply-To: <20170505201128.12099-1-ehabkost@redhat.com>
References: <20170505201128.12099-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] qapi: Add enum_table[] parameter to
 start_alternate
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

The new parameter will be used by the string input visitor to detect
alternate types that can't be parsed unambiguously.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (new patch added to series)
---
 include/qapi/visitor.h       | 10 +++++++++-
 include/qapi/visitor-impl.h  |  4 +++-
 scripts/qapi-visit.py        | 11 +++++++++--
 qapi/qapi-visit-core.c       |  7 +++++--
 qapi/qapi-clone-visitor.c    |  1 +
 qapi/qapi-dealloc-visitor.c  |  1 +
 qapi/qobject-input-visitor.c |  1 +
 qapi/trace-events            |  2 +-
 8 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 8f5a223714..05e5ca0eb2 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -411,13 +411,21 @@ void visit_end_list(Visitor *v, void **list);
  * @supported_qtypes is a bit mask indicating which QTypes are supported
  * by the alternate.
  *
+ * @enum_table contains the enum value lookup table, in case
+ * strings in the input are going to be parsed as enums. Visitors
+ * aren't required to validate string input according to
+ * enum_table, as visit_type_enum() will be called automatically
+ * if (*obj)->type is QTYPE_QSTRING.
+ *
  * If successful, this must be paired with visit_end_alternate() with
  * the same @obj to clean up, even if visiting the contents of the
  * alternate fails.
  */
 void visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
-                           uint32_t supported_qtypes, Error **errp);
+                           uint32_t supported_qtypes,
+                           const char *const enum_table[],
+                           Error **errp);
 
 /*
  * Finish visiting an alternate type.
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 8afcde0f5d..b98370fabb 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -71,7 +71,9 @@ struct Visitor
      * optional for output visitors. */
     void (*start_alternate)(Visitor *v, const char *name,
                             GenericAlternate **obj, size_t size,
-                            uint32_t supported_qtypes, Error **errp);
+                            uint32_t supported_qtypes,
+                            const char *const enum_table[],
+                            Error **errp);
 
     /* Optional, needed for dealloc visitor */
     void (*end_alternate)(Visitor *v, void **obj);
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 41c54982e2..2f4dc56918 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -166,6 +166,12 @@ def gen_visit_alternate(name, variants):
     supported_qtypes = ' | '.join(qtypes)
     ret = ''
 
+    enum_table = 'NULL'
+    for var in variants.variants:
+        if isinstance(var.type, QAPISchemaEnumType):
+            enum_table = '%s_lookup' % (var.type.c_name())
+            break
+
     ret += mcgen('''
 
 void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
@@ -174,7 +180,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     uint32_t supported_qtypes = %(supported_qtypes)s;
 
     visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**obj),
-                          supported_qtypes, &err);
+                          supported_qtypes, %(enum_table)s, &err);
     if (err) {
         goto out;
     }
@@ -183,7 +189,8 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     }
     switch ((*obj)->type) {
 ''',
-                 c_name=c_name(name), supported_qtypes=supported_qtypes)
+                 c_name=c_name(name), supported_qtypes=supported_qtypes,
+                 enum_table=enum_table)
 
     for var in variants.variants:
         ret += mcgen('''
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 8d62914393..479aa763c8 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -107,6 +107,7 @@ void visit_end_list(Visitor *v, void **obj)
 void visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
                            uint32_t supported_qtypes,
+                           const char *const enum_table[],
                            Error **errp)
 {
     Error *err = NULL;
@@ -115,9 +116,11 @@ void visit_start_alternate(Visitor *v, const char *name,
 
     assert(obj && size >= sizeof(GenericAlternate));
     assert(!(v->type & VISITOR_OUTPUT) || *obj);
-    trace_visit_start_alternate(v, name, obj, size, supported_qtypes);
+    trace_visit_start_alternate(v, name, obj, size, supported_qtypes,
+                                (void *)enum_table);
     if (v->start_alternate) {
-        v->start_alternate(v, name, obj, size, supported_qtypes, &err);
+        v->start_alternate(v, name, obj, size, supported_qtypes,
+                           enum_table, &err);
     }
     if (v->type & VISITOR_INPUT) {
         assert(v->start_alternate && !err != !*obj);
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index 2e40da5981..9340441ee6 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -71,6 +71,7 @@ static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
 static void qapi_clone_start_alternate(Visitor *v, const char *name,
                                        GenericAlternate **obj, size_t size,
                                        uint32_t supported_qtypes,
+                                       const char *const enum_table[],
                                        Error **errp)
 {
     qapi_clone_start_struct(v, name, (void **)obj, size, errp);
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index 23b64c21a4..fed366c660 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -39,6 +39,7 @@ static void qapi_dealloc_end_struct(Visitor *v, void **obj)
 static void qapi_dealloc_start_alternate(Visitor *v, const char *name,
                                          GenericAlternate **obj, size_t size,
                                          uint32_t supported_qtypes,
+                                         const char *const enum_table[],
                                          Error **errp)
 {
 }
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 25997ee816..ae4a6a04e1 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -339,6 +339,7 @@ static void qobject_input_check_list(Visitor *v, Error **errp)
 static void qobject_input_start_alternate(Visitor *v, const char *name,
                                           GenericAlternate **obj, size_t size,
                                           uint32_t supported_qtypes,
+                                          const char *const enum_table[],
                                           Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
diff --git a/qapi/trace-events b/qapi/trace-events
index b15a55b797..384c251814 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -11,7 +11,7 @@ visit_next_list(void *v, void *tail, size_t size) "v=%p tail=%p size=%zu"
 visit_check_list(void *v) "v=%p"
 visit_end_list(void *v, void *obj) "v=%p obj=%p"
 
-visit_start_alternate(void *v, const char *name, void *obj, size_t size, uint32_t supported_qtypes) "v=%p name=%s obj=%p size=%zu supported_qtypes=0x%x"
+visit_start_alternate(void *v, const char *name, void *obj, size_t size, uint32_t supported_qtypes, void *enum_table) "v=%p name=%s obj=%p size=%zu supported_qtypes=0x%x enum_table=%p"
 visit_end_alternate(void *v, void *obj) "v=%p obj=%p"
 
 visit_optional(void *v, const char *name, bool *present) "v=%p name=%s present=%p"
-- 
2.11.0.259.g40922b1
