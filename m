Received: from eggs.gnu.org ([2001:4830:134:3::10]:34544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxaty-0003nt-QU
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxatx-0002GA-SX
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:06:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Apr 2017 23:05:38 +0800
Message-Id: <20170410150542.30376-7-famz@redhat.com>
In-Reply-To: <20170410150542.30376-1-famz@redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9 v3 06/10] block: Introduce
 bdrv_coroutine_enter and *_if_inactive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c               | 10 ++++++++++
 include/block/block.h | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/block.c b/block.c
index a995a8e..e65b906 100644
--- a/block.c
+++ b/block.c
@@ -4324,6 +4324,16 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
     return bs->aio_context;
 }
 
+void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
+{
+    aio_co_enter(bdrv_get_aio_context(bs), co);
+}
+
+void bdrv_coroutine_enter_if_inactive(BlockDriverState *bs, Coroutine *co)
+{
+    aio_co_enter_if_inactive(bdrv_get_aio_context(bs), co);
+}
+
 static void bdrv_do_remove_aio_context_notifier(BdrvAioNotifier *ban)
 {
     QLIST_REMOVE(ban, list);
diff --git a/include/block/block.h b/include/block/block.h
index 488a07e..dd9416e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -558,6 +558,17 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
 AioContext *bdrv_get_aio_context(BlockDriverState *bs);
 
 /**
+ * Transfer control to @co in the aio context of @bs
+ */
+void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co);
+
+/**
+ * Transfer control to @co in the aio context of @bs if it's not active (i.e.
+ * part of the call stack of the running coroutine). Otherwise, do nothing.
+ */
+void bdrv_coroutine_enter_if_inactive(BlockDriverState *bs, Coroutine *co);
+
+/**
  * bdrv_set_aio_context:
  *
  * Changes the #AioContext used for fd handlers, timers, and BHs by this
-- 
2.9.3
