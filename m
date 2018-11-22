Received: from eggs.gnu.org ([208.118.235.92]:55100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gPntc-0000O3-07
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gPnsx-0000ib-7F
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:15:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gPnsw-0000hW-Uj
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:15:07 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 22 Nov 2018 14:13:53 +0200
Message-Id: <20181122121402.13764-16-yuval.shaia@oracle.com>
In-Reply-To: <20181122121402.13764-1-yuval.shaia@oracle.com>
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v5 15/24] hw/pvrdma: Make device state depend
 on Ethernet function state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

User should be able to control the device by changing Ethernet function
state so if user runs 'ifconfig ens3 down' the PVRDMA function should be
down as well.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
2.17.2
