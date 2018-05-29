Received: from eggs.gnu.org ([2001:4830:134:3::10]:37059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDQ-0001fC-5b
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDP-0004AK-DI
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:56 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDP-0004A5-66
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:55 -0400
Received: by mail-wr0-x244.google.com with SMTP id w10-v6so24707564wrk.9
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:55 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:57 +0200
Message-Id: <20180529105011.1914-25-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 24/38] target-microblaze: mmu: Add
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
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

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
