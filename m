Received: from eggs.gnu.org ([2001:4830:134:3::10]:44865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobbJ-00026F-Pz
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobbI-0003J3-Jn
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:21 -0400
Received: from mail.kernel.org ([198.145.29.136]:45954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cobbI-0003In-DI
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:20 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 16 Mar 2017 13:01:55 -0700
Message-Id: <1489694518-16978-6-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1489694518-16978-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v3 6/9] xen/9pfs: receive requests from the
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
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, jgross@suse.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Upon receiving an event channel notification from the frontend, schedule
the bottom half. From the bottom half, read one request from the ring,
create a pdu and call pdu_submit to handle it.

For now, only handle one request per ring at a time.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/xen-9p-backend.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 3fd20ff..f757591 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -104,12 +104,60 @@ static int xen_9pfs_init(struct XenDevice *xendev)
     return 0;
 }
 
+static int xen_9pfs_receive(Xen9pfsRing *ring)
+{
+    P9MsgHeader h;
+    RING_IDX cons, prod, masked_prod, masked_cons;
+    V9fsPDU *pdu;
+
+    if (ring->inprogress) {
+        return 0;
+    }
+
+    cons = ring->intf->out_cons;
+    prod = ring->intf->out_prod;
+    xen_rmb();
+
+    if (xen_9pfs_queued(prod, cons, XEN_9PFS_RING_SIZE) < sizeof(h)) {
+        return 0;
+    }
+    ring->inprogress = true;
+
+    masked_prod = xen_9pfs_mask(prod, XEN_9PFS_RING_SIZE);
+    masked_cons = xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
+
+    xen_9pfs_read_packet(ring->ring.out, masked_prod, &masked_cons,
+                         XEN_9PFS_RING_SIZE, (uint8_t *) &h, sizeof(h));
+
+    /* cannot fail, because we only handle one request per ring at a time */
+    pdu = pdu_alloc(&ring->priv->state);
+    pdu->size = le32_to_cpu(h.size_le);
+    pdu->id = h.id;
+    pdu->tag = le32_to_cpu(h.tag_le);
+    ring->out_size = le32_to_cpu(h.size_le);
+    ring->out_cons = cons + le32_to_cpu(h.size_le);
+
+    qemu_co_queue_init(&pdu->complete);
+    pdu_submit(pdu);
+
+    return 0;
+}
+
 static void xen_9pfs_bh(void *opaque)
 {
+    Xen9pfsRing *ring = opaque;
+    xen_9pfs_receive(ring);
 }
 
 static void xen_9pfs_evtchn_event(void *opaque)
 {
+    Xen9pfsRing *ring = opaque;
+    evtchn_port_t port;
+
+    port = xenevtchn_pending(ring->evtchndev);
+    xenevtchn_unmask(ring->evtchndev, port);
+
+    qemu_bh_schedule(ring->bh);
 }
 
 static int xen_9pfs_free(struct XenDevice *xendev)
-- 
1.9.1
