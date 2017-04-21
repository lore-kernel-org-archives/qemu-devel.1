Received: from eggs.gnu.org ([2001:4830:134:3::10]:35717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exq-0004EC-St
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exp-0002jf-OA
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:34 -0400
Received: from mail.kernel.org ([198.145.29.136]:43086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d1exp-0002jK-Ip
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:33 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri, 21 Apr 2017 13:14:57 -0700
Message-Id: <1492805702-19690-16-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1492805702-19690-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<1492805702-19690-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 16/21] xen/9pfs: send responses back to the
 frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

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
 hw/9pfs/xen-9p-backend.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 0c1dd5e..7e962aa 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -183,6 +183,25 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
 
 static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
 {
+    RING_IDX prod;
+    Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);
+    Xen9pfsRing *ring = &priv->rings[pdu->tag % priv->num_rings];
+
+    g_free(ring->sg);
+    ring->sg = NULL;
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
