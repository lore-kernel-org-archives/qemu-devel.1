Received: from eggs.gnu.org ([2001:4830:134:3::10]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3c-0004D2-HU
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3b-00069G-JW
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dEA3b-00068u-DF
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 May 2017 15:52:30 +0800
Message-Id: <20170526075246.20265-7-famz@redhat.com>
In-Reply-To: <20170526075246.20265-1-famz@redhat.com>
References: <20170526075246.20265-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 06/22] block: access quiesce_counter with atomic
 ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170525163225.29954-3-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 4 ++--
 include/block/block_int.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 80a3a8c..7d31946 100644
--- a/block/io.c
+++ b/block/io.c
@@ -240,7 +240,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
         return;
     }
 
-    if (!bs->quiesce_counter++) {
+    if (atomic_fetch_inc(&bs->quiesce_counter) == 0) {
         aio_disable_external(bdrv_get_aio_context(bs));
         bdrv_parent_drained_begin(bs);
     }
@@ -251,7 +251,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
 void bdrv_drained_end(BlockDriverState *bs)
 {
     assert(bs->quiesce_counter > 0);
-    if (--bs->quiesce_counter > 0) {
+    if (atomic_fetch_dec(&bs->quiesce_counter) > 1) {
         return;
     }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index c71492a..4af44df 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -637,6 +637,7 @@ struct BlockDriverState {
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
+    /* Accessed with atomic ops.  */
     int quiesce_counter;
 };
 
-- 
2.9.4
