Received: from eggs.gnu.org ([2001:4830:134:3::10]:46006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRCJ-0006jN-JS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRCH-0002wD-Hi
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:47 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Mar 2018 17:36:17 +0100
Message-Id: <20180301163619.21072-7-pbonzini@redhat.com>
In-Reply-To: <20180301163619.21072-1-pbonzini@redhat.com>
References: <20180301163619.21072-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 6/8] qed: make bdrv_qed_do_open a coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

It is called from qed_invalidate_cache in coroutine context (incoming
migration runs in a coroutine), so it's cleaner if metadata is always
loaded from a coroutine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1516279431-30424-5-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qed.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index dd31c5046e..d379c8c2f0 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -381,8 +381,9 @@ static void bdrv_qed_init_state(BlockDriverState *bs)
     qemu_co_queue_init(&s->allocating_write_reqs);
 }
 
-static int bdrv_qed_do_open(BlockDriverState *bs, QDict *options, int flags,
-                            Error **errp)
+/* Called with table_lock held.  */
+static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
+                                         int flags, Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
     QEDHeader le_header;
@@ -513,9 +514,35 @@ out:
     return ret;
 }
 
+typedef struct QEDOpenCo {
+    BlockDriverState *bs;
+    QDict *options;
+    int flags;
+    Error **errp;
+    int ret;
+} QEDOpenCo;
+
+static void coroutine_fn bdrv_qed_open_entry(void *opaque)
+{
+    QEDOpenCo *qoc = opaque;
+    BDRVQEDState *s = qoc->bs->opaque;
+
+    qemu_co_mutex_lock(&s->table_lock);
+    qoc->ret = bdrv_qed_do_open(qoc->bs, qoc->options, qoc->flags, qoc->errp);
+    qemu_co_mutex_unlock(&s->table_lock);
+}
+
 static int bdrv_qed_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
+    QEDOpenCo qoc = {
+        .bs = bs,
+        .options = options,
+        .flags = flags,
+        .errp = errp,
+        .ret = -EINPROGRESS
+    };
+
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
     if (!bs->file) {
@@ -523,7 +550,14 @@ static int bdrv_qed_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     bdrv_qed_init_state(bs);
-    return bdrv_qed_do_open(bs, options, flags, errp);
+    if (qemu_in_coroutine()) {
+        bdrv_qed_open_entry(&qoc);
+    } else {
+        qemu_coroutine_enter(qemu_coroutine_create(bdrv_qed_open_entry, &qoc));
+        BDRV_POLL_WHILE(bs, qoc.ret == -EINPROGRESS);
+    }
+    BDRV_POLL_WHILE(bs, qoc.ret == -EINPROGRESS);
+    return qoc.ret;
 }
 
 static void bdrv_qed_refresh_limits(BlockDriverState *bs, Error **errp)
-- 
2.14.3
