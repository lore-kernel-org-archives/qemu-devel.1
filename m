Received: from eggs.gnu.org ([2001:4830:134:3::10]:42542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fb5xC-0005pF-6U
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fb5x7-0003oC-UN
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:13:54 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  5 Jul 2018 11:13:34 -0400
Message-Id: <20180705151334.12271-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [RFC] fix setting FPSCR[FR] bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-environments-for-32-e3087633.html
Page 63 in table 2-4 is where the description of this bit can be found.

It is described as:

Floating-point fraction rounded. The last arithmetic or rounding and conversion instruction that rounded the intermediate result incremented the fraction. This bit is NOT sticky.

What I think this means is when the softfloat.c:round_canonical() function adds the inc variable to the frac variable, the floating point fraction rounded bit should be set. It also means that every time a floating point operation takes place, this bit needs to be updated since it isn't a sticky bit. My testing has produced mixed results with this patch. Some of my floating point tests are fixed by this patch, and others are broken by this patch. I'm not clear if this is the right way to implement setting the FPSCR[FR] bit. Feedback would be great.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 fpu/softfloat.c               | 6 +++++-
 include/fpu/softfloat-types.h | 1 +
 target/ppc/fpu_helper.c       | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8cd2400081..b2b2c61cff 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -382,11 +382,12 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     const uint64_t roundeven_mask = parm->roundeven_mask;
     const int exp_max = parm->exp_max;
     const int frac_shift = parm->frac_shift;
-    uint64_t frac, inc;
+    uint64_t frac, inc, old_frac;
     int exp, flags = 0;
     bool overflow_norm;
 
     frac = p.frac;
+    old_frac = frac; /* Used to determine if the fraction was rounded */
     exp = p.exp;
 
     switch (p.cls) {
@@ -503,6 +504,9 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
         g_assert_not_reached();
     }
 
+    if (frac != old_frac) {
+        flags |= float_flag_round;
+    }
     float_raise(flags, s);
     p.exp = exp;
     p.frac = frac;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 2aae6a89b1..1d124e659c 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -147,6 +147,7 @@ enum {
 
 enum {
     float_flag_invalid   =  1,
+    float_flag_round     =  2,
     float_flag_divbyzero =  4,
     float_flag_overflow  =  8,
     float_flag_underflow = 16,
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index cb82e6e842..ba57ea7cfe 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -581,6 +581,7 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
     CPUState *cs = CPU(ppc_env_get_cpu(env));
     int status = get_float_exception_flags(&env->fp_status);
     bool inexact_happened = false;
+    bool round_happened = false;
 
     if (status & float_flag_overflow) {
         float_overflow_excp(env);
@@ -589,6 +590,8 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
     } else if (status & float_flag_inexact) {
         float_inexact_excp(env);
         inexact_happened = true;
+    } else if (status & float_flag_round) {
+        round_happened = true;
     }
 
     /* if the inexact flag was not set */
@@ -596,6 +599,11 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
         env->fpscr &= ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
     }
 
+    /* if the floating-point fraction rounded bit was not set */
+    if (round_happened == false) {
+        env->fpscr &= ~(1 << FPSCR_FR); /* clear the FPSCR[FR] bit */
+    }
+
     if (cs->exception_index == POWERPC_EXCP_PROGRAM &&
         (env->error_code & POWERPC_EXCP_FP)) {
         /* Differred floating-point exception after target FPR update */
-- 
2.14.3 (Apple Git-98)
