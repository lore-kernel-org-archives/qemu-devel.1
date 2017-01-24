Received: from eggs.gnu.org ([2001:4830:134:3::10]:55328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68D-0001HY-64
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68B-0006nr-HX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68B-0006nT-8b
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:47 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58E8AC06511D
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:47 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUp020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:46 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:30 +0000
Message-Id: <20170124184742.1639-4-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] migration: migrate QTAILQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jianjun Duan <duanj@linux.vnet.ibm.com>

Currently we cannot directly transfer a QTAILQ instance because of the
limitation in the migration code. Here we introduce an approach to
transfer such structures. We created VMStateInfo vmstate_info_qtailq
for QTAILQ. Similar VMStateInfo can be created for other data structures
such as list.

When a QTAILQ is migrated from source to target, it is appended to the
corresponding QTAILQ structure, which is assumed to have been properly
initialized.

This approach will be used to transfer pending_events and ccs_list in spapr
state.

We also create some macros in qemu/queue.h to access a QTAILQ using pointer
arithmetic. This ensures that we do not depend on the implementation
details about QTAILQ in the migration code.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
Message-Id: <1484852453-12728-3-git-send-email-duanj@linux.vnet.ibm.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h | 20 +++++++++++++
 include/qemu/queue.h        | 60 +++++++++++++++++++++++++++++++++++++++
 migration/trace-events      |  4 +++
 migration/vmstate.c         | 69 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 7e61b1e..3bbe3ed 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -260,6 +260,7 @@ extern const VMStateInfo vmstate_info_timer;
 extern const VMStateInfo vmstate_info_buffer;
 extern const VMStateInfo vmstate_info_unused_buffer;
 extern const VMStateInfo vmstate_info_bitmap;
+extern const VMStateInfo vmstate_info_qtailq;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 #define type_check_array(t1,t2,n) ((t1(*)[n])0 - (t2*)0)
@@ -671,6 +672,25 @@ extern const VMStateInfo vmstate_info_bitmap;
     .offset       = offsetof(_state, _field),                        \
 }
 
+/* For migrating a QTAILQ.
+ * Target QTAILQ needs be properly initialized.
+ * _type: type of QTAILQ element
+ * _next: name of QTAILQ entry field in QTAILQ element
+ * _vmsd: VMSD for QTAILQ element
+ * size: size of QTAILQ element
+ * start: offset of QTAILQ entry in QTAILQ element
+ */
+#define VMSTATE_QTAILQ_V(_field, _state, _version, _vmsd, _type, _next)  \
+{                                                                        \
+    .name         = (stringify(_field)),                                 \
+    .version_id   = (_version),                                          \
+    .vmsd         = &(_vmsd),                                            \
+    .size         = sizeof(_type),                                       \
+    .info         = &vmstate_info_qtailq,                                \
+    .offset       = offsetof(_state, _field),                            \
+    .start        = offsetof(_type, _next),                              \
+}
+
 /* _f : field name
    _f_n : num of elements field_name
    _n : num of elements
diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 342073f..35292c3 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -438,4 +438,64 @@ struct {                                                                \
 #define QTAILQ_PREV(elm, headname, field) \
         (*(((struct headname *)((elm)->field.tqe_prev))->tqh_last))
 
+#define field_at_offset(base, offset, type)                                    \
+        ((type) (((char *) (base)) + (offset)))
+
+typedef struct DUMMY_Q_ENTRY DUMMY_Q_ENTRY;
+typedef struct DUMMY_Q DUMMY_Q;
+
+struct DUMMY_Q_ENTRY {
+        QTAILQ_ENTRY(DUMMY_Q_ENTRY) next;
+};
+
+struct DUMMY_Q {
+        QTAILQ_HEAD(DUMMY_Q_HEAD, DUMMY_Q_ENTRY) head;
+};
+
+#define dummy_q ((DUMMY_Q *) 0)
+#define dummy_qe ((DUMMY_Q_ENTRY *) 0)
+
+/*
+ * Offsets of layout of a tail queue head.
+ */
+#define QTAILQ_FIRST_OFFSET (offsetof(typeof(dummy_q->head), tqh_first))
+#define QTAILQ_LAST_OFFSET  (offsetof(typeof(dummy_q->head), tqh_last))
+/*
+ * Raw access of elements of a tail queue
+ */
+#define QTAILQ_RAW_FIRST(head)                                                 \
+        (*field_at_offset(head, QTAILQ_FIRST_OFFSET, void **))
+#define QTAILQ_RAW_TQH_LAST(head)                                              \
+        (*field_at_offset(head, QTAILQ_LAST_OFFSET, void ***))
+
+/*
+ * Offsets of layout of a tail queue element.
+ */
+#define QTAILQ_NEXT_OFFSET (offsetof(typeof(dummy_qe->next), tqe_next))
+#define QTAILQ_PREV_OFFSET (offsetof(typeof(dummy_qe->next), tqe_prev))
+
+/*
+ * Raw access of elements of a tail entry
+ */
+#define QTAILQ_RAW_NEXT(elm, entry)                                            \
+        (*field_at_offset(elm, entry + QTAILQ_NEXT_OFFSET, void **))
+#define QTAILQ_RAW_TQE_PREV(elm, entry)                                        \
+        (*field_at_offset(elm, entry + QTAILQ_PREV_OFFSET, void ***))
+/*
+ * Tail queue tranversal using pointer arithmetic.
+ */
+#define QTAILQ_RAW_FOREACH(elm, head, entry)                                   \
+        for ((elm) = QTAILQ_RAW_FIRST(head);                                   \
+             (elm);                                                            \
+             (elm) = QTAILQ_RAW_NEXT(elm, entry))
+/*
+ * Tail queue insertion using pointer arithmetic.
+ */
+#define QTAILQ_RAW_INSERT_TAIL(head, elm, entry) do {                          \
+        QTAILQ_RAW_NEXT(elm, entry) = NULL;                                    \
+        QTAILQ_RAW_TQE_PREV(elm, entry) = QTAILQ_RAW_TQH_LAST(head);           \
+        *QTAILQ_RAW_TQH_LAST(head) = (elm);                                    \
+        QTAILQ_RAW_TQH_LAST(head) = &QTAILQ_RAW_NEXT(elm, entry);              \
+} while (/*CONSTCOND*/0)
+
 #endif /* QEMU_SYS_QUEUE_H */
diff --git a/migration/trace-events b/migration/trace-events
index 94134f7..c46f9e9 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -52,6 +52,10 @@ vmstate_n_elems(const char *name, int n_elems) "%s: %d"
 vmstate_subsection_load(const char *parent) "%s"
 vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
 vmstate_subsection_load_good(const char *parent) "%s"
+get_qtailq(const char *name, int version_id) "%s v%d"
+get_qtailq_end(const char *name, const char *reason, int val) "%s %s/%d"
+put_qtailq(const char *name, int version_id) "%s v%d"
+put_qtailq_end(const char *name, const char *reason) "%s %s"
 
 # migration/qemu-file.c
 qemu_file_fclose(void) ""
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 7b4bd6e..2f9d4ba 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -5,6 +5,7 @@
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/queue.h"
 #include "trace.h"
 #include "migration/qjson.h"
 
@@ -965,3 +966,71 @@ const VMStateInfo vmstate_info_bitmap = {
     .get = get_bitmap,
     .put = put_bitmap,
 };
+
+/* get for QTAILQ
+ * meta data about the QTAILQ is encoded in a VMStateField structure
+ */
+static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
+                      VMStateField *field)
+{
+    int ret = 0;
+    const VMStateDescription *vmsd = field->vmsd;
+    /* size of a QTAILQ element */
+    size_t size = field->size;
+    /* offset of the QTAILQ entry in a QTAILQ element */
+    size_t entry_offset = field->start;
+    int version_id = field->version_id;
+    void *elm;
+
+    trace_get_qtailq(vmsd->name, version_id);
+    if (version_id > vmsd->version_id) {
+        error_report("%s %s",  vmsd->name, "too new");
+        trace_get_qtailq_end(vmsd->name, "too new", -EINVAL);
+
+        return -EINVAL;
+    }
+    if (version_id < vmsd->minimum_version_id) {
+        error_report("%s %s",  vmsd->name, "too old");
+        trace_get_qtailq_end(vmsd->name, "too old", -EINVAL);
+        return -EINVAL;
+    }
+
+    while (qemu_get_byte(f)) {
+        elm = g_malloc(size);
+        ret = vmstate_load_state(f, vmsd, elm, version_id);
+        if (ret) {
+            return ret;
+        }
+        QTAILQ_RAW_INSERT_TAIL(pv, elm, entry_offset);
+    }
+
+    trace_get_qtailq_end(vmsd->name, "end", ret);
+    return ret;
+}
+
+/* put for QTAILQ */
+static int put_qtailq(QEMUFile *f, void *pv, size_t unused_size,
+                      VMStateField *field, QJSON *vmdesc)
+{
+    const VMStateDescription *vmsd = field->vmsd;
+    /* offset of the QTAILQ entry in a QTAILQ element*/
+    size_t entry_offset = field->start;
+    void *elm;
+
+    trace_put_qtailq(vmsd->name, vmsd->version_id);
+
+    QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
+        qemu_put_byte(f, true);
+        vmstate_save_state(f, vmsd, elm, vmdesc);
+    }
+    qemu_put_byte(f, false);
+
+    trace_put_qtailq_end(vmsd->name, "end");
+
+    return 0;
+}
+const VMStateInfo vmstate_info_qtailq = {
+    .name = "qtailq",
+    .get  = get_qtailq,
+    .put  = put_qtailq,
+};
-- 
2.9.3
