Received: from eggs.gnu.org ([2001:4830:134:3::10]:33458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdi-00078j-GF
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdf-0000Rx-Oh
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:42 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:47:51 -0800
Message-Id: <20171106154813.19936-9-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/30] imx_fec: Use correct length for
 packet size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Use 'frame_size' instead of 'len' when calling qemu_send_packet(),
failing to do so results in malformed packets send in case when that
packed is fragmented into multiple DMA transactions.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/net/imx_fec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 38d8c27dcd..eefb3b2c62 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -528,7 +528,7 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
                 }
             }
             /* Last buffer in frame.  */
-            qemu_send_packet(qemu_get_queue(s->nic), frame, len);
+            qemu_send_packet(qemu_get_queue(s->nic), frame, frame_size);
             ptr = frame;
             frame_size = 0;
             if (bd.option & ENET_BD_TX_INT) {
-- 
2.13.6
