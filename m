Received: from eggs.gnu.org ([2001:4830:134:3::10]:46564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDz-0007g9-LS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDy-0001Dd-RQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:27 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmDy-0001DS-Ks
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:26 -0400
Received: by mail-pl0-x243.google.com with SMTP id n10-v6so19388158plp.0
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:26 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:15 +0800
Message-Id: <20180604095520.8563-8-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 07/12] migration: hold the lock only if it is
 really needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Try to hold src_page_req_mutex only if the queue is not
empty

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
index 15b20d3f70..f9a8646520 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1550,6 +1550,10 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
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
