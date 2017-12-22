Received: from eggs.gnu.org ([2001:4830:134:3::10]:38070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsd-0007Vd-DH
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsc-0000T5-BA
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCsc-0000Sh-4f
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:10 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:26 +0800
Message-Id: <1513908937-16034-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/18] sunhme: switch sunhme over to use
 net_crc32_le()
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

Instead of sunhme_crc32_le() using its own implementation, we can simply =
call
net_crc32_le() directly and apply the bit shift inline.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/sunhme.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index b1efa1b..7558fca 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -698,29 +698,6 @@ static inline void sunhme_set_rx_ring_nr(SunHMEState=
 *s, int i)
     s->erxregs[HME_ERXI_RING >> 2] =3D ring;
 }
=20
-#define POLYNOMIAL_LE 0xedb88320
-static uint32_t sunhme_crc32_le(const uint8_t *p, int len)
-{
-    uint32_t crc;
-    int carry, i, j;
-    uint8_t b;
-
-    crc =3D 0xffffffff;
-    for (i =3D 0; i < len; i++) {
-        b =3D *p++;
-        for (j =3D 0; j < 8; j++) {
-            carry =3D (crc & 0x1) ^ (b & 0x01);
-            crc >>=3D 1;
-            b >>=3D 1;
-            if (carry) {
-                crc =3D crc ^ POLYNOMIAL_LE;
-            }
-        }
-    }
-
-    return crc;
-}
-
 #define MIN_BUF_SIZE 60
=20
 static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
@@ -761,7 +738,7 @@ static ssize_t sunhme_receive(NetClientState *nc, con=
st uint8_t *buf,
             trace_sunhme_rx_filter_bcast_match();
         } else if (s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_HENAB=
LE) {
             /* Didn't match local address, check hash filter */
-            int mcast_idx =3D sunhme_crc32_le(buf, 6) >> 26;
+            int mcast_idx =3D net_crc32_le(buf, ETH_ALEN) >> 26;
             if (!(s->macregs[(HME_MACI_HASHTAB0 >> 2) - (mcast_idx >> 4)=
] &
                     (1 << (mcast_idx & 0xf)))) {
                 /* Didn't match hash filter */
--=20
2.7.4
