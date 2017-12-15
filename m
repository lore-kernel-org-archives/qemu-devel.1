Received: from eggs.gnu.org ([2001:4830:134:3::10]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw5-000626-E8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw2-0006iQ-PZ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60817
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePuw2-0006S0-JH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:14 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:44 +0000
Message-Id: <20171215184155.2543-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 02/13] net: introduce net_crc32_le() function
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index a14dc9910c..4ecaf80bd1 100644
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
+                crc ^= POLYNOMIAL_LE;
+            }
+        }
+    }
+
+    return crc;
+}
+
 unsigned compute_mcast_idx(const uint8_t *ep)
 {
     return net_crc32(ep, ETH_ALEN) >> 26;
-- 
2.11.0
