Received: from eggs.gnu.org ([209.51.188.92]:54388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8l-00054v-9Z
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8j-0002nZ-VC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:47 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:04 +1000
Message-Id: <20190503055316.6441-2-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 01/13] target/ppc: Implement the VTB
 for HV access
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

The virtual timebase register (VTB) is a 64-bit register which
increments at the same rate as the timebase register, present on POWER8
and later processors.

The register is able to be read/written by the hypervisor and read by
the supervisor. All other accesses are illegal.

Currently the VTB is just an alias for the timebase (TB) register.

Implement the VTB so that is can be read/written independent of the TB.
Make use of the existing method for accessing timebase facilities where
by the compensation is stored and used to compute the value on reads/is
updated on writes.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/ppc.c                    | 16 ++++++++++++++++
 include/hw/ppc/ppc.h            |  1 +
 linux-user/ppc/cpu_loop.c       |  5 +++++
 target/ppc/cpu.h                |  2 ++
 target/ppc/helper.h             |  2 ++
 target/ppc/timebase_helper.c    | 10 ++++++++++
 target/ppc/translate_init.inc.c | 19 +++++++++++++++----
 7 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b2ff99ec66..a57ca64626 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -694,6 +694,22 @@ void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value)
                      &tb_env->atb_offset, ((uint64_t)value << 32) | tb);
 }
 
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
+{
+    ppc_tb_t *tb_env = env->tb_env;
+
+    return cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                          tb_env->vtb_offset);
+}
+
+void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
+{
+    ppc_tb_t *tb_env = env->tb_env;
+
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->vtb_offset, value);
+}
+
 static void cpu_ppc_tb_stop (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4bdcb8bacd..205150e6b4 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -23,6 +23,7 @@ struct ppc_tb_t {
     /* Time base management */
     int64_t  tb_offset;    /* Compensation                    */
     int64_t  atb_offset;   /* Compensation                    */
+    int64_t  vtb_offset;
     uint32_t tb_freq;      /* TB frequency                    */
     /* Decrementer management */
     uint64_t decr_next;    /* Tick for next decr interrupt    */
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 801f5ace29..c715861804 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -46,6 +46,11 @@ uint32_t cpu_ppc_load_atbu(CPUPPCState *env)
     return cpu_ppc_get_tb(env) >> 32;
 }
 
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
+{
+    return cpu_ppc_get_tb(env);
+}
+
 uint32_t cpu_ppc601_load_rtcu(CPUPPCState *env)
 __attribute__ (( alias ("cpu_ppc_load_tbu") ));
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index fe93cf0555..70167bae22 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1327,6 +1327,8 @@ uint64_t cpu_ppc_load_atbl (CPUPPCState *env);
 uint32_t cpu_ppc_load_atbu (CPUPPCState *env);
 void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value);
 void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value);
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env);
+void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value);
 bool ppc_decr_clear_on_delivery(CPUPPCState *env);
 target_ulong cpu_ppc_load_decr (CPUPPCState *env);
 void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 69cbf7922f..3701bcbf1b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -680,6 +680,7 @@ DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_tbu, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_atbl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_atbu, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_1(load_vtb, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_601_rtcl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl, env)
 #if !defined(CONFIG_USER_ONLY)
@@ -700,6 +701,7 @@ DEF_HELPER_FLAGS_1(load_decr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_hid0_601, void, env, tl)
 DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
 DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 73363e08ae..8c3c2fe67c 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -45,6 +45,11 @@ target_ulong helper_load_atbu(CPUPPCState *env)
     return cpu_ppc_load_atbu(env);
 }
 
+target_ulong helper_load_vtb(CPUPPCState *env)
+{
+    return cpu_ppc_load_vtb(env);
+}
+
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 target_ulong helper_load_purr(CPUPPCState *env)
 {
@@ -113,6 +118,11 @@ void helper_store_hdecr(CPUPPCState *env, target_ulong val)
     cpu_ppc_store_hdecr(env, val);
 }
 
+void helper_store_vtb(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_vtb(env, val);
+}
+
 target_ulong helper_load_40x_pit(CPUPPCState *env)
 {
     return load_40x_pit(env);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0bd555eb19..e3f941800b 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -310,6 +310,16 @@ static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
     }
 }
 
+static void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_helper_load_vtb(cpu_gpr[gprn], cpu_env);
+}
+
+static void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
+}
+
 #endif
 #endif
 
@@ -8133,10 +8143,11 @@ static void gen_spr_power8_ebb(CPUPPCState *env)
 /* Virtual Time Base */
 static void gen_spr_vtb(CPUPPCState *env)
 {
-    spr_register_kvm(env, SPR_VTB, "VTB",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_tbl, SPR_NOACCESS,
-                 KVM_REG_PPC_VTB, 0x00000000);
+    spr_register_kvm_hv(env, SPR_VTB, "VTB",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_vtb, SPR_NOACCESS,
+                        &spr_read_vtb, &spr_write_vtb,
+                        KVM_REG_PPC_VTB, 0x00000000);
 }
 
 static void gen_spr_power8_fscr(CPUPPCState *env)
-- 
2.13.6
