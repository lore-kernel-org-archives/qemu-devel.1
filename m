Received: from eggs.gnu.org ([2001:4830:134:3::10]:37555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjALF-0005cu-Te
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjALE-0006CH-KI
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:55:17 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  2 Mar 2017 06:55:02 +1100
Message-Id: <20170301195502.4432-2-rth@twiddle.net>
In-Reply-To: <20170301195502.4432-1-rth@twiddle.net>
References: <20170301195502.4432-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL] target/sparc: Restore ldstub of odd asis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org

Fixes the booting of ss20 roms.

Cc: qemu-stable@nongnu.org
Reported-by: Michael Russo <mike@papersolve.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/translate.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 655060c..aa6734d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2448,8 +2448,31 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
         gen_ldstub(dc, dst, addr, da.mem_idx);
         break;
     default:
-        /* ??? Should be DAE_invalid_asi.  */
-        gen_exception(dc, TT_DATA_ACCESS);
+        /* ??? In theory, this should be raise DAE_invalid_asi.
+           But the SS-20 roms do ldstuba [%l0] #ASI_M_CTL, %o1.  */
+        if (parallel_cpus) {
+            gen_helper_exit_atomic(cpu_env);
+        } else {
+            TCGv_i32 r_asi = tcg_const_i32(da.asi);
+            TCGv_i32 r_mop = tcg_const_i32(MO_UB);
+            TCGv_i64 s64, t64;
+
+            save_state(dc);
+            t64 = tcg_temp_new_i64();
+            gen_helper_ld_asi(t64, cpu_env, addr, r_asi, r_mop);
+
+            s64 = tcg_const_i64(0xff);
+            gen_helper_st_asi(cpu_env, addr, s64, r_asi, r_mop);
+            tcg_temp_free_i64(s64);
+            tcg_temp_free_i32(r_mop);
+            tcg_temp_free_i32(r_asi);
+
+            tcg_gen_trunc_i64_tl(dst, t64);
+            tcg_temp_free_i64(t64);
+
+            /* End the TB.  */
+            dc->npc = DYNAMIC_PC;
+        }
         break;
     }
 }
-- 
2.9.3
