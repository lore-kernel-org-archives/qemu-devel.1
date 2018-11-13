Received: from eggs.gnu.org ([2001:4830:134:3::10]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gMSvz-0005Sv-3u
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gMSvv-0005AJ-CK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:16:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gMSvu-00059E-TE
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:16:23 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Tue, 13 Nov 2018 09:13:35 +0200
Message-Id: <20181113071336.6242-47-yuval.shaia@oracle.com>
In-Reply-To: <20181113071336.6242-1-yuval.shaia@oracle.com>
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v3 22/23] hw/rdma: Do not call
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
