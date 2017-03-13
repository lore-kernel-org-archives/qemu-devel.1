Received: from eggs.gnu.org ([2001:4830:134:3::10]:54129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZp4-0000P1-S6
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZp4-0004pv-1t
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:18 -0400
Received: from mail.kernel.org ([198.145.29.136]:46884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cnZp3-0004pT-S3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:17 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 13 Mar 2017 16:55:59 -0700
Message-Id: <1489449360-14411-8-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1489449360-14411-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v2 8/9] xen/9pfs: send responses back to the
 frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, anthony.perard@citrix.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Once a request is completed, xen_9pfs_push_and_notify gets called. In
xen_9pfs_push_and_notify, update the indexes (data has already been
copied to the sg by the common code) and send a notification to the
frontend.

Schedule the bottom-half to check if we already have any other requests
pending.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/xen-9p-backend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index d72a749..fed369f 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -166,6 +166,22 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
 
 static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
 {
+    RING_IDX prod;
+    struct Xen9pfsDev *priv = container_of(pdu->s, struct Xen9pfsDev, state);
+    struct Xen9pfsRing *ring = &priv->rings[pdu->tag % priv->num_rings];
+
+    ring->intf->out_cons = ring->out_cons;
+    xen_wmb();
+
+    prod = ring->intf->in_prod;
+    xen_rmb();
+    ring->intf->in_prod = prod + pdu->size;
+    xen_wmb();
+
+    ring->inprogress = false;
+    xenevtchn_notify(ring->evtchndev, ring->local_port);
+
+    qemu_bh_schedule(ring->bh);
 }
 
 static const struct V9fsTransport xen_9p_transport = {
-- 
1.9.1
