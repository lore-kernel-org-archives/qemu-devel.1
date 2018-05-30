Received: from eggs.gnu.org ([2001:4830:134:3::10]:58464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuQN-00022H-9R
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuQK-0001Cc-29
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:31 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:58092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNuQJ-0001CA-Su
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:28 -0400
Received: from player718.ha.ovh.net (unknown [10.109.108.84])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7DA0DC3341
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:17:26 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:17:08 +0200
Message-Id: <20180530061711.23673-2-clg@kaod.org>
In-Reply-To: <20180530061711.23673-1-clg@kaod.org>
References: <20180530061711.23673-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] ftgmac100: compute maximum frame size
 depending on the protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The maximum frame size includes the CRC and depends if a VLAN tag is
inserted or not. Adjust the frame size limit in the transmit handler
using on the FTGMAC100State buffer size and in the receive handler use
the packet protocol.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/hw/net/ftgmac100.h |  7 ++++++-
 hw/net/ftgmac100.c         | 23 ++++++++++++-----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index d9bc589fbf72..94cfe0533297 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -16,6 +16,11 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
=20
+/*
+ * Max frame size for the receiving buffer
+ */
+#define FTGMAC100_MAX_FRAME_SIZE    9220
+
 typedef struct FTGMAC100State {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -26,7 +31,7 @@ typedef struct FTGMAC100State {
     qemu_irq irq;
     MemoryRegion iomem;
=20
-    uint8_t *frame;
+    uint8_t frame[FTGMAC100_MAX_FRAME_SIZE];
=20
     uint32_t irq_state;
     uint32_t isr;
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 3300e8ef4a80..425ac36cff87 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -207,16 +207,18 @@ typedef struct {
 /*
  * Max frame size for the receiving buffer
  */
-#define FTGMAC100_MAX_FRAME_SIZE    10240
+#define FTGMAC100_MAX_FRAME_SIZE    9220
=20
 /* Limits depending on the type of the frame
  *
  *   9216 for Jumbo frames (+ 4 for VLAN)
  *   1518 for other frames (+ 4 for VLAN)
  */
-static int ftgmac100_max_frame_size(FTGMAC100State *s)
+static int ftgmac100_max_frame_size(FTGMAC100State *s, uint16_t proto)
 {
-    return (s->maccr & FTGMAC100_MACCR_JUMBO_LF ? 9216 : 1518) + 4;
+    int max =3D (s->maccr & FTGMAC100_MACCR_JUMBO_LF ? 9216 : 1518);
+
+    return max + (proto =3D=3D ETH_P_VLAN ? 4 : 0);
 }
=20
 static void ftgmac100_update_irq(FTGMAC100State *s)
@@ -408,7 +410,6 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32=
_t tx_ring,
     uint8_t *ptr =3D s->frame;
     uint32_t addr =3D tx_descriptor;
     uint32_t flags =3D 0;
-    int max_frame_size =3D ftgmac100_max_frame_size(s);
=20
     while (1) {
         FTGMAC100Desc bd;
@@ -427,11 +428,12 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint=
32_t tx_ring,
             flags =3D bd.des1;
         }
=20
-        len =3D bd.des0 & 0x3FFF;
-        if (frame_size + len > max_frame_size) {
+        len =3D FTGMAC100_TXDES0_TXBUF_SIZE(bd.des0);
+        if (frame_size + len > sizeof(s->frame)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes=
\n",
                           __func__, len);
-            len =3D max_frame_size - frame_size;
+            s->isr |=3D FTGMAC100_INT_XPKT_LOST;
+            len =3D  sizeof(s->frame) - frame_size;
         }
=20
         if (dma_memory_read(&address_space_memory, bd.des3, ptr, len)) {
@@ -788,7 +790,8 @@ static ssize_t ftgmac100_receive(NetClientState *nc, =
const uint8_t *buf,
     uint32_t buf_len;
     size_t size =3D len;
     uint32_t first =3D FTGMAC100_RXDES0_FRS;
-    int max_frame_size =3D ftgmac100_max_frame_size(s);
+    uint16_t proto =3D be16_to_cpu(PKT_GET_ETH_HDR(buf)->h_proto);
+    int max_frame_size =3D ftgmac100_max_frame_size(s, proto);
=20
     if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN=
))
          !=3D (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN)) {
@@ -820,9 +823,9 @@ static ssize_t ftgmac100_receive(NetClientState *nc, =
const uint8_t *buf,
=20
     /* Huge frames are truncated.  */
     if (size > max_frame_size) {
-        size =3D max_frame_size;
         qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %zd bytes\n"=
,
                       __func__, size);
+        size =3D max_frame_size;
         flags |=3D FTGMAC100_RXDES0_FTL;
     }
=20
@@ -940,8 +943,6 @@ static void ftgmac100_realize(DeviceState *dev, Error=
 **errp)
                           object_get_typename(OBJECT(dev)), DEVICE(dev)-=
>id,
                           s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-
-    s->frame =3D g_malloc(FTGMAC100_MAX_FRAME_SIZE);
 }
=20
 static const VMStateDescription vmstate_ftgmac100 =3D {
--=20
2.13.6
