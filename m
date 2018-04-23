Received: from eggs.gnu.org ([2001:4830:134:3::10]:55357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fAae4-0001Uf-Rc
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fAae3-0008A8-Mm
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:36 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fAae3-00089M-Ey
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:35 -0400
Received: by mail-lf0-x244.google.com with SMTP id r125-v6so14700697lfe.2
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 05:32:35 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 23 Apr 2018 14:32:24 +0200
Message-Id: <20180423123225.30503-5-edgar.iglesias@gmail.com>
In-Reply-To: <20180423123225.30503-1-edgar.iglesias@gmail.com>
References: <20180423123225.30503-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 4/5] target-microblaze: mmu: Make TLBSX
 write-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Make TLBSX write-only and guest-error log reads from it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index a0f06758f8..8391811900 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -182,7 +182,7 @@ done:
 uint32_t mmu_read(CPUMBState *env, uint32_t rn)
 {
     unsigned int i;
-    uint32_t r;
+    uint32_t r = 0;
 
     if (env->mmu.c_mmu < 2 || !env->mmu.c_mmu_tlb_access) {
         qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
@@ -211,6 +211,9 @@ uint32_t mmu_read(CPUMBState *env, uint32_t rn)
             }
             r = env->mmu.regs[rn];
             break;
+        case MMU_R_TLBSX:
+            qemu_log_mask(LOG_GUEST_ERROR, "TLBSX is write-only.\n");
+            break;
         default:
             r = env->mmu.regs[rn];
             break;
-- 
2.14.1
