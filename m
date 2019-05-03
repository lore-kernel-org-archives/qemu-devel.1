Received: from eggs.gnu.org ([209.51.188.92]:54453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8q-00058x-E9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8o-0002qI-NI
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:52 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:05 +1000
Message-Id: <20190503055316.6441-3-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 02/13] target/ppc: Work [S]PURR
 implementation and add HV support
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

The Processor Utilisation of Resources Register (PURR) and Scaled
Processor Utilisation of Resources Register (SPURR) provide an estimate
of the resources used by the thread, present on POWER7 and later
processors.

Currently the [S]PURR registers simply count at the rate of the
timebase.

Preserve this behaviour but rework the implementation to store an offset
like the timebase rather than doing the calculation manually. Also allow
hypervisor write access to the register along with the currently
available read access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/ppc.c                    | 17 +++++++----------
 include/hw/ppc/ppc.h            |  3 +--
 target/ppc/cpu.h                |  1 +
 target/ppc/helper.h             |  1 +
 target/ppc/timebase_helper.c    |  5 +++++
 target/ppc/translate_init.inc.c | 23 +++++++++++++++--------
 6 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a57ca64626..b567156f97 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -819,12 +819,9 @@ target_ulong cpu_ppc_load_hdecr (CPUPPCState *env)
 uint64_t cpu_ppc_load_purr (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    uint64_t diff;
 
-    diff = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - tb_env->purr_start;
-
-    return tb_env->purr_load +
-        muldiv64(diff, tb_env->tb_freq, NANOSECONDS_PER_SECOND);
+    return cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                          tb_env->purr_offset);
 }
 
 /* When decrementer expires,
@@ -980,12 +977,12 @@ static void cpu_ppc_hdecr_cb(void *opaque)
     cpu_ppc_hdecr_excp(cpu);
 }
 
-static void cpu_ppc_store_purr(PowerPCCPU *cpu, uint64_t value)
+void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
 {
-    ppc_tb_t *tb_env = cpu->env.tb_env;
+    ppc_tb_t *tb_env = env->tb_env;
 
-    tb_env->purr_load = value;
-    tb_env->purr_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->purr_offset, value);
 }
 
 static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
@@ -1002,7 +999,7 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
      */
     _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
     _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
-    cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
+    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
 }
 
 static void timebase_save(PPCTimebase *tb)
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 205150e6b4..b09ffbf300 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -32,8 +32,7 @@ struct ppc_tb_t {
     /* Hypervisor decrementer management */
     uint64_t hdecr_next;    /* Tick for next hdecr interrupt  */
     QEMUTimer *hdecr_timer;
-    uint64_t purr_load;
-    uint64_t purr_start;
+    int64_t purr_offset;
     void *opaque;
     uint32_t flags;
 };
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 70167bae22..19b3e1de0e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1335,6 +1335,7 @@ void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
 target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
 void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
 uint64_t cpu_ppc_load_purr (CPUPPCState *env);
+void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
 uint32_t cpu_ppc601_load_rtcu (CPUPPCState *env);
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3701bcbf1b..336e7802fb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -686,6 +686,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl, env)
 #if !defined(CONFIG_USER_ONLY)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_ptcr, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 8c3c2fe67c..2395295b77 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -55,6 +55,11 @@ target_ulong helper_load_purr(CPUPPCState *env)
 {
     return (target_ulong)cpu_ppc_load_purr(env);
 }
+
+void helper_store_purr(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_purr(env, val);
+}
 #endif
 
 target_ulong helper_load_601_rtcl(CPUPPCState *env)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index e3f941800b..9cd33e79ef 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -285,6 +285,11 @@ static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
     gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
 }
 
+static void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_purr(cpu_env, cpu_gpr[gprn]);
+}
+
 /* HDECR */
 static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 {
@@ -7972,14 +7977,16 @@ static void gen_spr_book3s_purr(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     /* PURR & SPURR: Hack - treat these as aliases for the TB for now */
-    spr_register_kvm(env, SPR_PURR,   "PURR",
-                     &spr_read_purr, SPR_NOACCESS,
-                     &spr_read_purr, SPR_NOACCESS,
-                     KVM_REG_PPC_PURR, 0x00000000);
-    spr_register_kvm(env, SPR_SPURR,   "SPURR",
-                     &spr_read_purr, SPR_NOACCESS,
-                     &spr_read_purr, SPR_NOACCESS,
-                     KVM_REG_PPC_SPURR, 0x00000000);
+    spr_register_kvm_hv(env, SPR_PURR,   "PURR",
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, &spr_write_purr,
+                        KVM_REG_PPC_PURR, 0x00000000);
+    spr_register_kvm_hv(env, SPR_SPURR,   "SPURR",
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, &spr_write_purr,
+                        KVM_REG_PPC_SPURR, 0x00000000);
 #endif
 }
 
-- 
2.13.6
