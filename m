Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsl-0007bn-6v
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsk-0000Yn-Gm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCsk-0000Y2-C9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:18 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:28 +0800
Message-Id: <1513908937-16034-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 09/18] eepro100: use inline net_crc32() and
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
 hw/net/eepro100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index e30fed8..a07a632 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1679,7 +1679,7 @@ static ssize_t nic_receive(NetClientState *nc, const uint8_t * buf, size_t size)
         rfd_status |= 0x0004;
     } else if (s->configuration[20] & BIT(6)) {
         /* Multiple IA bit set. */
-        unsigned mcast_idx = compute_mcast_idx(buf);
+        unsigned mcast_idx = net_crc32(buf, ETH_ALEN) >> 26;
         assert(mcast_idx < 64);
         if (s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7))) {
             TRACE(RXTX, logout("%p accepted, multiple IA bit set\n", s));
-- 
2.7.4
