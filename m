Received: from eggs.gnu.org ([2001:4830:134:3::10]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4b-00025C-FF
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0006mY-Fk
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4U-0006S6-Na
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:59 -0400
Received: by mail-wr1-x436.google.com with SMTP id j26-v6so646968wre.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:10 +0200
Message-Id: <1534870966-9287-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 38/74] rcu_queue: add RCU QSIMPLEQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20180819091335.22863-4-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/rcu_queue.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
index 6881ea5..e0395c9 100644
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
1.8.3.1
