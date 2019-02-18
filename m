Received: from eggs.gnu.org ([209.51.188.92]:39980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyZ-0007AH-Sk
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyY-0003af-H3
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:44 +1100
Message-Id: <20190218143049.17142-39-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/43] target/ppc: Add helper_mfvscr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

This is required before changing the representation of the register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215100058.20015-13-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/arch_dump.c              | 3 ++-
 target/ppc/helper.h                 | 1 +
 target/ppc/int_helper.c             | 5 +++++
 target/ppc/translate/vmx-impl.inc.c | 2 +-
 target/ppc/translate_init.inc.c     | 2 +-
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 3a00606d01..9ab04b2c38 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -17,6 +17,7 @@
 #include "elf.h"
 #include "sysemu/dump.h"
 #include "sysemu/kvm.h"
+#include "exec/helper-proto.h"
=20
 #ifdef TARGET_PPC64
 #define ELFCLASS ELFCLASS64
@@ -175,7 +176,7 @@ static void ppc_write_elf_vmxregset(NoteFuncArg *arg,=
 PowerPCCPU *cpu)
             vmxregset->avr[i].u64[1] =3D avr->u64[1];
         }
     }
-    vmxregset->vscr.u32[3] =3D cpu_to_dump32(s, cpu->env.vscr);
+    vmxregset->vscr.u32[3] =3D cpu_to_dump32(s, helper_mfvscr(&cpu->env)=
);
 }
=20
 static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
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
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index aa6ad2ce7e..ec3ef9ff3f 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -463,6 +463,11 @@ void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
     set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
 }
=20
+uint32_t helper_mfvscr(CPUPPCState *env)
+{
+    return env->vscr;
+}
+
 void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index 182d3fc563..5e13edbf53 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -187,7 +187,7 @@ static void gen_mfvscr(DisasContext *ctx)
     tcg_gen_movi_i64(avr, 0);
     set_avr64(rD(ctx->opcode), avr, true);
     t =3D tcg_temp_new_i32();
-    tcg_gen_ld_i32(t, cpu_env, offsetof(CPUPPCState, vscr));
+    gen_helper_mfvscr(t, cpu_env);
     tcg_gen_extu_i32_i64(avr, t);
     set_avr64(rD(ctx->opcode), avr, false);
     tcg_temp_free_i32(t);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index ee574b342e..1657d88341 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9573,7 +9573,7 @@ static int gdb_get_avr_reg(CPUPPCState *env, uint8_=
t *mem_buf, int n)
         return 16;
     }
     if (n =3D=3D 32) {
-        stl_p(mem_buf, env->vscr);
+        stl_p(mem_buf, helper_mfvscr(env));
         ppc_maybe_bswap_register(env, mem_buf, 4);
         return 4;
     }
--=20
2.20.1
