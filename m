Received: from eggs.gnu.org ([2001:4830:134:3::10]:45962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRCI-0006ig-M7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRCG-0002vB-Lz
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:46 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Mar 2018 17:36:16 +0100
Message-Id: <20180301163619.21072-6-pbonzini@redhat.com>
In-Reply-To: <20180301163619.21072-1-pbonzini@redhat.com>
References: <20180301163619.21072-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/8] qcow2: make qcow2_do_open a coroutine_fn
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

It is called from qcow2_invalidate_cache in coroutine context (incoming
migration runs in a coroutine), so it's cleaner if metadata is always
loaded from a coroutine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1516279431-30424-4-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4c216ecd63..b5410c5b00 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1097,8 +1097,9 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
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
@@ -1477,8 +1478,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    /* Initialise locks */
-    qemu_co_mutex_init(&s->lock);
     bs->supported_zero_flags = header.version >= 3 ? BDRV_REQ_MAY_UNMAP : 0;
 
     /* Repair image if dirty */
@@ -1524,16 +1523,53 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
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
2.14.3
