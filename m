Received: from eggs.gnu.org ([2001:4830:134:3::10]:53101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92z-0001jf-AQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92s-0002u6-UT
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:05 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92s-0002qx-JL
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:58 -0500
Received: by mail-pl1-x644.google.com with SMTP id e11so6705029plt.11
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:09 -0800
Message-Id: <20181218063911.2112-33-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 32/34] target/ppc: Split out VSCR_SAT to a
 vector field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Change the representation of VSCR_SAT such that it is easy
to set from vector code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h        |  4 +++-
 target/ppc/int_helper.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a2fe6058b1..26d2e16720 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1063,10 +1063,12 @@ struct CPUPPCState {
     /* Special purpose registers */
     target_ulong spr[1024];
     ppc_spr_t spr_cb[1024];
-    /* Vector status and control register */
+    /* Vector status and control register, minus VSCR_SAT.  */
     uint32_t vscr;
     /* VSX registers (including FP and AVR) */
     ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
+    /* Non-zero if and only if VSCR_SAT should be set.  */
+    ppc_vsr_t vscr_sat;
     /* SPE registers */
     uint64_t spe_acc;
     uint32_t spe_fscr;
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 38aa3e85a6..9dbcbcd87a 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -471,18 +471,23 @@ void helper_lvsr(ppc_avr_t *r, target_ulong sh)
 
 void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
 {
-    env->vscr = vscr;
+    env->vscr = vscr & ~(1u << VSCR_SAT);
+    /* Which bit we set is completely arbitrary, but clear the rest.  */
+    env->vscr_sat.u64[0] = vscr & (1u << VSCR_SAT);
+    env->vscr_sat.u64[1] = 0;
     set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
 }
 
 uint32_t helper_mfvscr(CPUPPCState *env)
 {
-    return env->vscr;
+    uint32_t sat = (env->vscr_sat.u64[0] | env->vscr_sat.u64[1]) != 0;
+    return env->vscr | (sat << VSCR_SAT);
 }
 
 static inline void set_vscr_sat(CPUPPCState *env)
 {
-    env->vscr |= 1 << VSCR_SAT;
+    /* The choice of non-zero value is arbitrary.  */
+    env->vscr_sat.u32[0] = 1;
 }
 
 void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.17.2
