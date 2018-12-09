Received: from eggs.gnu.org ([2001:4830:134:3::10]:33246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u1-0000Qr-16
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tx-0004zl-5g
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tw-0004wW-LN
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:18 -0500
Message-Id: <20181209193749.12277-8-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 07/38] queue: add QTAILQ_REMOVE_SEVERAL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This is faster than removing elements one by one.

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/queue.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index ac418efc43..0283c2dd7d 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -419,6 +419,16 @@ struct {                                                                \
         (elm)->field.tqe_prev = NULL;                                   \
 } while (/*CONSTCOND*/0)
 
+/* remove @left, @right and all elements in between from @head */
+#define QTAILQ_REMOVE_SEVERAL(head, left, right, field) do {    \
+        if (((right)->field.tqe_next) != NULL)                  \
+            (right)->field.tqe_next->field.tqe_prev =           \
+                (left)->field.tqe_prev;                         \
+        else                                                    \
+            (head)->tqh_last = (left)->field.tqe_prev;          \
+        *(left)->field.tqe_prev = (right)->field.tqe_next;      \
+    } while (/*CONSTCOND*/0)
+
 #define QTAILQ_FOREACH(var, head, field)                                \
         for ((var) = ((head)->tqh_first);                               \
                 (var);                                                  \
-- 
2.17.1
