Received: from eggs.gnu.org ([2001:4830:134:3::10]:39164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxuss-0004AL-JE
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusr-0003v5-Oj
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxusr-0003ut-Jj
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:57 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:27 +0800
Message-Id: <20170411122632.14050-7-famz@redhat.com>
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] block: Introduce bdrv_coroutine_enter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               | 5 +++++
 include/block/block.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/block.c b/block.c
index a995a8e..086a12d 100644
--- a/block.c
+++ b/block.c
@@ -4324,6 +4324,11 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
     return bs->aio_context;
 }
 
+void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
+{
+    aio_co_enter(bdrv_get_aio_context(bs), co);
+}
+
 static void bdrv_do_remove_aio_context_notifier(BdrvAioNotifier *ban)
 {
     QLIST_REMOVE(ban, list);
diff --git a/include/block/block.h b/include/block/block.h
index 488a07e..97d4330 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -558,6 +558,11 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
 AioContext *bdrv_get_aio_context(BlockDriverState *bs);
 
 /**
+ * Transfer control to @co in the aio context of @bs
+ */
+void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co);
+
+/**
  * bdrv_set_aio_context:
  *
  * Changes the #AioContext used for fd handlers, timers, and BHs by this
-- 
2.9.3
