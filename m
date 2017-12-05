Received: from eggs.gnu.org ([2001:4830:134:3::10]:47423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eM8QT-0004Sd-FJ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eM8QS-0006uD-D6
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:18:01 -0500
Received: from chuckie.co.uk ([82.165.15.123]:38192
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eM8QS-0006td-7X
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:18:00 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  5 Dec 2017 08:17:41 +0000
Message-Id: <20171205081744.6563-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 2/5] net: introduce net_crc32_le() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

This provides a standard ethernet CRC32 little-endian implementation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/net/net.h |  2 ++
 net/net.c         | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 586098cb94..4afac1a9dd 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -228,7 +228,9 @@ NetClientState *net_hub_port_find(int hub_id);
 void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
 
 #define POLYNOMIAL_BE 0x04c11db6
+#define POLYNOMIAL_LE 0xedb88320
 uint32_t net_crc32(const uint8_t *p, int len);
+uint32_t net_crc32_le(const uint8_t *p, int len);
 unsigned compute_mcast_idx(const uint8_t *ep);
 
 #define vmstate_offset_macaddr(_state, _field)                       \
diff --git a/net/net.c b/net/net.c
index 02a567c18f..38008fe8e7 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1603,6 +1603,28 @@ uint32_t net_crc32(const uint8_t *p, int len)
     return crc;
 }
 
+uint32_t net_crc32_le(const uint8_t *p, int len)
+{
+    uint32_t crc;
+    int carry, i, j;
+    uint8_t b;
+
+    crc = 0xffffffff;
+    for (i = 0; i < len; i++) {
+        b = *p++;
+        for (j = 0; j < 8; j++) {
+            carry = (crc & 0x1) ^ (b & 0x01);
+            crc >>= 1;
+            b >>= 1;
+            if (carry) {
+                crc = crc ^ POLYNOMIAL_LE;
+            }
+        }
+    }
+
+    return crc;
+}
+
 unsigned compute_mcast_idx(const uint8_t *ep)
 {
     return net_crc32(ep, 6) >> 26;
-- 
2.11.0
