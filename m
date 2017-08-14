Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNb-0001nW-Dd
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNX-0002Ql-Bs
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNNW-0002Q3-VX
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF1E77003E
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:58:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:39 -0300
Message-Id: <20170814215748.5158-5-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 04/13] qdev: Slot info helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

Helper functions to deal with slot info data structures, and
automatically merge similar device slots

There's room for improvement on the slot merging algorithm, but
this version should be enough to demonstrate how bus
implementations can benefit from it.

TODO: write API documentation, make object ownership/reference
rules clear, clean up code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-slotinfo.h |  85 +++++++
 hw/core/slotinfo.c         | 610 +++++++++++++++++++++++++++++++++++++++++++++
 tests/test-slotinfo.c      | 398 +++++++++++++++++++++++++++++
 hw/core/Makefile.objs      |   2 +
 tests/Makefile.include     |  14 +-
 5 files changed, 1103 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/qdev-slotinfo.h
 create mode 100644 hw/core/slotinfo.c
 create mode 100644 tests/test-slotinfo.c

diff --git a/include/hw/qdev-slotinfo.h b/include/hw/qdev-slotinfo.h
new file mode 100644
index 0000000..6d8fb54
--- /dev/null
+++ b/include/hw/qdev-slotinfo.h
@@ -0,0 +1,85 @@
+#ifndef QDEV_SLOTINFO_H
+#define QDEV_SLOTINFO_H
+
+#include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qstring.h"
+
+/**
+ * valuelist_contains:
+ *
+ * Returns true if the value list represented by @values
+ * contains @v.
+ *
+ * @values follows the format documented at SlotOption.values
+ * in the QAPI schema.
+ */
+bool valuelist_contains(QObject *values, QObject *v);
+
+/**
+ * valuelist_extend:
+ *
+ * Extend a value list with elements from another value list.
+ *
+ * Ownership of 'new' is transfered to the function.
+ */
+void valuelist_extend(QObject **valuelist, QObject *new);
+
+/*
+ * TODO: Use more efficient data structurs (instead of
+ * DeviceSlotInfoList and SlotOptionList) when building the list
+ * and combining items.
+ */
+
+/**
+ * slot_options_can_be_combined:
+ *
+ * Check if two SlotOptionLists can be combined in one.
+ *
+ * Two slot option lists can be combined if all options have exactly
+ * the same value except (at most) one.
+ *
+ * Returns true if the option lists can be combined.
+ *
+ * If return value is true, *@opt_name is set to the only
+ * mismatching option name.  If all options match, *@opt_name is
+ * set to NULL.
+ */
+bool slot_options_can_be_combined(SlotOptionList *a, SlotOptionList *b,
+                                  const char **opt_name);
+
+/*TODO: doc */
+bool slots_can_be_combined(DeviceSlotInfo *a, DeviceSlotInfo *b,
+	                       const char **opt_name);
+
+/*TODO: doc */
+void slots_combine(DeviceSlotInfo *a, DeviceSlotInfo *b, const char *opt_name);
+
+/*TODO: doc */
+bool slots_try_combine(DeviceSlotInfo *a, DeviceSlotInfo *b);
+
+/*TODO: doc */
+void slot_list_add_slot(DeviceSlotInfoList **l, DeviceSlotInfo *slot);
+
+/*TODO: doc */
+DeviceSlotInfoList *slot_list_collapse(DeviceSlotInfoList *l);
+
+/*TODO: doc */
+void slot_add_opt(DeviceSlotInfo *slot, const char *option, QObject *values);
+
+#define slot_add_opt_str(slot, option, s) \
+    slot_add_opt(slot, option, QOBJECT(qstring_from_str(s)));
+
+#define slot_add_opt_int(slot, option, i) \
+    slot_add_opt(slot, option, QOBJECT(qnum_from_int(i)));
+
+SlotOption *slot_options_find_opt(SlotOptionList *opts, const char *option);
+
+static inline SlotOption *slot_find_opt(DeviceSlotInfo *slot, const char *option)
+{
+	return slot_options_find_opt(slot->opts, option);
+}
+
+/*TODO: doc */
+DeviceSlotInfo *make_slot(BusState *bus);
+
+#endif /* QDEV_SLOTINFO_H */
diff --git a/hw/core/slotinfo.c b/hw/core/slotinfo.c
new file mode 100644
index 0000000..c03bda2
--- /dev/null
+++ b/hw/core/slotinfo.c
@@ -0,0 +1,610 @@
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-slotinfo.h"
+#include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/util.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi-visit.h"
+
+//#define DEBUG_QOBJECTS
+
+#ifdef DEBUG_QOBJECTS
+#define _DBG(args...) fprintf(stderr, args);
+
+#define DBG(args...) do { _DBG("%s: ", __FUNCTION__); \
+                          _DBG(args); \
+                     } while (0)
+#define QDBG(fmt, obj, args...) do { \
+        QString *js = qobject_to_json(obj); \
+        DBG(fmt ## args); \
+        _DBG(": %s\n", qstring_get_str(js)); \
+        QDECREF(js); \
+    } while (0)
+#else
+#define DBG(...) do { } while (0)
+#define QDBG(...) do { } while (0)
+#endif
+
+/* Ensure a value list is normalized to a list of values
+ *
+ * This does NOT normalize individual elements of the list to be
+ * in the [A] or [A, B] format.
+ *
+ * Returns a new reference to the normalized value.
+ */
+static QList *valuelist_normalize(QObject *values)
+{
+    if (qobject_type(values) == QTYPE_QLIST) {
+        qobject_incref(values);
+        return qobject_to_qlist(values);
+    } else {
+        QList *l = qlist_new();
+
+        qobject_incref(values);
+        qlist_append_obj(l, values);
+        return l;
+    }
+}
+
+/* Simplify value list, if possible
+ *
+ * Onwership of @values is transfered to the function, and a
+ * new object is returned.
+ */
+static QObject *valuelist_simplify(QList *values)
+{
+    if (qlist_size(values) == 1) {
+        QObject *o = qlist_entry_obj(qlist_first(values));
+        QType t = qobject_type(o);
+        if (t == QTYPE_QNULL ||
+            t == QTYPE_QNUM ||
+            t == QTYPE_QSTRING ||
+            t == QTYPE_QBOOL) {
+            qobject_incref(o);
+            QDECREF(values);
+            return o;
+        }
+    }
+
+    return QOBJECT(values);
+}
+
+/* Check if a given single-element value can be represented as a [A, B] range */
+static bool value_can_be_range(QObject *v)
+{
+    QType t = qobject_type(v);
+    return (t == QTYPE_QNUM || t == QTYPE_QSTRING);
+}
+
+/*
+ * Represent a single value (if max is NULL), or a [min, max] range
+ * if @max is not NULL
+ */
+typedef struct ValueRange {
+    QObject *min, *max;
+} ValueRange;
+
+/*
+ * Validate a value list element and put result on ValueRange
+ *
+ * NOTE: this won't increase ref count of @vr->min and @vr->max
+ */
+static bool valuelist_element_get_range(QObject *elm, ValueRange *vr)
+{
+    QObject *min = NULL, *max = NULL;
+
+    if (qobject_type(elm) == QTYPE_QLIST) {
+        QList *l = qobject_to_qlist(elm);
+        if (qlist_size(l) < 1 || qlist_size(l) > 2) {
+            return false;
+        }
+        min = qlist_entry_obj(qlist_first(l));
+        if (qlist_size(l) == 2) {
+            max = qlist_entry_obj(qlist_next(qlist_first(l)));
+        }
+    } else {
+        min = elm;
+    }
+
+    assert(min);
+    /* Invalid range: */
+    if (max && (!value_can_be_range(min) || !value_can_be_range(max) ||
+                qobject_type(min) != qobject_type(max))) {
+        return false;
+    }
+
+    /* If the value can be a range, make it a range */
+    if (!max && value_can_be_range(min)) {
+        max = min;
+    }
+
+    vr->min = min;
+    vr->max = max;
+    return true;
+}
+
+/* Check if @v is inside the @vr range */
+static bool range_contains(ValueRange *vr, QObject *v)
+{
+    assert(vr->min);
+    if (vr->max) { /* range */
+        return qobject_type(vr->min) == qobject_type(v) &&
+               qobject_compare(vr->max, v) >= 0 &&
+               qobject_compare(v, vr->min) >= 0;
+    } else {  /* single element */
+        return qobject_compare(vr->min, v) == 0;
+    }
+}
+
+/* Check if @a contains @b */
+static bool range_contains_range(ValueRange *a, ValueRange *b)
+{
+    bool r = range_contains(a, b->min);
+    if (b->max) {
+        r &= range_contains(a, b->max);
+    }
+    return r;
+}
+
+/* Check if the intersection of @a and @b is not empty */
+static bool range_overlaps_range(ValueRange *a, ValueRange *b)
+{
+    return range_contains(a, b->min) ||
+           (b->max && range_contains(a, b->max)) ||
+           range_contains_range(b, a);
+}
+
+/*
+ * Check if a given entry of a value list contains the range @minv-@maxv
+ * If @maxv is NULL, only check if the entry contains @minv
+ */
+static bool valuelist_entry_contains(QObject *ev, ValueRange *vr)
+{
+    ValueRange er;
+
+    if (!valuelist_element_get_range(ev, &er)) {
+        return false;
+    }
+    return range_contains_range(&er, vr);
+}
+
+/*
+ * Check if a given entry of a value list contains the range @minv-@maxv
+ * If @maxv is NULL, only check if the entry contains @minv
+ */
+static bool valuelist_entry_overlaps(QObject *ev, ValueRange *vr)
+{
+    ValueRange er;
+
+    if (!valuelist_element_get_range(ev, &er)) {
+        return false;
+    }
+
+    return range_overlaps_range(&er, vr);
+}
+
+/*
+ * Find the entry in the value list that contains the range @minv-@maxv
+ * If @maxv is NULL, check if the value list contains @minv
+ *
+ * Returns the list entry that contains the range, or NULL if
+ * not found.
+ */
+static QListEntry *nvaluelist_find_range_match(QList *l, ValueRange *vr)
+{
+    QListEntry *e;
+
+    QLIST_FOREACH_ENTRY(l, e) {
+        QObject *ev = qlist_entry_obj(e);
+        if (valuelist_entry_contains(ev, vr)) {
+            return e;
+        }
+    }
+
+    return NULL;
+}
+
+/*
+ * Find the entry in the value list that contains @v
+ *
+ * Returns the list entry that contains the range, or NULL if
+ * not found.
+ */
+static QListEntry *nvaluelist_find_value_match(QList *l, QObject *v)
+{
+    ValueRange vr = { .min = v };
+    return nvaluelist_find_range_match(l, &vr);
+}
+
+/*
+ * Try to sum i to number, if it's an integer.
+ * Otherwise, just return a new reference to @v
+ */
+static QObject *qnum_try_int_add(QObject *v, int i)
+{
+    QNum *qn;
+    uint64_t u64;
+    int64_t i64;
+
+    if (qobject_type(v) != QTYPE_QNUM) {
+        qobject_incref(v);
+        return v;
+    }
+
+    /*TODO: we should be able to convert uint to int and vice-versa. e.g.:
+     * - qnum_try_int_add(qnum_from_int(INT64_MAX), 1)
+     * - qnum_try_int_add(qnum_from_uint(UINT64_MIN), -1)
+     */
+    qn = qobject_to_qnum(v);
+    if (qnum_get_try_int(qn, &i64)) {
+        if ((i < 0) && INT64_MIN - i >= i64) {
+            i64 = INT64_MIN;
+        } else if ((i > 0) && INT64_MAX - i <= i64) {
+            i64 = INT64_MAX;
+        } else {
+            i64 = i64 + i;
+        }
+        return QOBJECT(qnum_from_int(i64));
+    } else if (qnum_get_try_uint(qn, &u64)) {
+        if ((i < 0) && -i >= u64) {
+            u64 = 0;
+        } else if ((i > 0) && UINT64_MAX - i <= u64) {
+            u64 = UINT64_MAX;
+        } else {
+            u64 = u64 + i;
+        }
+        return QOBJECT(qnum_from_uint(u64));
+    } else {
+        qobject_incref(v);
+        return v;
+    }
+}
+
+/*
+ * Look for any entry that overlaps or touches @vr
+ * If @skip is not NULL, @skip is not considered as a match.
+ */
+static QListEntry *nvaluelist_find_overlap(QList *l, ValueRange *vr,
+                                           QListEntry *skip)
+{
+    QListEntry *r = NULL;
+    QListEntry *e;
+    ValueRange key;
+
+    key.min = qnum_try_int_add(vr->min, -1);
+    key.max = qnum_try_int_add(vr->max, 1);
+
+    QLIST_FOREACH_ENTRY(l, e) {
+        QObject *ev = qlist_entry_obj(e);
+        if (e == skip) {
+            continue;
+        }
+        if (valuelist_entry_overlaps(ev, &key)) {
+            r = e;
+            break;
+        }
+    }
+
+    qobject_decref(key.min);
+    qobject_decref(key.max);
+    return r;
+}
+
+bool valuelist_contains(QObject *values, QObject *v)
+{
+    QList *l = valuelist_normalize(values);
+    bool r = !!nvaluelist_find_value_match(l, v);
+
+    QDECREF(l);
+    return r;
+}
+
+static QListEntry *valuelist_try_overlap(QList *l, ValueRange *vr,
+                                         QListEntry *skip)
+{
+    ValueRange ovr;
+    QList *newrange;
+    QListEntry *ov = nvaluelist_find_overlap(l, vr, skip);
+
+    if (!ov) {
+        return NULL;
+    }
+
+    valuelist_element_get_range(ov->value, &ovr);
+    if (qobject_compare(ovr.min, vr->min) > 0) {
+        ovr.min = vr->min;
+    }
+    if (qobject_compare(vr->max, ovr.max) > 0) {
+        ovr.max = vr->max;
+    }
+
+    newrange = qlist_new();
+    qobject_incref(ovr.min);
+    qlist_append_obj(newrange, ovr.min);
+    qobject_incref(ovr.max);
+    qlist_append_obj(newrange, ovr.max);
+
+    /*FIXME: this is a hack */
+    qobject_decref(ov->value);
+    ov->value = QOBJECT(newrange);
+    return ov;
+}
+
+/* Ownership of @e is passed to the function */
+static QListEntry *valuelist_try_merge(QList *l, QListEntry *e)
+{
+    ValueRange vr;
+    QListEntry *ov;
+
+    if (!valuelist_element_get_range(e->value, &vr)) {
+        return NULL;
+    }
+
+    ov = valuelist_try_overlap(l, &vr, e);
+    assert(ov != e);
+    if (ov) {
+        /*TODO: this is a hack */
+        QTAILQ_REMOVE(&l->head, e, next);
+        qobject_decref(e->value);
+        g_free(e);
+    }
+    return ov;
+}
+
+/* Ownership of @elm is NOT given to the function: only the reference
+ * count is increased if necessary.
+ */
+static void valuelist_append_element(QList *l, QObject *elm)
+{
+    ValueRange vr;
+
+    if (valuelist_element_get_range(elm, &vr)) {
+        QListEntry *ov;
+
+        if (nvaluelist_find_range_match(l, &vr)) {
+            return;
+        }
+
+        ov = valuelist_try_overlap(l, &vr, NULL);
+        /* If we find an overlapping entry, keep trying to merge it with
+         * other elements.
+         */
+        if (ov) {
+            while (ov) {
+                ov = valuelist_try_merge(l, ov);
+            }
+            return;
+        }
+    }
+
+    /* No overlap found, just append element to the list */
+    qobject_incref(elm);
+    qlist_append_obj(l, elm);
+}
+
+void valuelist_extend(QObject **valuelist, QObject *new)
+{
+    QObject *old = *valuelist;
+    QList *l = valuelist_normalize(old);
+    QList *newl = valuelist_normalize(new);
+    QListEntry *e;
+
+    QLIST_FOREACH_ENTRY(newl, e) {
+        QObject *elm = qlist_entry_obj(e);
+        valuelist_append_element(l, elm);
+    }
+    QDECREF(newl);
+
+    *valuelist = valuelist_simplify(l);
+    qobject_decref(old);
+}
+
+SlotOption *slot_options_find_opt(SlotOptionList *opts, const char *option)
+{
+    for (; opts; opts = opts->next) {
+        if (!strcmp(opts->value->option, option)) {
+            return opts->value;
+        }
+    }
+    return NULL;
+}
+
+bool slot_options_can_be_combined(SlotOptionList *a, SlotOptionList *b,
+                                  const char **opt_name)
+{
+    SlotOptionList *ol;
+    const char *mismatch = NULL;
+
+    /* Check if all options in @b will be handled when we loop through @a */
+    for (ol = b; ol; ol = ol->next) {
+        if (!slot_options_find_opt(a, ol->value->option)) {
+            return false;
+        }
+    }
+
+    for (ol = a; ol; ol = ol->next) {
+        SlotOption *ao = ol->value;
+        SlotOption *bo = slot_options_find_opt(b, ao->option);
+
+        if (!bo) {
+            return false;
+        }
+
+        if (qobject_compare(bo->values, ao->values)) {
+            if (mismatch && strcmp(mismatch, ao->option)) {
+                return false;
+            }
+
+            mismatch = ao->option;
+        }
+    }
+
+    if (opt_name) {
+        *opt_name = mismatch;
+    }
+    return true;
+}
+
+static int compare_strList(strList *a, strList *b)
+{
+    for (; a && b; a = a->next, b = b->next) {
+        int c = strcmp(a->value, b->value);
+        if (c) {
+            return c;
+        }
+    }
+
+    if (b) {
+        return -1;
+    } else if (a) {
+        return 1;
+    } else {
+        return 0;
+    }
+
+}
+
+bool slots_can_be_combined(DeviceSlotInfo *a, DeviceSlotInfo *b,
+                           const char **opt_name)
+{
+    if (a->available != b->available ||
+        a->hotpluggable != b->hotpluggable ||
+        a->has_count != b->has_count ||
+        a->opts_complete != b->opts_complete ||
+        a->has_device || b->has_device ||
+        compare_strList(a->device_types, b->device_types)) {
+        return false;
+    }
+
+    return slot_options_can_be_combined(a->opts, b->opts, opt_name);
+}
+
+void slots_combine(DeviceSlotInfo *a, DeviceSlotInfo *b, const char *opt_name)
+{
+    assert(slots_can_be_combined(a, b, NULL));
+    if (a->has_count) {
+        a->count += b->count;
+    }
+    if (opt_name) {
+        SlotOption *aopt = slot_options_find_opt(a->opts, opt_name);
+        SlotOption *bopt = slot_options_find_opt(b->opts, opt_name);
+
+        valuelist_extend(&aopt->values, bopt->values);
+    }
+}
+
+bool slots_try_combine(DeviceSlotInfo *a, DeviceSlotInfo *b)
+{
+    const char *opt = NULL;
+    assert(a != b);
+
+    if (slots_can_be_combined(a, b, &opt)) {
+        slots_combine(a, b, opt);
+        return true;
+    }
+
+    return false;
+}
+
+/* Try to combine @slot with an entry in @l
+ *
+ * Will return a pointer to the 'next' pointer in the previous entry,
+ * to allow callers to remove the entry from the list if necessary.
+ */
+static DeviceSlotInfoList **slot_list_try_combine_slot(DeviceSlotInfoList **l, DeviceSlotInfo *slot)
+{
+    DeviceSlotInfoList **pprev;
+
+    for (pprev = l; *pprev; pprev = &(*pprev)->next) {
+        DeviceSlotInfo *i = (*pprev)->value;
+        if (slots_try_combine(i, slot)) {
+            return pprev;
+        }
+    }
+
+    return NULL;
+}
+
+DeviceSlotInfoList *slot_list_collapse(DeviceSlotInfoList *l)
+{
+    DeviceSlotInfoList *newlist = NULL;
+    DeviceSlotInfoList *queue = l;
+
+    while (queue) {
+        DeviceSlotInfoList **pprev;
+        DeviceSlotInfoList *next = queue->next;
+
+        pprev = slot_list_try_combine_slot(&newlist, queue->value);
+        if (pprev) {
+            DeviceSlotInfoList *removed = *pprev;
+            /* Remove modified item from @newlist@ */
+            *pprev = (*pprev)->next;
+            /* Dequeue item from @queue */
+            queue->next = NULL;
+            qapi_free_DeviceSlotInfoList(queue);
+            /* Queue modified item on @queue */
+            removed->next = next;
+            queue = removed;
+        } else {
+            /* Not combined, just insert into newlist */
+            queue->next = newlist;
+            newlist = queue;
+            queue = next;
+        }
+    }
+
+    return newlist;
+}
+
+/* Ownership of @slot is given to the function */
+void slot_list_add_slot(DeviceSlotInfoList **l, DeviceSlotInfo *slot)
+{
+    DeviceSlotInfoList *li;
+
+    /* Avoid adding new entry if it can be combined */
+    if (slot_list_try_combine_slot(l, slot)) {
+        qapi_free_DeviceSlotInfo(slot);
+        return;
+    }
+
+    li = g_new0(DeviceSlotInfoList, 1);
+    li->value = slot;
+    li->next = *l;
+    *l = li;
+}
+
+void slot_add_opt(DeviceSlotInfo *slot, const char *option, QObject *values)
+{
+    SlotOptionList *l =  g_new0(SlotOptionList, 1);
+
+    l->value = g_new0(SlotOption, 1);
+    l->value->option = g_strdup(option);
+    l->value->values = values;
+    l->next = slot->opts;
+    slot->opts = l;
+}
+
+/*TODO: move it to common code */
+static inline bool qbus_is_full(BusState *bus)
+{
+    BusClass *bus_class = BUS_GET_CLASS(bus);
+    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
+}
+
+DeviceSlotInfo *make_slot(BusState *bus)
+{
+    DeviceSlotInfo *s = g_new0(DeviceSlotInfo, 1);
+
+    s->device_types = g_new0(strList, 1);
+    s->device_types->value = g_strdup(BUS_GET_CLASS(bus)->device_type);
+    s->hotpluggable = qbus_is_hotpluggable(bus);
+    s->available = !qbus_is_full(bus);
+
+    slot_add_opt_str(s, "bus", bus->name);
+
+    return s;
+}
diff --git a/tests/test-slotinfo.c b/tests/test-slotinfo.c
new file mode 100644
index 0000000..b169712
--- /dev/null
+++ b/tests/test-slotinfo.c
@@ -0,0 +1,398 @@
+/*
+ * Unit tests for QAPI utility functions
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Eduardo Habkost <ehabkost@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/util.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qjson.h"
+#include "hw/qdev-slotinfo.h"
+
+#define JS(json) qobject_from_json((json), &error_abort)
+
+static bool json_valuelist_contains(const char *jvalues, const char *jvalue)
+{
+    QObject *values = JS(jvalues);
+    QObject *value = JS(jvalue);
+    bool r = valuelist_contains(values, value);
+
+    qobject_decref(values);
+    qobject_decref(value);
+    return r;
+}
+
+static void test_valuelist_contains(void)
+{
+    g_assert_true(json_valuelist_contains("100", "100"));
+    g_assert_false(json_valuelist_contains("100", "200"));
+
+    g_assert_false(json_valuelist_contains("[]", "100"));
+    g_assert_true(json_valuelist_contains("[100, 200, 300]", "200"));
+    g_assert_false(json_valuelist_contains("[100, 200, 300]", "150"));
+
+    g_assert_true(json_valuelist_contains("\"abc\"", "\"abc\""));
+    g_assert_false(json_valuelist_contains("\"abc\"", "\"xyz\""));
+    g_assert_true(json_valuelist_contains("[\"abc\"]", "\"abc\""));
+    g_assert_false(json_valuelist_contains("[\"abc\", \"cde\"]", "\"xyz\""));
+
+#define TEST_RANGE "[[1,10], [18,20], [\"aaaa2\", \"jyz3\"], [-100, 5]," \
+                    "\"kkk\", 14, -50, [51], [[30, 31]] ]"
+
+    /* [-100, 5] */
+    g_assert_false(json_valuelist_contains(TEST_RANGE, "-101"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE, "-100"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,  "-99"));
+
+    /* -50 */
+    g_assert_true( json_valuelist_contains(TEST_RANGE,  "-51"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,  "-50"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,  "-49"));
+
+    /* [-100, 5], [1, 10] */
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "-1"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,    "0"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,    "1"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,    "2"));
+
+    /* [-100, 5] */
+    g_assert_true( json_valuelist_contains(TEST_RANGE,    "4"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,    "5"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,    "6"));
+
+    /* [1, 10] */
+    g_assert_true( json_valuelist_contains(TEST_RANGE,    "9"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "10"));
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "11"));
+
+    /* 14 */
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "13"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "14"));
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "15"));
+
+    /* [18, 20] */
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "17"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "18"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "19"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "20"));
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "21"));
+
+    /* [51] */
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "50"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "51"));
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "52"));
+
+    /* [ "aaa2" , "jyz3" ] */
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "\"aaaa\""));
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "\"aaaa1\""));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "\"aaaa2\""));
+    g_assert_true(json_valuelist_contains(TEST_RANGE,   "\"aaaa3\""));
+
+    /* [ "aaa2" , "jyz3" ] */
+    g_assert_true(json_valuelist_contains(TEST_RANGE,   "\"bcde\""));
+
+    /* [ "aaa2" , "jyz3" ] */
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "\"jyz\""));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "\"jyz2\""));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "\"jyz3\""));
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "\"jyz4\""));
+
+    /* "kkk" */
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "\"kk\""));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "\"kkk\""));
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "\"kkkk\""));
+
+    /* [[30, 31]] */
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "30"));
+    g_assert_false(json_valuelist_contains(TEST_RANGE,   "[30]"));
+    g_assert_true( json_valuelist_contains(TEST_RANGE,   "[30, 31]"));
+
+    /* empty set doesn't contain an empty list: */
+    g_assert_false(json_valuelist_contains("[]", "[]"));
+
+    /* [] is an invalid element on a value list: */
+    g_assert_false(json_valuelist_contains("[[]]", "[]"));
+
+    /* [[]] indicates [] is a valid value */
+    g_assert_true(json_valuelist_contains("[[[]]]", "[]"));
+}
+
+#define assert_valuelist_extend(before, extend, after)           \
+    do {                                                         \
+        QObject *set = JS(before);                               \
+        QObject *expected = JS(after);                           \
+                                                                 \
+        valuelist_extend(&set, JS(extend));;                     \
+        g_assert_cmpint(qobject_compare(set, expected), ==, 0);  \
+                                                                 \
+        qobject_decref(set);                                     \
+        qobject_decref(expected);                                \
+    } while (0)
+
+static void test_valuelist_extend(void)
+{
+    assert_valuelist_extend("[]",
+                            "1",
+                            "1");
+
+    assert_valuelist_extend("1",
+                            "1",
+                            "1");
+
+    assert_valuelist_extend("1",
+                            "3",
+                            "[1, 3]");
+
+    assert_valuelist_extend("[1, 3]",
+                            "6",
+                            "[1, 3, 6]");
+
+    /*TODO: implement and test range merging */
+
+    /* single-element becomes range: */
+    assert_valuelist_extend("[1, 3, 6]",
+                            "4",
+                            "[1, [3, 4], 6]");
+    assert_valuelist_extend("[1, 4, 6]",
+                            "3",
+                            "[1, [3, 4], 6]");
+
+
+    /* single-element merges two elements: */
+    assert_valuelist_extend("[1, 3, 6]",
+                            "2",
+                            "[[1, 3], 6]");
+
+    /* [] -> empty set */
+    assert_valuelist_extend("[1, 3, 6]",
+                            "[]",
+                            "[1, 3, 6]");
+
+    /* [3, 100] -> two elements: 3 and 100 (not a range) */
+    assert_valuelist_extend("[[1, 4], 6]",
+                            "[3, 100]",
+                            "[[1, 4], 6, 100]");
+
+    /* tests for appending new ranges: */
+
+    /* add two ranges: 7-30, 40-50 */
+    assert_valuelist_extend("[[1, 4], 6, 100]",
+                            "[[7, 30], [40, 50]]",
+                            "[[1, 4], [6, 30], 100, [40, 50]]");
+
+    /* multiple ways of appending to a range: */
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "30",
+                            "[[1, 4], [6, 30], [40, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "31",
+                            "[[1, 4], [6, 31], [40, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[25, 35]]",
+                            "[[1, 4], [6, 35], [40, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[30, 35]]",
+                            "[[1, 4], [6, 35], [40, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[31, 35]]",
+                            "[[1, 4], [6, 35], [40, 50], [53, 60]]");
+    //TODO: make this work:
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[38, 51]]",
+                            "[[1, 4], [6, 30], [38, 51], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[38, 52]]",
+                            "[[1, 4], [6, 30], [38, 60]]");
+    /* off-by-one check: */
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "51",
+                            "[[1, 4], [6, 30], [40, 51], [53, 60]]");
+    /* _not_ appending to a range: */
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "32",
+                            "[[1, 4], [6, 30], [40, 50], [53, 60], 32]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[32, 35]]",
+                            "[[1, 4], [6, 30], [40, 50], [53, 60], [32, 35]]");
+
+    /* multiple ways of prepending to a range: */
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "40",
+                            "[[1, 4], [6, 30], [40, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "39",
+                            "[[1, 4], [6, 30], [39, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[35, 45]]",
+                            "[[1, 4], [6, 30], [35, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[35, 40]]",
+                            "[[1, 4], [6, 30], [35, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[35, 39]]",
+                            "[[1, 4], [6, 30], [35, 50], [53, 60]]");
+    /* off-by-one check: */
+    assert_valuelist_extend("[[1, 4], [6, 30], [33, 50], [53, 60]]",
+                            "32",
+                            "[[1, 4], [6, 30], [32, 50], [53, 60]]");
+    /* _not_ prepending to a range: */
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "38",
+                            "[[1, 4], [6, 30], [40, 50], [53, 60], 38]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[35, 38]]",
+                            "[[1, 4], [6, 30], [40, 50], [53, 60], [35, 38]]");
+
+    /* multiple ways of combining two ranges: */
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "5",
+                            "[[1, 30], [40, 50], [53, 60]]");
+    assert_valuelist_extend("[[1, 4], [6, 30], [40, 50], [53, 60]]",
+                            "[[25, 45]]",
+                            "[[1, 4], [6, 50], [53, 60]]");
+}
+
+static void test_slots_can_combine(void)
+{
+    DeviceSlotInfo *a = g_new0(DeviceSlotInfo, 1);
+    DeviceSlotInfo *b = g_new0(DeviceSlotInfo, 1);
+    const char *opt_name = NULL;
+
+    g_assert_true(slots_can_be_combined(a, b, &opt_name));
+    g_assert_null(opt_name);
+
+    slot_add_opt(a, "bus", JS("\"mybus.0\""));
+    g_assert_false(slots_can_be_combined(a, b, &opt_name));
+    slot_add_opt(b, "bus", JS("\"mybus.0\""));
+
+    g_assert_true(slots_can_be_combined(a, b, &opt_name));
+    g_assert_null(opt_name);
+
+    slot_add_opt(a, "addr", JS("[ 1, 3 ]"));
+    g_assert_false(slots_can_be_combined(a, b, &opt_name));
+    slot_add_opt(b, "addr", JS("5"));
+
+    g_assert_true(slots_can_be_combined(a, b, &opt_name));
+    g_assert_cmpstr(opt_name, ==, "addr");
+
+    slot_add_opt(a, "unit", JS("1"));
+    g_assert_false(slots_can_be_combined(a, b, &opt_name));
+    slot_add_opt(b, "unit", JS("1"));
+
+    g_assert_true(slots_can_be_combined(a, b, &opt_name));
+    g_assert_cmpstr(opt_name, ==, "addr");
+
+    a->hotpluggable = true;
+    g_assert_false(slots_can_be_combined(a, b, &opt_name));
+    a->hotpluggable = false;
+
+    a->has_device = true;
+    a->device = g_strdup("/machine/somedevice");
+    g_assert_false(slots_can_be_combined(a, b, &opt_name));
+    g_free(a->device);
+    a->has_device = false;
+    a->device = NULL;
+
+    slot_add_opt(a, "port", JS("10"));
+    g_assert_false(slots_can_be_combined(a, b, &opt_name));
+    slot_add_opt(b, "port", JS("20"));
+
+    g_assert_false(slots_can_be_combined(a, b, &opt_name));
+}
+
+static void test_slots_combine(void)
+{
+    DeviceSlotInfo *a = g_new0(DeviceSlotInfo, 1);
+    DeviceSlotInfo *b = g_new0(DeviceSlotInfo, 1);
+    SlotOption *o;
+
+    slot_add_opt(a, "bus", JS("\"mybus.0\""));
+    slot_add_opt(b, "bus", JS("\"mybus.0\""));
+
+    slot_add_opt(a, "addr", JS("[ 1, 3 ]"));
+    slot_add_opt(b, "addr", JS("5"));
+
+    slot_add_opt(a, "unit", JS("1"));
+    slot_add_opt(b, "unit", JS("1"));
+
+    g_assert_true(slots_try_combine(a, b));
+
+    o = a->opts->value;
+    g_assert_cmpstr(o->option, ==, "unit");
+    g_assert_cmpint(qobject_compare(o->values, JS("1")), ==, 0);
+
+    o = a->opts->next->value;
+    g_assert_cmpstr(o->option, ==, "addr");
+    g_assert_cmpint(qobject_compare(o->values, JS("[1, 3, 5]")), ==, 0);
+
+    o = a->opts->next->next->value;
+    g_assert_cmpstr(o->option, ==, "bus");
+    g_assert_cmpint(qobject_compare(o->values, JS("\"mybus.0\"")), ==, 0);
+}
+
+static void test_slot_list_collapse(void)
+{
+    DeviceSlotInfoList *l = NULL;
+    SlotOption *o;
+    int node, socket, core, thread;
+
+    for (node = 0; node < 4; node++) {
+        for (socket = 0; socket < 8; socket++) {
+            for (core = 0; core < 4; core++) {
+                for (thread = 0; thread < 2; thread++) {
+                    DeviceSlotInfo *s = g_new0(DeviceSlotInfo, 1);
+                    slot_add_opt_int(s, "node", node);
+                    slot_add_opt_int(s, "socket", socket);
+                    slot_add_opt_int(s, "core", core);
+                    slot_add_opt_int(s, "thread", thread);
+                    slot_list_add_slot(&l, s);
+                }
+            }
+        }
+    }
+
+    /*
+     * All the entries above should be merged in a single entry:
+     * node = [0, 3]
+     * socket = [0, 7]
+     * core = [0, 3]
+     * thread = [0, 1]
+     */
+    l = slot_list_collapse(l);
+    g_assert_nonnull(l);
+    g_assert_null(l->next);
+
+    o = slot_find_opt(l->value, "node");
+    g_assert_cmpint(qobject_compare(o->values, JS("[ [0, 3] ]")), ==, 0);
+
+    o = slot_find_opt(l->value, "socket");
+    g_assert_cmpint(qobject_compare(o->values, JS("[ [0, 7] ]")), ==, 0);
+
+    o = slot_find_opt(l->value, "core");
+    g_assert_cmpint(qobject_compare(o->values, JS("[ [0, 3] ]")), ==, 0);
+
+    o = slot_find_opt(l->value, "thread");
+    g_assert_cmpint(qobject_compare(o->values, JS("[ [0, 1] ]")), ==, 0);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/qapi/util/valuelist_contains", test_valuelist_contains);
+    g_test_add_func("/qapi/util/valuelist_extend", test_valuelist_extend);
+    g_test_add_func("/qapi/util/slots_can_combine", test_slots_can_combine);
+    g_test_add_func("/qapi/util/slots_combine", test_slots_combine);
+    g_test_add_func("/qapi/util/slot_list_collapse", test_slot_list_collapse);
+    g_test_run();
+    return 0;
+}
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8d7a4a..0f3a0a6 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-y += fw-path-provider.o
 common-obj-y += irq.o
 common-obj-y += hotplug.o
 common-obj-y += nmi.o
+common-obj-y += slotinfo.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
@@ -21,3 +22,4 @@ common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 
 obj-$(CONFIG_SOFTMMU) += generic-loader.o
 obj-$(CONFIG_SOFTMMU) += null-machine.o
+
diff --git a/tests/Makefile.include b/tests/Makefile.include
index eb4895f..493f9ce 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -131,6 +131,8 @@ check-unit-y += tests/ptimer-test$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
+check-unit-y += tests/test-slotinfo$(EXESUF)
+gcov-files-test-slotinfo-y = hw/core/slotinfo.c
 
 check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 
@@ -535,6 +537,10 @@ test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
 	tests/test-qapi-event.o tests/test-qmp-introspect.o \
 	$(test-qom-obj-y)
+test-qdev-obj-y = hw/core/qdev.o hw/core/qdev-properties.o \
+	hw/core/hotplug.o hw/core/bus.o hw/core/irq.o \
+	hw/core/fw-path-provider.o hw/core/reset.o \
+	hw/core/slotinfo.o
 benchmark-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
 test-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
 test-io-obj-y = $(io-obj-y) $(test-crypto-obj-y)
@@ -573,12 +579,7 @@ tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
 
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
-	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
-	hw/core/bus.o \
-	hw/core/irq.o \
-	hw/core/fw-path-provider.o \
-	hw/core/reset.o \
-	$(test-qapi-obj-y)
+	$(test-qdev-obj-y) $(test-qapi-obj-y)
 tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
         migration/qemu-file-channel.o migration/qjson.o \
@@ -767,6 +768,7 @@ tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libvhost-use
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
+tests/test-slotinfo$(EXESUF): tests/test-slotinfo.o hw/core/slotinfo.o $(test-qdev-obj-y) $(test-qom-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 
-- 
2.9.4
