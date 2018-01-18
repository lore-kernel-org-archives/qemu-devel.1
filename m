Received: from eggs.gnu.org ([2001:4830:134:3::10]:40041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ec9Y0-0001Et-Nu
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ec9Xz-0004XV-Ac
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:44:00 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Jan 2018 13:43:47 +0100
Message-Id: <1516279431-30424-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] qcow2: make qcow2_do_open a coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

It is called from qcow2_invalidate_cache in coroutine context (incoming
migration runs in a coroutine), so it's cleaner if metadata is always
loaded from a coroutine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index fec065b..7c11516 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1087,8 +1087,9 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
     return ret;
 }
 
-static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
-                         Error **errp)
+/* Called with s->lock held.  */
+static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
+                                      int flags, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int len, i;
@@ -1467,8 +1468,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    /* Initialise locks */
-    qemu_co_mutex_init(&s->lock);
     bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
 
     /* Repair image if dirty */
@@ -1514,16 +1513,53 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
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
1.8.3.1
