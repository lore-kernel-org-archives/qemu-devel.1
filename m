Received: from eggs.gnu.org ([2001:4830:134:3::10]:45783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6k-0008Ud-1X
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6f-0008NS-Sj
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:18 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:51018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6f-0008N6-MA
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:13 -0400
Received: by mail-wr0-x243.google.com with SMTP id p96so9428609wrb.7
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:11 +0200
Message-Id: <20171025093535.10175-28-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 27/51] target/hppa: check CF_PARALLEL instead of
 parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h    |  2 ++
 target/hppa/op_helper.c | 32 ++++++++++++++++++++++++++++----
 target/hppa/translate.c | 12 ++++++++++--
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 789f07fc0a..0a6b900555 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -3,7 +3,9 @@ DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_1(probe_r, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(probe_w, TCG_CALL_NO_RWG_SE, tl, tl)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index c05c0d5572..3104404e8d 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -76,7 +76,8 @@ static void atomic_store_3(CPUHPPAState *env, target_ulong addr, uint32_t val,
 #endif
 }
 
-void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ulong val)
+static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
+                      bool parallel)
 {
     uintptr_t ra = GETPC();
 
@@ -89,7 +90,7 @@ void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ulong val)
         break;
     case 1:
         /* The 3 byte store must appear atomic.  */
-        if (parallel_cpus) {
+        if (parallel) {
             atomic_store_3(env, addr, val, 0x00ffffffu, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 16, ra);
@@ -102,14 +103,26 @@ void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ulong val)
     }
 }
 
-void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ulong val)
+void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ulong val)
+{
+    do_stby_b(env, addr, val, false);
+}
+
+void HELPER(stby_b_parallel)(CPUHPPAState *env, target_ulong addr,
+                             target_ulong val)
+{
+    do_stby_b(env, addr, val, true);
+}
+
+static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ulong val,
+                      bool parallel)
 {
     uintptr_t ra = GETPC();
 
     switch (addr & 3) {
     case 3:
         /* The 3 byte store must appear atomic.  */
-        if (parallel_cpus) {
+        if (parallel) {
             atomic_store_3(env, addr - 3, val, 0xffffff00u, ra);
         } else {
             cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
@@ -132,6 +145,17 @@ void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ulong val)
     }
 }
 
+void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ulong val)
+{
+    do_stby_e(env, addr, val, false);
+}
+
+void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
+                             target_ulong val)
+{
+    do_stby_e(env, addr, val, true);
+}
+
 target_ulong HELPER(probe_r)(target_ulong addr)
 {
     return page_check_range(addr, 1, PAGE_READ);
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 460b4d3154..08b2c73291 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2291,9 +2291,17 @@ static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
     val = load_gpr(ctx, rt);
 
     if (a) {
-        gen_helper_stby_e(cpu_env, addr, val);
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            gen_helper_stby_e_parallel(cpu_env, addr, val);
+        } else {
+            gen_helper_stby_e(cpu_env, addr, val);
+        }
     } else {
-        gen_helper_stby_b(cpu_env, addr, val);
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            gen_helper_stby_b_parallel(cpu_env, addr, val);
+        } else {
+            gen_helper_stby_b(cpu_env, addr, val);
+        }
     }
 
     if (m) {
-- 
2.13.6
