Received: from eggs.gnu.org ([2001:4830:134:3::10]:41998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjec-0000QH-R1
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjeb-0000gZ-MQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRjeb-0000gT-ED
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:13 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jan 2017 15:53:52 -0200
Message-Id: <20170112175356.21701-3-ehabkost@redhat.com>
In-Reply-To: <20170112175356.21701-1-ehabkost@redhat.com>
References: <20170112175356.21701-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] monitor: reuse user_creatable_add_opts()
 instead of user_creatable_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Simplify code by dropping ~57LOC by merging user_creatable_add()
into user_creatable_add_opts() and using the later from monitor.
Along with it allocate opts_visitor_new() once in user_creatable_add_opts().

As result we have one less API func and a more readable/simple
user_creatable_add_opts() vs user_creatable_add().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1484052795-158195-3-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object_interfaces.h | 17 ----------
 hmp.c                           |  5 +--
 qom/object_interfaces.c         | 71 ++++++++++-------------------------------
 3 files changed, 18 insertions(+), 75 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index 8b17f4def7..fdd7603c84 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -76,23 +76,6 @@ void user_creatable_complete(Object *obj, Error **errp);
 bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp);
 
 /**
- * user_creatable_add:
- * @qdict: the object definition
- * @v: the visitor
- * @errp: if an error occurs, a pointer to an area to store the error
- *
- * Create an instance of the user creatable object whose type
- * is defined in @qdict by the 'qom-type' field, placing it
- * in the object composition tree with name provided by the
- * 'id' field. The remaining fields in @qdict are used to
- * initialize the object properties.
- *
- * Returns: the newly created object or NULL on error
- */
-Object *user_creatable_add(const QDict *qdict,
-                           Visitor *v, Error **errp);
-
-/**
  * user_creatable_add_type:
  * @type: the object type name
  * @id: the unique ID for the object
diff --git a/hmp.c b/hmp.c
index b86961705d..e7bead5a1d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1808,7 +1808,6 @@ void hmp_object_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     QemuOpts *opts;
-    Visitor *v;
     Object *obj = NULL;
 
     opts = qemu_opts_from_qdict(qemu_find_opts("object"), qdict, &err);
@@ -1817,9 +1816,7 @@ void hmp_object_add(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    v = opts_visitor_new(opts);
-    obj = user_creatable_add(qdict, v, &err);
-    visit_free(v);
+    obj = user_creatable_add_opts(opts, &err);
     qemu_opts_del(opts);
 
     if (err) {
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 4b880d077c..9b4155a227 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -34,57 +34,6 @@ bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp)
     }
 }
 
-
-Object *user_creatable_add(const QDict *qdict,
-                           Visitor *v, Error **errp)
-{
-    char *type = NULL;
-    char *id = NULL;
-    Object *obj = NULL;
-    Error *local_err = NULL;
-    QDict *pdict;
-
-    pdict = qdict_clone_shallow(qdict);
-
-    visit_start_struct(v, NULL, NULL, 0, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    qdict_del(pdict, "qom-type");
-    visit_type_str(v, "qom-type", &type, &local_err);
-    if (local_err) {
-        goto out_visit;
-    }
-
-    qdict_del(pdict, "id");
-    visit_type_str(v, "id", &id, &local_err);
-    if (local_err) {
-        goto out_visit;
-    }
-    visit_check_struct(v, &local_err);
-    if (local_err) {
-        goto out_visit;
-    }
-
-    obj = user_creatable_add_type(type, id, pdict, v, &local_err);
-
-out_visit:
-    visit_end_struct(v, NULL);
-
-out:
-    QDECREF(pdict);
-    g_free(id);
-    g_free(type);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        object_unref(obj);
-        return NULL;
-    }
-    return obj;
-}
-
-
 Object *user_creatable_add_type(const char *type, const char *id,
                                 const QDict *qdict,
                                 Visitor *v, Error **errp)
@@ -157,13 +106,27 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
 {
     Visitor *v;
     QDict *pdict;
-    Object *obj = NULL;
+    Object *obj;
+    const char *id = qemu_opts_id(opts);
+    const char *type = qemu_opt_get(opts, "qom-type");
+
+    if (!type) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
+        return NULL;
+    }
+    if (!id) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        return NULL;
+    }
 
-    v = opts_visitor_new(opts);
     pdict = qemu_opts_to_qdict(opts, NULL);
+    qdict_del(pdict, "qom-type");
+    qdict_del(pdict, "id");
 
-    obj = user_creatable_add(pdict, v, errp);
+    v = opts_visitor_new(opts);
+    obj = user_creatable_add_type(type, id, pdict, v, errp);
     visit_free(v);
+
     QDECREF(pdict);
     return obj;
 }
-- 
2.11.0.259.g40922b1
