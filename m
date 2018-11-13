Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gMSvu-0005Qk-Ow
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gMSvr-00057P-0V
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:16:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gMSvq-00056l-N0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:16:18 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Tue, 13 Nov 2018 09:13:34 +0200
Message-Id: <20181113071336.6242-46-yuval.shaia@oracle.com>
In-Reply-To: <20181113071336.6242-1-yuval.shaia@oracle.com>
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v3 21/23] hw/rdma: Do not use
 bitmap_zero_extend to free bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

bitmap_zero_extend is designed to work for extending, not for
shrinking.
Using g_free instead.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 0a5ab8935a..35a96d9a64 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -43,7 +43,7 @@ static inline void res_tbl_free(RdmaRmResTbl *tbl)
 {
     qemu_mutex_destroy(&tbl->lock);
     g_free(tbl->tbl);
-    bitmap_zero_extend(tbl->bitmap, tbl->tbl_sz, 0);
+    g_free(tbl->bitmap);
 }
 
 static inline void *res_tbl_get(RdmaRmResTbl *tbl, uint32_t handle)
-- 
2.17.2
