Received: from eggs.gnu.org ([2001:4830:134:3::10]:55931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gaLzz-0000y1-Se
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gaLzw-0001BV-J6
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:41:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gaLzw-00012R-2x
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:41:56 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Fri, 21 Dec 2018 16:40:35 +0200
Message-Id: <20181221144037.10290-22-yuval.shaia@oracle.com>
In-Reply-To: <20181221144037.10290-1-yuval.shaia@oracle.com>
References: <20181221144037.10290-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v9 21/23] hw/rdma: Do not use
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
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index b7d4ebe972..ca127c8c26 100644
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
