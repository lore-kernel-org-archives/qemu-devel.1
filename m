Received: from eggs.gnu.org ([2001:4830:134:3::10]:55440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8be-0007cG-Qe
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bb-0003cz-Ql
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:64820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eX8bb-0003aL-De
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:59 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 17:42:46 +0100
Message-Id: <20180104164251.26494-13-laurent@vivier.eu>
In-Reply-To: <20180104164251.26494-1-laurent@vivier.eu>
References: <20180104164251.26494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 12/17] target/m68k: implement fsave/frestore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180104012913.30763-13-laurent@vivier.eu>
---
 target/m68k/translate.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e8f7d07f3f..b8ed85c237 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5103,28 +5103,35 @@ DISAS_INSN(fscc)
 #if defined(CONFIG_SOFTMMU)
 DISAS_INSN(frestore)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
+    TCGv addr;
 
     if (IS_USER(s)) {
         gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
-
-    /* TODO: Implement frestore.  */
-    cpu_abort(CPU(cpu), "FRESTORE not implemented");
+    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
+        SRC_EA(env, addr, OS_LONG, 0, NULL);
+        /* FIXME: check the state frame */
+    } else {
+        disas_undef(env, s, insn);
+    }
 }
 
 DISAS_INSN(fsave)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-
     if (IS_USER(s)) {
         gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
 
-    /* TODO: Implement fsave.  */
-    cpu_abort(CPU(cpu), "FSAVE not implemented");
+    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
+        /* always write IDLE */
+        TCGv idle = tcg_const_i32(0x41000000);
+        DEST_EA(env, insn, OS_LONG, idle, NULL);
+        tcg_temp_free(idle);
+    } else {
+        disas_undef(env, s, insn);
+    }
 }
 #endif
 
-- 
2.14.3
