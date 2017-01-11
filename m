Received: from eggs.gnu.org ([2001:4830:134:3::10]:56984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEF-0008N4-6z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEA-0005Zj-LJ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:15 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:48248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1cRJEA-0005Xs-Dj
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:10 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 11 Jan 2017 14:45:49 +0100
Message-Id: <20170111134549.32669-6-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
References: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 5/5] target-tricore: Add updfl instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/tricore/fpu_helper.c | 14 ++++++++++++++
 target/tricore/helper.h     |  1 +
 target/tricore/translate.c  |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 9bfed28b45..7979bb6692 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -333,3 +333,17 @@ uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
     }
     return result;
 }
+
+void helper_updfl(CPUTriCoreState *env, uint32_t arg)
+{
+    env->FPU_FS =  extract32(arg, 7, 1) & extract32(arg, 15, 1);
+    env->FPU_FI = (extract32(arg, 6, 1) & extract32(arg, 14, 1)) << 31;
+    env->FPU_FV = (extract32(arg, 5, 1) & extract32(arg, 13, 1)) << 31;
+    env->FPU_FZ = (extract32(arg, 4, 1) & extract32(arg, 12, 1)) << 31;
+    env->FPU_FU = (extract32(arg, 3, 1) & extract32(arg, 11, 1)) << 31;
+    /* clear FX and RM */
+    env->PSW &= ~(extract32(arg, 10, 1) << 26);
+    env->PSW |= (extract32(arg, 2, 1) & extract32(arg, 10, 1)) << 26;
+
+    fpu_set_state(env);
+}
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index c897a44eb3..012ac9679c 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -115,6 +115,7 @@ DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
 DEF_HELPER_2(ftouz, i32, env, i32)
+DEF_HELPER_2(updfl, void, env, i32)
 /* dvinit */
 DEF_HELPER_3(dvinit_b_13, i64, env, i32, i32)
 DEF_HELPER_3(dvinit_b_131, i64, env, i32, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 9d1ee66b94..54249c1547 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6735,6 +6735,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_FTOUZ:
         gen_helper_ftouz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_UPDFL:
+        gen_helper_updfl(cpu_env, cpu_gpr_d[r1]);
+        break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-- 
2.11.0
