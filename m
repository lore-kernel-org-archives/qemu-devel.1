Received: from eggs.gnu.org ([2001:4830:134:3::10]:37999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsY-0007St-NI
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsW-0000Nn-0B
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCsV-0000M7-Qd
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:03 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:24 +0800
Message-Id: <1513908937-16034-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/18] pcnet: switch pcnet over to use
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

Instead of lnc_mchash() using its own implementation, we can simply call
net_crc32_le() directly and apply the bit shift inline.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/pcnet.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 6544553..39d5d93 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -38,6 +38,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
 #include "sysemu/sysemu.h"
@@ -522,25 +523,6 @@ static inline void pcnet_rmd_store(PCNetState *s, st=
ruct pcnet_RMD *rmd,
            be16_to_cpu(hdr->ether_type));       \
 } while (0)
=20
-#define MULTICAST_FILTER_LEN 8
-
-static inline uint32_t lnc_mchash(const uint8_t *ether_addr)
-{
-#define LNC_POLYNOMIAL          0xEDB88320UL
-    uint32_t crc =3D 0xFFFFFFFF;
-    int idx, bit;
-    uint8_t data;
-
-    for (idx =3D 0; idx < 6; idx++) {
-        for (data =3D *ether_addr++, bit =3D 0; bit < MULTICAST_FILTER_L=
EN; bit++) {
-            crc =3D (crc >> 1) ^ (((crc ^ data) & 1) ? LNC_POLYNOMIAL : =
0);
-            data >>=3D 1;
-        }
-    }
-    return crc;
-#undef LNC_POLYNOMIAL
-}
-
 #define CRC(crc, ch)	 (crc =3D (crc >> 8) ^ crctab[(crc ^ (ch)) & 0xff])
=20
 /* generated using the AUTODIN II polynomial
@@ -656,7 +638,7 @@ static inline int ladr_match(PCNetState *s, const uin=
t8_t *buf, int size)
             s->csr[10] & 0xff, s->csr[10] >> 8,
             s->csr[11] & 0xff, s->csr[11] >> 8
         };
-        int index =3D lnc_mchash(hdr->ether_dhost) >> 26;
+        int index =3D net_crc32_le(hdr->ether_dhost, ETH_ALEN) >> 26;
         return !!(ladr[index >> 3] & (1 << (index & 7)));
     }
     return 0;
--=20
2.7.4
