Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbV-00077t-JH
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbT-0003Sl-0Q
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:53 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 25 Aug 2017 16:23:30 +0300
Message-Id: <20170825132332.6734-6-el13635@mail.ntua.gr>
In-Reply-To: <20170825132332.6734-1-el13635@mail.ntua.gr>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 5/7] block/throttle-groups.c: remove
 throttle-groups list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

block/throttle-groups.c uses a list to keep track of all groups and make
sure all names are unique.

This patch moves all ThrottleGroup objects under the root container.
While block/throttle.c requires that all throttle groups are created
with object-add or -object, the legacy throttling interface still used
the throttle_groups list. By using the root container we get the name
collision check for free and have all groups, legacy or not, available
through the qom-get/qom-set commands. Legacy groups are marked and freed
when they have no users left instead of waiting for an explicit
object-del.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 include/block/throttle-groups.h |   1 +
 block/block-backend.c           |  15 +++--
 block/throttle-groups.c         | 145 +++++++++++++++++++++++-----------------
 tests/test-throttle.c           |   3 +
 4 files changed, 96 insertions(+), 68 deletions(-)

diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 8493540766..13fbc63f1e 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -58,6 +58,7 @@ typedef struct ThrottleGroupMember {
 
 const char *throttle_group_get_name(ThrottleGroupMember *tgm);
 
+void throttle_group_new_legacy(const char *name, Error **errp);
 ThrottleState *throttle_group_incref(const char *name);
 void throttle_group_unref(ThrottleState *ts);
 
diff --git a/block/block-backend.c b/block/block-backend.c
index 693ad27fc9..65f458ce8f 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1957,12 +1957,18 @@ void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error **errp)
     BlockDriverState *bs = blk_bs(blk), *throttle_node;
     QDict *options = qdict_new();
     Error *local_err = NULL;
-    ThrottleState *ts;
-
-    bdrv_drained_begin(bs);
 
     /* Force creation of group in case it doesn't exist */
-    ts = throttle_group_incref(group);
+    if (!throttle_group_exists(group)) {
+        throttle_group_new_legacy(group, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    bdrv_drained_begin(bs);
+
     qdict_set_default_str(options, "file", bs->node_name);
     qdict_set_default_str(options, QEMU_OPT_THROTTLE_GROUP_NAME, group);
     throttle_node = bdrv_new_open_driver(bdrv_find_format("throttle"), NULL,
@@ -1987,7 +1993,6 @@ void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error **errp)
     assert(throttle_node->refcnt == 1);
 
 end:
-    throttle_group_unref(ts);
     bdrv_drained_end(bs);
     blk_get_public(blk)->throttle_node = throttle_node;
 }
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 454bfcb067..238b648489 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -33,8 +33,10 @@
 #include "qapi-visit.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
+#include "qapi/qobject-input-visitor.h"
 
 static void throttle_group_obj_init(Object *obj);
+static bool throttle_group_can_be_deleted(UserCreatable *uc, Error **errp);
 static void throttle_group_obj_complete(UserCreatable *obj, Error **errp);
 
 /* The ThrottleGroup structure (with its ThrottleState) is shared
@@ -66,6 +68,7 @@ typedef struct ThrottleGroup {
 
     /* refuse individual property change if initialization is complete */
     bool is_initialized;
+    bool legacy;
     char *name; /* This is constant during the lifetime of the group */
 
     QemuMutex lock; /* This lock protects the following four fields */
@@ -74,34 +77,47 @@ typedef struct ThrottleGroup {
     ThrottleGroupMember *tokens[2];
     bool any_timer_armed[2];
     QEMUClockType clock_type;
-
-    /* This field is protected by the global QEMU mutex */
-    QTAILQ_ENTRY(ThrottleGroup) list;
 } ThrottleGroup;
 
-/* This is protected by the global QEMU mutex */
-static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =
-    QTAILQ_HEAD_INITIALIZER(throttle_groups);
 
+struct ThrottleGroupQuery {
+    const char *name;
+    ThrottleGroup *result;
+};
 
-/* This function reads throttle_groups and must be called under the global
- * mutex.
+static int query_throttle_groups_foreach(Object *obj, void *data)
+{
+    ThrottleGroup *tg;
+    struct ThrottleGroupQuery *query = data;
+
+    tg = (ThrottleGroup *)object_dynamic_cast(obj, TYPE_THROTTLE_GROUP);
+    if (!tg) {
+        return 0;
+    }
+
+    if (!g_strcmp0(query->name, tg->name)) {
+        query->result = tg;
+        return 1;
+    }
+
+    return 0;
+}
+
+
+/* This function reads the QOM root container and must be called under the
+ * global mutex.
  */
 static ThrottleGroup *throttle_group_by_name(const char *name)
 {
-    ThrottleGroup *iter;
+    struct ThrottleGroupQuery query = { name = name };
 
     /* Look for an existing group with that name */
-    QTAILQ_FOREACH(iter, &throttle_groups, list) {
-        if (!g_strcmp0(name, iter->name)) {
-            return iter;
-        }
-    }
-
-    return NULL;
+    object_child_foreach(object_get_objects_root(),
+                         query_throttle_groups_foreach, &query);
+    return query.result;
 }
 
-/* This function reads throttle_groups and must be called under the global
+/* This function must be called under the global
  * mutex.
  */
 bool throttle_group_exists(const char *name)
@@ -109,34 +125,49 @@ bool throttle_group_exists(const char *name)
     return throttle_group_by_name(name) != NULL;
 }
 
+/*
+ * Create a new ThrottleGroup, insert it in the object root container so that
+ * we can refer to it by id and set tg->legacy to true
+ *
+ * This function edits the QOM root container and must be called under the
+ * global mutex.
+ *
+ * @name: the name of the ThrottleGroup.
+ * @errp: Error object. Will be set if @name collides with a non-ThrottleGroup
+ *        QOM object
+ */
+void throttle_group_new_legacy(const char *name, Error **errp)
+{
+    ThrottleGroup *tg = NULL;
+
+    /* Create an empty property qdict. Caller is responsible for
+     * setting up limits */
+    QDict *pdict = qdict_new();
+    Visitor *v = qobject_input_visitor_new(QOBJECT(pdict));
+
+    /* tg will have a ref count of 2, one for the object root container
+     * and one for the caller */
+    tg = THROTTLE_GROUP(user_creatable_add_type(TYPE_THROTTLE_GROUP,
+                name, pdict, v, errp));
+    visit_free(v);
+    QDECREF(pdict);
+    if (!tg) {
+        return;
+    }
+    tg->legacy = true;
+}
+
 /* Increments the reference count of a ThrottleGroup given its name.
  *
- * If no ThrottleGroup is found with the given name a new one is
- * created.
- *
- * This function edits throttle_groups and must be called under the global
- * mutex.
- *
  * @name: the name of the ThrottleGroup
  * @ret:  the ThrottleState member of the ThrottleGroup
  */
 ThrottleState *throttle_group_incref(const char *name)
 {
-    ThrottleGroup *tg = NULL;
-
-    /* Look for an existing group with that name */
-    tg = throttle_group_by_name(name);
-
-    if (tg) {
-        object_ref(OBJECT(tg));
-    } else {
-        /* Create a new one if not found */
-        /* new ThrottleGroup obj will have a refcnt = 1 */
-        tg = THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
-        tg->name = g_strdup(name);
-        throttle_group_obj_complete(USER_CREATABLE(tg), &error_abort);
-    }
+    ThrottleGroup *tg = throttle_group_by_name(name);
 
+    assert(tg);
+    object_ref(OBJECT(tg));
     return &tg->ts;
 }
 
@@ -145,8 +176,8 @@ ThrottleState *throttle_group_incref(const char *name)
  * When the reference count reaches zero the ThrottleGroup is
  * destroyed.
  *
- * This function edits throttle_groups and must be called under the global
- * mutex.
+ * This function edits the QOM root container and must be called under the
+ * global mutex.
  *
  * @ts:  The ThrottleGroup to unref, given by its ThrottleState member
  */
@@ -154,6 +185,13 @@ void throttle_group_unref(ThrottleState *ts)
 {
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     object_unref(OBJECT(tg));
+    /* ThrottleGroups will always have an extra reference from their container,
+     * so accessing it now is safe */
+    if (tg->legacy && OBJECT(tg)->ref == 1) {
+        tg->legacy = false;
+        /* Drop object created from legacy interface manually */
+        user_creatable_del(tg->name, &error_abort);
+    }
 }
 
 /* Get the name from a ThrottleGroupMember's group. The name (and the pointer)
@@ -490,14 +528,10 @@ static void write_timer_cb(void *opaque)
 }
 
 /* Register a ThrottleGroupMember from the throttling group, also initializing
- * its timers and updating its throttle_state pointer to point to it. If a
- * throttling group with that name does not exist yet, it will be created.
- *
- * This function edits throttle_groups and must be called under the global
- * mutex.
+ * its timers and updating its throttle_state pointer to point to it.
  *
  * @tgm:       the ThrottleGroupMember to insert
- * @groupname: the name of the group
+ * @groupname: the name of the group. It must already exist.
  * @ctx:       the AioContext to use
  */
 void throttle_group_register_tgm(ThrottleGroupMember *tgm,
@@ -690,8 +724,6 @@ static ThrottleParamInfo properties[] = {
     }
 };
 
-/* This function edits throttle_groups and must be called under the global
- * mutex */
 static void throttle_group_obj_init(Object *obj)
 {
     ThrottleGroup *tg = THROTTLE_GROUP(obj);
@@ -702,49 +734,36 @@ static void throttle_group_obj_init(Object *obj)
         tg->clock_type = QEMU_CLOCK_VIRTUAL;
     }
     tg->is_initialized = false;
+    tg->legacy = false;
     qemu_mutex_init(&tg->lock);
     throttle_init(&tg->ts);
     QLIST_INIT(&tg->head);
 }
 
-/* This function edits throttle_groups and must be called under the global
- * mutex */
 static void throttle_group_obj_complete(UserCreatable *obj, Error **errp)
 {
     ThrottleGroup *tg = THROTTLE_GROUP(obj);
     ThrottleConfig cfg;
 
-    /* set group name to object id if it exists */
+    /* set group name to object id */
     if (!tg->name && tg->parent_obj.parent) {
         tg->name = object_get_canonical_path_component(OBJECT(obj));
     }
     /* We must have a group name at this point */
     assert(tg->name);
 
-    /* error if name is duplicate */
-    if (throttle_group_exists(tg->name)) {
-        error_setg(errp, "A group with this name already exists");
-        return;
-    }
-
     /* check validity */
     throttle_get_config(&tg->ts, &cfg);
     if (!throttle_is_valid(&cfg, errp)) {
         return;
     }
     throttle_config(&tg->ts, tg->clock_type, &cfg);
-    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
     tg->is_initialized = true;
 }
 
-/* This function edits throttle_groups and must be called under the global
- * mutex */
 static void throttle_group_obj_finalize(Object *obj)
 {
     ThrottleGroup *tg = THROTTLE_GROUP(obj);
-    if (tg->is_initialized) {
-        QTAILQ_REMOVE(&throttle_groups, tg, list);
-    }
     qemu_mutex_destroy(&tg->lock);
     g_free(tg->name);
 }
@@ -881,7 +900,7 @@ static void throttle_group_get_limits(Object *obj, Visitor *v,
 
 static bool throttle_group_can_be_deleted(UserCreatable *uc, Error **errp)
 {
-    return OBJECT(uc)->ref == 1;
+    return OBJECT(uc)->ref == 1 && THROTTLE_GROUP(uc)->legacy == false;
 }
 
 static void throttle_group_obj_class_init(ObjectClass *klass, void *class_data)
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index eef2b1c707..927117ecab 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -609,6 +609,9 @@ static void test_groups(void)
     g_assert(tgm2->throttle_state == NULL);
     g_assert(tgm3->throttle_state == NULL);
 
+    throttle_group_new_legacy("foo", &error_fatal);
+    throttle_group_new_legacy("bar", &error_fatal);
+
     throttle_group_register_tgm(tgm1, "bar", blk_get_aio_context(blk1));
     throttle_group_register_tgm(tgm2, "foo", blk_get_aio_context(blk2));
     throttle_group_register_tgm(tgm3, "bar", blk_get_aio_context(blk3));
-- 
2.11.0
