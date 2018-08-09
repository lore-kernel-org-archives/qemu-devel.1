Received: from eggs.gnu.org ([2001:4830:134:3::10]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZS-0005yx-1D
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZR-0003PE-2u
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  9 Aug 2018 14:01:14 +0100
Message-Id: <20180809130115.28951-16-peter.maydell@linaro.org>
In-Reply-To: <20180809130115.28951-1-peter.maydell@linaro.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 15/16] hw/dma/pl080: Remove hw_error() if DMA
 is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The PL08x model currently will unconditionally call hw_error()
if the DMA engine is enabled by the guest. This has been
present since the PL080 model was edded in 2006, and is
presumably either unintentional debug code left enabled,
or a guard against untested DMA engine code being used.

Remove the hw_error(), since we now have a guest which
will actually try to use the DMA engine (the self-test
binary for the AN505 MPS2 FPGA image).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.17.1
