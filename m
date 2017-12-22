Received: from eggs.gnu.org ([2001:4830:134:3::10]:38248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsu-0007i7-Ev
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCst-0000kf-IZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCst-0000jN-D7
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:27 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:30 +0800
Message-Id: <1513908937-16034-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 11/18] lan9118: use inline net_crc32() and
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
 hw/net/lan9118.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 3db8937..b9032da 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "hw/devices.h"
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
@@ -504,7 +505,7 @@ static int lan9118_filter(lan9118_state *s, const uint8_t *addr)
         }
     } else {
         /* Hash matching  */
-        hash = compute_mcast_idx(addr);
+        hash = net_crc32(addr, ETH_ALEN) >> 26;
         if (hash & 0x20) {
             return (s->mac_hashh >> (hash & 0x1f)) & 1;
         } else {
-- 
2.7.4
