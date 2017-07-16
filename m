Received: from eggs.gnu.org ([2001:4830:134:3::10]:46212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmb-0001At-Gs
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmV-0008IP-9V
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmV-0008Hv-69
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:59 -0400
Message-Id: <1500235468-15341-17-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 16/45] target/hppa: check CF_PARALLEL
 instead of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Thereby decoupling the resulting translated code from the current state
of the system.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/hppa/helper.h    |  2 ++
 target/hppa/op_helper.c | 32 ++++++++++++++++++++++++++++----
 target/hppa/translate.c | 12 ++++++++++--
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 789f07f..0a6b900 100644
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
index c05c0d5..3104404 100644
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
index 91053e2..fde3dba 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2309,9 +2309,17 @@ static ExitStatus trans_stby(DisasContext *ctx, uint32_t insn,
     val = load_gpr(ctx, rt);
 
     if (a) {
-        gen_helper_stby_e(cpu_env, addr, val);
+        if (ctx->tb->cflags & CF_PARALLEL) {
+            gen_helper_stby_e_parallel(cpu_env, addr, val);
+        } else {
+            gen_helper_stby_e(cpu_env, addr, val);
+        }
     } else {
-        gen_helper_stby_b(cpu_env, addr, val);
+        if (ctx->tb->cflags & CF_PARALLEL) {
+            gen_helper_stby_b_parallel(cpu_env, addr, val);
+        } else {
+            gen_helper_stby_b(cpu_env, addr, val);
+        }
     }
 
     if (m) {
-- 
2.7.4
