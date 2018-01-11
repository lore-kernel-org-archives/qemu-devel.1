Received: from eggs.gnu.org ([2001:4830:134:3::10]:52264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd45-0007Vm-37
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd44-0000Az-BS
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd44-00009A-4U
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:40 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd42-0005j0-Oy
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:14 +0000
Message-Id: <1515677902-23436-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/26] imx_fec: Use correct length for packet
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

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
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/imx_fec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 77d27f7..6cb9e2e 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -556,7 +556,7 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
             }
             /* Last buffer in frame.  */
 
-            qemu_send_packet(qemu_get_queue(s->nic), s->frame, len);
+            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_size);
             ptr = s->frame;
 
             frame_size = 0;
-- 
2.7.4
