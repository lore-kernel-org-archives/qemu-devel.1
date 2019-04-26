Received: from eggs.gnu.org ([209.51.188.92]:60473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu12-00065S-1l
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0y-00056Y-4v
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:13 +1000
Message-Id: <20190426060627.18153-23-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/36] target/ppc: Style fixes for
 translate_init.inc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate_init.inc.c | 243 +++++++++++++++++++-------------
 1 file changed, 148 insertions(+), 95 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 20a64f3b77..0394a9ddad 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -41,12 +41,13 @@
 #include "fpu/softfloat.h"
 #include "qapi/qapi-commands-target.h"
=20
-//#define PPC_DUMP_CPU
-//#define PPC_DEBUG_SPR
-//#define PPC_DUMP_SPR_ACCESSES
+/* #define PPC_DUMP_CPU */
+/* #define PPC_DEBUG_SPR */
+/* #define PPC_DUMP_SPR_ACCESSES */
 /* #define USE_APPLE_GDB */
=20
-/* Generic callbacks:
+/*
+ * Generic callbacks:
  * do nothing but store/retrieve spr value
  */
 static void spr_load_dump_spr(int sprn)
@@ -58,7 +59,7 @@ static void spr_load_dump_spr(int sprn)
 #endif
 }
=20
-static void spr_read_generic (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_generic(DisasContext *ctx, int gprn, int sprn)
 {
     gen_load_spr(cpu_gpr[gprn], sprn);
     spr_load_dump_spr(sprn);
@@ -230,13 +231,13 @@ static void spr_read_tbu(DisasContext *ctx, int gpr=
n, int sprn)
     }
 }
=20
-__attribute__ (( unused ))
+ATTRIBUTE_UNUSED
 static void spr_read_atbl(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_atbl(cpu_gpr[gprn], cpu_env);
 }
=20
-__attribute__ (( unused ))
+ATTRIBUTE_UNUSED
 static void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_atbu(cpu_gpr[gprn], cpu_env);
@@ -267,20 +268,20 @@ static void spr_write_tbu(DisasContext *ctx, int sp=
rn, int gprn)
     }
 }
=20
-__attribute__ (( unused ))
+ATTRIBUTE_UNUSED
 static void spr_write_atbl(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_atbl(cpu_env, cpu_gpr[gprn]);
 }
=20
-__attribute__ (( unused ))
+ATTRIBUTE_UNUSED
 static void spr_write_atbu(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_atbu(cpu_env, cpu_gpr[gprn]);
 }
=20
 #if defined(TARGET_PPC64)
-__attribute__ (( unused ))
+ATTRIBUTE_UNUSED
 static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
@@ -319,12 +320,16 @@ static void spr_write_hdecr(DisasContext *ctx, int =
sprn, int gprn)
 /* IBAT0L...IBAT7L */
 static void spr_read_ibat(DisasContext *ctx, int gprn, int sprn)
 {
-    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, IBAT[spr=
n & 1][(sprn - SPR_IBAT0U) / 2]));
+    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env,
+                  offsetof(CPUPPCState,
+                           IBAT[sprn & 1][(sprn - SPR_IBAT0U) / 2]));
 }
=20
 static void spr_read_ibat_h(DisasContext *ctx, int gprn, int sprn)
 {
-    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, IBAT[spr=
n & 1][((sprn - SPR_IBAT4U) / 2) + 4]));
+    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env,
+                  offsetof(CPUPPCState,
+                           IBAT[sprn & 1][((sprn - SPR_IBAT4U) / 2) + 4]=
));
 }
=20
 static void spr_write_ibatu(DisasContext *ctx, int sprn, int gprn)
@@ -359,12 +364,16 @@ static void spr_write_ibatl_h(DisasContext *ctx, in=
t sprn, int gprn)
 /* DBAT0L...DBAT7L */
 static void spr_read_dbat(DisasContext *ctx, int gprn, int sprn)
 {
-    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, DBAT[spr=
n & 1][(sprn - SPR_DBAT0U) / 2]));
+    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env,
+                  offsetof(CPUPPCState,
+                           DBAT[sprn & 1][(sprn - SPR_DBAT0U) / 2]));
 }
=20
 static void spr_read_dbat_h(DisasContext *ctx, int gprn, int sprn)
 {
-    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, DBAT[spr=
n & 1][((sprn - SPR_DBAT4U) / 2) + 4]));
+    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env,
+                  offsetof(CPUPPCState,
+                           DBAT[sprn & 1][((sprn - SPR_DBAT4U) / 2) + 4]=
));
 }
=20
 static void spr_write_dbatu(DisasContext *ctx, int sprn, int gprn)
@@ -473,7 +482,9 @@ static void spr_write_hid0_601(DisasContext *ctx, int=
 sprn, int gprn)
 #if !defined(CONFIG_USER_ONLY)
 static void spr_read_601_ubat(DisasContext *ctx, int gprn, int sprn)
 {
-    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, IBAT[spr=
n & 1][(sprn - SPR_IBAT0U) / 2]));
+    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env,
+                  offsetof(CPUPPCState,
+                           IBAT[sprn & 1][(sprn - SPR_IBAT0U) / 2]));
 }
=20
 static void spr_write_601_ubatu(DisasContext *ctx, int sprn, int gprn)
@@ -532,7 +543,8 @@ static void spr_write_booke_tsr(DisasContext *ctx, in=
t sprn, int gprn)
 #if !defined(CONFIG_USER_ONLY)
 static void spr_read_403_pbr(DisasContext *ctx, int gprn, int sprn)
 {
-    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, pb[sprn =
- SPR_403_PBL1]));
+    tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env,
+                  offsetof(CPUPPCState, pb[sprn - SPR_403_PBL1]));
 }
=20
 static void spr_write_403_pbr(DisasContext *ctx, int sprn, int gprn)
@@ -661,14 +673,20 @@ static inline void vscr_init(CPUPPCState *env, uint=
32_t val)
=20
 static inline void _spr_register(CPUPPCState *env, int num,
                                  const char *name,
-                                 void (*uea_read)(DisasContext *ctx, int=
 gprn, int sprn),
-                                 void (*uea_write)(DisasContext *ctx, in=
t sprn, int gprn),
+                                 void (*uea_read)(DisasContext *ctx,
+                                                  int gprn, int sprn),
+                                 void (*uea_write)(DisasContext *ctx,
+                                                   int sprn, int gprn),
 #if !defined(CONFIG_USER_ONLY)
=20
-                                 void (*oea_read)(DisasContext *ctx, int=
 gprn, int sprn),
-                                 void (*oea_write)(DisasContext *ctx, in=
t sprn, int gprn),
-                                 void (*hea_read)(DisasContext *opaque, =
int gprn, int sprn),
-                                 void (*hea_write)(DisasContext *opaque,=
 int sprn, int gprn),
+                                 void (*oea_read)(DisasContext *ctx,
+                                                  int gprn, int sprn),
+                                 void (*oea_write)(DisasContext *ctx,
+                                                   int sprn, int gprn),
+                                 void (*hea_read)(DisasContext *opaque,
+                                                  int gprn, int sprn),
+                                 void (*hea_write)(DisasContext *opaque,
+                                                   int sprn, int gprn),
 #endif
 #if defined(CONFIG_KVM)
                                  uint64_t one_reg_id,
@@ -678,7 +696,7 @@ static inline void _spr_register(CPUPPCState *env, in=
t num,
     ppc_spr_t *spr;
=20
     spr =3D &env->spr_cb[num];
-    if (spr->name !=3D NULL ||env-> spr[num] !=3D 0x00000000 ||
+    if (spr->name !=3D NULL || env->spr[num] !=3D 0x00000000 ||
 #if !defined(CONFIG_USER_ONLY)
         spr->oea_read !=3D NULL || spr->oea_write !=3D NULL ||
 #endif
@@ -774,8 +792,10 @@ static void gen_spr_sdr1(CPUPPCState *env)
 {
 #ifndef CONFIG_USER_ONLY
     if (env->has_hv_mode) {
-        /* SDR1 is a hypervisor resource on CPUs which have a
-         * hypervisor mode */
+        /*
+         * SDR1 is a hypervisor resource on CPUs which have a
+         * hypervisor mode
+         */
         spr_register_hv(env, SPR_SDR1, "SDR1",
                         SPR_NOACCESS, SPR_NOACCESS,
                         SPR_NOACCESS, SPR_NOACCESS,
@@ -1123,7 +1143,8 @@ static void spr_write_amr(DisasContext *ctx, int sp=
rn, int gprn)
     TCGv t1 =3D tcg_temp_new();
     TCGv t2 =3D tcg_temp_new();
=20
-    /* Note, the HV=3D1 PR=3D0 case is handled earlier by simply using
+    /*
+     * Note, the HV=3D1 PR=3D0 case is handled earlier by simply using
      * spr_write_generic for HV mode in the SPR table
      */
=20
@@ -1157,7 +1178,8 @@ static void spr_write_uamor(DisasContext *ctx, int =
sprn, int gprn)
     TCGv t1 =3D tcg_temp_new();
     TCGv t2 =3D tcg_temp_new();
=20
-    /* Note, the HV=3D1 case is handled earlier by simply using
+    /*
+     * Note, the HV=3D1 case is handled earlier by simply using
      * spr_write_generic for HV mode in the SPR table
      */
=20
@@ -1187,7 +1209,8 @@ static void spr_write_iamr(DisasContext *ctx, int s=
prn, int gprn)
     TCGv t1 =3D tcg_temp_new();
     TCGv t2 =3D tcg_temp_new();
=20
-    /* Note, the HV=3D1 case is handled earlier by simply using
+    /*
+     * Note, the HV=3D1 case is handled earlier by simply using
      * spr_write_generic for HV mode in the SPR table
      */
=20
@@ -1215,10 +1238,13 @@ static void spr_write_iamr(DisasContext *ctx, int=
 sprn, int gprn)
 static void gen_spr_amr(CPUPPCState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    /* Virtual Page Class Key protection */
-    /* The AMR is accessible either via SPR 13 or SPR 29.  13 is
+    /*
+     * Virtual Page Class Key protection
+     *
+     * The AMR is accessible either via SPR 13 or SPR 29.  13 is
      * userspace accessible, 29 is privileged.  So we only need to set
-     * the kvm ONE_REG id on one of them, we use 29 */
+     * the kvm ONE_REG id on one of them, we use 29
+     */
     spr_register(env, SPR_UAMR, "UAMR",
                  &spr_read_generic, &spr_write_amr,
                  &spr_read_generic, &spr_write_amr,
@@ -1902,7 +1928,8 @@ static void gen_spr_BookE206(CPUPPCState *env, uint=
32_t mas_mask,
     /* TLB assist registers */
     /* XXX : not implemented */
     for (i =3D 0; i < 8; i++) {
-        void (*uea_write)(DisasContext *ctx, int sprn, int gprn) =3D &sp=
r_write_generic32;
+        void (*uea_write)(DisasContext *ctx, int sprn, int gprn) =3D
+            &spr_write_generic32;
         if (i =3D=3D 2 && (mas_mask & (1 << i)) && (env->insns_flags & P=
PC_64B)) {
             uea_write =3D &spr_write_generic;
         }
@@ -2798,7 +2825,6 @@ static void gen_spr_8xx(CPUPPCState *env)
                  0x00000000);
 }
=20
-// XXX: TODO
 /*
  * AMR     =3D> SPR 29 (Power 2.04)
  * CTRL    =3D> SPR 136 (Power 2.04)
@@ -3344,16 +3370,18 @@ static int check_pow_nocheck(CPUPPCState *env)
=20
 static int check_pow_hid0(CPUPPCState *env)
 {
-    if (env->spr[SPR_HID0] & 0x00E00000)
+    if (env->spr[SPR_HID0] & 0x00E00000) {
         return 1;
+    }
=20
     return 0;
 }
=20
 static int check_pow_hid0_74xx(CPUPPCState *env)
 {
-    if (env->spr[SPR_HID0] & 0x00600000)
+    if (env->spr[SPR_HID0] & 0x00600000) {
         return 1;
+    }
=20
     return 0;
 }
@@ -4602,7 +4630,8 @@ POWERPC_FAMILY(e200)(ObjectClass *oc, void *data)
     dc->desc =3D "e200 core";
     pcc->init_proc =3D init_proc_e200;
     pcc->check_pow =3D check_pow_hid0;
-    /* XXX: unimplemented instructions:
+    /*
+     * XXX: unimplemented instructions:
      * dcblc
      * dcbtlst
      * dcbtstls
@@ -4797,18 +4826,18 @@ static void init_proc_e500(CPUPPCState *env, int =
version)
      * gen_spr_BookE(env, 0x0000000F0000FD7FULL);
      */
     switch (version) {
-        case fsl_e500v1:
-        case fsl_e500v2:
-        default:
-            ivor_mask =3D 0x0000000F0000FFFFULL;
-            break;
-        case fsl_e500mc:
-        case fsl_e5500:
-            ivor_mask =3D 0x000003FE0000FFFFULL;
-            break;
-        case fsl_e6500:
-            ivor_mask =3D 0x000003FF0000FFFFULL;
-            break;
+    case fsl_e500v1:
+    case fsl_e500v2:
+    default:
+        ivor_mask =3D 0x0000000F0000FFFFULL;
+        break;
+    case fsl_e500mc:
+    case fsl_e5500:
+        ivor_mask =3D 0x000003FE0000FFFFULL;
+        break;
+    case fsl_e6500:
+        ivor_mask =3D 0x000003FF0000FFFFULL;
+        break;
     }
     gen_spr_BookE(env, ivor_mask);
     gen_spr_usprg3(env);
@@ -4848,7 +4877,8 @@ static void init_proc_e500(CPUPPCState *env, int ve=
rsion)
         tlbncfg[1] =3D 0x40028040;
         break;
     default:
-        cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n", env->spr=
[SPR_PVR]);
+        cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n",
+                  env->spr[SPR_PVR]);
     }
 #endif
     /* Cache sizes */
@@ -4872,7 +4902,8 @@ static void init_proc_e500(CPUPPCState *env, int ve=
rsion)
         l1cfg1 |=3D 0x0B83820;
         break;
     default:
-        cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n", env->spr=
[SPR_PVR]);
+        cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n",
+                  env->spr[SPR_PVR]);
     }
     gen_spr_BookE206(env, 0x000000DF, tlbncfg, mmucfg);
     /* XXX : not implemented */
@@ -5252,7 +5283,8 @@ static void init_proc_601(CPUPPCState *env)
                  0x00000000);
     /* Memory management */
     init_excp_601(env);
-    /* XXX: beware that dcache line size is 64=20
+    /*
+     * XXX: beware that dcache line size is 64
      *      but dcbz uses 32 bytes "sectors"
      * XXX: this breaks clcs instruction !
      */
@@ -5789,7 +5821,8 @@ static void init_proc_750(CPUPPCState *env)
                  0x00000000);
     /* Memory management */
     gen_low_BATs(env);
-    /* XXX: high BATs are also present but are known to be bugged on
+    /*
+     * XXX: high BATs are also present but are known to be bugged on
      *      die version 1.x
      */
     init_excp_7x0(env);
@@ -5971,7 +6004,8 @@ POWERPC_FAMILY(750cl)(ObjectClass *oc, void *data)
     dc->desc =3D "PowerPC 750 CL";
     pcc->init_proc =3D init_proc_750cl;
     pcc->check_pow =3D check_pow_hid0;
-    /* XXX: not implemented:
+    /*
+     * XXX: not implemented:
      * cache lock instructions:
      * dcbz_l
      * floating point paired instructions
@@ -7569,8 +7603,10 @@ static void gen_spr_book3s_altivec(CPUPPCState *en=
v)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_VRSAVE, 0x00000000);
=20
-    /* Can't find information on what this should be on reset.  This
-     * value is the one used by 74xx processors. */
+    /*
+     * Can't find information on what this should be on reset.  This
+     * value is the one used by 74xx processors.
+     */
     vscr_init(env, 0x00010000);
 }
=20
@@ -8975,8 +9011,9 @@ static void init_ppc_proc(PowerPCCPU *cpu)
=20
     env->irq_inputs =3D NULL;
     /* Set all exception vectors to an invalid address */
-    for (i =3D 0; i < POWERPC_EXCP_NB; i++)
+    for (i =3D 0; i < POWERPC_EXCP_NB; i++) {
         env->excp_vectors[i] =3D (target_ulong)(-1ULL);
+    }
     env->ivor_mask =3D 0x00000000;
     env->ivpr_mask =3D 0x00000000;
     /* Default MMU definitions */
@@ -9108,8 +9145,9 @@ static void init_ppc_proc(PowerPCCPU *cpu)
 #if !defined(CONFIG_USER_ONLY)
     if (env->nb_tlb !=3D 0) {
         int nb_tlb =3D env->nb_tlb;
-        if (env->id_tlbs !=3D 0)
+        if (env->id_tlbs !=3D 0) {
             nb_tlb *=3D 2;
+        }
         switch (env->tlb_type) {
         case TLB_6XX:
             env->tlb.tlb6 =3D g_new0(ppc6xx_tlb_t, nb_tlb);
@@ -9201,8 +9239,9 @@ static void fill_new_table(opc_handler_t **table, i=
nt len)
 {
     int i;
=20
-    for (i =3D 0; i < len; i++)
+    for (i =3D 0; i < len; i++) {
         table[i] =3D &invalid_handler;
+    }
 }
=20
 static int create_new_table(opc_handler_t **table, unsigned char idx)
@@ -9219,8 +9258,9 @@ static int create_new_table(opc_handler_t **table, =
unsigned char idx)
 static int insert_in_table(opc_handler_t **table, unsigned char idx,
                             opc_handler_t *handler)
 {
-    if (table[idx] !=3D &invalid_handler)
+    if (table[idx] !=3D &invalid_handler) {
         return -1;
+    }
     table[idx] =3D handler;
=20
     return 0;
@@ -9341,17 +9381,20 @@ static int register_insn(opc_handler_t **ppc_opco=
des, opcode_t *insn)
                 }
             } else {
                 if (register_dblind_insn(ppc_opcodes, insn->opc1, insn->=
opc2,
-                                         insn->opc3, &insn->handler) < 0=
)
+                                         insn->opc3, &insn->handler) < 0=
) {
                     return -1;
+                }
             }
         } else {
             if (register_ind_insn(ppc_opcodes, insn->opc1,
-                                  insn->opc2, &insn->handler) < 0)
+                                  insn->opc2, &insn->handler) < 0) {
                 return -1;
+            }
         }
     } else {
-        if (register_direct_insn(ppc_opcodes, insn->opc1, &insn->handler=
) < 0)
+        if (register_direct_insn(ppc_opcodes, insn->opc1, &insn->handler=
) < 0) {
             return -1;
+        }
     }
=20
     return 0;
@@ -9363,8 +9406,9 @@ static int test_opcode_table(opc_handler_t **table,=
 int len)
=20
     for (i =3D 0, count =3D 0; i < len; i++) {
         /* Consistency fixup */
-        if (table[i] =3D=3D NULL)
+        if (table[i] =3D=3D NULL) {
             table[i] =3D &invalid_handler;
+        }
         if (table[i] !=3D &invalid_handler) {
             if (is_indirect_opcode(table[i])) {
                 tmp =3D test_opcode_table(ind_table(table[i]),
@@ -9386,8 +9430,9 @@ static int test_opcode_table(opc_handler_t **table,=
 int len)
=20
 static void fix_opcode_tables(opc_handler_t **ppc_opcodes)
 {
-    if (test_opcode_table(ppc_opcodes, PPC_CPU_OPCODES_LEN) =3D=3D 0)
+    if (test_opcode_table(ppc_opcodes, PPC_CPU_OPCODES_LEN) =3D=3D 0) {
         printf("*** WARNING: no opcode defined !\n");
+    }
 }
=20
 /***********************************************************************=
******/
@@ -9726,14 +9771,15 @@ static int ppc_fixup_cpu(PowerPCCPU *cpu)
 {
     CPUPPCState *env =3D &cpu->env;
=20
-    /* TCG doesn't (yet) emulate some groups of instructions that
-     * are implemented on some otherwise supported CPUs (e.g. VSX
-     * and decimal floating point instructions on POWER7).  We
-     * remove unsupported instruction groups from the cpu state's
-     * instruction masks and hope the guest can cope.  For at
-     * least the pseries machine, the unavailability of these
-     * instructions can be advertised to the guest via the device
-     * tree. */
+    /*
+     * TCG doesn't (yet) emulate some groups of instructions that are
+     * implemented on some otherwise supported CPUs (e.g. VSX and
+     * decimal floating point instructions on POWER7).  We remove
+     * unsupported instruction groups from the cpu state's instruction
+     * masks and hope the guest can cope.  For at least the pseries
+     * machine, the unavailability of these instructions can be
+     * advertised to the guest via the device tree.
+     */
     if ((env->insns_flags & ~PPC_TCG_INSNS)
         || (env->insns_flags2 & ~PPC_TCG_INSNS2)) {
         warn_report("Disabling some instructions which are not "
@@ -9928,31 +9974,37 @@ static void ppc_cpu_realize(DeviceState *dev, Err=
or **errp)
                "    Bus model        : %s\n",
                excp_model, bus_model);
         printf("    MSR features     :\n");
-        if (env->flags & POWERPC_FLAG_SPE)
+        if (env->flags & POWERPC_FLAG_SPE) {
             printf("                        signal processing engine ena=
ble"
                    "\n");
-        else if (env->flags & POWERPC_FLAG_VRE)
+        } else if (env->flags & POWERPC_FLAG_VRE) {
             printf("                        vector processor enable\n");
-        if (env->flags & POWERPC_FLAG_TGPR)
+        }
+        if (env->flags & POWERPC_FLAG_TGPR) {
             printf("                        temporary GPRs\n");
-        else if (env->flags & POWERPC_FLAG_CE)
+        } else if (env->flags & POWERPC_FLAG_CE) {
             printf("                        critical input enable\n");
-        if (env->flags & POWERPC_FLAG_SE)
+        }
+        if (env->flags & POWERPC_FLAG_SE) {
             printf("                        single-step trace mode\n");
-        else if (env->flags & POWERPC_FLAG_DWE)
+        } else if (env->flags & POWERPC_FLAG_DWE) {
             printf("                        debug wait enable\n");
-        else if (env->flags & POWERPC_FLAG_UBLE)
+        } else if (env->flags & POWERPC_FLAG_UBLE) {
             printf("                        user BTB lock enable\n");
-        if (env->flags & POWERPC_FLAG_BE)
+        }
+        if (env->flags & POWERPC_FLAG_BE) {
             printf("                        branch-step trace mode\n");
-        else if (env->flags & POWERPC_FLAG_DE)
+        } else if (env->flags & POWERPC_FLAG_DE) {
             printf("                        debug interrupt enable\n");
-        if (env->flags & POWERPC_FLAG_PX)
+        }
+        if (env->flags & POWERPC_FLAG_PX) {
             printf("                        inclusive protection\n");
-        else if (env->flags & POWERPC_FLAG_PMM)
+        } else if (env->flags & POWERPC_FLAG_PMM) {
             printf("                        performance monitor mark\n")=
;
-        if (env->flags =3D=3D POWERPC_FLAG_NONE)
+        }
+        if (env->flags =3D=3D POWERPC_FLAG_NONE) {
             printf("                        none\n");
+        }
         printf("    Time-base/decrementer clock source: %s\n",
                env->flags & POWERPC_FLAG_RTC_CLK ? "RTC clock" : "bus cl=
ock");
         dump_ppc_insns(env);
@@ -10094,8 +10146,9 @@ static ObjectClass *ppc_cpu_class_by_name(const c=
har *name)
     const char *p;
     unsigned long pvr;
=20
-    /* Lookup by PVR if cpu_model is valid 8 digit hex number
-     * (excl: 0x prefix if present)
+    /*
+     * Lookup by PVR if cpu_model is valid 8 digit hex number (excl:
+     * 0x prefix if present)
      */
     if (!qemu_strtoul(name, &p, 16, &pvr)) {
         int len =3D p - name;
@@ -10439,14 +10492,14 @@ static void ppc_cpu_instance_init(Object *obj)
     env->bfd_mach =3D pcc->bfd_mach;
     env->check_pow =3D pcc->check_pow;
=20
-    /* Mark HV mode as supported if the CPU has an MSR_HV bit
-     * in the msr_mask. The mask can later be cleared by PAPR
-     * mode but the hv mode support will remain, thus enforcing
-     * that we cannot use priv. instructions in guest in PAPR
-     * mode. For 970 we currently simply don't set HV in msr_mask
-     * thus simulating an "Apple mode" 970. If we ever want to
-     * support 970 HV mode, we'll have to add a processor attribute
-     * of some sort.
+    /*
+     * Mark HV mode as supported if the CPU has an MSR_HV bit in the
+     * msr_mask. The mask can later be cleared by PAPR mode but the hv
+     * mode support will remain, thus enforcing that we cannot use
+     * priv. instructions in guest in PAPR mode. For 970 we currently
+     * simply don't set HV in msr_mask thus simulating an "Apple mode"
+     * 970. If we ever want to support 970 HV mode, we'll have to add
+     * a processor attribute of some sort.
      */
 #if !defined(CONFIG_USER_ONLY)
     env->has_hv_mode =3D !!(env->msr_mask & MSR_HVB);
@@ -10573,7 +10626,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
     cc->tcg_initialize =3D ppc_translate_init;
 #endif
     cc->disas_set_info =3D ppc_disas_set_info;
-=20
+
     dc->fw_name =3D "PowerPC,UNKNOWN";
 }
=20
--=20
2.20.1
