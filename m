Received: from eggs.gnu.org ([2001:4830:134:3::10]:48176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cZEuW-0004Tk-OI
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cZEuT-00073u-Km
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:46:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cZEuT-00073n-EQ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:46:37 -0500
From: P J P <ppandit@redhat.com>
Date: Thu,  2 Feb 2017 16:16:24 +0530
Message-Id: <20170202104624.13948-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v3] net: imx: limit buffer descriptor count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

i.MX Fast Ethernet Controller uses buffer descriptors to manage
data flow to/fro receive & transmit queues. While transmitting
packets, it could continue to read buffer descriptors if a buffer
descriptor has length of zero and has crafted values in bd.flags.
Set an upper limit to number of buffer descriptors.

Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/net/imx_fec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Patch v2
  -> https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg05554.html
  - Restrict loop in 'imx_enet_do_tx' to IMX_MAX_DESC descriptors.

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 50c7564..90e6ee3 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -55,6 +55,8 @@
         } \
     } while (0)
 
+#define IMX_MAX_DESC    1024
+
 static const char *imx_default_reg_name(IMXFECState *s, uint32_t index)
 {
     static char tmp[20];
@@ -402,12 +404,12 @@ static void imx_eth_update(IMXFECState *s)
 
 static void imx_fec_do_tx(IMXFECState *s)
 {
-    int frame_size = 0;
+    int frame_size = 0, descnt = 0;
     uint8_t frame[ENET_MAX_FRAME_SIZE];
     uint8_t *ptr = frame;
     uint32_t addr = s->tx_descriptor;
 
-    while (1) {
+    while (descnt++ < IMX_MAX_DESC) {
         IMXFECBufDesc bd;
         int len;
 
@@ -453,12 +455,12 @@ static void imx_fec_do_tx(IMXFECState *s)
 
 static void imx_enet_do_tx(IMXFECState *s)
 {
-    int frame_size = 0;
+    int frame_size = 0, descnt = 0;
     uint8_t frame[ENET_MAX_FRAME_SIZE];
     uint8_t *ptr = frame;
     uint32_t addr = s->tx_descriptor;
 
-    while (1) {
+    while (descnt++ < IMX_MAX_DESC) {
         IMXENETBufDesc bd;
         int len;
 
-- 
2.9.3
