Received: from eggs.gnu.org ([2001:4830:134:3::10]:55894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gaLzz-0000xB-4V
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gaLzv-0001A9-V9
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:41:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gaLzv-000103-Ip
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:41:55 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Fri, 21 Dec 2018 16:40:36 +0200
Message-Id: <20181221144037.10290-23-yuval.shaia@oracle.com>
In-Reply-To: <20181221144037.10290-1-yuval.shaia@oracle.com>
References: <20181221144037.10290-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v9 22/23] hw/rdma: Do not call
 rdma_backend_del_gid on an empty gid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

When device goes down the function fini_ports loops over all entries in
gid table regardless of the fact whether entry is valid or not. In case
that entry is not valid we'd like to skip from any further processing in
backend device.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index ca127c8c26..f5b1295890 100644
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
     if (rc) {
-- 
2.17.2
