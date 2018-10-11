Received: from eggs.gnu.org ([2001:4830:134:3::10]:54216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkaq-0001o9-Fj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkao-0002HG-Az
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:12 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:40710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAkam-000253-9n
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:10 -0400
Received: by mail-pg1-x533.google.com with SMTP id n31-v6so4907749pgm.7
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:42:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 16:41:54 -0700
Message-Id: <20181011234159.11496-3-richard.henderson@linaro.org>
In-Reply-To: <20181011234159.11496-1-richard.henderson@linaro.org>
References: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/7] target/ppc: Remove float_check_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

Use do_float_check_status directly, so that we don't get confused
about which return address we're using.  And definitely don't use
helper_float_check_status.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c | 77 +++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 42 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 6ec5227dd5..c9198f826d 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -630,13 +630,6 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
     }
 }
 
-static inline  __attribute__((__always_inline__))
-void float_check_status(CPUPPCState *env)
-{
-    /* GETPC() works here because this is inline */
-    do_float_check_status(env, GETPC());
-}
-
 void helper_float_check_status(CPUPPCState *env)
 {
     do_float_check_status(env, GETPC());
@@ -757,7 +750,7 @@ uint64_t helper_##op(CPUPPCState *env, uint64_t arg)                   \
                    float_flag_invalid) {                               \
             float_invalid_op_vxcvi(env, 1, GETPC());                   \
         }                                                              \
-        float_check_status(env);                                       \
+        do_float_check_status(env, GETPC());                           \
     }                                                                  \
     return farg.ll;                                                    \
  }
@@ -782,7 +775,7 @@ uint64_t helper_##op(CPUPPCState *env, uint64_t arg)       \
     } else {                                               \
         farg.d = cvtr(arg, &env->fp_status);               \
     }                                                      \
-    float_check_status(env);                               \
+    do_float_check_status(env, GETPC());                   \
     return farg.ll;                                        \
 }
 
@@ -815,7 +808,7 @@ static inline uint64_t do_fri(CPUPPCState *env, uint64_t arg,
             env->fp_status.float_exception_flags &= ~float_flag_inexact;
         }
     }
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
     return farg.ll;
 }
 
@@ -885,7 +878,7 @@ uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
             float64_maddsub_update_excp(env, arg1, arg2, arg3,          \
                                         madd_flags, GETPC());           \
         }                                                               \
-        float_check_status(env);                                        \
+        do_float_check_status(env, GETPC());                            \
     }                                                                   \
     return ret;                                                         \
 }
@@ -1819,7 +1812,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
         }                                                                    \
     }                                                                        \
     putVSR(xT(opcode), &xt, env);                                            \
-    float_check_status(env);                                                 \
+    do_float_check_status(env, GETPC());                                     \
 }
 
 VSX_ADD_SUB(xsadddp, add, 1, float64, VsrD(0), 1, 0)
@@ -1862,7 +1855,7 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
     helper_compute_fprf_float128(env, xt.f128);
 
     putVSR(rD(opcode) + 32, &xt, env);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
 
 /* VSX_MUL - VSX floating point multiply
@@ -1909,7 +1902,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
     }                                                                        \
                                                                              \
     putVSR(xT(opcode), &xt, env);                                            \
-    float_check_status(env);                                                 \
+    do_float_check_status(env, GETPC());                                     \
 }
 
 VSX_MUL(xsmuldp, 1, float64, VsrD(0), 1, 0)
@@ -1948,7 +1941,7 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
     helper_compute_fprf_float128(env, xt.f128);
 
     putVSR(rD(opcode) + 32, &xt, env);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
 
 /* VSX_DIV - VSX floating point divide
@@ -1999,7 +1992,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
     }                                                                         \
                                                                               \
     putVSR(xT(opcode), &xt, env);                                             \
-    float_check_status(env);                                                  \
+    do_float_check_status(env, GETPC());                                      \
 }
 
 VSX_DIV(xsdivdp, 1, float64, VsrD(0), 1, 0)
@@ -2042,7 +2035,7 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
 
     helper_compute_fprf_float128(env, xt.f128);
     putVSR(rD(opcode) + 32, &xt, env);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
 
 /* VSX_RE  - VSX floating point reciprocal estimate
@@ -2078,7 +2071,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
     }                                                                         \
                                                                               \
     putVSR(xT(opcode), &xt, env);                                             \
-    float_check_status(env);                                                  \
+    do_float_check_status(env, GETPC());                                      \
 }
 
 VSX_RE(xsredp, 1, float64, VsrD(0), 1, 0)
@@ -2127,7 +2120,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
     }                                                                        \
                                                                              \
     putVSR(xT(opcode), &xt, env);                                            \
-    float_check_status(env);                                                 \
+    do_float_check_status(env, GETPC());                                     \
 }
 
 VSX_SQRT(xssqrtdp, 1, float64, VsrD(0), 1, 0)
@@ -2177,7 +2170,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
     }                                                                        \
                                                                              \
     putVSR(xT(opcode), &xt, env);                                            \
-    float_check_status(env);                                                 \
+    do_float_check_status(env, GETPC());                                     \
 }
 
 VSX_RSQRTE(xsrsqrtedp, 1, float64, VsrD(0), 1, 0)
@@ -2360,7 +2353,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
         }                                                                     \
     }                                                                         \
     putVSR(xT(opcode), &xt_out, env);                                         \
-    float_check_status(env);                                                  \
+    do_float_check_status(env, GETPC());                                      \
 }
 
 VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
@@ -2443,7 +2436,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
         }                                                                     \
     }                                                                         \
     putVSR(xT(opcode), &xt, env);                                             \
-    helper_float_check_status(env);                                           \
+    do_float_check_status(env, GETPC());                                      \
 }
 
 VSX_SCALAR_CMP_DP(xscmpeqdp, eq, 1, 0)
@@ -2480,7 +2473,7 @@ void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode)
     env->fpscr |= cc << FPSCR_FPRF;
     env->crf[BF(opcode)] = cc;
 
-    helper_float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
 
 void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
@@ -2512,7 +2505,7 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
     env->fpscr |= cc << FPSCR_FPRF;
     env->crf[BF(opcode)] = cc;
 
-    helper_float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
 
 #define VSX_SCALAR_CMP(op, ordered)                                      \
@@ -2559,7 +2552,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
     env->fpscr |= cc << FPSCR_FPRF;                                      \
     env->crf[BF(opcode)] = cc;                                           \
                                                                          \
-    float_check_status(env);                                             \
+    do_float_check_status(env, GETPC());                                 \
 }
 
 VSX_SCALAR_CMP(xscmpodp, 1)
@@ -2609,7 +2602,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
     env->fpscr |= cc << FPSCR_FPRF;                                     \
     env->crf[BF(opcode)] = cc;                                          \
                                                                         \
-    float_check_status(env);                                            \
+    do_float_check_status(env, GETPC());                                \
 }
 
 VSX_SCALAR_CMPQ(xscmpoqp, 1)
@@ -2641,7 +2634,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
     }                                                                         \
                                                                               \
     putVSR(xT(opcode), &xt, env);                                             \
-    float_check_status(env);                                                  \
+    do_float_check_status(env, GETPC());                                      \
 }
 
 VSX_MAX_MIN(xsmaxdp, maxnum, 1, float64, VsrD(0))
@@ -2792,7 +2785,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
     if ((opcode >> (31-21)) & 1) {                                        \
         env->crf[6] = (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);       \
     }                                                                     \
-    float_check_status(env);                                              \
+    do_float_check_status(env, GETPC());                                  \
  }
 
 VSX_CMP(xvcmpeqdp, 2, float64, VsrD(i), eq, 0, 1)
@@ -2835,7 +2828,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
     }                                                              \
                                                                    \
     putVSR(xT(opcode), &xt, env);                                  \
-    float_check_status(env);                                       \
+    do_float_check_status(env, GETPC());                           \
 }
 
 VSX_CVT_FP_TO_FP(xscvdpsp, 1, float64, float32, VsrD(0), VsrW(0), 1)
@@ -2874,7 +2867,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
     }                                                                   \
                                                                         \
     putVSR(rD(opcode) + 32, &xt, env);                                  \
-    float_check_status(env);                                            \
+    do_float_check_status(env, GETPC());                                \
 }
 
 VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, float128, VsrD(0), f128, 1)
@@ -2911,7 +2904,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
     }                                                              \
                                                                    \
     putVSR(xT(opcode), &xt, env);                                  \
-    float_check_status(env);                                       \
+    do_float_check_status(env, GETPC());                           \
 }
 
 VSX_CVT_FP_TO_FP_HP(xscvdphp, 1, float64, float16, VsrD(0), VsrH(3), 1)
@@ -2945,7 +2938,7 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
     helper_compute_fprf_float64(env, xt.VsrD(0));
 
     putVSR(rD(opcode) + 32, &xt, env);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
 
 uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
@@ -2999,7 +2992,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
     }                                                                        \
                                                                              \
     putVSR(xT(opcode), &xt, env);                                            \
-    float_check_status(env);                                                 \
+    do_float_check_status(env, GETPC());                                     \
 }
 
 VSX_CVT_FP_TO_INT(xscvdpsxds, 1, float64, int64, VsrD(0), VsrD(0), \
@@ -3051,7 +3044,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
     }                                                                        \
                                                                              \
     putVSR(rD(opcode) + 32, &xt, env);                                       \
-    float_check_status(env);                                                 \
+    do_float_check_status(env, GETPC());                                     \
 }
 
 VSX_CVT_FP_TO_INT_VECTOR(xscvqpsdz, float128, int64, f128, VsrD(0),          \
@@ -3092,7 +3085,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
     }                                                                   \
                                                                         \
     putVSR(xT(opcode), &xt, env);                                       \
-    float_check_status(env);                                            \
+    do_float_check_status(env, GETPC());                                \
 }
 
 VSX_CVT_INT_TO_FP(xscvsxddp, 1, int64, float64, VsrD(0), VsrD(0), 1, 0)
@@ -3127,7 +3120,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
     helper_compute_fprf_##ttp(env, xt.tfld);                            \
                                                                         \
     putVSR(xT(opcode) + 32, &xt, env);                                  \
-    float_check_status(env);                                            \
+    do_float_check_status(env, GETPC());                                \
 }
 
 VSX_CVT_INT_TO_FP_VECTOR(xscvsdqp, int64, float128, VsrD(0), f128)
@@ -3181,7 +3174,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                    \
     }                                                                  \
                                                                        \
     putVSR(xT(opcode), &xt, env);                                      \
-    float_check_status(env);                                           \
+    do_float_check_status(env, GETPC());                               \
 }
 
 VSX_ROUND(xsrdpi, 1, float64, VsrD(0), float_round_ties_away, 1)
@@ -3209,7 +3202,7 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
     uint64_t xt = helper_frsp(env, xb);
 
     helper_compute_fprf_float64(env, xt);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
     return xt;
 }
 
@@ -3401,7 +3394,7 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
     }
 
     helper_compute_fprf_float128(env, xt.f128);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
     putVSR(rD(opcode) + 32, &xt, env);
 }
 
@@ -3458,7 +3451,7 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
 
     helper_compute_fprf_float128(env, xt.f128);
     putVSR(rD(opcode) + 32, &xt, env);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
 
 void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
@@ -3494,7 +3487,7 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
 
     helper_compute_fprf_float128(env, xt.f128);
     putVSR(rD(opcode) + 32, &xt, env);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
 
 void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
@@ -3527,5 +3520,5 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
 
     helper_compute_fprf_float128(env, xt.f128);
     putVSR(rD(opcode) + 32, &xt, env);
-    float_check_status(env);
+    do_float_check_status(env, GETPC());
 }
-- 
2.17.1
