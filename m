Received: from eggs.gnu.org ([2001:4830:134:3::10]:56982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEF-0008N3-5Y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEA-0005a6-P7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:15 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:48231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1cRJEA-0005XS-Iz
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:10 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 11 Jan 2017 14:45:45 +0100
Message-Id: <20170111134549.32669-2-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
References: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 1/5] target-tricore: Added FTOUZ instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Converts a 32-bit floating point number to an unsigned int. The
result is rounded towards zero.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/tricore/fpu_helper.c | 27 +++++++++++++++++++++++++++
 target/tricore/helper.h     |  1 +
 target/tricore/translate.c  |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 98fe9472b1..215c3970b1 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -215,3 +215,30 @@ uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
     }
     return (uint32_t)f_result;
 }
+
+uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
+{
+    float32 f_arg = make_float32(arg);
+    uint32_t result;
+    int32_t flags;
+
+    result = float32_to_uint32_round_to_zero(f_arg, &env->fp_status);
+
+    flags = f_get_excp_flags(env);
+    if (flags & float_flag_invalid) {
+        flags &= ~float_flag_inexact;
+        if (float32_is_any_nan(f_arg)) {
+            result = 0;
+        }
+    } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
+        flags = float_flag_invalid;
+        result = 0;
+    }
+
+    if (flags) {
+        f_update_psw_flags(env, flags);
+    } else {
+        env->FPU_FS = 0;
+    }
+    return result;
+}
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 9333e161ab..467c88013a 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -112,6 +112,7 @@ DEF_HELPER_3(fdiv, i32, env, i32, i32)
 DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
+DEF_HELPER_2(ftouz, i32, env, i32)
 /* dvinit */
 DEF_HELPER_3(dvinit_b_13, i64, env, i32, i32)
 DEF_HELPER_3(dvinit_b_131, i64, env, i32, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 36f734a662..eb6fdc3ca4 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6698,6 +6698,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_ITOF:
         gen_helper_itof(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_FTOUZ:
+        gen_helper_ftouz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-- 
2.11.0
