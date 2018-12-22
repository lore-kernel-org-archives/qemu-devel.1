Received: from eggs.gnu.org ([2001:4830:134:3::10]:41796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006Zb-D1
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwI-0006hn-PW
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadwE-0006Zw-R6
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:19 -0500
Received: by mail-wm1-x344.google.com with SMTP id p6so7872086wmc.1
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:13 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:28 +0200
Message-Id: <20181222095036.29743-24-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 23/31] hw/rdma: Do not call
 rdma_backend_del_gid on an empty gid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Yuval Shaia <yuval.shaia@oracle.com>

When device goes down the function fini_ports loops over all entries in
gid table regardless of the fact whether entry is valid or not. In case
that entry is not valid we'd like to skip from any further processing in
backend device.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
2.17.1
