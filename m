Received: from eggs.gnu.org ([2001:4830:134:3::10]:53813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1XK-0003NF-5K
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1XI-0000rA-Bc
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:30 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:32921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1XI-0000qh-4z
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:28 -0400
Received: by mail-wr0-x244.google.com with SMTP id o4-v6so2794778wrm.0
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:52:27 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:32 +0200
Message-Id: <20180516185146.30708-25-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 24/38] target-microblaze: mmu: Add
 R_TBLX_MISS macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add a R_TBLX_MISS MASK and SHIFT macros.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/mmu.c | 5 +++--
 target/microblaze/mmu.h | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 0019ebd18f..f4a4c339c9 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -292,8 +292,9 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
                                 v & TLB_EPN_MASK, 0, cpu_mmu_index(env, false));
             if (hit) {
                 env->mmu.regs[MMU_R_TLBX] = lu.idx;
-            } else
-                env->mmu.regs[MMU_R_TLBX] |= 0x80000000;
+            } else {
+                env->mmu.regs[MMU_R_TLBX] |= R_TBLX_MISS_MASK;
+            }
             break;
         }
         default:
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 3b7a9983d5..113539c6e9 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -54,6 +54,10 @@
 #define TLB_M                 0x00000002 /* Memory is coherent */
 #define TLB_G                 0x00000001 /* Memory is guarded from prefetch */
 
+/* TLBX  */
+#define R_TBLX_MISS_SHIFT 31
+#define R_TBLX_MISS_MASK (1U << R_TBLX_MISS_SHIFT)
+
 #define TLB_ENTRIES    64
 
 struct microblaze_mmu
-- 
2.14.1
