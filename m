Received: from eggs.gnu.org ([2001:4830:134:3::10]:53607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Wx-00034p-Hk
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Ww-0000k8-Oq
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:07 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1Wv-0000js-Jz
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:06 -0400
Received: by mail-wm0-x242.google.com with SMTP id w194-v6so3861070wmf.2
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:52:05 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:18 +0200
Message-Id: <20180516185146.30708-11-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 10/38] target-microblaze: Bypass MMU with
 MMU_NOMMU_IDX
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

Bypass MMU translation when mmu-index MMU_NOMMU_IDX is used.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a9f4ca93e3..261dcc74c7 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -58,7 +58,8 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     int prot;
 
     /* Translate if the MMU is available and enabled.  */
-    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)) {
+    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)
+        && mmu_idx != MMU_NOMMU_IDX) {
         uint32_t vaddr, paddr;
         struct microblaze_mmu_lookup lu;
 
-- 
2.14.1
