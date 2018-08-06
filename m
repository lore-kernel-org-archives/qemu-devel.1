Received: from eggs.gnu.org ([2001:4830:134:3::10]:37926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmUJ0-0008QS-O9
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmUIy-0001Ft-Hx
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:30 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fmUIy-0001Fa-DE
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:28 -0400
Received: by mail-pg1-x533.google.com with SMTP id r5-v6so5444561pgv.0
	for <qemu-devel@nongnu.org>; Sun, 05 Aug 2018 18:27:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  5 Aug 2018 18:27:22 -0700
Message-Id: <20180806012723.5639-2-richard.henderson@linaro.org>
In-Reply-To: <20180806012723.5639-1-richard.henderson@linaro.org>
References: <20180806012723.5639-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] fixup! target/ppc: Honor fpscr_ze
 semantics and tidy fdiv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk

---
 target/ppc/fpu_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index cb82e6e842..faea64020b 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1965,6 +1965,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
                 tp##_is_signaling_nan(xb.fld, &tstat)) {                      \
                 float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);    \
             }                                                                 \
+        }                                                                     \
+        if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {   \
+            float_zero_divide_excp(env, GETPC());                             \
         }                                                                     \
                                                                               \
         if (r2sp) {                                                           \
@@ -2015,6 +2018,9 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
             float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
         }
     }
+    if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {
+        float_zero_divide_excp(env, GETPC());
+    }
 
     helper_compute_fprf_float128(env, xt.f128);
     putVSR(rD(opcode) + 32, &xt, env);
-- 
2.17.1
