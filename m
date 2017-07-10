Received: from eggs.gnu.org ([2001:4830:134:3::10]:58315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc17-00043n-IH
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc14-000308-SD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUc14-0002zX-Me
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E57680C0F
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:58:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Jul 2017 18:58:24 +0200
Message-Id: <20170710165827.4250-3-pbonzini@redhat.com>
In-Reply-To: <20170710165827.4250-1-pbonzini@redhat.com>
References: <20170710165827.4250-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] qed: make bdrv_qed_do_open a coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kwolf@redhat.com

It is called from bdrv_invalidate_cache in coroutine context, so always
load metadata from a coroutine.
---
 block/qed.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index d43cb55923..3c2867c946 100644
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
2.13.0
