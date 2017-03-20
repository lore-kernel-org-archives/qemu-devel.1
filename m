Received: from eggs.gnu.org ([2001:4830:134:3::10]:41906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R6-00027d-Lr
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qv-0005He-VR
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40008
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qv-0005GV-OG
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8btF119572
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:49 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ajfe8nwh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:49 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:48 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:37 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-74-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 73/81] eth: Extend vlan stripping functions
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

Make VLAN stripping functions return number of bytes
copied to given Ethernet header buffer.

This information should be used to re-compose
packet IOV after VLAN stripping.

Cc: qemu-stable@nongnu.org
Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 566342c3125ac2e73abd36c650222318164517ed)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/net/eth.h |  4 ++--
 net/eth.c         | 25 ++++++++++++++-----------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 2013175..afeb45b 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -331,12 +331,12 @@ eth_get_pkt_tci(const void *p)
     }
 }
 
-bool
+size_t
 eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
                uint8_t *new_ehdr_buf,
                uint16_t *payload_offset, uint16_t *tci);
 
-bool
+size_t
 eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
                   uint16_t vet, uint8_t *new_ehdr_buf,
                   uint16_t *payload_offset, uint16_t *tci);
diff --git a/net/eth.c b/net/eth.c
index df81efb..5b9ba26 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -232,7 +232,7 @@ void eth_get_protocols(const struct iovec *iov, int iovcnt,
     }
 }
 
-bool
+size_t
 eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
                uint8_t *new_ehdr_buf,
                uint16_t *payload_offset, uint16_t *tci)
@@ -244,7 +244,7 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
                                new_ehdr, sizeof(*new_ehdr));
 
     if (copied < sizeof(*new_ehdr)) {
-        return false;
+        return 0;
     }
 
     switch (be16_to_cpu(new_ehdr->h_proto)) {
@@ -254,7 +254,7 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
                             &vlan_hdr, sizeof(vlan_hdr));
 
         if (copied < sizeof(vlan_hdr)) {
-            return false;
+            return 0;
         }
 
         new_ehdr->h_proto = vlan_hdr.h_proto;
@@ -268,18 +268,21 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
                                 PKT_GET_VLAN_HDR(new_ehdr), sizeof(vlan_hdr));
 
             if (copied < sizeof(vlan_hdr)) {
-                return false;
+                return 0;
             }
 
             *payload_offset += sizeof(vlan_hdr);
+
+            return sizeof(struct eth_header) + sizeof(struct vlan_header);
+        } else {
+            return sizeof(struct eth_header);
         }
-        return true;
     default:
-        return false;
+        return 0;
     }
 }
 
-bool
+size_t
 eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
                   uint16_t vet, uint8_t *new_ehdr_buf,
                   uint16_t *payload_offset, uint16_t *tci)
@@ -291,7 +294,7 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
                                new_ehdr, sizeof(*new_ehdr));
 
     if (copied < sizeof(*new_ehdr)) {
-        return false;
+        return 0;
     }
 
     if (be16_to_cpu(new_ehdr->h_proto) == vet) {
@@ -299,17 +302,17 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
                             &vlan_hdr, sizeof(vlan_hdr));
 
         if (copied < sizeof(vlan_hdr)) {
-            return false;
+            return 0;
         }
 
         new_ehdr->h_proto = vlan_hdr.h_proto;
 
         *tci = be16_to_cpu(vlan_hdr.h_tci);
         *payload_offset = iovoff + sizeof(*new_ehdr) + sizeof(vlan_hdr);
-        return true;
+        return sizeof(struct eth_header);
     }
 
-    return false;
+    return 0;
 }
 
 void
-- 
2.7.4
