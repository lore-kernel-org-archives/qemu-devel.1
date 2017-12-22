Received: from eggs.gnu.org ([2001:4830:134:3::10]:38042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsa-0007UR-GN
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsZ-0000RQ-Dj
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCsZ-0000Qc-5N
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:07 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:25 +0800
Message-Id: <1513908937-16034-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/18] eepro100: switch eepro100
 e100_compute_mcast_idx() over to use net_crc32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Instead of e100_compute_mcast_idx() using its own implementation, we can
simply call net_crc32() directly and apply the bit shift inline.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/eepro100.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 71cddfe..e30fed8 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -44,6 +44,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
@@ -325,28 +326,6 @@ static const uint16_t eepro100_mdi_mask[] =3D {
=20
 static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s);
=20
-/* From FreeBSD (locally modified). */
-static unsigned e100_compute_mcast_idx(const uint8_t *ep)
-{
-    uint32_t crc;
-    int carry, i, j;
-    uint8_t b;
-
-    crc =3D 0xffffffff;
-    for (i =3D 0; i < 6; i++) {
-        b =3D *ep++;
-        for (j =3D 0; j < 8; j++) {
-            carry =3D ((crc & 0x80000000L) ? 1 : 0) ^ (b & 0x01);
-            crc <<=3D 1;
-            b >>=3D 1;
-            if (carry) {
-                crc =3D ((crc ^ POLYNOMIAL_BE) | carry);
-            }
-        }
-    }
-    return (crc & BITS(7, 2)) >> 2;
-}
-
 /* Read a 16 bit control/status (CSR) register. */
 static uint16_t e100_read_reg2(EEPRO100State *s, E100RegisterOffset addr=
)
 {
@@ -843,7 +822,8 @@ static void set_multicast_list(EEPRO100State *s)
         uint8_t multicast_addr[6];
         pci_dma_read(&s->dev, s->cb_address + 10 + i, multicast_addr, 6)=
;
         TRACE(OTHER, logout("multicast entry %s\n", nic_dump(multicast_a=
ddr, 6)));
-        unsigned mcast_idx =3D e100_compute_mcast_idx(multicast_addr);
+        unsigned mcast_idx =3D (net_crc32(multicast_addr, ETH_ALEN) &
+                              BITS(7, 2)) >> 2;
         assert(mcast_idx < 64);
         s->mult[mcast_idx >> 3] |=3D (1 << (mcast_idx & 7));
     }
@@ -1679,7 +1659,7 @@ static ssize_t nic_receive(NetClientState *nc, cons=
t uint8_t * buf, size_t size)
         if (s->configuration[21] & BIT(3)) {
           /* Multicast all bit is set, receive all multicast frames. */
         } else {
-          unsigned mcast_idx =3D e100_compute_mcast_idx(buf);
+          unsigned mcast_idx =3D (net_crc32(buf, ETH_ALEN) & BITS(7, 2))=
 >> 2;
           assert(mcast_idx < 64);
           if (s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7))) {
             /* Multicast frame is allowed in hash table. */
--=20
2.7.4
