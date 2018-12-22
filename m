Received: from eggs.gnu.org ([2001:4830:134:3::10]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadw3-0006Ls-Qp
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadw0-0006UA-94
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:07 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadw0-0006TI-3H
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id n190so7399864wmd.0
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:04 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:21 +0200
Message-Id: <20181222095036.29743-17-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 16/31] hw/pvrdma: Make device state depend
 on Ethernet function state
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

User should be able to control the device by changing Ethernet function
state so if user runs 'ifconfig ens3 down' the PVRDMA function should be
down as well.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 2979582fac..0d3c818c20 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -139,7 +139,8 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
     resp->hdr.ack = PVRDMA_CMD_QUERY_PORT_RESP;
     resp->hdr.err = 0;
 
-    resp->attrs.state = attrs.state;
+    resp->attrs.state = dev->func0->device_active ? attrs.state :
+                                                    PVRDMA_PORT_DOWN;
     resp->attrs.max_mtu = attrs.max_mtu;
     resp->attrs.active_mtu = attrs.active_mtu;
     resp->attrs.phys_state = attrs.phys_state;
-- 
2.17.1
