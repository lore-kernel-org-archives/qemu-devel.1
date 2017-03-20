Received: from eggs.gnu.org ([2001:4830:134:3::10]:34518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cq1tv-0006Zy-St
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 14:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cq1tu-0007kf-Cw
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 14:19:27 -0400
Received: from mail.kernel.org ([198.145.29.136]:46198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cq1tu-0007kM-3S
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 14:19:26 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 20 Mar 2017 11:19:10 -0700
Message-Id: <1490033952-26735-6-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1490033952-26735-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
	<1490033952-26735-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v4 6/8] xen/9pfs: implement in/out_iov_from_pdu
 and vmarshal/vunmarshal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Implement xen_9pfs_init_in/out_iov_from_pdu and
xen_9pfs_pdu_vmarshal/vunmarshall by creating new sg pointing to the
data on the ring.

This is safe as we only handle one request per ring at any given time.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/xen-9p-backend.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 8222db6..3564452 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -58,12 +58,81 @@ typedef struct Xen9pfsDev {
     Xen9pfsRing *rings;
 } Xen9pfsDev;
 
+static void xen_9pfs_in_sg(Xen9pfsRing *ring,
+                           struct iovec *in_sg,
+                           int *num,
+                           uint32_t idx,
+                           uint32_t size)
+{
+    RING_IDX cons, prod, masked_prod, masked_cons;
+
+    cons = ring->intf->in_cons;
+    prod = ring->intf->in_prod;
+    xen_rmb();
+    masked_prod = xen_9pfs_mask(prod, XEN_FLEX_RING_SIZE(ring->ring_order));
+    masked_cons = xen_9pfs_mask(cons, XEN_FLEX_RING_SIZE(ring->ring_order));
+
+    if (masked_prod < masked_cons) {
+        in_sg[0].iov_base = ring->ring.in + masked_prod;
+        in_sg[0].iov_len = masked_cons - masked_prod;
+        *num = 1;
+    } else {
+        in_sg[0].iov_base = ring->ring.in + masked_prod;
+        in_sg[0].iov_len = XEN_FLEX_RING_SIZE(ring->ring_order) - masked_prod;
+        in_sg[1].iov_base = ring->ring.in;
+        in_sg[1].iov_len = masked_cons;
+        *num = 2;
+    }
+}
+
+static void xen_9pfs_out_sg(Xen9pfsRing *ring,
+                            struct iovec *out_sg,
+                            int *num,
+                            uint32_t idx)
+{
+    RING_IDX cons, prod, masked_prod, masked_cons;
+
+    cons = ring->intf->out_cons;
+    prod = ring->intf->out_prod;
+    xen_rmb();
+    masked_prod = xen_9pfs_mask(prod, XEN_FLEX_RING_SIZE(ring->ring_order));
+    masked_cons = xen_9pfs_mask(cons, XEN_FLEX_RING_SIZE(ring->ring_order));
+
+    if (masked_cons < masked_prod) {
+        out_sg[0].iov_base = ring->ring.out + masked_cons;
+        out_sg[0].iov_len = ring->out_size;
+        *num = 1;
+    } else {
+        if (ring->out_size >
+            (XEN_FLEX_RING_SIZE(ring->ring_order) - masked_cons)) {
+            out_sg[0].iov_base = ring->ring.out + masked_cons;
+            out_sg[0].iov_len = XEN_FLEX_RING_SIZE(ring->ring_order) -
+                                masked_cons;
+            out_sg[1].iov_base = ring->ring.out;
+            out_sg[1].iov_len = ring->out_size -
+                                (XEN_FLEX_RING_SIZE(ring->ring_order) -
+                                 masked_cons);
+            *num = 2;
+        } else {
+            out_sg[0].iov_base = ring->ring.out + masked_cons;
+            out_sg[0].iov_len = ring->out_size;
+            *num = 1;
+        }
+    }
+}
+
 static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
                                      size_t offset,
                                      const char *fmt,
                                      va_list ap)
 {
-    return 0;
+    Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
+    struct iovec in_sg[2];
+    int num;
+
+    xen_9pfs_in_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
+                   in_sg, &num, pdu->idx, ROUND_UP(offset + 128, 512));
+    return v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
 }
 
 static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
@@ -71,13 +140,29 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
                                        const char *fmt,
                                        va_list ap)
 {
-    return 0;
+    Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
+    struct iovec out_sg[2];
+    int num;
+
+    xen_9pfs_out_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
+                    out_sg, &num, pdu->idx);
+    return v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
 }
 
 static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
                                            struct iovec **piov,
                                            unsigned int *pniov)
 {
+    Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
+    Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
+    int num;
+
+    g_free(ring->sg);
+
+    ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
+    xen_9pfs_out_sg(ring, ring->sg, &num, pdu->idx);
+    *piov = ring->sg;
+    *pniov = num;
 }
 
 static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
@@ -85,6 +170,16 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
                                           unsigned int *pniov,
                                           size_t size)
 {
+    Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
+    Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
+    int num;
+
+    g_free(ring->sg);
+
+    ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
+    *piov = ring->sg;
+    *pniov = num;
 }
 
 static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
-- 
1.9.1
