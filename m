Received: from eggs.gnu.org ([2001:4830:134:3::10]:36765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnY1-00086T-1U
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnY0-0001YL-6y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:21:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  4 Jun 2018 12:20:34 +0100
Message-Id: <20180604112036.2715-10-stefanha@redhat.com>
In-Reply-To: <20180604112036.2715-1-stefanha@redhat.com>
References: <20180604112036.2715-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] block-backend: Add blk_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fam Zheng <famz@redhat.com>

It's a BlockBackend wrapper of the BDS interface.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180601092648.24614-10-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/block-backend.h |  4 ++++
 block/block-backend.c          | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 92ab624fac..8d03d493c2 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -232,4 +232,8 @@ void blk_set_force_allow_inactivate(BlockBackend *blk);
 void blk_register_buf(BlockBackend *blk, void *host, size_t size);
 void blk_unregister_buf(BlockBackend *blk, void *host);
 
+int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
+                                   BlockBackend *blk_out, int64_t off_out,
+                                   int bytes, BdrvRequestFlags flags);
+
 #endif
diff --git a/block/block-backend.c b/block/block-backend.c
index 89f47b00ea..d55c328736 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2211,3 +2211,21 @@ void blk_unregister_buf(BlockBackend *blk, void *host)
 {
     bdrv_unregister_buf(blk_bs(blk), host);
 }
+
+int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
+                                   BlockBackend *blk_out, int64_t off_out,
+                                   int bytes, BdrvRequestFlags flags)
+{
+    int r;
+    r = blk_check_byte_request(blk_in, off_in, bytes);
+    if (r) {
+        return r;
+    }
+    r = blk_check_byte_request(blk_out, off_out, bytes);
+    if (r) {
+        return r;
+    }
+    return bdrv_co_copy_range(blk_in->root, off_in,
+                              blk_out->root, off_out,
+                              bytes, flags);
+}
-- 
2.17.1
