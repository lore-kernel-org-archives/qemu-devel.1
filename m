Received: from eggs.gnu.org ([2001:4830:134:3::10]:60087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0q-0001eM-6n
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0o-0004U6-37
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:36 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:46:56 +0300
Message-Id: <20170623124700.1389-5-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 4/8] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

ThrottleGroup is converted to an object to allow easy runtime
configuration of throttling filter nodes in the BDS graph using QOM.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/throttle-groups.c | 351 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/throttle.h |   4 +
 2 files changed, 355 insertions(+)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 7883cbb511..60079dc8ea 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -25,9 +25,11 @@
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
 #include "block/throttle-groups.h"
+#include "qemu/throttle-options.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "sysemu/qtest.h"
+#include "qapi/error.h"
 
 /* The ThrottleGroup structure (with its ThrottleState) is shared
  * among different ThrottleGroupMembers and it's independent from
@@ -54,6 +56,7 @@
  * that BlockBackend has throttled requests in the queue.
  */
 typedef struct ThrottleGroup {
+    Object parent_obj;
     char *name; /* This is constant during the lifetime of the group */
 
     QemuMutex lock; /* This lock protects the following four fields */
@@ -562,3 +565,351 @@ static void throttle_groups_init(void)
 }
 
 block_init(throttle_groups_init);
+
+
+static bool throttle_group_exists(const char *name)
+{
+    ThrottleGroup *iter;
+    bool ret = false;
+
+    qemu_mutex_lock(&throttle_groups_lock);
+    /* Look for an existing group with that name */
+    QTAILQ_FOREACH(iter, &throttle_groups, list) {
+        if (!strcmp(name, iter->name)) {
+            ret = true;
+            break;
+        }
+    }
+
+    qemu_mutex_unlock(&throttle_groups_lock);
+    return ret;
+}
+
+typedef struct ThrottleGroupClass {
+    /* private */
+    ObjectClass parent_class;
+    /* public */
+} ThrottleGroupClass;
+
+
+#define DOUBLE 0
+#define UINT64 1
+#define UNSIGNED 2
+
+typedef struct {
+    BucketType type;
+    int size; /* field size */
+    ptrdiff_t offset; /* offset in LeakyBucket struct. */
+} ThrottleParamInfo;
+
+static ThrottleParamInfo throttle_iops_total_info = {
+    THROTTLE_OPS_TOTAL, DOUBLE, offsetof(LeakyBucket, avg),
+};
+
+static ThrottleParamInfo throttle_iops_total_max_info = {
+    THROTTLE_OPS_TOTAL, DOUBLE, offsetof(LeakyBucket, max),
+};
+
+static ThrottleParamInfo throttle_iops_total_max_length_info = {
+    THROTTLE_OPS_TOTAL, UNSIGNED, offsetof(LeakyBucket, burst_length),
+};
+
+static ThrottleParamInfo throttle_iops_read_info = {
+    THROTTLE_OPS_READ, DOUBLE, offsetof(LeakyBucket, avg),
+};
+
+static ThrottleParamInfo throttle_iops_read_max_info = {
+    THROTTLE_OPS_READ, DOUBLE, offsetof(LeakyBucket, max),
+};
+
+static ThrottleParamInfo throttle_iops_read_max_length_info = {
+    THROTTLE_OPS_READ, UNSIGNED, offsetof(LeakyBucket, burst_length),
+};
+
+static ThrottleParamInfo throttle_iops_write_info = {
+    THROTTLE_OPS_WRITE, DOUBLE, offsetof(LeakyBucket, avg),
+};
+
+static ThrottleParamInfo throttle_iops_write_max_info = {
+    THROTTLE_OPS_WRITE, DOUBLE, offsetof(LeakyBucket, max),
+};
+
+static ThrottleParamInfo throttle_iops_write_max_length_info = {
+    THROTTLE_OPS_WRITE, UNSIGNED, offsetof(LeakyBucket, burst_length),
+};
+
+static ThrottleParamInfo throttle_bps_total_info = {
+    THROTTLE_BPS_TOTAL, DOUBLE, offsetof(LeakyBucket, avg),
+};
+
+static ThrottleParamInfo throttle_bps_total_max_info = {
+    THROTTLE_BPS_TOTAL, DOUBLE, offsetof(LeakyBucket, max),
+};
+
+static ThrottleParamInfo throttle_bps_total_max_length_info = {
+    THROTTLE_BPS_TOTAL, UNSIGNED, offsetof(LeakyBucket, burst_length),
+};
+
+static ThrottleParamInfo throttle_bps_read_info = {
+    THROTTLE_BPS_READ, DOUBLE, offsetof(LeakyBucket, avg),
+};
+
+static ThrottleParamInfo throttle_bps_read_max_info = {
+    THROTTLE_BPS_READ, DOUBLE, offsetof(LeakyBucket, max),
+};
+
+static ThrottleParamInfo throttle_bps_read_max_length_info = {
+    THROTTLE_BPS_READ, UNSIGNED, offsetof(LeakyBucket, burst_length),
+};
+
+static ThrottleParamInfo throttle_bps_write_info = {
+    THROTTLE_BPS_WRITE, DOUBLE, offsetof(LeakyBucket, avg),
+};
+
+static ThrottleParamInfo throttle_bps_write_max_info = {
+    THROTTLE_BPS_WRITE, DOUBLE, offsetof(LeakyBucket, max),
+};
+
+static ThrottleParamInfo throttle_bps_write_max_length_info = {
+    THROTTLE_BPS_WRITE, UNSIGNED, offsetof(LeakyBucket, burst_length),
+};
+
+static ThrottleParamInfo throttle_iops_size_info = {
+    0, UINT64, offsetof(ThrottleConfig, op_size),
+};
+
+
+static void throttle_group_obj_complete(UserCreatable *obj, Error **errp)
+{
+    char *name = NULL;
+    Error *local_error = NULL;
+    ThrottleGroup *tg = THROTTLE_GROUP(obj);
+
+    name = object_get_canonical_path_component(OBJECT(obj));
+    if (throttle_group_exists(name)) {
+        error_setg(&local_error, "A throttle group with this name already \
+                                  exists.");
+        goto ret;
+    }
+
+    qemu_mutex_lock(&throttle_groups_lock);
+    tg->name = name;
+    qemu_mutex_init(&tg->lock);
+    QLIST_INIT(&tg->head);
+    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
+    tg->refcount++;
+    qemu_mutex_unlock(&throttle_groups_lock);
+
+ret:
+    error_propagate(errp, local_error);
+    return;
+
+}
+
+static void throttle_group_set(Object *obj, Visitor *v, const char * name,
+        void *opaque, Error **errp)
+
+{
+    ThrottleGroup *tg = THROTTLE_GROUP(obj);
+    ThrottleConfig cfg = tg->ts.cfg;
+    Error *local_err = NULL;
+    ThrottleParamInfo *info = opaque;
+    int64_t value;
+
+    visit_type_int64(v, name, &value, &local_err);
+
+    if (local_err) {
+        goto out;
+    }
+    if (value < 0) {
+        error_setg(&local_err, "%s value must be in range [0, %"PRId64"]",
+                "iops-total", INT64_MAX); /* change option string */
+        goto out;
+    }
+
+    switch (info->size) {
+    case UINT64:
+        {
+            uint64_t *field = (void *)&cfg.buckets[info->type] + info->offset;
+            *field = value;
+        }
+        break;
+    case DOUBLE:
+        {
+            double *field = (void *)&cfg.buckets[info->type] + info->offset;
+            *field = value;
+        }
+        break;
+    case UNSIGNED:
+        {
+            unsigned *field = (void *)&cfg.buckets[info->type] + info->offset;
+            *field = value;
+        }
+    }
+
+    tg->ts.cfg = cfg;
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void throttle_group_get(Object *obj, Visitor *v, const char *name,
+        void *opaque, Error **errp)
+{
+    ThrottleGroup *tg = THROTTLE_GROUP(obj);
+    ThrottleConfig cfg = tg->ts.cfg;
+    ThrottleParamInfo *info = opaque;
+    int64_t value;
+
+    switch (info->size) {
+    case UINT64:
+        {
+            uint64_t *field = (void *)&cfg.buckets[info->type] + info->offset;
+            value = *field;
+        }
+        break;
+    case DOUBLE:
+        {
+            double *field = (void *)&cfg.buckets[info->type] + info->offset;
+            value = *field;
+        }
+        break;
+    case UNSIGNED:
+        {
+            unsigned *field = (void *)&cfg.buckets[info->type] + info->offset;
+            value = *field;
+        }
+    }
+
+    visit_type_int64(v, name, &value, errp);
+
+}
+
+static void throttle_group_init(Object *obj)
+{
+    ThrottleGroup *tg = THROTTLE_GROUP(obj);
+    throttle_init(&tg->ts);
+}
+
+static void throttle_group_class_init(ObjectClass *klass, void *class_data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
+
+    ucc->complete = throttle_group_obj_complete;
+    /* iops limits */
+    object_class_property_add(klass, QEMU_OPT_IOPS_TOTAL, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_total_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_IOPS_TOTAL_MAX, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_total_max_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_total_max_length_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_IOPS_READ, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_read_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_IOPS_READ_MAX, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_read_max_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_IOPS_READ_MAX_LENGTH, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_read_max_length_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_IOPS_WRITE, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_write_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_IOPS_WRITE_MAX, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_write_max_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_IOPS_WRITE_MAX_LENGTH, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_write_max_length_info, &error_abort);
+    /* bps limits */
+    object_class_property_add(klass, QEMU_OPT_BPS_TOTAL, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_total_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_BPS_TOTAL_MAX, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_total_max_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_BPS_TOTAL_MAX_LENGTH, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_total_max_length_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_BPS_READ, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_read_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_BPS_READ_MAX, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_read_max_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_BPS_READ_MAX_LENGTH, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_read_max_length_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_BPS_WRITE, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_write_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_BPS_WRITE_MAX, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_write_max_info, &error_abort);
+    object_class_property_add(klass, QEMU_OPT_BPS_WRITE_MAX_LENGTH, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_bps_write_max_length_info, &error_abort);
+    /* rest */
+    object_class_property_add(klass, QEMU_OPT_IOPS_SIZE, "int",
+            throttle_group_get,
+            throttle_group_set,
+            NULL, &throttle_iops_size_info, &error_abort);
+}
+
+
+static void throttle_group_finalize(Object *obj)
+{
+    ThrottleGroup *tg = THROTTLE_GROUP(obj);
+
+    qemu_mutex_lock(&throttle_groups_lock);
+    if (--tg->refcount == 0) {
+        QTAILQ_REMOVE(&throttle_groups, tg, list);
+        qemu_mutex_destroy(&tg->lock);
+        g_free(tg->name);
+        g_free(tg);
+    }
+    qemu_mutex_unlock(&throttle_groups_lock);
+
+}
+
+static const TypeInfo throttle_group_info = {
+   .name = TYPE_THROTTLE_GROUP,
+   .parent = TYPE_OBJECT,
+   .class_init = throttle_group_class_init,
+   .instance_size = sizeof(ThrottleGroup),
+   .instance_init = throttle_group_init,
+   .instance_finalize = throttle_group_finalize,
+   .interfaces = (InterfaceInfo[]) {
+       { TYPE_USER_CREATABLE },
+       { }
+   },
+};
+
+static void throttle_group_register_types(void)
+{
+    qemu_mutex_init(&throttle_groups_lock);
+    type_register_static(&throttle_group_info);
+}
+
+type_init(throttle_group_register_types);
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 3e92d4d4eb..dd56baeb35 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -28,6 +28,8 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/coroutine.h"
+#include "qom/object.h"
+#include "qom/object_interfaces.h"
 
 #define THROTTLE_VALUE_MAX 1000000000000000LL
 
@@ -180,4 +182,6 @@ typedef struct ThrottleGroupMember {
 
 } ThrottleGroupMember;
 
+#define TYPE_THROTTLE_GROUP "throttling-group"
+#define THROTTLE_GROUP(obj) OBJECT_CHECK(ThrottleGroup, (obj), TYPE_THROTTLE_GROUP)
 #endif
-- 
2.11.0
