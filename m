Received: from eggs.gnu.org ([2001:4830:134:3::10]:58485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuQS-00024E-76
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuQP-0001E8-0Z
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:36 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:50687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNuQO-0001Dm-Qn
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:32 -0400
Received: from player718.ha.ovh.net (unknown [10.109.120.47])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id A706415CA5
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:17:31 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:17:09 +0200
Message-Id: <20180530061711.23673-3-clg@kaod.org>
In-Reply-To: <20180530061711.23673-1-clg@kaod.org>
References: <20180530061711.23673-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/4] ftgmac100: add IEEE 802.1Q VLAN support
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

The ftgmac100 NIC supports VLAN tag insertion and the MAC engine also
has a control to remove VLAN tags from received packets.

The VLAN control bits and VLAN tag information are contained in the
second word of the transmit and receive descriptors. The Insert VLAN
bit and the VLAN Tag available bit are only valid in the first segment
of the packet.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

 Changes since v1:

 - replaced byte shifting by store/load helpers
=20
 hw/net/ftgmac100.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 425ac36cff87..abf80655f28f 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -443,6 +443,22 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint3=
2_t tx_ring,
             break;
         }
=20
+        /* Check for VLAN */
+        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
+            bd.des1 & FTGMAC100_TXDES1_INS_VLANTAG &&
+            be16_to_cpu(PKT_GET_ETH_HDR(ptr)->h_proto) !=3D ETH_P_VLAN) =
{
+            if (frame_size + len + 4 > sizeof(s->frame)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d b=
ytes\n",
+                              __func__, len);
+                s->isr |=3D FTGMAC100_INT_XPKT_LOST;
+                len =3D  sizeof(s->frame) - frame_size - 4;
+            }
+            memmove(ptr + 16, ptr + 12, len - 12);
+            stw_be_p(ptr + 12, ETH_P_VLAN);
+            stw_be_p(ptr + 14, bd.des1);
+            len +=3D 4;
+        }
+
         ptr +=3D len;
         frame_size +=3D len;
         if (bd.des0 & FTGMAC100_TXDES0_LTS) {
@@ -864,7 +880,20 @@ static ssize_t ftgmac100_receive(NetClientState *nc,=
 const uint8_t *buf,
             buf_len +=3D size - 4;
         }
         buf_addr =3D bd.des3;
-        dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+        if (first && proto =3D=3D ETH_P_VLAN && buf_len >=3D 18) {
+            bd.des1 =3D lduw_be_p(buf + 14) | FTGMAC100_RXDES1_VLANTAG_A=
VAIL;
+
+            if (s->maccr & FTGMAC100_MACCR_RM_VLAN) {
+                dma_memory_write(&address_space_memory, buf_addr, buf, 1=
2);
+                dma_memory_write(&address_space_memory, buf_addr + 12, b=
uf + 16,
+                                 buf_len - 16);
+            } else {
+                dma_memory_write(&address_space_memory, buf_addr, buf, b=
uf_len);
+            }
+        } else {
+            bd.des1 =3D 0;
+            dma_memory_write(&address_space_memory, buf_addr, buf, buf_l=
en);
+        }
         buf +=3D buf_len;
         if (size < 4) {
             dma_memory_write(&address_space_memory, buf_addr + buf_len,
--=20
2.13.6
