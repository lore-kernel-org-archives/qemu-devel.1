Received: from eggs.gnu.org ([2001:4830:134:3::10]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1a-0000ns-JE
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1Z-0004cM-OK
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1Z-0004bV-Hl
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:45 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:18 +0800
Message-Id: <20170717034825.1524-9-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] qed: introduce bdrv_qed_init_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This will be used in the next patch, which will call bdrv_qed_do_open
with a CoMutex taken.  bdrv_qed_init_state provides a nice place to
initialize it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170629132749.997-9-pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qed.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 6625320..adcc5c9 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -363,6 +363,15 @@ static void coroutine_fn bdrv_qed_co_drain(BlockDriverState *bs)
     }
 }
 
+static void bdrv_qed_init_state(BlockDriverState *bs)
+{
+    BDRVQEDState *s = bs->opaque;
+
+    memset(s, 0, sizeof(BDRVQEDState));
+    s->bs = bs;
+    qemu_co_queue_init(&s->allocating_write_reqs);
+}
+
 static int bdrv_qed_do_open(BlockDriverState *bs, QDict *options, int flags,
                             Error **errp)
 {
@@ -371,9 +380,6 @@ static int bdrv_qed_do_open(BlockDriverState *bs, QDict *options, int flags,
     int64_t file_size;
     int ret;
 
-    s->bs = bs;
-    qemu_co_queue_init(&s->allocating_write_reqs);
-
     ret = bdrv_pread(bs->file, 0, &le_header, sizeof(le_header));
     if (ret < 0) {
         return ret;
@@ -507,6 +513,7 @@ static int bdrv_qed_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
+    bdrv_qed_init_state(bs);
     return bdrv_qed_do_open(bs, options, flags, errp);
 }
 
@@ -1462,13 +1469,12 @@ static int bdrv_qed_change_backing_file(BlockDriverState *bs,
 
 static void bdrv_qed_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
-    BDRVQEDState *s = bs->opaque;
     Error *local_err = NULL;
     int ret;
 
     bdrv_qed_close(bs);
 
-    memset(s, 0, sizeof(BDRVQEDState));
+    bdrv_qed_init_state(bs);
     ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.9.4
