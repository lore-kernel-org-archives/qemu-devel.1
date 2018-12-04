Received: from eggs.gnu.org ([2001:4830:134:3::10]:58194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmG-0007ul-J8
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmE-0001Df-LL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:16 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Dec 2018 13:29:49 +0000
Message-Id: <20181204132952.2601-3-peter.maydell@linaro.org>
In-Reply-To: <20181204132952.2601-1-peter.maydell@linaro.org>
References: <20181204132952.2601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/5] hw/arm/mps2-tz.c: Free mscname string in
 make_dma()
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

The clang leak sanitizer spots a (one-off, trivial) memory
leak in make_dma() due to a missing free.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 6dd02ae47e8..82b1d020a58 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -322,6 +322,7 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
     sysbus_connect_irq(s, 2, qdev_get_gpio_in_named(iotkitdev,
                                                     "EXP_IRQ", 57 + i * 3));
 
+    g_free(mscname);
     return sysbus_mmio_get_region(s, 0);
 }
 
-- 
2.19.2
