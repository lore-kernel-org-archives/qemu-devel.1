Received: from eggs.gnu.org ([2001:4830:134:3::10]:37282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUS-00047J-Ml
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUS-0005hl-1m
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUR-0005hG-R6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:51 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUQ-0003Fu-Rz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:50 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:12 +0100
Message-Id: <20180820103212.2810-26-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/25] hw/dma/pl080: Remove hw_error() if DMA is
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PL08x model currently will unconditionally call hw_error()
if the DMA engine is enabled by the guest. This has been
present since the PL080 model was edded in 2006, and is
presumably either unintentional debug code left enabled,
or a guard against untested DMA engine code being used.

Remove the hw_error(), since we now have a guest which
will actually try to use the DMA engine (the self-test
binary for the AN505 MPS2 FPGA image).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/pl080.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 8f92550392b..ef15d3e628d 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -110,7 +110,6 @@ static void pl080_run(PL080State *s)
     if ((s->conf & PL080_CONF_E) == 0)
         return;
 
-hw_error("DMA active\n");
     /* If we are already in the middle of a DMA operation then indicate that
        there may be new DMA requests and return immediately.  */
     if (s->running) {
-- 
2.18.0
