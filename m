Received: from eggs.gnu.org ([2001:4830:134:3::10]:51527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgpYT-0005lq-Ti
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgpYS-0003EF-W7
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:17 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 23 Feb 2017 17:18:45 +0800
Message-Id: <20170223091845.18523-7-famz@redhat.com>
In-Reply-To: <20170223091845.18523-1-famz@redhat.com>
References: <20170223091845.18523-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] qemu-img: dma map buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

To avoid bounce buffer performance penalty of the NVMe VFIO driver.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index cff22e3..b70a523 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1256,6 +1256,9 @@ static int img_compare(int argc, char **argv)
 
     buf1 = blk_blockalign(blk1, IO_BUF_SIZE);
     buf2 = blk_blockalign(blk2, IO_BUF_SIZE);
+
+    blk_dma_map(blk1, buf1, IO_BUF_SIZE);
+    blk_dma_map(blk2, buf2, IO_BUF_SIZE);
     total_sectors1 = blk_nb_sectors(blk1);
     if (total_sectors1 < 0) {
         error_report("Can't get size of %s: %s",
@@ -1431,6 +1434,8 @@ static int img_compare(int argc, char **argv)
     ret = 0;
 
 out:
+    blk_dma_unmap(blk1, buf1);
+    blk_dma_unmap(blk2, buf2);
     qemu_vfree(buf1);
     qemu_vfree(buf2);
     blk_unref(blk2);
@@ -1684,6 +1689,8 @@ static int convert_do_copy(ImgConvertState *s)
     }
     buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
 
+    blk_dma_map(s->target, buf, s->buf_sectors * BDRV_SECTOR_SIZE);
+
     /* Calculate allocated sectors for progress */
     s->allocated_sectors = 0;
     sector_num = 0;
@@ -1754,6 +1761,7 @@ static int convert_do_copy(ImgConvertState *s)
 
     ret = 0;
 fail:
+    blk_dma_unmap(s->target, buf);
     qemu_vfree(buf);
     return ret;
 }
@@ -3009,6 +3017,9 @@ static int img_rebase(int argc, char **argv)
         buf_old = blk_blockalign(blk, IO_BUF_SIZE);
         buf_new = blk_blockalign(blk, IO_BUF_SIZE);
 
+        blk_dma_map(blk, buf_old, IO_BUF_SIZE);
+        blk_dma_map(blk, buf_new, IO_BUF_SIZE);
+
         num_sectors = blk_nb_sectors(blk);
         if (num_sectors < 0) {
             error_report("Could not get size of '%s': %s",
@@ -3154,6 +3165,8 @@ out:
         blk_unref(blk_old_backing);
         blk_unref(blk_new_backing);
     }
+    blk_dma_unmap(blk, buf_old);
+    blk_dma_unmap(blk, buf_new);
     qemu_vfree(buf_old);
     qemu_vfree(buf_new);
 
@@ -3786,6 +3799,7 @@ static int img_bench(int argc, char **argv)
 
     data.buf = blk_blockalign(blk, data.nrreq * data.bufsize);
     memset(data.buf, pattern, data.nrreq * data.bufsize);
+    blk_dma_map(blk, data.buf, data.nrreq * data.bufsize);
 
     data.qiov = g_new(QEMUIOVector, data.nrreq);
     for (i = 0; i < data.nrreq; i++) {
@@ -3807,6 +3821,7 @@ static int img_bench(int argc, char **argv)
            + ((double)(t2.tv_usec - t1.tv_usec) / 1000000));
 
 out:
+    blk_dma_unmap(blk, data.buf);
     qemu_vfree(data.buf);
     blk_unref(blk);
 
-- 
2.9.3
