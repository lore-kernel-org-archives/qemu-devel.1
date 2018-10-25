Received: from eggs.gnu.org ([2001:4830:134:3::10]:60299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5V-0004D4-4e
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgup-0007nh-3F
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgun-0007fO-1N
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:44 -0400
Message-Id: <20181025144644.15464-11-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 11/71] m68k: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>

Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/m68k/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ae3651b867..d55e707cf6 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -43,7 +43,6 @@
 #undef DEFO32
 #undef DEFO64
 
-static TCGv_i32 cpu_halted;
 static TCGv_i32 cpu_exception_index;
 
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
@@ -79,9 +78,6 @@ void m68k_tcg_init(void)
 #undef DEFO32
 #undef DEFO64
 
-    cpu_halted = tcg_global_mem_new_i32(cpu_env,
-                                        -offsetof(M68kCPU, env) +
-                                        offsetof(CPUState, halted), "HALTED");
     cpu_exception_index = tcg_global_mem_new_i32(cpu_env,
                                                  -offsetof(M68kCPU, env) +
                                                  offsetof(CPUState, exception_index),
@@ -4637,6 +4633,7 @@ DISAS_INSN(halt)
 DISAS_INSN(stop)
 {
     uint16_t ext;
+    TCGv_i32 tmp;
 
     if (IS_USER(s)) {
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
@@ -4646,7 +4643,9 @@ DISAS_INSN(stop)
     ext = read_im16(env, s);
 
     gen_set_sr_im(s, ext, 0);
-    tcg_gen_movi_i32(cpu_halted, 1);
+    tmp = tcg_const_i32(1);
+    gen_helper_cpu_halted_set(cpu_env, tmp);
+    tcg_temp_free_i32(tmp);
     gen_exception(s, s->pc, EXCP_HLT);
 }
 
-- 
2.17.1
