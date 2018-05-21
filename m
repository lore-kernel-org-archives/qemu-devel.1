Received: from eggs.gnu.org ([2001:4830:134:3::10]:41735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaQ-0000gO-OH
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaO-0003H8-3U
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fKqaN-0003Fr-S8
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:12 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 21 May 2018 12:34:59 -0700
Message-Id: <1526931304-7289-10-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 10/15] xen: remove other open-coded use of
 libxengnttab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

Now that helpers are available in xen_backend, use them throughout all
Xen PV backends.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony Perard <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/9pfs/xen-9p-backend.c | 32 +++++++++++++++-----------------
 hw/char/xen_console.c    |  9 ++++-----
 hw/net/xen_nic.c         | 33 ++++++++++++++-------------------
 hw/usb/xen-usb.c         | 37 +++++++++++++++++--------------------
 4 files changed, 50 insertions(+), 61 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 95e50c4..6026780 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -331,14 +331,14 @@ static int xen_9pfs_free(struct XenDevice *xendev)
 
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].data != NULL) {
-            xengnttab_unmap(xen_9pdev->xendev.gnttabdev,
-                    xen_9pdev->rings[i].data,
-                    (1 << xen_9pdev->rings[i].ring_order));
+            xen_be_unmap_grant_refs(&xen_9pdev->xendev,
+                                    xen_9pdev->rings[i].data,
+                                    (1 << xen_9pdev->rings[i].ring_order));
         }
         if (xen_9pdev->rings[i].intf != NULL) {
-            xengnttab_unmap(xen_9pdev->xendev.gnttabdev,
-                    xen_9pdev->rings[i].intf,
-                    1);
+            xen_be_unmap_grant_refs(&xen_9pdev->xendev,
+                                    xen_9pdev->rings[i].intf,
+                                    1);
         }
         if (xen_9pdev->rings[i].bh != NULL) {
             qemu_bh_delete(xen_9pdev->rings[i].bh);
@@ -390,11 +390,10 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
         }
         g_free(str);
 
-        xen_9pdev->rings[i].intf =  xengnttab_map_grant_ref(
-                xen_9pdev->xendev.gnttabdev,
-                xen_9pdev->xendev.dom,
-                xen_9pdev->rings[i].ref,
-                PROT_READ | PROT_WRITE);
+        xen_9pdev->rings[i].intf =
+            xen_be_map_grant_ref(&xen_9pdev->xendev,
+                                 xen_9pdev->rings[i].ref,
+                                 PROT_READ | PROT_WRITE);
         if (!xen_9pdev->rings[i].intf) {
             goto out;
         }
@@ -403,12 +402,11 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
             goto out;
         }
         xen_9pdev->rings[i].ring_order = ring_order;
-        xen_9pdev->rings[i].data = xengnttab_map_domain_grant_refs(
-                xen_9pdev->xendev.gnttabdev,
-                (1 << ring_order),
-                xen_9pdev->xendev.dom,
-                xen_9pdev->rings[i].intf->ref,
-                PROT_READ | PROT_WRITE);
+        xen_9pdev->rings[i].data =
+            xen_be_map_grant_refs(&xen_9pdev->xendev,
+                                  xen_9pdev->rings[i].intf->ref,
+                                  (1 << ring_order),
+                                  PROT_READ | PROT_WRITE);
         if (!xen_9pdev->rings[i].data) {
             goto out;
         }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index bdfaa40..8b4b4bf 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -233,12 +233,11 @@ static int con_initialise(struct XenDevice *xendev)
     if (!xendev->dev) {
         xen_pfn_t mfn = con->ring_ref;
         con->sring = xenforeignmemory_map(xen_fmem, con->xendev.dom,
-                                          PROT_READ|PROT_WRITE,
+                                          PROT_READ | PROT_WRITE,
                                           1, &mfn, NULL);
     } else {
-        con->sring = xengnttab_map_grant_ref(xendev->gnttabdev, con->xendev.dom,
-                                             con->ring_ref,
-                                             PROT_READ|PROT_WRITE);
+        con->sring = xen_be_map_grant_ref(xendev, con->ring_ref,
+                                          PROT_READ | PROT_WRITE);
     }
     if (!con->sring)
 	return -1;
@@ -267,7 +266,7 @@ static void con_disconnect(struct XenDevice *xendev)
         if (!xendev->dev) {
             xenforeignmemory_unmap(xen_fmem, con->sring, 1);
         } else {
-            xengnttab_unmap(xendev->gnttabdev, con->sring, 1);
+            xen_be_unmap_grant_ref(xendev, con->sring);
         }
         con->sring = NULL;
     }
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 20c43a6..46a8dbf 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -160,9 +160,8 @@ static void net_tx_packets(struct XenNetDev *netdev)
                           (txreq.flags & NETTXF_more_data)      ? " more_data"      : "",
                           (txreq.flags & NETTXF_extra_info)     ? " extra_info"     : "");
 
-            page = xengnttab_map_grant_ref(netdev->xendev.gnttabdev,
-                                           netdev->xendev.dom,
-                                           txreq.gref, PROT_READ);
+            page = xen_be_map_grant_ref(&netdev->xendev, txreq.gref,
+                                        PROT_READ);
             if (page == NULL) {
                 xen_pv_printf(&netdev->xendev, 0,
                               "error: tx gref dereference failed (%d)\n",
@@ -183,7 +182,7 @@ static void net_tx_packets(struct XenNetDev *netdev)
                 qemu_send_packet(qemu_get_queue(netdev->nic),
                                  page + txreq.offset, txreq.size);
             }
-            xengnttab_unmap(netdev->xendev.gnttabdev, page, 1);
+            xen_be_unmap_grant_ref(&netdev->xendev, page);
             net_tx_response(netdev, &txreq, NETIF_RSP_OKAY);
         }
         if (!netdev->tx_work) {
@@ -254,9 +253,7 @@ static ssize_t net_rx_packet(NetClientState *nc, const uint8_t *buf, size_t size
     memcpy(&rxreq, RING_GET_REQUEST(&netdev->rx_ring, rc), sizeof(rxreq));
     netdev->rx_ring.req_cons = ++rc;
 
-    page = xengnttab_map_grant_ref(netdev->xendev.gnttabdev,
-                                   netdev->xendev.dom,
-                                   rxreq.gref, PROT_WRITE);
+    page = xen_be_map_grant_ref(&netdev->xendev, rxreq.gref, PROT_WRITE);
     if (page == NULL) {
         xen_pv_printf(&netdev->xendev, 0,
                       "error: rx gref dereference failed (%d)\n",
@@ -265,7 +262,7 @@ static ssize_t net_rx_packet(NetClientState *nc, const uint8_t *buf, size_t size
         return -1;
     }
     memcpy(page + NET_IP_ALIGN, buf, size);
-    xengnttab_unmap(netdev->xendev.gnttabdev, page, 1);
+    xen_be_unmap_grant_ref(&netdev->xendev, page);
     net_rx_response(netdev, &rxreq, NETIF_RSP_OKAY, NET_IP_ALIGN, size, 0);
 
     return size;
@@ -338,19 +335,17 @@ static int net_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    netdev->txs = xengnttab_map_grant_ref(netdev->xendev.gnttabdev,
-                                          netdev->xendev.dom,
-                                          netdev->tx_ring_ref,
-                                          PROT_READ | PROT_WRITE);
+    netdev->txs = xen_be_map_grant_ref(&netdev->xendev,
+                                       netdev->tx_ring_ref,
+                                       PROT_READ | PROT_WRITE);
     if (!netdev->txs) {
         return -1;
     }
-    netdev->rxs = xengnttab_map_grant_ref(netdev->xendev.gnttabdev,
-                                          netdev->xendev.dom,
-                                          netdev->rx_ring_ref,
-                                          PROT_READ | PROT_WRITE);
+    netdev->rxs = xen_be_map_grant_ref(&netdev->xendev,
+                                       netdev->rx_ring_ref,
+                                       PROT_READ | PROT_WRITE);
     if (!netdev->rxs) {
-        xengnttab_unmap(netdev->xendev.gnttabdev, netdev->txs, 1);
+        xen_be_unmap_grant_ref(&netdev->xendev, netdev->txs);
         netdev->txs = NULL;
         return -1;
     }
@@ -375,11 +370,11 @@ static void net_disconnect(struct XenDevice *xendev)
     xen_pv_unbind_evtchn(&netdev->xendev);
 
     if (netdev->txs) {
-        xengnttab_unmap(netdev->xendev.gnttabdev, netdev->txs, 1);
+        xen_be_unmap_grant_ref(&netdev->xendev, netdev->txs);
         netdev->txs = NULL;
     }
     if (netdev->rxs) {
-        xengnttab_unmap(netdev->xendev.gnttabdev, netdev->rxs, 1);
+        xen_be_unmap_grant_ref(&netdev->xendev, netdev->rxs);
         netdev->rxs = NULL;
     }
 }
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index b3a90c0..5b2e21e 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -173,8 +173,9 @@ static int usbback_gnttab_map(struct usbback_req *usbback_req)
         for (i = 0; i < usbback_req->nr_buffer_segs; i++) {
             ref[i] = usbback_req->req.seg[i].gref;
         }
-        usbback_req->buffer = xengnttab_map_domain_grant_refs(xendev->gnttabdev,
-            usbback_req->nr_buffer_segs, xendev->dom, ref, prot);
+        usbback_req->buffer =
+            xen_be_map_grant_refs(xendev, ref, usbback_req->nr_buffer_segs,
+                                  prot);
 
         if (!usbback_req->buffer) {
             return -ENOMEM;
@@ -206,8 +207,9 @@ static int usbback_gnttab_map(struct usbback_req *usbback_req)
     for (i = 0; i < usbback_req->nr_extra_segs; i++) {
         ref[i] = usbback_req->req.seg[i + usbback_req->req.nr_buffer_segs].gref;
     }
-    usbback_req->isoc_buffer = xengnttab_map_domain_grant_refs(
-         xendev->gnttabdev, usbback_req->nr_extra_segs, xendev->dom, ref, prot);
+    usbback_req->isoc_buffer =
+        xen_be_map_grant_refs(xendev, ref, usbback_req->nr_extra_segs,
+                              prot);
 
     if (!usbback_req->isoc_buffer) {
         return -ENOMEM;
@@ -291,14 +293,14 @@ static void usbback_do_response(struct usbback_req *usbback_req, int32_t status,
     }
 
     if (usbback_req->buffer) {
-        xengnttab_unmap(xendev->gnttabdev, usbback_req->buffer,
-                        usbback_req->nr_buffer_segs);
+        xen_be_unmap_grant_refs(xendev, usbback_req->buffer,
+                                usbback_req->nr_buffer_segs);
         usbback_req->buffer = NULL;
     }
 
     if (usbback_req->isoc_buffer) {
-        xengnttab_unmap(xendev->gnttabdev, usbback_req->isoc_buffer,
-                        usbback_req->nr_extra_segs);
+        xen_be_unmap_grant_refs(xendev, usbback_req->isoc_buffer,
+                                usbback_req->nr_extra_segs);
         usbback_req->isoc_buffer = NULL;
     }
 
@@ -834,11 +836,11 @@ static void usbback_disconnect(struct XenDevice *xendev)
     xen_pv_unbind_evtchn(xendev);
 
     if (usbif->urb_sring) {
-        xengnttab_unmap(xendev->gnttabdev, usbif->urb_sring, 1);
+        xen_be_unmap_grant_ref(xendev, usbif->urb_sring);
         usbif->urb_sring = NULL;
     }
     if (usbif->conn_sring) {
-        xengnttab_unmap(xendev->gnttabdev, usbif->conn_sring, 1);
+        xen_be_unmap_grant_ref(xendev, usbif->conn_sring);
         usbif->conn_sring = NULL;
     }
 
@@ -877,12 +879,10 @@ static int usbback_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    usbif->urb_sring = xengnttab_map_grant_ref(xendev->gnttabdev, xendev->dom,
-                                               urb_ring_ref,
-                                               PROT_READ | PROT_WRITE);
-    usbif->conn_sring = xengnttab_map_grant_ref(xendev->gnttabdev, xendev->dom,
-                                                conn_ring_ref,
-                                                PROT_READ | PROT_WRITE);
+    usbif->urb_sring = xen_be_map_grant_ref(xendev, urb_ring_ref,
+                                            PROT_READ | PROT_WRITE);
+    usbif->conn_sring = xen_be_map_grant_ref(xendev, conn_ring_ref,
+                                             PROT_READ | PROT_WRITE);
     if (!usbif->urb_sring || !usbif->conn_sring) {
         xen_pv_printf(xendev, 0, "error mapping rings\n");
         usbback_disconnect(xendev);
@@ -1024,10 +1024,7 @@ static void usbback_alloc(struct XenDevice *xendev)
 
     /* max_grants: for each request and for the rings (request and connect). */
     max_grants = USBIF_MAX_SEGMENTS_PER_REQUEST * USB_URB_RING_SIZE + 2;
-    if (xengnttab_set_max_grants(xendev->gnttabdev, max_grants) < 0) {
-        xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
-                      strerror(errno));
-    }
+    xen_be_set_max_grant_refs(xendev, max_grants);
 }
 
 static int usbback_free(struct XenDevice *xendev)
-- 
1.9.1
