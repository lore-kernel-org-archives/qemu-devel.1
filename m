Received: from eggs.gnu.org ([2001:4830:134:3::10]:38345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCt7-0007ry-3M
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCt6-00010p-8C
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCt6-00010D-1r
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:40 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:33 +0800
Message-Id: <1513908937-16034-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 14/18] rtl8139: use inline net_crc32() and
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
 hw/net/rtl8139.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index a6b2a9f..1cc95b8 100644
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
2.7.4
