Received: from eggs.gnu.org ([2001:4830:134:3::10]:45167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePv05-00015l-AJ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePv04-0005ha-4z
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:25 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60863
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePv03-0005gF-Um
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:24 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:54 +0000
Message-Id: <20171215184155.2543-13-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 12/13] rtl8139: use inline net_crc32() and
 bitshift instead of compute_mcast_idx()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

This makes it much easier to compare the multicast CRC calculation endian and
bitshift against the Linux driver implementation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/rtl8139.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index a6b2a9f7a4..1cc95b8cba 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -882,7 +882,7 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
                 return size;
             }
 
-            int mcast_idx = compute_mcast_idx(buf);
+            int mcast_idx = net_crc32(buf, ETH_ALEN) >> 26;
 
             if (!(s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7))))
             {
-- 
2.11.0
