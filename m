Received: from eggs.gnu.org ([2001:4830:134:3::10]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cE5Yj-00046h-Ik
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cE5Yi-0006cl-S3
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cE5Yi-0006c3-MY
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:44 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  6 Dec 2016 10:32:31 +0800
Message-Id: <1480991552-14360-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
References: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 2/3] fsl_etsec: Pad short payloads with zeros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Depending on QEMU network setup it is possible for us to receive a
complete Ethernet packet that is less 64 bytes long. One such example is
when QEMU is configured to use a standalone TAP device (not set to be a
part of any bridge) receives and ARP packet. In cases like that we need
to add more than just 4-bytes of CRC padding and ensure that our payload
is at least 60 bytes long, such that, when combined with CRC padding
bytes the resulting size is at least 802.3 minimum MTU bytes
long (64). Failing to do that results in code in etsec_walk_rx_ring()
setting BD_RX_SH which, in turn, makes corresponding Linux driver of
emulated host to reject buffer as a runt packet

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/fsl_etsec/rings.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 79d2f14..54c0127 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -474,6 +474,14 @@ static void rx_init_frame(eTSEC *etsec, const uint8_t *buf, size_t size)
     /* CRC padding (We don't have to compute the CRC) */
     etsec->rx_padding = 4;
 
+    /*
+     * Ensure that payload length + CRC length is at least 802.3
+     * minimum MTU size bytes long (64)
+     */
+    if (etsec->rx_buffer_len < 60) {
+        etsec->rx_padding += 60 - etsec->rx_buffer_len;
+    }
+
     etsec->rx_first_in_frame = 1;
     etsec->rx_remaining_data = etsec->rx_buffer_len;
     RING_DEBUG("%s: rx_buffer_len:%u rx_padding+crc:%u\n", __func__,
-- 
2.7.4
