Received: from eggs.gnu.org ([2001:4830:134:3::10]:36853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcD1-0001Ku-GU
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcD0-0003s0-Fl
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:31 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcD0-0003qz-85
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:30 -0400
Received: by mail-wr0-x241.google.com with SMTP id i14-v6so24683519wre.2
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:30 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:42 +0200
Message-Id: <20180529105011.1914-10-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 09/38] target-microblaze: Conditionalize
 setting of PVR11_USE_MMU
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

Conditionalize setting of PVR11_USE_MMU on the use_mmu
CPU property, otherwise we may incorrectly advertise an
MMU via PVR when the core in fact has none.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 06476f6efc..a6f1ce6549 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -201,7 +201,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                                         PVR5_DCACHE_WRITEBACK_MASK : 0;
 
     env->pvr.regs[10] = 0x0c000000; /* Default to spartan 3a dsp family.  */
-    env->pvr.regs[11] = PVR11_USE_MMU | (16 << 17);
+    env->pvr.regs[11] = (cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
+                        16 << 17;
 
     mcc->parent_realize(dev, errp);
 }
-- 
2.14.1
