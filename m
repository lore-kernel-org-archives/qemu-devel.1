Received: from eggs.gnu.org ([2001:4830:134:3::10]:45654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fYddk-0007Hy-V1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fYddh-0008AM-Rd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:35:40 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Thu, 28 Jun 2018 22:35:24 +0200
Message-Id: <20180628203524.16221-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [RFC] ppc/tcg: send cpu to sleep for simple endless
 guest loops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mail@sebastianbauer.info
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org

When a branch instructions points to itself, only external events will
change the internally observable cpu state. This change will adjust the
behaviour of QEMU such that it sends the emulated cpu into a sleep state
if this case is detected.

The effect for guests whose idle task contains this endless loop (e.g.,
AmigaOS) is that they no longer hog the cpu of the host if they are idle.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>

---

This is a RFC because I'm not really familiar with the internals
of QEMU. There are probably other (better) ways to achive a similar
behaviour. For that reason I haven't tested the change thoroughly
yet, except that it produces the desired effect.

The patch will change the behaviour wrt. the instruction count which
is no longer the same. But I don't think that this will matter.

I will be grateful for any expressed concerns and suggestion of that
matter.

Patch is based on ppc-for-3.0.
---
 target/ppc/helper.h    |  2 ++
 target/ppc/translate.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index d751f0e219..5f9b157417 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -799,3 +799,5 @@ DEF_HELPER_4(dscliq, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+DEF_HELPER_1(sleep, void, env)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3a215a1dc6..7db53003ea 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3469,6 +3469,18 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_lr, nip);
 }
 
+/* Helper for bringing the cpu to the sleep state so it will
+ * react only on "external" events */
+void helper_sleep(CPUPPCState *env)
+{
+    CPUState *cs = CPU(ppc_env_get_cpu(env));
+
+    cs->exception_index = EXCP_HALTED;
+    cs->exit_request = 1;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
+}
+
 /* b ba bl bla */
 static void gen_b(DisasContext *ctx)
 {
@@ -3483,6 +3495,13 @@ static void gen_b(DisasContext *ctx)
     } else {
         target = li;
     }
+
+    if (target == ctx->base.pc_next - 4) {
+        /* Endless-loop, CPU can now react on "external" events only, so we
+         * simply go to sleep in order to save host processing resources */
+        gen_helper_sleep(cpu_env);
+    }
+
     if (LK(ctx->opcode)) {
         gen_setlr(ctx, ctx->base.pc_next);
     }
-- 
2.18.0
