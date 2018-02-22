Received: from eggs.gnu.org ([2001:4830:134:3::10]:33127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eomnf-00060N-Cl
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eomnZ-0003TX-MB
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:04:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eomnZ-0003Sq-GO
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:04:17 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 22 Feb 2018 10:04:13 +0100
Message-Id: <1519290253-23854-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] net: Move the toeplitz functions from
 checksum.h to net_rx_pkt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

The functions are only used in this single .c file, so there is
no need to put all this code in a header that is included from
multiple places.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/net_rx_pkt.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/net/checksum.h | 44 --------------------------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 98a5030..f66beb3 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -48,6 +48,50 @@ struct NetRxPkt {
     eth_l4_hdr_info  l4hdr_info;
 };
 
+typedef struct toeplitz_key_st {
+    uint32_t leftmost_32_bits;
+    uint8_t *next_byte;
+} net_toeplitz_key;
+
+static inline
+void net_toeplitz_key_init(net_toeplitz_key *key, uint8_t *key_bytes)
+{
+    key->leftmost_32_bits = be32_to_cpu(*(uint32_t *)key_bytes);
+    key->next_byte = key_bytes + sizeof(uint32_t);
+}
+
+static inline
+void net_toeplitz_add(uint32_t *result,
+                      uint8_t *input,
+                      uint32_t len,
+                      net_toeplitz_key *key)
+{
+    register uint32_t accumulator = *result;
+    register uint32_t leftmost_32_bits = key->leftmost_32_bits;
+    register uint32_t byte;
+
+    for (byte = 0; byte < len; byte++) {
+        register uint8_t input_byte = input[byte];
+        register uint8_t key_byte = *(key->next_byte++);
+        register uint8_t bit;
+
+        for (bit = 0; bit < 8; bit++) {
+            if (input_byte & (1 << 7)) {
+                accumulator ^= leftmost_32_bits;
+            }
+
+            leftmost_32_bits =
+                (leftmost_32_bits << 1) | ((key_byte & (1 << 7)) >> 7);
+
+            input_byte <<= 1;
+            key_byte <<= 1;
+        }
+    }
+
+    key->leftmost_32_bits = leftmost_32_bits;
+    *result = accumulator;
+}
+
 void net_rx_pkt_init(struct NetRxPkt **pkt, bool has_virt_hdr)
 {
     struct NetRxPkt *p = g_malloc0(sizeof *p);
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 05a0d27..77a56c1 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -59,48 +59,4 @@ uint32_t net_checksum_add_iov(const struct iovec *iov,
                               uint32_t iov_off, uint32_t size,
                               uint32_t csum_offset);
 
-typedef struct toeplitz_key_st {
-    uint32_t leftmost_32_bits;
-    uint8_t *next_byte;
-} net_toeplitz_key;
-
-static inline
-void net_toeplitz_key_init(net_toeplitz_key *key, uint8_t *key_bytes)
-{
-    key->leftmost_32_bits = be32_to_cpu(*(uint32_t *)key_bytes);
-    key->next_byte = key_bytes + sizeof(uint32_t);
-}
-
-static inline
-void net_toeplitz_add(uint32_t *result,
-                      uint8_t *input,
-                      uint32_t len,
-                      net_toeplitz_key *key)
-{
-    register uint32_t accumulator = *result;
-    register uint32_t leftmost_32_bits = key->leftmost_32_bits;
-    register uint32_t byte;
-
-    for (byte = 0; byte < len; byte++) {
-        register uint8_t input_byte = input[byte];
-        register uint8_t key_byte = *(key->next_byte++);
-        register uint8_t bit;
-
-        for (bit = 0; bit < 8; bit++) {
-            if (input_byte & (1 << 7)) {
-                accumulator ^= leftmost_32_bits;
-            }
-
-            leftmost_32_bits =
-                (leftmost_32_bits << 1) | ((key_byte & (1 << 7)) >> 7);
-
-            input_byte <<= 1;
-            key_byte <<= 1;
-        }
-    }
-
-    key->leftmost_32_bits = leftmost_32_bits;
-    *result = accumulator;
-}
-
 #endif /* QEMU_NET_CHECKSUM_H */
-- 
1.8.3.1
