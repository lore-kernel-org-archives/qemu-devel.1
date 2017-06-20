Received: from eggs.gnu.org ([2001:4830:134:3::10]:38958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLRF-00050s-2Z
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLRC-0003y7-V4
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:33 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLRC-0003xk-NU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:30 -0400
Received: by mail-lf0-x242.google.com with SMTP id l200so3940551lfg.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:51:30 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 17:51:19 +0200
Message-Id: <1497973886-26257-2-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/8] target-microblaze: Correct bit shift
 for the PVR0 version field
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

Correct bit shift for the PVR0 version field.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 2 +-
 target/microblaze/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 3d58869..af70faa 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -182,7 +182,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.use_fpu ? PVR0_USE_FPU_MASK : 0) |
                         (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
                         (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
-                        (version_code << 16) |
+                        (version_code << PVR0_VERSION_SHIFT) |
                         (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0);
 
     env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index bf6963b..68c33e8 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -129,6 +129,8 @@ typedef struct CPUMBState CPUMBState;
 #define PVR0_USER1_MASK                 0x000000FF
 #define PVR0_SPROT_MASK                 0x00000001
 
+#define PVR0_VERSION_SHIFT              8
+
 /* User 2 PVR mask */
 #define PVR1_USER2_MASK                 0xFFFFFFFF
 
-- 
2.7.4
