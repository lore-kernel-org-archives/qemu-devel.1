Received: from eggs.gnu.org ([208.118.235.92]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfQSa-0008W3-I1
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfQSY-0000om-2T
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:28:28 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri,  4 Jan 2019 15:28:12 +0100
Message-Id: <20190104142812.20444-3-edgar.iglesias@gmail.com>
In-Reply-To: <20190104142812.20444-1-edgar.iglesias@gmail.com>
References: <20190104142812.20444-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/2] target/microblaze: Add props enabling
 exceptions on failed bus accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, luc.michel@greensocs.com, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add MicroBlaze CPU properties to enable exceptions on failed
bus accesses.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 12 +++++++++++-
 target/microblaze/cpu.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 49876b19b3..5596cd5485 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -202,7 +202,11 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0) |
                         (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0) |
                         (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR : 0) |
-                        (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR : 0);
+                        (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR : 0) |
+                        (cpu->cfg.dopb_bus_exception ?
+                                                 PVR2_DOPB_BUS_EXC_MASK : 0) |
+                        (cpu->cfg.iopb_bus_exception ?
+                                                 PVR2_IOPB_BUS_EXC_MASK : 0);
 
     env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
                                         PVR5_DCACHE_WRITEBACK_MASK : 0;
@@ -265,6 +269,12 @@ static Property mb_properties[] = {
     DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
                      false),
     DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
+    /* Enables bus exceptions on failed data accesses (load/stores).  */
+    DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
+                     cfg.dopb_bus_exception, false),
+    /* Enables bus exceptions on failed instruction fetches.  */
+    DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
+                     cfg.iopb_bus_exception, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
     DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 03ca91007d..792bbc97c7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -308,6 +308,8 @@ struct MicroBlazeCPU {
         bool use_mmu;
         bool dcache_writeback;
         bool endi;
+        bool dopb_bus_exception;
+        bool iopb_bus_exception;
         char *version;
         uint8_t pvr;
     } cfg;
-- 
2.17.1
