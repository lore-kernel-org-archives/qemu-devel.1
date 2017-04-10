Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxP2i-0006Qe-Qt
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 22:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxP2f-0007Z6-MZ
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 22:27:00 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Apr 2017 10:26:35 +0800
Message-Id: <20170410022636.29925-2-famz@redhat.com>
In-Reply-To: <20170410022636.29925-1-famz@redhat.com>
References: <20170410022636.29925-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] block: Make
 bdrv_parent_drained_begin/end public
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
 block/io.c            |  4 ++--
 include/block/block.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7321dda..9598646 100644
--- a/block/io.c
+++ b/block/io.c
@@ -44,7 +44,7 @@ static void coroutine_fn bdrv_co_do_rw(void *opaque);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int count, BdrvRequestFlags flags);
 
-static void bdrv_parent_drained_begin(BlockDriverState *bs)
+void bdrv_parent_drained_begin(BlockDriverState *bs)
 {
     BdrvChild *c;
 
@@ -55,7 +55,7 @@ static void bdrv_parent_drained_begin(BlockDriverState *bs)
     }
 }
 
-static void bdrv_parent_drained_end(BlockDriverState *bs)
+void bdrv_parent_drained_end(BlockDriverState *bs)
 {
     BdrvChild *c;
 
diff --git a/include/block/block.h b/include/block/block.h
index 3e09222..488a07e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -573,6 +573,22 @@ void bdrv_io_plug(BlockDriverState *bs);
 void bdrv_io_unplug(BlockDriverState *bs);
 
 /**
+ * bdrv_parent_drained_begin:
+ *
+ * Begin a quiesced section of all users of @bs. This is part of
+ * bdrv_drained_begin.
+ */
+void bdrv_parent_drained_begin(BlockDriverState *bs);
+
+/**
+ * bdrv_parent_drained_end:
+ *
+ * End a quiesced section of all users of @bs. This is part of
+ * bdrv_drained_end.
+ */
+void bdrv_parent_drained_end(BlockDriverState *bs);
+
+/**
  * bdrv_drained_begin:
  *
  * Begin a quiesced section for exclusive access to the BDS, by disabling
-- 
2.9.3
