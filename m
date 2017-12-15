Received: from eggs.gnu.org ([2001:4830:134:3::10]:43230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw5-000627-D7
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw2-0006g8-4Q
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60814
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePuw1-0006Oe-Sg
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:14 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:43 +0000
Message-Id: <20171215184155.2543-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 01/13] net: move CRC32 calculation from
 compute_mcast_idx() into its own net_crc32() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

Separate out the standard ethernet CRC32 calculation into a new net_crc32()
function, renaming the constant POLYNOMIAL to POLYNOMIAL_BE to make it clear
that this is a big-endian CRC32 calculation.

As part of the constant rename, remove the duplicate definition of POLYNOMIAL
from eepro100.c and use the new POLYNOMIAL_BE constant instead.

Once this is complete remove the existing CRC32 implementation from
compute_mcast_idx() and call the new net_crc32() function in its place.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/eepro100.c |  4 +---
 include/net/net.h |  3 ++-
 net/net.c         | 16 +++++++++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 1c0def555b..71cddfece4 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -323,8 +323,6 @@ static const uint16_t eepro100_mdi_mask[] = {
     0xffff, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
 
-#define POLYNOMIAL 0x04c11db6
-
 static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s);
 
 /* From FreeBSD (locally modified). */
@@ -342,7 +340,7 @@ static unsigned e100_compute_mcast_idx(const uint8_t *ep)
             crc <<= 1;
             b >>= 1;
             if (carry) {
-                crc = ((crc ^ POLYNOMIAL) | carry);
+                crc = ((crc ^ POLYNOMIAL_BE) | carry);
             }
         }
     }
diff --git a/include/net/net.h b/include/net/net.h
index 1c55a93588..586098cb94 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -227,7 +227,8 @@ NetClientState *net_hub_port_find(int hub_id);
 
 void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
 
-#define POLYNOMIAL 0x04c11db6
+#define POLYNOMIAL_BE 0x04c11db6
+uint32_t net_crc32(const uint8_t *p, int len);
 unsigned compute_mcast_idx(const uint8_t *ep);
 
 #define vmstate_offset_macaddr(_state, _field)                       \
diff --git a/net/net.c b/net/net.c
index 39ef546708..a14dc9910c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1581,25 +1581,31 @@ int net_client_parse(QemuOptsList *opts_list, const char *optarg)
 
 /* From FreeBSD */
 /* XXX: optimize */
-unsigned compute_mcast_idx(const uint8_t *ep)
+uint32_t net_crc32(const uint8_t *p, int len)
 {
     uint32_t crc;
     int carry, i, j;
     uint8_t b;
 
     crc = 0xffffffff;
-    for (i = 0; i < 6; i++) {
-        b = *ep++;
+    for (i = 0; i < len; i++) {
+        b = *p++;
         for (j = 0; j < 8; j++) {
             carry = ((crc & 0x80000000L) ? 1 : 0) ^ (b & 0x01);
             crc <<= 1;
             b >>= 1;
             if (carry) {
-                crc = ((crc ^ POLYNOMIAL) | carry);
+                crc = ((crc ^ POLYNOMIAL_BE) | carry);
             }
         }
     }
-    return crc >> 26;
+
+    return crc;
+}
+
+unsigned compute_mcast_idx(const uint8_t *ep)
+{
+    return net_crc32(ep, ETH_ALEN) >> 26;
 }
 
 QemuOptsList qemu_netdev_opts = {
-- 
2.11.0
