Received: from eggs.gnu.org ([2001:4830:134:3::10]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl9q-0007f1-6o
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl9p-0000zN-5U
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:06 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:37 +0800
Message-Id: <1488777954-4578-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 02/19] eth: Extend vlan stripping
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: Dmitry Fleytman <dmitry@daynix.com>

Make VLAN stripping functions return number of bytes
copied to given Ethernet header buffer.

This information should be used to re-compose
packet IOV after VLAN stripping.

Cc: qemu-stable@nongnu.org
Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
