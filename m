Received: from eggs.gnu.org ([2001:4830:134:3::10]:55270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCa-0007bn-VD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCZ-0001TW-TX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:24 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCZ-0000rT-HR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:23 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:03:52 -0500
Message-Id: <20181213050453.9677-13-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 12/73] m68k: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/m68k/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 752e46ef63..5bd4220e06 100644
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
