Received: from eggs.gnu.org ([2001:4830:134:3::10]:41551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXx-0002Ac-PA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXu-0000a2-Qt
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:05 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKXu-0000ZV-Ir
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:02 -0400
Received: by mail-lf0-x242.google.com with SMTP id t72so17250904lff.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:55:02 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:39 +0200
Message-Id: <1499162088-1562-9-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 08/17] target-microblaze: Introduce a
 use-msr-instr property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Introduce a use-msr-instr property making msr instructions
optional.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 5 +++--
 target/microblaze/cpu.h       | 1 +
 target/microblaze/translate.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 70e4743..bc96505 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -157,7 +157,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         | PVR2_D_LMB_MASK \
                         | PVR2_I_OPB_MASK \
                         | PVR2_I_LMB_MASK \
-                        | PVR2_USE_MSR_INSTR \
                         | PVR2_USE_PCMP_INSTR \
                         | PVR2_FPU_EXC_MASK \
                         | 0;
@@ -188,7 +187,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.use_hw_mul ? PVR2_USE_HW_MUL_MASK : 0) |
                         (cpu->cfg.use_hw_mul > 1 ? PVR2_USE_MUL64_MASK : 0) |
                         (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0) |
-                        (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0);
+                        (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0) |
+                        (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR : 0);
 
     env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
                                         PVR5_DCACHE_WRITEBACK_MASK : 0;
@@ -241,6 +241,7 @@ static Property mb_properties[] = {
     DEFINE_PROP_UINT8("use-hw-mul", MicroBlazeCPU, cfg.use_hw_mul, 2),
     DEFINE_PROP_BOOL("use-barrel", MicroBlazeCPU, cfg.use_barrel, true),
     DEFINE_PROP_BOOL("use-div", MicroBlazeCPU, cfg.use_div, true),
+    DEFINE_PROP_BOOL("use-msr-instr", MicroBlazeCPU, cfg.use_msr_instr, true),
     DEFINE_PROP_BOOL("use-mmu", MicroBlazeCPU, cfg.use_mmu, true),
     DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
                      false),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e202229..5c960d0 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -301,6 +301,7 @@ struct MicroBlazeCPU {
         uint8_t use_hw_mul;
         bool use_barrel;
         bool use_div;
+        bool use_msr_instr;
         bool use_mmu;
         bool dcache_writeback;
         bool endi;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 36caa03..bb1bdfa 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -443,7 +443,7 @@ static void dec_msr(DisasContext *dc)
         LOG_DIS("msr%s r%d imm=%x\n", clr ? "clr" : "set",
                 dc->rd, dc->imm);
 
-        if (!(dc->cpu->env.pvr.regs[2] & PVR2_USE_MSR_INSTR)) {
+        if (!dc->cpu->cfg.use_msr_instr) {
             /* nop??? */
             return;
         }
-- 
2.7.4
