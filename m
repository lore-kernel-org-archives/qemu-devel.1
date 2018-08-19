Received: from eggs.gnu.org ([2001:4830:134:3::10]:57165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmS-0002N2-7R
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmO-0000cO-Qq
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 19 Aug 2018 05:13:27 -0400
Message-Id: <20180819091335.22863-4-cota@braap.org>
In-Reply-To: <20180819091335.22863-1-cota@braap.org>
References: <20180819091335.22863-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 03/11] rcu_queue: add RCU QSIMPLEQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/rcu_queue.h | 65 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
index 6881ea5274..e0395c989a 100644
--- a/include/qemu/rcu_queue.h
+++ b/include/qemu/rcu_queue.h
@@ -128,6 +128,71 @@ extern "C" {
           ((next_var) = atomic_rcu_read(&(var)->field.le_next), 1);  \
            (var) = (next_var))
 
+/*
+ * RCU simple queue
+ */
+
+/* Simple queue access methods */
+#define QSIMPLEQ_EMPTY_RCU(head)      (atomic_read(&(head)->sqh_first) == NULL)
+#define QSIMPLEQ_FIRST_RCU(head)       atomic_rcu_read(&(head)->sqh_first)
+#define QSIMPLEQ_NEXT_RCU(elm, field)  atomic_rcu_read(&(elm)->field.sqe_next)
+
+/* Simple queue functions */
+#define QSIMPLEQ_INSERT_HEAD_RCU(head, elm, field) do {         \
+    (elm)->field.sqe_next = (head)->sqh_first;                  \
+    if ((elm)->field.sqe_next == NULL) {                        \
+        (head)->sqh_last = &(elm)->field.sqe_next;              \
+    }                                                           \
+    atomic_rcu_set(&(head)->sqh_first, (elm));                  \
+} while (/*CONSTCOND*/0)
+
+#define QSIMPLEQ_INSERT_TAIL_RCU(head, elm, field) do {    \
+    (elm)->field.sqe_next = NULL;                          \
+    atomic_rcu_set((head)->sqh_last, (elm));               \
+    (head)->sqh_last = &(elm)->field.sqe_next;             \
+} while (/*CONSTCOND*/0)
+
+#define QSIMPLEQ_INSERT_AFTER_RCU(head, listelm, elm, field) do {       \
+    (elm)->field.sqe_next = (listelm)->field.sqe_next;                  \
+    if ((elm)->field.sqe_next == NULL) {                                \
+        (head)->sqh_last = &(elm)->field.sqe_next;                      \
+    }                                                                   \
+    atomic_rcu_set(&(listelm)->field.sqe_next, (elm));                  \
+} while (/*CONSTCOND*/0)
+
+#define QSIMPLEQ_REMOVE_HEAD_RCU(head, field) do {                     \
+    atomic_set(&(head)->sqh_first, (head)->sqh_first->field.sqe_next); \
+    if ((head)->sqh_first == NULL) {                                   \
+        (head)->sqh_last = &(head)->sqh_first;                         \
+    }                                                                  \
+} while (/*CONSTCOND*/0)
+
+#define QSIMPLEQ_REMOVE_RCU(head, elm, type, field) do {            \
+    if ((head)->sqh_first == (elm)) {                               \
+        QSIMPLEQ_REMOVE_HEAD_RCU((head), field);                    \
+    } else {                                                        \
+        struct type *curr = (head)->sqh_first;                      \
+        while (curr->field.sqe_next != (elm)) {                     \
+            curr = curr->field.sqe_next;                            \
+        }                                                           \
+        atomic_set(&curr->field.sqe_next,                           \
+                   curr->field.sqe_next->field.sqe_next);           \
+        if (curr->field.sqe_next == NULL) {                         \
+            (head)->sqh_last = &(curr)->field.sqe_next;             \
+        }                                                           \
+    }                                                               \
+} while (/*CONSTCOND*/0)
+
+#define QSIMPLEQ_FOREACH_RCU(var, head, field)                          \
+    for ((var) = atomic_rcu_read(&(head)->sqh_first);                   \
+         (var);                                                         \
+         (var) = atomic_rcu_read(&(var)->field.sqe_next))
+
+#define QSIMPLEQ_FOREACH_SAFE_RCU(var, head, field, next)                \
+    for ((var) = atomic_rcu_read(&(head)->sqh_first);                    \
+         (var) && ((next) = atomic_rcu_read(&(var)->field.sqe_next), 1); \
+         (var) = (next))
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.17.1
