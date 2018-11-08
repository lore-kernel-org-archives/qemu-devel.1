Received: from eggs.gnu.org ([2001:4830:134:3::10]:59663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmsb-0005fj-Ef
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmsY-00010m-7R
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:10:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gKmsX-00010M-Tt
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:09:58 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu,  8 Nov 2018 18:08:18 +0200
Message-Id: <20181108160818.5485-23-yuval.shaia@oracle.com>
In-Reply-To: <20181108160818.5485-1-yuval.shaia@oracle.com>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 22/22] rdma: Do not call
 rdma_backend_del_gid on an empty gid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_rm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 35a96d9a64..e3f6b2f6ea 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -555,6 +555,10 @@ int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
 {
     int rc;
 
+    if (!dev_res->port.gid_tbl[gid_idx].gid.global.interface_id) {
+        return 0;
+    }
+
     rc = rdma_backend_del_gid(backend_dev, ifname,
                               &dev_res->port.gid_tbl[gid_idx].gid);
     if (rc < 0) {
-- 
2.17.2
