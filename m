Received: from eggs.gnu.org ([2001:4830:134:3::10]:48952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUJ-0005oI-My
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUI-0001Qg-TP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:03 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Jun 2017 15:27:46 +0200
Message-Id: <20170629132749.997-9-pbonzini@redhat.com>
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
References: <20170629132749.997-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/11] qed: introduce bdrv_qed_init_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

This will be used in the next patch, which will call bdrv_qed_do_open
with a CoMutex taken.  bdrv_qed_init_state provides a nice place to
initialize it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        RFC->v2: new

 block/qed.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index db390efdbd..8228a50f68 100644
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
 
@@ -1461,7 +1468,7 @@ static void bdrv_qed_invalidate_cache(BlockDriverState *bs, Error **errp)
 
     bdrv_qed_close(bs);
 
-    memset(s, 0, sizeof(BDRVQEDState));
+    bdrv_qed_init_state(bs);
     ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.13.0
