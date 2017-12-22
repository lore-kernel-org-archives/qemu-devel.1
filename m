Received: from eggs.gnu.org ([2001:4830:134:3::10]:38129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsj-0007Zv-7Y
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsg-0000Vb-D8
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCsg-0000VD-61
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:14 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:27 +0800
Message-Id: <1513908937-16034-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/18] sungem: fix multicast filter CRC
 calculation
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

>From the Linux sungem driver, we know that the multicast filter CRC is
implemented using ether_crc_le() which isn't the same as calling zlib's
crc32() function (the zlib implementation requires a complemented initial=
 value
and also returns the complemented result).

Fix the multicast filter by simply using the new net_crc32_le() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/sungem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 6aa8d11..60f1e47 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -11,12 +11,11 @@
 #include "hw/pci/pci.h"
 #include "qemu/log.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "net/checksum.h"
 #include "hw/net/mii.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
-/* For crc32 */
-#include <zlib.h>
=20
 #define TYPE_SUNGEM "sungem"
=20
@@ -595,7 +594,7 @@ static ssize_t sungem_receive(NetClientState *nc, con=
st uint8_t *buf,
     }
=20
     /* Get MAC crc */
-    mac_crc =3D crc32(~0, buf, 6);
+    mac_crc =3D net_crc32_le(buf, ETH_ALEN);
=20
     /* Packet isn't for me ? */
     rx_cond =3D sungem_check_rx_mac(s, buf, mac_crc);
--=20
2.7.4
