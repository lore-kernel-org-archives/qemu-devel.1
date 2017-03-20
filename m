Received: from eggs.gnu.org ([2001:4830:134:3::10]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6RA-0002CT-1N
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qy-0005Kg-Bv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45441
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qx-0005JT-Vy
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8oej008070
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:51 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29afu7a8cx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:51 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:50 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:38 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-75-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 74/81] NetRxPkt: Fix memory corruption on VLAN
 header stripping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>

From: Dmitry Fleytman <dmitry@daynix.com>

This patch fixed a problem that was introduced in commit eb700029.

When net_rx_pkt_attach_iovec() calls eth_strip_vlan()
this can result in pkt->ehdr_buf being overflowed, because
ehdr_buf is only sizeof(struct eth_header) bytes large
but eth_strip_vlan() can write
sizeof(struct eth_header) + sizeof(struct vlan_header)
bytes into it.

Devices affected by this problem: vmxnet3.

Cc: qemu-stable@nongnu.org
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit df8bf7a7fe75eb5d5caffa55f5cd4292b757aea6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/net_rx_pkt.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 1019b50..7c0beac 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -23,13 +23,13 @@
 
 struct NetRxPkt {
     struct virtio_net_hdr virt_hdr;
-    uint8_t ehdr_buf[sizeof(struct eth_header)];
+    uint8_t ehdr_buf[sizeof(struct eth_header) + sizeof(struct vlan_header)];
     struct iovec *vec;
     uint16_t vec_len_total;
     uint16_t vec_len;
     uint32_t tot_len;
     uint16_t tci;
-    bool vlan_stripped;
+    size_t ehdr_buf_len;
     bool has_virt_hdr;
     eth_pkt_types_e packet_type;
 
@@ -88,15 +88,13 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
                         const struct iovec *iov, int iovcnt,
                         size_t ploff)
 {
-    if (pkt->vlan_stripped) {
+    if (pkt->ehdr_buf_len) {
         net_rx_pkt_iovec_realloc(pkt, iovcnt + 1);
 
         pkt->vec[0].iov_base = pkt->ehdr_buf;
-        pkt->vec[0].iov_len = sizeof(pkt->ehdr_buf);
-
-        pkt->tot_len =
-            iov_size(iov, iovcnt) - ploff + sizeof(struct eth_header);
+        pkt->vec[0].iov_len = pkt->ehdr_buf_len;
 
+        pkt->tot_len = iov_size(iov, iovcnt) - ploff + pkt->ehdr_buf_len;
         pkt->vec_len = iov_copy(pkt->vec + 1, pkt->vec_len_total - 1,
                                 iov, iovcnt, ploff, pkt->tot_len);
     } else {
@@ -123,11 +121,12 @@ void net_rx_pkt_attach_iovec(struct NetRxPkt *pkt,
     uint16_t tci = 0;
     uint16_t ploff = iovoff;
     assert(pkt);
-    pkt->vlan_stripped = false;
 
     if (strip_vlan) {
-        pkt->vlan_stripped = eth_strip_vlan(iov, iovcnt, iovoff, pkt->ehdr_buf,
-                                            &ploff, &tci);
+        pkt->ehdr_buf_len = eth_strip_vlan(iov, iovcnt, iovoff, pkt->ehdr_buf,
+                                           &ploff, &tci);
+    } else {
+        pkt->ehdr_buf_len = 0;
     }
 
     pkt->tci = tci;
@@ -143,12 +142,13 @@ void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
     uint16_t tci = 0;
     uint16_t ploff = iovoff;
     assert(pkt);
-    pkt->vlan_stripped = false;
 
     if (strip_vlan) {
-        pkt->vlan_stripped = eth_strip_vlan_ex(iov, iovcnt, iovoff, vet,
-                                               pkt->ehdr_buf,
-                                               &ploff, &tci);
+        pkt->ehdr_buf_len = eth_strip_vlan_ex(iov, iovcnt, iovoff, vet,
+                                              pkt->ehdr_buf,
+                                              &ploff, &tci);
+    } else {
+        pkt->ehdr_buf_len = 0;
     }
 
     pkt->tci = tci;
@@ -162,8 +162,8 @@ void net_rx_pkt_dump(struct NetRxPkt *pkt)
     NetRxPkt *pkt = (NetRxPkt *)pkt;
     assert(pkt);
 
-    printf("RX PKT: tot_len: %d, vlan_stripped: %d, vlan_tag: %d\n",
-              pkt->tot_len, pkt->vlan_stripped, pkt->tci);
+    printf("RX PKT: tot_len: %d, ehdr_buf_len: %lu, vlan_tag: %d\n",
+              pkt->tot_len, pkt->ehdr_buf_len, pkt->tci);
 #endif
 }
 
@@ -426,7 +426,7 @@ bool net_rx_pkt_is_vlan_stripped(struct NetRxPkt *pkt)
 {
     assert(pkt);
 
-    return pkt->vlan_stripped;
+    return pkt->ehdr_buf_len ? true : false;
 }
 
 bool net_rx_pkt_has_virt_hdr(struct NetRxPkt *pkt)
-- 
2.7.4
