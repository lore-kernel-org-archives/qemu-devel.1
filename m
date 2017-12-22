Received: from eggs.gnu.org ([2001:4830:134:3::10]:37747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsN-0007KX-BC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsL-0000EB-Rk
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCsL-0000DR-IY
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:53 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:22 +0800
Message-Id: <1513908937-16034-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/18] net: move CRC32 calculation from
 compute_mcast_idx() into its own net_crc32() function
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

Separate out the standard ethernet CRC32 calculation into a new net_crc32=
()
function, renaming the constant POLYNOMIAL to POLYNOMIAL_BE to make it cl=
ear
that this is a big-endian CRC32 calculation.

As part of the constant rename, remove the duplicate definition of POLYNO=
MIAL
from eepro100.c and use the new POLYNOMIAL_BE constant instead.

Once this is complete remove the existing CRC32 implementation from
compute_mcast_idx() and call the new net_crc32() function in its place.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/eepro100.c |  4 +---
 include/net/net.h |  3 ++-
 net/net.c         | 16 +++++++++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 1c0def5..71cddfe 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -323,8 +323,6 @@ static const uint16_t eepro100_mdi_mask[] =3D {
     0xffff, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
=20
-#define POLYNOMIAL 0x04c11db6
-
 static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s);
=20
 /* From FreeBSD (locally modified). */
@@ -342,7 +340,7 @@ static unsigned e100_compute_mcast_idx(const uint8_t =
*ep)
             crc <<=3D 1;
             b >>=3D 1;
             if (carry) {
-                crc =3D ((crc ^ POLYNOMIAL) | carry);
+                crc =3D ((crc ^ POLYNOMIAL_BE) | carry);
             }
         }
     }
diff --git a/include/net/net.h b/include/net/net.h
index 1c55a93..586098c 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -227,7 +227,8 @@ NetClientState *net_hub_port_find(int hub_id);
=20
 void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
=20
-#define POLYNOMIAL 0x04c11db6
+#define POLYNOMIAL_BE 0x04c11db6
+uint32_t net_crc32(const uint8_t *p, int len);
 unsigned compute_mcast_idx(const uint8_t *ep);
=20
 #define vmstate_offset_macaddr(_state, _field)                       \
diff --git a/net/net.c b/net/net.c
index 39ef546..a14dc99 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1581,25 +1581,31 @@ int net_client_parse(QemuOptsList *opts_list, con=
st char *optarg)
=20
 /* From FreeBSD */
 /* XXX: optimize */
-unsigned compute_mcast_idx(const uint8_t *ep)
+uint32_t net_crc32(const uint8_t *p, int len)
 {
     uint32_t crc;
     int carry, i, j;
     uint8_t b;
=20
     crc =3D 0xffffffff;
-    for (i =3D 0; i < 6; i++) {
-        b =3D *ep++;
+    for (i =3D 0; i < len; i++) {
+        b =3D *p++;
         for (j =3D 0; j < 8; j++) {
             carry =3D ((crc & 0x80000000L) ? 1 : 0) ^ (b & 0x01);
             crc <<=3D 1;
             b >>=3D 1;
             if (carry) {
-                crc =3D ((crc ^ POLYNOMIAL) | carry);
+                crc =3D ((crc ^ POLYNOMIAL_BE) | carry);
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
=20
 QemuOptsList qemu_netdev_opts =3D {
--=20
2.7.4
