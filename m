Received: from eggs.gnu.org ([209.51.188.92]:34956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gm1Re-0007Mr-4r
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gm1Rc-0002TW-C4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:10:46 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:35671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1gm1Rc-0002Ma-3e
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:10:44 -0500
Received: by mail-pf1-x42a.google.com with SMTP id z9so12235986pfi.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:10:35 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 22 Jan 2019 04:20:48 -0800
Message-Id: <20190122122048.10845-4-edgar.iglesias@gmail.com>
In-Reply-To: <20190122122048.10845-1-edgar.iglesias@gmail.com>
References: <20190122122048.10845-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v1 3/3] target/microblaze: Add props enabling
 exceptions on failed bus accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add MicroBlaze CPU properties to enable exceptions on failed
bus accesses.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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
2.19.1
