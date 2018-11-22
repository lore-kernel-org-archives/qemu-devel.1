Received: from eggs.gnu.org ([208.118.235.92]:55198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gPntc-0000RX-48
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gPntX-00029q-CA
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:15:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gPntU-0001ZV-0j
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:15:40 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 22 Nov 2018 14:14:01 +0200
Message-Id: <20181122121402.13764-24-yuval.shaia@oracle.com>
In-Reply-To: <20181122121402.13764-1-yuval.shaia@oracle.com>
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v5 23/24] hw/pvrdma: Do not clean resources on
 shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

All resources are already cleaned at rm_fini phase.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 6a1e39d4c0..8ab25e94b1 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -1075,28 +1075,9 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
 
 static void mad_stop(RdmaBackendDev *backend_dev)
 {
-    QObject *o_ctx_id;
-    unsigned long cqe_ctx_id;
-    BackendCtx *bctx;
-
-    pr_dbg("Closing MAD\n");
+    pr_dbg("Stopping MAD\n");
 
     disable_rdmacm_mux_async(backend_dev);
-
-    /* Clear MAD buffers list */
-    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
-    do {
-        o_ctx_id = qlist_pop(backend_dev->recv_mads_list.list);
-        if (o_ctx_id) {
-            cqe_ctx_id = qnum_get_uint(qobject_to(QNum, o_ctx_id));
-            bctx = rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
-            if (bctx) {
-                rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
-                g_free(bctx);
-            }
-        }
-    } while (o_ctx_id);
-    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
 }
 
 static void mad_fini(RdmaBackendDev *backend_dev)
-- 
2.17.2
