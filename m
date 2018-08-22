Received: from eggs.gnu.org ([2001:4830:134:3::10]:39117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpX-00070M-LS
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpV-0000IN-PT
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRpV-0000Hu-GL
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:41 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:50 +0200
Message-Id: <20180822120050.12694-21-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 20/20] migration: hold the lock only if it is
 really needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Try to hold src_page_req_mutex only if the queue is not
empty

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/qemu/queue.h | 1 +
 migration/ram.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 59fd1203a1..ac418efc43 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -341,6 +341,7 @@ struct {                                                                \
 /*
  * Simple queue access methods.
  */
+#define QSIMPLEQ_EMPTY_ATOMIC(head) (atomic_read(&((head)->sqh_first)) == NULL)
 #define QSIMPLEQ_EMPTY(head)        ((head)->sqh_first == NULL)
 #define QSIMPLEQ_FIRST(head)        ((head)->sqh_first)
 #define QSIMPLEQ_NEXT(elm, field)   ((elm)->field.sqe_next)
diff --git a/migration/ram.c b/migration/ram.c
index 40013e68a1..79c89425a3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2033,6 +2033,10 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
 {
     RAMBlock *block = NULL;
 
+    if (QSIMPLEQ_EMPTY_ATOMIC(&rs->src_page_requests)) {
+        return NULL;
+    }
+
     qemu_mutex_lock(&rs->src_page_req_mutex);
     if (!QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
         struct RAMSrcPageRequest *entry =
-- 
2.17.1
