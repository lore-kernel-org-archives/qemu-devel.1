Received: from eggs.gnu.org ([2001:4830:134:3::10]:56831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIM-0001h8-Ne
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIL-0003aV-N8
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:25 +1000
Message-Id: <20170424015927.8933-46-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 45/47] target/ppc: Flush TLB on write to PIDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The PIDR (process id register) is used to store the id of the currently
running process, which is used to select the process table entry used to
perform address translation. This means that when we write to this register
all the translations in the TLB become outdated as they are for a
previously running process. Thus when this register is written to we need
to invalidate the TLB entries to ensure stale entries aren't used to
to perform translation for the new process, which would result in at best
segfaults or alternatively just random memory being accessed.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
[dwg: Fixed compile error for 32-bit targets]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h         |  1 +
 target/ppc/misc_helper.c    |  8 ++++++++
 target/ppc/translate_init.c | 10 ++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6d77661..bb6a94a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -709,6 +709,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
+DEF_HELPER_2(store_pidr, void, env, tl)
 DEF_HELPER_FLAGS_2(store_tbl, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_tbu, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_atbl, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index fa573dd..0e42178 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -88,6 +88,14 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
     }
 }
 
+void helper_store_pidr(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+
+    env->spr[SPR_BOOKS_PID] = val;
+    tlb_flush(CPU(cpu));
+}
+
 void helper_store_hid0_601(CPUPPCState *env, target_ulong val)
 {
     target_ulong hid0;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index aa0c44d..77e5463 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -394,8 +394,14 @@ static void spr_write_sdr1 (DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_sdr1(cpu_env, cpu_gpr[gprn]);
 }
 
-/* 64 bits PowerPC specific SPRs */
 #if defined(TARGET_PPC64)
+/* 64 bits PowerPC specific SPRs */
+/* PIDR */
+static void spr_write_pidr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_pidr(cpu_env, cpu_gpr[gprn]);
+}
+
 static void spr_read_hior (DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, excp_prefix));
@@ -8200,7 +8206,7 @@ static void gen_spr_power8_book4(CPUPPCState *env)
                      KVM_REG_PPC_ACOP, 0);
     spr_register_kvm(env, SPR_BOOKS_PID, "PID",
                      SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, &spr_write_generic,
+                     &spr_read_generic, &spr_write_pidr,
                      KVM_REG_PPC_PID, 0);
     spr_register_kvm(env, SPR_WORT, "WORT",
                      SPR_NOACCESS, SPR_NOACCESS,
-- 
2.9.3
