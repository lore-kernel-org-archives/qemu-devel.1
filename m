Received: from eggs.gnu.org ([2001:4830:134:3::10]:52985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92v-0001fg-Tq
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92r-0002rw-R0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:01 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92r-0002p7-AI
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:57 -0500
Received: by mail-pg1-x541.google.com with SMTP id g189so7344540pgc.5
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:08 -0800
Message-Id: <20181218063911.2112-32-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 31/34] target/ppc: Add set_vscr_sat
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

This is required before changing the representation of the register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 75201bbba6..38aa3e85a6 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -480,6 +480,11 @@ uint32_t helper_mfvscr(CPUPPCState *env)
     return env->vscr;
 }
 
+static inline void set_vscr_sat(CPUPPCState *env)
+{
+    env->vscr |= 1 << VSCR_SAT;
+}
+
 void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
@@ -593,7 +598,7 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | float_muladd_negate_c);
             }                                                           \
         }                                                               \
         if (sat) {                                                      \
-            env->vscr |= (1 << VSCR_SAT);                               \
+            set_vscr_sat(env);                                          \
         }                                                               \
     }
 #define VARITHSAT_SIGNED(suffix, element, optype, cvt)          \
@@ -865,7 +870,7 @@ void helper_vcmpbfp_dot(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
             }                                                           \
         }                                                               \
         if (sat) {                                                      \
-            env->vscr |= (1 << VSCR_SAT);                               \
+            set_vscr_sat(env);                                          \
         }                                                               \
     }
 VCT(uxs, cvtsduw, u32)
@@ -916,7 +921,7 @@ void helper_vmhaddshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
@@ -933,7 +938,7 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
@@ -1061,7 +1066,7 @@ void helper_vmsumshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
@@ -1114,7 +1119,7 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
@@ -1633,7 +1638,7 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
         }                                                               \
         *r = result;                                                    \
         if (dosat && sat) {                                             \
-            env->vscr |= (1 << VSCR_SAT);                               \
+            set_vscr_sat(env);                                          \
         }                                                               \
     }
 #define I(x, y) (x)
@@ -2106,7 +2111,7 @@ void helper_vsumsws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     *r = result;
 
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
@@ -2133,7 +2138,7 @@ void helper_vsum2sws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
     *r = result;
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
@@ -2152,7 +2157,7 @@ void helper_vsum4sbs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
@@ -2169,7 +2174,7 @@ void helper_vsum4shs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
@@ -2188,7 +2193,7 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 
     if (sat) {
-        env->vscr |= (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
 
-- 
2.17.2
