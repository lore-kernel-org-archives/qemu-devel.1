Received: from eggs.gnu.org ([2001:4830:134:3::10]:55403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bd-0007bL-Rp
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bb-0003c1-BE
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:01 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:49267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eX8ba-0003Zf-Rv
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:59 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 17:42:45 +0100
Message-Id: <20180104164251.26494-12-laurent@vivier.eu>
In-Reply-To: <20180104164251.26494-1-laurent@vivier.eu>
References: <20180104164251.26494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 11/17] target/m68k: add reset
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

The instruction traps if the CPU is not in
Supervisor state but the helper is empty because
there is no easy way to reset all the peripherals
without resetting the CPU itself.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180104012913.30763-12-laurent@vivier.eu>
---
 target/m68k/helper.c    |  7 +++++++
 target/m68k/helper.h    |  4 ++++
 target/m68k/translate.c | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index af57ffcea9..52b054e1a3 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -711,3 +711,10 @@ void HELPER(set_mac_extu)(CPUM68KState *env, uint32_t val, uint32_t acc)
     res |= (uint64_t)(val & 0xffff0000) << 16;
     env->macc[acc + 1] = res;
 }
+
+#if defined(CONFIG_SOFTMMU)
+void HELPER(reset)(CPUM68KState *env)
+{
+    /* FIXME: reset all except CPU */
+}
+#endif
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 78483da003..d27ea37d60 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -97,3 +97,7 @@ DEF_HELPER_FLAGS_4(bfffo_mem, TCG_CALL_NO_WG, i64, env, i32, s32, i32)
 
 DEF_HELPER_3(chk, void, env, s32, s32)
 DEF_HELPER_4(chk2, void, env, s32, s32, s32)
+
+#if defined(CONFIG_SOFTMMU)
+DEF_HELPER_FLAGS_1(reset, TCG_CALL_NO_RWG, void, env)
+#endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 98efe6b976..e8f7d07f3f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2762,6 +2762,18 @@ DISAS_INSN(unlk)
     tcg_temp_free(src);
 }
 
+#if defined(CONFIG_SOFTMMU)
+DISAS_INSN(reset)
+{
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+
+    gen_helper_reset(cpu_env);
+}
+#endif
+
 DISAS_INSN(nop)
 {
 }
@@ -5572,6 +5584,7 @@ void register_m68k_insns (CPUM68KState *env)
 #if defined(CONFIG_SOFTMMU)
     INSN(move_to_usp, 4e60, fff8, USP);
     INSN(move_from_usp, 4e68, fff8, USP);
+    INSN(reset,     4e70, ffff, M68000);
     BASE(stop,      4e72, ffff);
     BASE(rte,       4e73, ffff);
     INSN(movec,     4e7b, ffff, CF_ISA_A);
-- 
2.14.3
