Received: from eggs.gnu.org ([209.51.188.92]:54542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8y-0005Gd-9V
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8w-0002tg-Mv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:00 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:07 +1000
Message-Id: <20190503055316.6441-5-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 04/13] target/ppc: Add SPR TBU40
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spr TBU40 is used to set the upper 40 bits of the timebase
register, present on POWER5+ and later processors.

This register can only be written by the hypervisor, and cannot be read.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/ppc.c                    | 13 +++++++++++++
 target/ppc/cpu.h                |  1 +
 target/ppc/helper.h             |  1 +
 target/ppc/timebase_helper.c    |  5 +++++
 target/ppc/translate_init.inc.c | 19 +++++++++++++++++++
 5 files changed, 39 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b567156f97..b618c6f615 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -710,6 +710,19 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
                      &tb_env->vtb_offset, value);
 }
 
+void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
+{
+    ppc_tb_t *tb_env = env->tb_env;
+    uint64_t tb;
+
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->tb_offset);
+    tb &= 0xFFFFFFUL;
+    tb |= (value & ~0xFFFFFFUL);
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->tb_offset, tb);
+}
+
 static void cpu_ppc_tb_stop (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8d66265e5a..e324064111 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1334,6 +1334,7 @@ target_ulong cpu_ppc_load_decr (CPUPPCState *env);
 void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
 target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
 void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
+void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
 uint64_t cpu_ppc_load_purr (CPUPPCState *env);
 void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 336e7802fb..6aee195528 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -703,6 +703,7 @@ DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(store_tbu40, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_hid0_601, void, env, tl)
 DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
 DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 2395295b77..703bd9ed18 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -128,6 +128,11 @@ void helper_store_vtb(CPUPPCState *env, target_ulong val)
     cpu_ppc_store_vtb(env, val);
 }
 
+void helper_store_tbu40(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_tbu40(env, val);
+}
+
 target_ulong helper_load_40x_pit(CPUPPCState *env)
 {
     return load_40x_pit(env);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index a0cae58e19..8e287066e5 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -325,6 +325,11 @@ static void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
 }
 
+static void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
+}
+
 #endif
 #endif
 
@@ -7812,6 +7817,16 @@ static void gen_spr_power5p_ear(CPUPPCState *env)
                  0x00000000);
 }
 
+static void gen_spr_power5p_tb(CPUPPCState *env)
+{
+    /* TBU40 (High 40 bits of the Timebase register */
+    spr_register_hv(env, SPR_TBU40, "TBU40",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, &spr_write_tbu40,
+                    0x00000000);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
 {
@@ -8352,6 +8367,7 @@ static void init_proc_power5plus(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
 
     /* env variables */
     env->dcache_line_size = 128;
@@ -8464,6 +8480,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power7_book4(env);
@@ -8605,6 +8622,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power8_tce_address_control(env);
@@ -8793,6 +8811,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power8_tce_address_control(env);
-- 
2.13.6
