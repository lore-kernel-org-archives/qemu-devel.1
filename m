Received: from eggs.gnu.org ([2001:4830:134:3::10]:53193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ933-0001p4-1P
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92u-0002w5-CE
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:08 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92u-0002lO-1I
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:00 -0500
Received: by mail-pg1-x541.google.com with SMTP id z11so7360465pgu.0
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:06 -0800
Message-Id: <20181218063911.2112-30-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 29/34] target/ppc: Add helper_mfvscr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This is required before changing the representation of the register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 | 1 +
 target/ppc/arch_dump.c              | 3 ++-
 target/ppc/int_helper.c             | 5 +++++
 target/ppc/translate/vmx-impl.inc.c | 2 +-
 target/ppc/translate_init.inc.c     | 2 +-
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index b3ffe28103..7dbb08b9dd 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -295,6 +295,7 @@ DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
 DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
+DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
 DEF_HELPER_3(lvebx, void, env, avr, tl)
 DEF_HELPER_3(lvehx, void, env, avr, tl)
 DEF_HELPER_3(lvewx, void, env, avr, tl)
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index c272d0d3d4..f753798789 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -17,6 +17,7 @@
 #include "elf.h"
 #include "sysemu/dump.h"
 #include "sysemu/kvm.h"
+#include "exec/helper-proto.h"
 
 #ifdef TARGET_PPC64
 #define ELFCLASS ELFCLASS64
@@ -173,7 +174,7 @@ static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
             vmxregset->avr[i].u64[1] = cpu->env.vsr[32 + i].u64[1];
         }
     }
-    vmxregset->vscr.u32[3] = cpu_to_dump32(s, cpu->env.vscr);
+    vmxregset->vscr.u32[3] = cpu_to_dump32(s, helper_mfvscr(&cpu->env));
 }
 
 static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 0443f33cd2..75201bbba6 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -475,6 +475,11 @@ void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
     set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
 }
 
+uint32_t helper_mfvscr(CPUPPCState *env)
+{
+    return env->vscr;
+}
+
 void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index ab6da3aa55..1c0c461241 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -187,7 +187,7 @@ static void gen_mfvscr(DisasContext *ctx)
     tcg_gen_movi_i64(avr, 0);
     set_avr64(rD(ctx->opcode), avr, true);
     t = tcg_temp_new_i32();
-    tcg_gen_ld_i32(t, cpu_env, offsetof(CPUPPCState, vscr));
+    gen_helper_mfvscr(t, cpu_env);
     tcg_gen_extu_i32_i64(avr, t);
     set_avr64(rD(ctx->opcode), avr, false);
     tcg_temp_free_i32(t);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 292b1df700..353285c6bd 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9527,7 +9527,7 @@ static int gdb_get_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
         return 16;
     }
     if (n == 32) {
-        stl_p(mem_buf, env->vscr);
+        stl_p(mem_buf, helper_mfvscr(env));
         ppc_maybe_bswap_register(env, mem_buf, 4);
         return 4;
     }
-- 
2.17.2
