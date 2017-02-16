Received: from eggs.gnu.org ([2001:4830:134:3::10]:47570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLCB-00030O-Qo
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLCA-0007pU-QG
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:29:59 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ceLCA-0007pI-J7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:29:58 -0500
Received: by mail-wm0-x241.google.com with SMTP id v77so2902748wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:29:58 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Date: Thu, 16 Feb 2017 14:29:32 +0200
Message-Id: <1487248176-29602-2-git-send-email-dmitry@daynix.com>
In-Reply-To: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
Subject: [Qemu-devel] [PATCH 1/5] eth: Extend vlan stripping functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, P J P <ppandit@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>

Make VLAN stripping functions return number of bytes
copied to given Ethernet header buffer.

This information should be used to re-compose
packet IOV after VLAN stripping.

Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
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
