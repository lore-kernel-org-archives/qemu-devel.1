Received: from eggs.gnu.org ([2001:4830:134:3::10]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dii3p-0006Pq-AW
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dii3m-0006OM-Ju
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:41 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57476
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dii3m-0006Dx-Bk
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:38 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 18 Aug 2017 15:15:05 +0100
Message-Id: <1503065708-28277-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/4] net: move CRC32 calculation from
 compute_mcast_idx() into its own net_crc32() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com

Separate out the standard ethernet CRC32 calculation into a new net_crc32()
function, renaming the constant POLYNOMIAL to POLYNOMIAL_BE to make it clear
that this is a big-endian CRC32 calculation.

Then remove the existing implementation from compute_mcast_idx() and call the
new function in its place.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/net/net.h |    3 ++-
 net/net.c         |   16 +++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 1c55a93..586098c 100644
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
index 0e28099..a856907 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1568,25 +1568,31 @@ int net_client_parse(QemuOptsList *opts_list, const char *optarg)
 
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
+    return net_crc32(ep, 6) >> 26;
 }
 
 QemuOptsList qemu_netdev_opts = {
-- 
1.7.10.4
