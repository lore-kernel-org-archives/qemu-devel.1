Received: from eggs.gnu.org ([2001:4830:134:3::10]:60813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRU-0001rj-JE
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRT-0003J3-Jr
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:10:04 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Mar 2018 19:09:13 +0800
Message-Id: <20180329110914.20888-8-famz@redhat.com>
In-Reply-To: <20180329110914.20888-1-famz@redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 7/8] block-backend: Add blk_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

It's a BlockBackend wrapper of bdrv_co_copy_range.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c          | 8 ++++++++
 include/sysemu/block-backend.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 681b240b12..54b0789282 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2217,3 +2217,11 @@ void blk_unregister_buf(BlockBackend *blk, void *host)
 {
     bdrv_unregister_buf(blk_bs(blk), host);
 }
+
+int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
+                                   BlockBackend *blk_out, int64_t off_out,
+                                   int bytes)
+{
+    return bdrv_co_copy_range(blk_in->root, off_in, blk_out->root, off_out,
+                              bytes);
+}
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 92ab624fac..1fde14b461 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -232,4 +232,8 @@ void blk_set_force_allow_inactivate(BlockBackend *blk);
 void blk_register_buf(BlockBackend *blk, void *host, size_t size);
 void blk_unregister_buf(BlockBackend *blk, void *host);
 
+int blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
+                      BlockBackend *blk_out, int64_t off_out,
+                      int bytes);
+
 #endif
-- 
2.14.3
