Received: from eggs.gnu.org ([2001:4830:134:3::10]:33487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4Z-0001zN-A0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0006mA-9F
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:02 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:53043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4U-0006U1-Dx
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:58 -0400
Received: by mail-wm0-x232.google.com with SMTP id y139-v6so854074wmc.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:11 +0200
Message-Id: <1534870966-9287-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/74] rcu_queue: add RCU QTAILQ
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
Message-Id: <20180819091335.22863-5-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/rcu_queue.h | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
index e0395c9..904b337 100644
--- a/include/qemu/rcu_queue.h
+++ b/include/qemu/rcu_queue.h
@@ -193,6 +193,72 @@ extern "C" {
          (var) && ((next) = atomic_rcu_read(&(var)->field.sqe_next), 1); \
          (var) = (next))
 
+/*
+ * RCU tail queue
+ */
+
+/* Tail queue access methods */
+#define QTAILQ_EMPTY_RCU(head)      (atomic_read(&(head)->tqh_first) == NULL)
+#define QTAILQ_FIRST_RCU(head)       atomic_rcu_read(&(head)->tqh_first)
+#define QTAILQ_NEXT_RCU(elm, field)  atomic_rcu_read(&(elm)->field.tqe_next)
+
+/* Tail queue functions */
+#define QTAILQ_INSERT_HEAD_RCU(head, elm, field) do {                   \
+    (elm)->field.tqe_next = (head)->tqh_first;                          \
+    if ((elm)->field.tqe_next != NULL) {                                \
+        (head)->tqh_first->field.tqe_prev = &(elm)->field.tqe_next;     \
+    } else {                                                            \
+        (head)->tqh_last = &(elm)->field.tqe_next;                      \
+    }                                                                   \
+    atomic_rcu_set(&(head)->tqh_first, (elm));                          \
+    (elm)->field.tqe_prev = &(head)->tqh_first;                         \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_INSERT_TAIL_RCU(head, elm, field) do {               \
+    (elm)->field.tqe_next = NULL;                                   \
+    (elm)->field.tqe_prev = (head)->tqh_last;                       \
+    atomic_rcu_set((head)->tqh_last, (elm));                        \
+    (head)->tqh_last = &(elm)->field.tqe_next;                      \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_INSERT_AFTER_RCU(head, listelm, elm, field) do {         \
+    (elm)->field.tqe_next = (listelm)->field.tqe_next;                  \
+    if ((elm)->field.tqe_next != NULL) {                                \
+        (elm)->field.tqe_next->field.tqe_prev = &(elm)->field.tqe_next; \
+    } else {                                                            \
+        (head)->tqh_last = &(elm)->field.tqe_next;                      \
+    }                                                                   \
+    atomic_rcu_set(&(listelm)->field.tqe_next, (elm));                  \
+    (elm)->field.tqe_prev = &(listelm)->field.tqe_next;                 \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_INSERT_BEFORE_RCU(listelm, elm, field) do {          \
+    (elm)->field.tqe_prev = (listelm)->field.tqe_prev;              \
+    (elm)->field.tqe_next = (listelm);                              \
+    atomic_rcu_set((listelm)->field.tqe_prev, (elm));               \
+    (listelm)->field.tqe_prev = &(elm)->field.tqe_next;             \
+    } while (/*CONSTCOND*/0)
+
+#define QTAILQ_REMOVE_RCU(head, elm, field) do {                        \
+    if (((elm)->field.tqe_next) != NULL) {                              \
+        (elm)->field.tqe_next->field.tqe_prev = (elm)->field.tqe_prev;  \
+    } else {                                                            \
+        (head)->tqh_last = (elm)->field.tqe_prev;                       \
+    }                                                                   \
+    atomic_set((elm)->field.tqe_prev, (elm)->field.tqe_next);           \
+    (elm)->field.tqe_prev = NULL;                                       \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_FOREACH_RCU(var, head, field)                            \
+    for ((var) = atomic_rcu_read(&(head)->tqh_first);                   \
+         (var);                                                         \
+         (var) = atomic_rcu_read(&(var)->field.tqe_next))
+
+#define QTAILQ_FOREACH_SAFE_RCU(var, head, field, next)                  \
+    for ((var) = atomic_rcu_read(&(head)->tqh_first);                    \
+         (var) && ((next) = atomic_rcu_read(&(var)->field.tqe_next), 1); \
+         (var) = (next))
+
 #ifdef __cplusplus
 }
 #endif
-- 
1.8.3.1
