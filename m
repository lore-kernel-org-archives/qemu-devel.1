Received: from eggs.gnu.org ([2001:4830:134:3::10]:58318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc17-00043r-It
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc13-0002zG-KI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUc13-0002yg-Ac
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C4997D0F1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:58:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Jul 2017 18:58:23 +0200
Message-Id: <20170710165827.4250-2-pbonzini@redhat.com>
In-Reply-To: <20170710165827.4250-1-pbonzini@redhat.com>
References: <20170710165827.4250-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] qcow2: make qcow2_do_open a coroutine_fn
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

It is called from qcow2_invalidate_cache in coroutine context, so always
load metadata from a coroutine.
---
 block/qcow2.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index cb081ea47f..b5de67d113 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -814,8 +814,8 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
     return ret;
 }
 
-static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
-                         Error **errp)
+static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
+                                      int flags, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int len, i;
@@ -1161,8 +1161,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    /* Initialise locks */
-    qemu_co_mutex_init(&s->lock);
     bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
 
     /* Repair image if dirty */
@@ -1205,16 +1203,53 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     return ret;
 }
 
+typedef struct QCow2OpenCo {
+    BlockDriverState *bs;
+    QDict *options;
+    int flags;
+    Error **errp;
+    int ret;
+} QCow2OpenCo;
+
+static void coroutine_fn qcow2_open_entry(void *opaque)
+{
+    QCow2OpenCo *qoc = opaque;
+    BDRVQcow2State *s = qoc->bs->opaque;
+
+    qemu_co_mutex_lock(&s->lock);
+    qoc->ret = qcow2_do_open(qoc->bs, qoc->options, qoc->flags, qoc->errp);
+    qemu_co_mutex_unlock(&s->lock);
+}
+
 static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
+    BDRVQcow2State *s = bs->opaque;
+    QCow2OpenCo qoc = {
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
         return -EINVAL;
     }
 
-    return qcow2_do_open(bs, options, flags, errp);
+    /* Initialise locks */
+    qemu_co_mutex_init(&s->lock);
+
+    if (qemu_in_coroutine()) {
+        /* From bdrv_co_create.  */
+        qcow2_open_entry(&qoc);
+    } else {
+        qemu_coroutine_enter(qemu_coroutine_create(qcow2_open_entry, &qoc));
+        BDRV_POLL_WHILE(bs, qoc.ret == -EINPROGRESS);
+    }
+    return qoc.ret;
 }
 
 static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
-- 
2.13.0
