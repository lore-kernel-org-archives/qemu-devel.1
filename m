Received: from eggs.gnu.org ([2001:4830:134:3::10]:44353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqY-00086p-6X
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqT-0001Lg-Nc
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:24:56 +1100
Message-Id: <20170303032507.16142-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/17] target/ppc: Don't gen an SDR1 on POWER9
 and rework register creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

POWER9 doesn't have a storage description register 1 (SDR1) which is used
to store the base and size of the hash table. Thus we don't need to
generate this register on the POWER9 cpu model. While we're here, the
register generation code for 970, POWER5+, POWER<7/8/9> in general is a
mess where we call a generic function from a model specific function which
then attempts to call model specific functions, so rework this for
readability.

We update ppc_cpu_dump_state so that "info registers" will only display
the value of sdr1 if the register has been generated.

As mentioned above the register generation for the pcc->init_proc
function for 970, POWER5+, POWER7, POWER8 and POWER9 has been reworked
for improved clarity. Instead of calling init_proc_book3s_64 which then
attempts to generate the correct registers through a mess of if statements,
we remove this function and instead call the appropriate register
generation functions directly. This follows the register generation model
used for earlier cpu models (pre-970) whereby cpu specific registers are
generated directly in the init_proc function and makes it easier to
add/remove specific registers for new cpu models.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c      |   7 +-
 target/ppc/translate_init.c | 316 +++++++++++++++++++++++++++-----------------
 2 files changed, 203 insertions(+), 120 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 6e6868b..1de554a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7090,9 +7090,12 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     case POWERPC_MMU_2_06a:
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_3_00:
 #endif
-        cpu_fprintf(f, " SDR1 " TARGET_FMT_lx "   DAR " TARGET_FMT_lx
-                       "  DSISR " TARGET_FMT_lx "\n", env->spr[SPR_SDR1],
+        if (env->spr_cb[SPR_SDR1].name) { /* SDR1 Exists */
+            cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1]);
+        }
+        cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "\n",
                     env->spr[SPR_DAR], env->spr[SPR_DSISR]);
         break;
     case POWERPC_MMU_BOOKE206:
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 37f74be..1a05ac3 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -723,7 +723,7 @@ static void gen_spr_generic (CPUPPCState *env)
 }
 
 /* SPR common to all non-embedded PowerPC, including 601 */
-static void gen_spr_ne_601 (CPUPPCState *env)
+static void gen_spr_ne_601(CPUPPCState *env)
 {
     /* Exception processing */
     spr_register_kvm(env, SPR_DSISR, "DSISR",
@@ -739,7 +739,11 @@ static void gen_spr_ne_601 (CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_decr, &spr_write_decr,
                  0x00000000);
-    /* Memory management */
+}
+
+/* Storage Description Register 1 */
+static void gen_spr_sdr1(CPUPPCState *env)
+{
 #ifndef CONFIG_USER_ONLY
     if (env->has_hv_mode) {
         /* SDR1 is a hypervisor resource on CPUs which have a
@@ -1180,7 +1184,7 @@ static void spr_write_iamr(DisasContext *ctx, int sprn, int gprn)
 }
 #endif /* CONFIG_USER_ONLY */
 
-static void gen_spr_amr(CPUPPCState *env, bool has_iamr)
+static void gen_spr_amr(CPUPPCState *env)
 {
 #ifndef CONFIG_USER_ONLY
     /* Virtual Page Class Key protection */
@@ -1206,13 +1210,17 @@ static void gen_spr_amr(CPUPPCState *env, bool has_iamr)
                     SPR_NOACCESS, SPR_NOACCESS,
                     &spr_read_generic, &spr_write_generic,
                     0);
-    if (has_iamr) {
-        spr_register_kvm_hv(env, SPR_IAMR, "IAMR",
-                            SPR_NOACCESS, SPR_NOACCESS,
-                            &spr_read_generic, &spr_write_iamr,
-                            &spr_read_generic, &spr_write_generic,
-                            KVM_REG_PPC_IAMR, 0);
-    }
+#endif /* !CONFIG_USER_ONLY */
+}
+
+static void gen_spr_iamr(CPUPPCState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    spr_register_kvm_hv(env, SPR_IAMR, "IAMR",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_iamr,
+                        &spr_read_generic, &spr_write_generic,
+                        KVM_REG_PPC_IAMR, 0);
 #endif /* !CONFIG_USER_ONLY */
 }
 #endif /* TARGET_PPC64 */
@@ -4422,6 +4430,7 @@ POWERPC_FAMILY(MPC8xx)(ObjectClass *oc, void *data)
 static void init_proc_G2 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_G2_755(env);
     gen_spr_G2(env);
     /* Time base */
@@ -4500,6 +4509,7 @@ POWERPC_FAMILY(G2)(ObjectClass *oc, void *data)
 static void init_proc_G2LE (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_G2_755(env);
     gen_spr_G2(env);
     /* Time base */
@@ -4735,6 +4745,7 @@ POWERPC_FAMILY(e200)(ObjectClass *oc, void *data)
 static void init_proc_e300 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_603(env);
     /* Time base */
     gen_tbl(env);
@@ -5234,6 +5245,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
 static void init_proc_601 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_601(env);
     /* Hardware implementation registers */
     /* XXX : not implemented */
@@ -5348,6 +5360,7 @@ POWERPC_FAMILY(601v)(ObjectClass *oc, void *data)
 static void init_proc_602 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_602(env);
     /* Time base */
     gen_tbl(env);
@@ -5417,6 +5430,7 @@ POWERPC_FAMILY(602)(ObjectClass *oc, void *data)
 static void init_proc_603 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_603(env);
     /* Time base */
     gen_tbl(env);
@@ -5483,6 +5497,7 @@ POWERPC_FAMILY(603)(ObjectClass *oc, void *data)
 static void init_proc_603E (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_603(env);
     /* Time base */
     gen_tbl(env);
@@ -5549,6 +5564,7 @@ POWERPC_FAMILY(603E)(ObjectClass *oc, void *data)
 static void init_proc_604 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_604(env);
     /* Time base */
     gen_tbl(env);
@@ -5612,6 +5628,7 @@ POWERPC_FAMILY(604)(ObjectClass *oc, void *data)
 static void init_proc_604E (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_604(env);
     /* XXX : not implemented */
     spr_register(env, SPR_7XX_MMCR1, "MMCR1",
@@ -5695,6 +5712,7 @@ POWERPC_FAMILY(604E)(ObjectClass *oc, void *data)
 static void init_proc_740 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -5765,6 +5783,7 @@ POWERPC_FAMILY(740)(ObjectClass *oc, void *data)
 static void init_proc_750 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* XXX : not implemented */
     spr_register(env, SPR_L2CR, "L2CR",
@@ -5843,6 +5862,7 @@ POWERPC_FAMILY(750)(ObjectClass *oc, void *data)
 static void init_proc_750cl (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* XXX : not implemented */
     spr_register(env, SPR_L2CR, "L2CR",
@@ -6044,6 +6064,7 @@ POWERPC_FAMILY(750cl)(ObjectClass *oc, void *data)
 static void init_proc_750cx (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* XXX : not implemented */
     spr_register(env, SPR_L2CR, "L2CR",
@@ -6126,6 +6147,7 @@ POWERPC_FAMILY(750cx)(ObjectClass *oc, void *data)
 static void init_proc_750fx (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* XXX : not implemented */
     spr_register(env, SPR_L2CR, "L2CR",
@@ -6213,6 +6235,7 @@ POWERPC_FAMILY(750fx)(ObjectClass *oc, void *data)
 static void init_proc_750gx (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* XXX : not implemented (XXX: different from 750fx) */
     spr_register(env, SPR_L2CR, "L2CR",
@@ -6300,6 +6323,7 @@ POWERPC_FAMILY(750gx)(ObjectClass *oc, void *data)
 static void init_proc_745 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     gen_spr_G2_755(env);
     /* Time base */
@@ -6375,6 +6399,7 @@ POWERPC_FAMILY(745)(ObjectClass *oc, void *data)
 static void init_proc_755 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     gen_spr_G2_755(env);
     /* Time base */
@@ -6461,6 +6486,7 @@ POWERPC_FAMILY(755)(ObjectClass *oc, void *data)
 static void init_proc_7400 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -6539,6 +6565,7 @@ POWERPC_FAMILY(7400)(ObjectClass *oc, void *data)
 static void init_proc_7410 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -6623,6 +6650,7 @@ POWERPC_FAMILY(7410)(ObjectClass *oc, void *data)
 static void init_proc_7440 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -6730,6 +6758,7 @@ POWERPC_FAMILY(7440)(ObjectClass *oc, void *data)
 static void init_proc_7450 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -6863,6 +6892,7 @@ POWERPC_FAMILY(7450)(ObjectClass *oc, void *data)
 static void init_proc_7445 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -6999,6 +7029,7 @@ POWERPC_FAMILY(7445)(ObjectClass *oc, void *data)
 static void init_proc_7455 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -7137,6 +7168,7 @@ POWERPC_FAMILY(7455)(ObjectClass *oc, void *data)
 static void init_proc_7457 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -7299,6 +7331,7 @@ POWERPC_FAMILY(7457)(ObjectClass *oc, void *data)
 static void init_proc_e600 (CPUPPCState *env)
 {
     gen_spr_ne_601(env);
+    gen_spr_sdr1(env);
     gen_spr_7xx(env);
     /* Time base */
     gen_tbl(env);
@@ -7444,15 +7477,6 @@ POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
 #define POWERPC970_HID5_INIT 0x00000000
 #endif
 
-enum BOOK3S_CPU_TYPE {
-    BOOK3S_CPU_970,
-    BOOK3S_CPU_POWER5PLUS,
-    BOOK3S_CPU_POWER6,
-    BOOK3S_CPU_POWER7,
-    BOOK3S_CPU_POWER8,
-    BOOK3S_CPU_POWER9
-};
-
 static void gen_fscr_facility_check(DisasContext *ctx, int facility_sprn,
                                     int bit, int sprn, int cause)
 {
@@ -7540,7 +7564,7 @@ static void gen_spr_970_hior(CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_spr_book3s_common(CPUPPCState *env)
+static void gen_spr_book3s_ctrl(CPUPPCState *env)
 {
     spr_register(env, SPR_CTRL, "SPR_CTRL",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -8210,112 +8234,42 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
 #endif
 }
 
-static void init_proc_book3s_64(CPUPPCState *env, int version)
+static void init_proc_book3s_common(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_tbl(env);
     gen_spr_book3s_altivec(env);
     gen_spr_book3s_pmu_sup(env);
     gen_spr_book3s_pmu_user(env);
-    gen_spr_book3s_common(env);
+    gen_spr_book3s_ctrl(env);
+}
 
-    switch (version) {
-    case BOOK3S_CPU_970:
-    case BOOK3S_CPU_POWER5PLUS:
-        gen_spr_970_hid(env);
-        gen_spr_970_hior(env);
-        gen_low_BATs(env);
-        gen_spr_970_pmu_sup(env);
-        gen_spr_970_pmu_user(env);
-        break;
-    case BOOK3S_CPU_POWER7:
-    case BOOK3S_CPU_POWER8:
-    case BOOK3S_CPU_POWER9:
-        gen_spr_book3s_ids(env);
-        gen_spr_amr(env, version >= BOOK3S_CPU_POWER8);
-        gen_spr_book3s_purr(env);
-        env->ci_large_pages = true;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    if (version >= BOOK3S_CPU_POWER5PLUS) {
-        gen_spr_power5p_common(env);
-        gen_spr_power5p_lpar(env);
-        gen_spr_power5p_ear(env);
-    } else {
-        gen_spr_970_lpar(env);
-    }
-    if (version == BOOK3S_CPU_970) {
-        gen_spr_970_dbg(env);
-    }
-    if (version >= BOOK3S_CPU_POWER6) {
-        gen_spr_power6_common(env);
-        gen_spr_power6_dbg(env);
-    }
-    if (version == BOOK3S_CPU_POWER7) {
-        gen_spr_power7_book4(env);
-    }
-    if (version >= BOOK3S_CPU_POWER8) {
-        gen_spr_power8_tce_address_control(env);
-        gen_spr_power8_ids(env);
-        gen_spr_power8_ebb(env);
-        gen_spr_power8_fscr(env);
-        gen_spr_power8_pmu_sup(env);
-        gen_spr_power8_pmu_user(env);
-        gen_spr_power8_tm(env);
-        gen_spr_power8_pspb(env);
-        gen_spr_vtb(env);
-        gen_spr_power8_ic(env);
-        gen_spr_power8_book4(env);
-        gen_spr_power8_rpr(env);
-    }
-    if (version < BOOK3S_CPU_POWER8) {
-        gen_spr_book3s_dbg(env);
-    } else {
-        gen_spr_book3s_207_dbg(env);
-    }
+static void init_proc_970(CPUPPCState *env)
+{
+    /* Common Registers */
+    init_proc_book3s_common(env);
+    gen_spr_sdr1(env);
+    gen_spr_book3s_dbg(env);
+
+    /* 970 Specific Registers */
+    gen_spr_970_hid(env);
+    gen_spr_970_hior(env);
+    gen_low_BATs(env);
+    gen_spr_970_pmu_sup(env);
+    gen_spr_970_pmu_user(env);
+    gen_spr_970_lpar(env);
+    gen_spr_970_dbg(env);
+
+    /* env variables */
 #if !defined(CONFIG_USER_ONLY)
-    switch (version) {
-    case BOOK3S_CPU_970:
-    case BOOK3S_CPU_POWER5PLUS:
-        env->slb_nr = 64;
-        break;
-    case BOOK3S_CPU_POWER7:
-    case BOOK3S_CPU_POWER8:
-    case BOOK3S_CPU_POWER9:
-    default:
-        env->slb_nr = 32;
-        break;
-    }
+    env->slb_nr = 64;
 #endif
-    /* Allocate hardware IRQ controller */
-    switch (version) {
-    case BOOK3S_CPU_970:
-    case BOOK3S_CPU_POWER5PLUS:
-        init_excp_970(env);
-        ppc970_irq_init(ppc_env_get_cpu(env));
-        break;
-    case BOOK3S_CPU_POWER7:
-        init_excp_POWER7(env);
-        ppcPOWER7_irq_init(ppc_env_get_cpu(env));
-        break;
-    case BOOK3S_CPU_POWER8:
-    case BOOK3S_CPU_POWER9:
-        init_excp_POWER8(env);
-        ppcPOWER7_irq_init(ppc_env_get_cpu(env));
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
-}
 
-static void init_proc_970(CPUPPCState *env)
-{
-    init_proc_book3s_64(env, BOOK3S_CPU_970);
+    /* Allocate hardware IRQ controller */
+    init_excp_970(env);
+    ppc970_irq_init(ppc_env_get_cpu(env));
 }
 
 POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
@@ -8367,7 +8321,31 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
 
 static void init_proc_power5plus(CPUPPCState *env)
 {
-    init_proc_book3s_64(env, BOOK3S_CPU_POWER5PLUS);
+    /* Common Registers */
+    init_proc_book3s_common(env);
+    gen_spr_sdr1(env);
+    gen_spr_book3s_dbg(env);
+
+    /* POWER5+ Specific Registers */
+    gen_spr_970_hid(env);
+    gen_spr_970_hior(env);
+    gen_low_BATs(env);
+    gen_spr_970_pmu_sup(env);
+    gen_spr_970_pmu_user(env);
+    gen_spr_power5p_common(env);
+    gen_spr_power5p_lpar(env);
+    gen_spr_power5p_ear(env);
+
+    /* env variables */
+#if !defined(CONFIG_USER_ONLY)
+    env->slb_nr = 64;
+#endif
+    env->dcache_line_size = 128;
+    env->icache_line_size = 128;
+
+    /* Allocate hardware IRQ controller */
+    init_excp_970(env);
+    ppc970_irq_init(ppc_env_get_cpu(env));
 }
 
 POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
@@ -8520,7 +8498,33 @@ static const struct ppc_segment_page_sizes POWER7_POWER8_sps = {
 
 static void init_proc_POWER7 (CPUPPCState *env)
 {
-    init_proc_book3s_64(env, BOOK3S_CPU_POWER7);
+    /* Common Registers */
+    init_proc_book3s_common(env);
+    gen_spr_sdr1(env);
+    gen_spr_book3s_dbg(env);
+
+    /* POWER7 Specific Registers */
+    gen_spr_book3s_ids(env);
+    gen_spr_amr(env);
+    gen_spr_book3s_purr(env);
+    gen_spr_power5p_common(env);
+    gen_spr_power5p_lpar(env);
+    gen_spr_power5p_ear(env);
+    gen_spr_power6_common(env);
+    gen_spr_power6_dbg(env);
+    gen_spr_power7_book4(env);
+
+    /* env variables */
+#if !defined(CONFIG_USER_ONLY)
+    env->slb_nr = 32;
+#endif
+    env->ci_large_pages = true;
+    env->dcache_line_size = 128;
+    env->icache_line_size = 128;
+
+    /* Allocate hardware IRQ controller */
+    init_excp_POWER7(env);
+    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
 }
 
 static bool ppc_pvr_match_power7(PowerPCCPUClass *pcc, uint32_t pvr)
@@ -8636,7 +8640,45 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
 
 static void init_proc_POWER8(CPUPPCState *env)
 {
-    init_proc_book3s_64(env, BOOK3S_CPU_POWER8);
+    /* Common Registers */
+    init_proc_book3s_common(env);
+    gen_spr_sdr1(env);
+    gen_spr_book3s_207_dbg(env);
+
+    /* POWER8 Specific Registers */
+    gen_spr_book3s_ids(env);
+    gen_spr_amr(env);
+    gen_spr_iamr(env);
+    gen_spr_book3s_purr(env);
+    gen_spr_power5p_common(env);
+    gen_spr_power5p_lpar(env);
+    gen_spr_power5p_ear(env);
+    gen_spr_power6_common(env);
+    gen_spr_power6_dbg(env);
+    gen_spr_power8_tce_address_control(env);
+    gen_spr_power8_ids(env);
+    gen_spr_power8_ebb(env);
+    gen_spr_power8_fscr(env);
+    gen_spr_power8_pmu_sup(env);
+    gen_spr_power8_pmu_user(env);
+    gen_spr_power8_tm(env);
+    gen_spr_power8_pspb(env);
+    gen_spr_vtb(env);
+    gen_spr_power8_ic(env);
+    gen_spr_power8_book4(env);
+    gen_spr_power8_rpr(env);
+
+    /* env variables */
+#if !defined(CONFIG_USER_ONLY)
+    env->slb_nr = 32;
+#endif
+    env->ci_large_pages = true;
+    env->dcache_line_size = 128;
+    env->icache_line_size = 128;
+
+    /* Allocate hardware IRQ controller */
+    init_excp_POWER8(env);
+    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
 }
 
 static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr)
@@ -8764,9 +8806,47 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_lpcr;
 }
+
 static void init_proc_POWER9(CPUPPCState *env)
 {
-    init_proc_book3s_64(env, BOOK3S_CPU_POWER9);
+    /* Common Registers */
+    init_proc_book3s_common(env);
+    gen_spr_book3s_207_dbg(env);
+
+    /* POWER8 Specific Registers */
+    gen_spr_book3s_ids(env);
+    gen_spr_amr(env);
+    gen_spr_iamr(env);
+    gen_spr_book3s_purr(env);
+    gen_spr_power5p_common(env);
+    gen_spr_power5p_lpar(env);
+    gen_spr_power5p_ear(env);
+    gen_spr_power6_common(env);
+    gen_spr_power6_dbg(env);
+    gen_spr_power8_tce_address_control(env);
+    gen_spr_power8_ids(env);
+    gen_spr_power8_ebb(env);
+    gen_spr_power8_fscr(env);
+    gen_spr_power8_pmu_sup(env);
+    gen_spr_power8_pmu_user(env);
+    gen_spr_power8_tm(env);
+    gen_spr_power8_pspb(env);
+    gen_spr_vtb(env);
+    gen_spr_power8_ic(env);
+    gen_spr_power8_book4(env);
+    gen_spr_power8_rpr(env);
+
+    /* env variables */
+#if !defined(CONFIG_USER_ONLY)
+    env->slb_nr = 32;
+#endif
+    env->ci_large_pages = true;
+    env->dcache_line_size = 128;
+    env->icache_line_size = 128;
+
+    /* Allocate hardware IRQ controller */
+    init_excp_POWER8(env);
+    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
 }
 
 static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
-- 
2.9.3
