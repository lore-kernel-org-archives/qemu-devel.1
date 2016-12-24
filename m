Received: from eggs.gnu.org ([2001:4830:134:3::10]:43830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cKnz0-0005Yo-8h
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 10:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cKnyx-0000wk-36
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 10:11:38 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cKnyw-0000wB-Sq
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 10:11:35 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Sat, 24 Dec 2016 16:11:13 +0100
Message-Id: <20161224151113.23955-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH] [M25P80] Make sure not to overrun the internal
 data buffer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

It did happen that the internal data buffer was overrun leading to a Qemu
crash (in particular while emulating the i.MX6 sabrelite board).

This patch makes sure the data array would not be overrun and allow the
sabrelite emulation to run without crash.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/block/m25p80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index d29ff4c..a1c4e5d 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1117,7 +1117,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
         s->data[s->len] = (uint8_t)tx;
         s->len++;
 
-        if (s->len == s->needed_bytes) {
+        if ((s->len >= s->needed_bytes) || (s->len >= sizeof(s->data))) {
             complete_collecting_data(s);
         }
         break;
-- 
2.9.3
