Received: from eggs.gnu.org ([2001:4830:134:3::10]:55032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZkJ-0003Pa-OC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZkE-0002wy-QY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42184
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQZkE-0002wn-Jv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TDcsuw124619
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:30 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcyr886m4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:29 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 29 Jun 2017 14:44:27 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Jun 2017 15:43:50 +0200
In-Reply-To: <1498743831-28676-1-git-send-email-groug@kaod.org>
References: <1498743831-28676-1-git-send-email-groug@kaod.org>
Message-Id: <1498743831-28676-8-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 7/8] xen-9pfs: disconnect if buffers are
 misconfigured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>, Stefano Stabellini <stefano@aporeto.com>

From: Stefano Stabellini <sstabellini@kernel.org>

Implement xen_9pfs_disconnect by unbinding the event channels. On
xen_9pfs_free, call disconnect if any event channels haven't been
disconnected.

If the frontend misconfigured the buffers set the backend to "Closing"
and disconnect it. Misconfigurations include requesting a read of more
bytes than available on the ring buffer, or claiming to be writing more
data than available on the ring buffer.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/xen-9p-backend.c | 85 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 21 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index a82cf817fe45..ee87f08926a2 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -54,6 +54,8 @@ typedef struct Xen9pfsDev {
     Xen9pfsRing *rings;
 } Xen9pfsDev;
 
+static void xen_9pfs_disconnect(struct XenDevice *xendev);
+
 static void xen_9pfs_in_sg(Xen9pfsRing *ring,
                            struct iovec *in_sg,
                            int *num,
@@ -125,10 +127,19 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     struct iovec in_sg[2];
     int num;
+    ssize_t ret;
 
     xen_9pfs_in_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
                    in_sg, &num, pdu->idx, ROUND_UP(offset + 128, 512));
-    return v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
+
+    ret = v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
+    if (ret < 0) {
+        xen_pv_printf(&xen_9pfs->xendev, 0,
+                      "Failed to encode VirtFS request type %d\n", pdu->id + 1);
+        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
+        xen_9pfs_disconnect(&xen_9pfs->xendev);
+    }
+    return ret;
 }
 
 static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
@@ -139,10 +150,19 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     struct iovec out_sg[2];
     int num;
+    ssize_t ret;
 
     xen_9pfs_out_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
                     out_sg, &num, pdu->idx);
-    return v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
+
+    ret = v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
+    if (ret < 0) {
+        xen_pv_printf(&xen_9pfs->xendev, 0,
+                      "Failed to decode VirtFS request type %d\n", pdu->id);
+        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
+        xen_9pfs_disconnect(&xen_9pfs->xendev);
+    }
+    return ret;
 }
 
 static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
@@ -170,11 +190,22 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
     int num;
+    size_t buf_size;
 
     g_free(ring->sg);
 
     ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
     xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
+
+    buf_size = iov_size(ring->sg, num);
+    if (buf_size  < size) {
+        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
+                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
+                buf_size);
+        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
+        xen_9pfs_disconnect(&xen_9pfs->xendev);
+    }
+
     *piov = ring->sg;
     *pniov = num;
 }
@@ -218,7 +249,7 @@ static int xen_9pfs_init(struct XenDevice *xendev)
 static int xen_9pfs_receive(Xen9pfsRing *ring)
 {
     P9MsgHeader h;
-    RING_IDX cons, prod, masked_prod, masked_cons;
+    RING_IDX cons, prod, masked_prod, masked_cons, queued;
     V9fsPDU *pdu;
 
     if (ring->inprogress) {
@@ -229,8 +260,8 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
     prod = ring->intf->out_prod;
     xen_rmb();
 
-    if (xen_9pfs_queued(prod, cons, XEN_FLEX_RING_SIZE(ring->ring_order)) <
-        sizeof(h)) {
+    queued = xen_9pfs_queued(prod, cons, XEN_FLEX_RING_SIZE(ring->ring_order));
+    if (queued < sizeof(h)) {
         return 0;
     }
     ring->inprogress = true;
@@ -241,6 +272,9 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
     xen_9pfs_read_packet((uint8_t *) &h, ring->ring.out, sizeof(h),
                          masked_prod, &masked_cons,
                          XEN_FLEX_RING_SIZE(ring->ring_order));
+    if (queued < le32_to_cpu(h.size_le)) {
+        return 0;
+    }
 
     /* cannot fail, because we only handle one request per ring at a time */
     pdu = pdu_alloc(&ring->priv->state);
@@ -269,15 +303,30 @@ static void xen_9pfs_evtchn_event(void *opaque)
     qemu_bh_schedule(ring->bh);
 }
 
-static int xen_9pfs_free(struct XenDevice *xendev)
+static void xen_9pfs_disconnect(struct XenDevice *xendev)
 {
+    Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
     int i;
+
+    for (i = 0; i < xen_9pdev->num_rings; i++) {
+        if (xen_9pdev->rings[i].evtchndev != NULL) {
+            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
+                    NULL, NULL, NULL);
+            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev,
+                             xen_9pdev->rings[i].local_port);
+            xen_9pdev->rings[i].evtchndev = NULL;
+        }
+    }
+}
+
+static int xen_9pfs_free(struct XenDevice *xendev)
+{
     Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
+    int i;
 
-    g_free(xen_9pdev->id);
-    g_free(xen_9pdev->tag);
-    g_free(xen_9pdev->path);
-    g_free(xen_9pdev->security_model);
+    if (xen_9pdev->rings[0].evtchndev != NULL) {
+        xen_9pfs_disconnect(xendev);
+    }
 
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].data != NULL) {
@@ -290,16 +339,15 @@ static int xen_9pfs_free(struct XenDevice *xendev)
                     xen_9pdev->rings[i].intf,
                     1);
         }
-        if (xen_9pdev->rings[i].evtchndev > 0) {
-            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
-                    NULL, NULL, NULL);
-            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev,
-                             xen_9pdev->rings[i].local_port);
-        }
         if (xen_9pdev->rings[i].bh != NULL) {
             qemu_bh_delete(xen_9pdev->rings[i].bh);
         }
     }
+
+    g_free(xen_9pdev->id);
+    g_free(xen_9pdev->tag);
+    g_free(xen_9pdev->path);
+    g_free(xen_9pdev->security_model);
     g_free(xen_9pdev->rings);
     return 0;
 }
@@ -423,11 +471,6 @@ static void xen_9pfs_alloc(struct XenDevice *xendev)
     xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
 }
 
-static void xen_9pfs_disconnect(struct XenDevice *xendev)
-{
-    /* Dynamic hotplug of PV filesystems at runtime is not supported. */
-}
-
 struct XenDevOps xen_9pfs_ops = {
     .size       = sizeof(Xen9pfsDev),
     .flags      = DEVOPS_FLAG_NEED_GNTDEV,
-- 
2.7.5
