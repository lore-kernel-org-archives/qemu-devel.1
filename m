Received: from eggs.gnu.org ([209.51.188.92]:46386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXob-00050x-2k
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoY-00026r-Se
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:48 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoY-00022a-DR
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:46 -0500
Received: by mail-wm1-x341.google.com with SMTP id y185so6500503wmd.1
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:00 +0000
Message-Id: <20190107163117.16269-21-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/37] hw/arm: versal: Plug memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Plug a couple of "board creation time" memory leaks.

Fixes: 6f16da53ffe4567 ("hw/arm: versal: Add a virtual Xilinx Versal board")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190104104749.5314-2-edgar.iglesias@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index c6feeac532f..f95fde2309b 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -130,6 +130,7 @@ static void fdt_add_gic_nodes(VersalVirt *s)
                                  2, MM_GIC_APU_REDIST_0_SIZE);
     qemu_fdt_setprop_cell(s->fdt, nodename, "#interrupt-cells", 3);
     qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "arm,gic-v3");
+    g_free(nodename);
 }
 
 static void fdt_add_timer_nodes(VersalVirt *s)
@@ -364,6 +365,7 @@ static void create_virtio_regions(VersalVirt *s)
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->soc.mr_ps, base, mr);
+        g_free(name);
     }
 
     for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-- 
2.19.2
