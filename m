Received: from eggs.gnu.org ([2001:4830:134:3::10]:43154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkp-00061V-O8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETko-0007J7-ER
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:15 +1000
Message-Id: <20180504055930.3786-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/17] target/ppc: add basic support for PTCR on
 POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The Partition Table Control Register (PTCR) is a hypervisor privileged
SPR. It contains the host real address of the Partition Table and its
size.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h            |  2 ++
 target/ppc/helper.h         |  1 +
 target/ppc/misc_helper.c    | 12 ++++++++++++
 target/ppc/mmu-book3s-v3.h  |  6 ++++++
 target/ppc/mmu_helper.c     | 29 +++++++++++++++++++++++++++++
 target/ppc/translate.c      |  3 +++
 target/ppc/translate_init.c | 18 ++++++++++++++++++
 7 files changed, 71 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8c9e03f54d..2f619f39d3 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1295,6 +1295,7 @@ int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr a=
ddress, int size, int rw,
=20
 #if !defined(CONFIG_USER_ONLY)
 void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
+void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr (CPUPPCState *env, target_ulong value);
=20
@@ -1585,6 +1586,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
 #define SPR_BOOKE_GIVOR13     (0x1BC)
 #define SPR_BOOKE_GIVOR14     (0x1BD)
 #define SPR_TIR               (0x1BE)
+#define SPR_PTCR              (0x1D0)
 #define SPR_BOOKE_SPEFSCR     (0x200)
 #define SPR_Exxx_BBEAR        (0x201)
 #define SPR_Exxx_BBTAR        (0x202)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5b739179b8..19453c6813 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -709,6 +709,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl=
, env)
 #if !defined(CONFIG_USER_ONLY)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_2(store_ptcr, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 0e4217821b..8c8cba5cc6 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -88,6 +88,18 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong =
val)
     }
 }
=20
+#if defined(TARGET_PPC64)
+void helper_store_ptcr(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
+
+    if (env->spr[SPR_PTCR] !=3D val) {
+        ppc_store_ptcr(env, val);
+        tlb_flush(CPU(cpu));
+    }
+}
+#endif /* defined(TARGET_PPC64) */
+
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 56095dab52..fdf80987d7 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -22,6 +22,12 @@
=20
 #ifndef CONFIG_USER_ONLY
=20
+/*
+ * Partition table definitions
+ */
+#define PTCR_PATB               0x0FFFFFFFFFFFF000ULL /* Partition Table=
 Base */
+#define PTCR_PATS               0x000000000000001FULL /* Partition Table=
 Size */
+
 /* Partition Table Entry Fields */
 #define PATBE1_GR 0x8000000000000000
=20
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 8075b7149a..98ce17985b 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2028,6 +2028,35 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong=
 value)
     env->spr[SPR_SDR1] =3D value;
 }
=20
+#if defined(TARGET_PPC64)
+void ppc_store_ptcr(CPUPPCState *env, target_ulong value)
+{
+    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
+    target_ulong ptcr_mask =3D PTCR_PATB | PTCR_PATS;
+    target_ulong patbsize =3D value & PTCR_PATS;
+
+    qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, valu=
e);
+
+    assert(!cpu->vhyp);
+    assert(env->mmu_model & POWERPC_MMU_3_00);
+
+    if (value & ~ptcr_mask) {
+        error_report("Invalid bits 0x"TARGET_FMT_lx" set in PTCR",
+                     value & ~ptcr_mask);
+        value &=3D ptcr_mask;
+    }
+
+    if (patbsize > 24) {
+        error_report("Invalid Partition Table size 0x" TARGET_FMT_lx
+                     " stored in PTCR", patbsize);
+        return;
+    }
+
+    env->spr[SPR_PTCR] =3D value;
+}
+
+#endif /* defined(TARGET_PPC64) */
+
 /* Segment registers load and store */
 target_ulong helper_load_sr(CPUPPCState *env, target_ulong sr_num)
 {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3beaa1e2f0..2a4140f420 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7136,6 +7136,9 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
         if (env->spr_cb[SPR_SDR1].name) { /* SDR1 Exists */
             cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1=
]);
         }
+        if (env->spr_cb[SPR_PTCR].name) { /* PTCR Exists */
+            cpu_fprintf(f, " PTCR " TARGET_FMT_lx " ", env->spr[SPR_PTCR=
]);
+        }
         cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "=
\n",
                     env->spr[SPR_DAR], env->spr[SPR_DSISR]);
         break;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 808f6c1a08..c83c910a29 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -420,6 +420,11 @@ static void spr_write_hior(DisasContext *ctx, int sp=
rn, int gprn)
     tcg_gen_st_tl(t0, cpu_env, offsetof(CPUPPCState, excp_prefix));
     tcg_temp_free(t0);
 }
+static void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_ptcr(cpu_env, cpu_gpr[gprn]);
+}
+
 #endif
 #endif
=20
@@ -8167,6 +8172,18 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
 #endif
 }
=20
+static void gen_spr_power9_mmu(CPUPPCState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    /* Partition Table Control */
+    spr_register_hv(env, SPR_PTCR, "PTCR",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    &spr_read_generic, &spr_write_ptcr,
+                    0x00000000);
+#endif
+}
+
 static void init_proc_book3s_common(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
@@ -8719,6 +8736,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     gen_spr_power8_ic(env);
     gen_spr_power8_book4(env);
     gen_spr_power8_rpr(env);
+    gen_spr_power9_mmu(env);
=20
     /* POWER9 Specific registers */
     spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
--=20
2.17.0
