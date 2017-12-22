Received: from eggs.gnu.org ([2001:4830:134:3::10]:38295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCt3-0007oJ-0c
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCt1-0000xX-WD
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCt1-0000wI-PW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:35 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:32 +0800
Message-Id: <1513908937-16034-14-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 13/18] ne2000: use inline net_crc32() and
 bitshift instead of compute_mcast_idx()
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

This makes it much easier to compare the multicast CRC calculation endian and
bitshift against the Linux driver implementation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/ne2000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 6874c8c..687ef84 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -23,6 +23,8 @@
  */
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "net/net.h"
+#include "net/eth.h"
 #include "ne2000.h"
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
@@ -199,7 +201,7 @@ ssize_t ne2000_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
             /* multicast */
             if (!(s->rxcr & 0x08))
                 return size;
-            mcast_idx = compute_mcast_idx(buf);
+            mcast_idx = net_crc32(buf, ETH_ALEN) >> 26;
             if (!(s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7))))
                 return size;
         } else if (s->mem[0] == buf[0] &&
-- 
2.7.4
