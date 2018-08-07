Received: from eggs.gnu.org ([2001:4830:134:3::10]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fmy32-0003Hc-V3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fmy31-00059s-Mn
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:13:00 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:39881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fmy31-00059Y-F6
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:12:59 -0400
Received: by mail-pl0-x244.google.com with SMTP id w14-v6so1273406plp.6
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 02:12:59 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue,  7 Aug 2018 17:12:05 +0800
Message-Id: <20180807091209.13531-7-xiaoguangrong@tencent.com>
In-Reply-To: <20180807091209.13531-1-xiaoguangrong@tencent.com>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 06/10] migration: hold the lock only if it
 is really needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Try to hold src_page_req_mutex only if the queue is not
empty

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
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
index d804d01aae..99ecf9b315 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2026,6 +2026,10 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
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
2.14.4
