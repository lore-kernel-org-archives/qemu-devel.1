Received: from eggs.gnu.org ([2001:4830:134:3::10]:51442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0pn2-0007ob-09
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0pn1-0000vU-3F
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f0pn0-0000uj-Uy
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 27 Mar 2018 15:41:21 +0100
Message-Id: <20180327144124.32533-2-stefanha@redhat.com>
In-Reply-To: <20180327144124.32533-1-stefanha@redhat.com>
References: <20180327144124.32533-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] queue: add QSIMPLEQ_PREPEND()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

QSIMPLEQ_CONCAT(a, b) joins a = a + b.  The new QSIMPLEQ_PREPEND(a, b)
API joins a = b + a.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20180322152834.12656-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/queue.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index aa270d2b38..59fd1203a1 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -324,6 +324,14 @@ struct {                                                                \
     }                                                                   \
 } while (/*CONSTCOND*/0)
 
+#define QSIMPLEQ_PREPEND(head1, head2) do {                             \
+    if (!QSIMPLEQ_EMPTY((head2))) {                                     \
+        *(head2)->sqh_last = (head1)->sqh_first;                        \
+        (head1)->sqh_first = (head2)->sqh_first;                          \
+        QSIMPLEQ_INIT((head2));                                         \
+    }                                                                   \
+} while (/*CONSTCOND*/0)
+
 #define QSIMPLEQ_LAST(head, type, field)                                \
     (QSIMPLEQ_EMPTY((head)) ?                                           \
         NULL :                                                          \
-- 
2.14.3
