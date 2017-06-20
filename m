Received: from eggs.gnu.org ([2001:4830:134:3::10]:39026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLRK-00055M-T8
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLRJ-00040C-Qp
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:38 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLRJ-0003zp-JJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:37 -0400
Received: by mail-lf0-x241.google.com with SMTP id x81so15466594lfb.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:51:37 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 17:51:24 +0200
Message-Id: <1497973886-26257-7-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 6/8] target-microblaze: Introduce a
 use-hw-mul property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Introduce a use-div property making multiplication instructions
optional.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 12 ++++++++----
 target/microblaze/cpu.h       |  1 +
 target/microblaze/translate.c |  5 ++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 5bf2a29..70e4743 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -150,8 +150,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
-    env->pvr.regs[0] = PVR0_USE_HW_MUL_MASK \
-                       | PVR0_USE_EXC_MASK \
+    env->pvr.regs[0] = PVR0_USE_EXC_MASK \
                        | PVR0_USE_ICACHE_MASK \
                        | PVR0_USE_DCACHE_MASK;
     env->pvr.regs[2] = PVR2_D_OPB_MASK \
@@ -160,8 +159,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         | PVR2_I_LMB_MASK \
                         | PVR2_USE_MSR_INSTR \
                         | PVR2_USE_PCMP_INSTR \
-                        | PVR2_USE_HW_MUL_MASK \
-                        | PVR2_USE_MUL64_MASK \
                         | PVR2_FPU_EXC_MASK \
                         | 0;
 
@@ -178,6 +175,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
     env->pvr.regs[0] |= (cpu->cfg.stackprot ? PVR0_SPROT_MASK : 0) |
                         (cpu->cfg.use_fpu ? PVR0_USE_FPU_MASK : 0) |
+                        (cpu->cfg.use_hw_mul ? PVR0_USE_HW_MUL_MASK : 0) |
                         (cpu->cfg.use_barrel ? PVR0_USE_BARREL_MASK : 0) |
                         (cpu->cfg.use_div ? PVR0_USE_DIV_MASK : 0) |
                         (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
@@ -187,6 +185,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
     env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
                         (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
+                        (cpu->cfg.use_hw_mul ? PVR2_USE_HW_MUL_MASK : 0) |
+                        (cpu->cfg.use_hw_mul > 1 ? PVR2_USE_MUL64_MASK : 0) |
                         (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0) |
                         (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0);
 
@@ -235,6 +235,10 @@ static Property mb_properties[] = {
      *                  are enabled
      */
     DEFINE_PROP_UINT8("use-fpu", MicroBlazeCPU, cfg.use_fpu, 2),
+    /* If use-hw-mul > 0 - Multiplier is enabled
+     * If use-hw-mul = 2 - 64-bit multiplier is enabled
+     */
+    DEFINE_PROP_UINT8("use-hw-mul", MicroBlazeCPU, cfg.use_hw_mul, 2),
     DEFINE_PROP_BOOL("use-barrel", MicroBlazeCPU, cfg.use_barrel, true),
     DEFINE_PROP_BOOL("use-div", MicroBlazeCPU, cfg.use_div, true),
     DEFINE_PROP_BOOL("use-mmu", MicroBlazeCPU, cfg.use_mmu, true),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 4397338..e202229 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -298,6 +298,7 @@ struct MicroBlazeCPU {
         bool stackprot;
         uint32_t base_vectors;
         uint8_t use_fpu;
+        uint8_t use_hw_mul;
         bool use_barrel;
         bool use_div;
         bool use_mmu;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index afe4bd4..36caa03 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -589,7 +589,7 @@ static void dec_mul(DisasContext *dc)
 
     if ((dc->tb_flags & MSR_EE_FLAG)
          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-         && !(dc->cpu->env.pvr.regs[0] & PVR0_USE_HW_MUL_MASK)) {
+         && !dc->cpu->cfg.use_hw_mul) {
         tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
         return;
@@ -604,8 +604,7 @@ static void dec_mul(DisasContext *dc)
     }
 
     /* mulh, mulhsu and mulhu are not available if C_USE_HW_MUL is < 2.  */
-    if (subcode >= 1 && subcode <= 3
-        && !((dc->cpu->env.pvr.regs[2] & PVR2_USE_MUL64_MASK))) {
+    if (subcode >= 1 && subcode <= 3 && dc->cpu->cfg.use_hw_mul < 2) {
         /* nop??? */
     }
 
-- 
2.7.4
