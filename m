Received: from eggs.gnu.org ([2001:4830:134:3::10]:38613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cE5Yi-00046b-Fz
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cE5Yf-0006am-Te
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cE5Yf-0006aV-O7
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:41 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  6 Dec 2016 10:32:30 +0800
Message-Id: <1480991552-14360-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
References: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 1/3] net: mcf: check receive buffer size
 register value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

ColdFire Fast Ethernet Controller uses a receive buffer size
register(EMRBR) to hold maximum size of all receive buffers.
It is set by a user before any operation. If it was set to be
zero, ColdFire emulator would go into an infinite loop while
receiving data in mcf_fec_receive. Add check to avoid it.

Reported-by: Wjjzhang <wjjzhang@tencent.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/mcf_fec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index dc61bac..4025eb3 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -393,7 +393,7 @@ static void mcf_fec_write(void *opaque, hwaddr addr,
         s->tx_descriptor = s->etdsr;
         break;
     case 0x188:
-        s->emrbr = value & 0x7f0;
+        s->emrbr = value > 0 ? value & 0x7F0 : 0x7F0;
         break;
     default:
         hw_error("mcf_fec_write Bad address 0x%x\n", (int)addr);
-- 
2.7.4
