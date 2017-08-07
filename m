Received: from eggs.gnu.org ([2001:4830:134:3::10]:57514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dekKU-0007yG-Sl
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dekKP-0005oH-Nr
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:30 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Mon,  7 Aug 2017 17:50:48 +0200
Message-Id: <1502121048-1816-5-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
References: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.11 4/4] ppc64: introduce e6500
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, frederic.konrad@adacore.com

This introduces e6500 core.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 target/ppc/cpu-models.c     |  2 +
 target/ppc/cpu-models.h     |  1 +
 target/ppc/translate_init.c | 91 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 4d3e635..e0d9faf 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -693,6 +693,8 @@
 #ifdef TARGET_PPC64
     POWERPC_DEF_SVR("e5500", "e5500",
                     CPU_POWERPC_e5500,        POWERPC_SVR_E500,      e5500)
+    POWERPC_DEF_SVR("e6500", "e6500",
+                    CPU_POWERPC_e6500,        POWERPC_SVR_E500,      e6500)
 #endif
     /* PowerPC e500 microcontrollers                                         */
     POWERPC_DEF_SVR("MPC8533_v10", "MPC8533 v1.0",
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index b563c45..eaa6849 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -346,6 +346,7 @@ enum {
     CPU_POWERPC_e500v2_v30         = 0x80210030,
     CPU_POWERPC_e500mc             = 0x80230020,
     CPU_POWERPC_e5500              = 0x80240020,
+    CPU_POWERPC_e6500              = 0x80400020,
     /* MPC85xx microcontrollers */
 #define CPU_POWERPC_MPC8533_v10      CPU_POWERPC_e500v2_v21
 #define CPU_POWERPC_MPC8533_v11      CPU_POWERPC_e500v2_v22
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 2627cbe..9d2b050 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -4888,6 +4888,7 @@ enum fsl_e500_version {
     fsl_e500v2,
     fsl_e500mc,
     fsl_e5500,
+    fsl_e6500,
 };
 
 static void init_proc_e500(CPUPPCState *env, int version)
@@ -4922,6 +4923,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
         case fsl_e5500:
             ivor_mask = 0x000003FE0000FFFFULL;
             break;
+        case fsl_e6500:
+            ivor_mask = 0x000003FF0000FFFFULL;
+            break;
     }
     gen_spr_BookE(env, ivor_mask);
     gen_spr_usprg3(env);
@@ -4954,6 +4958,12 @@ static void init_proc_e500(CPUPPCState *env, int version)
         tlbncfg[0] = gen_tlbncfg(4, 1, 1, 0, 512);
         tlbncfg[1] = gen_tlbncfg(64, 1, 12, TLBnCFG_AVAIL | TLBnCFG_IPROT, 64);
         break;
+    case fsl_e6500:
+        mmucfg = 0x6510B45;
+        env->nb_pids = 1;
+        tlbncfg[0] = 0x08052400;
+        tlbncfg[1] = 0x40028040;
+        break;
     default:
         cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n", env->spr[SPR_PVR]);
     }
@@ -4972,6 +4982,12 @@ static void init_proc_e500(CPUPPCState *env, int version)
         l1cfg0 |= 0x1000000; /* 64 byte cache block size */
         l1cfg1 |= 0x1000000; /* 64 byte cache block size */
         break;
+    case fsl_e6500:
+        env->dcache_line_size = 32;
+        env->icache_line_size = 32;
+        l1cfg0 |= 0x0F83820;
+        l1cfg1 |= 0x0B83820;
+        break;
     default:
         cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n", env->spr[SPR_PVR]);
     }
@@ -5050,7 +5066,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
                  &spr_read_generic, SPR_NOACCESS,
                  0x00000000);
     /* XXX better abstract into Emb.xxx features */
-    if (version == fsl_e5500) {
+    if ((version == fsl_e5500) || (version == fsl_e6500)) {
         spr_register(env, SPR_BOOKE_EPCR, "EPCR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
@@ -5062,6 +5078,30 @@ static void init_proc_e500(CPUPPCState *env, int version)
         ivpr_mask = (target_ulong)~0xFFFFULL;
     }
 
+    if (version == fsl_e6500) {
+        spr_register(env, SPR_BOOKE_SPRG8, "SPRG8",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     0x00000000);
+        spr_register(env, SPR_BOOKE_SPRG9, "SPRG9",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     0x00000000);
+        /* Thread identification */
+        spr_register(env, SPR_TIR, "TIR",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, SPR_NOACCESS,
+                     0x00000000);
+        spr_register(env, SPR_BOOKE_TLB0PS, "TLB0PS",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, SPR_NOACCESS,
+                     0x00000004);
+        spr_register(env, SPR_BOOKE_TLB1PS, "TLB1PS",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, SPR_NOACCESS,
+                     0x7FFFFFFC);
+    }
+
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 0;
     env->tlb_type = TLB_MAS;
@@ -5254,6 +5294,55 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
+
+static void init_proc_e6500(CPUPPCState *env)
+{
+    init_proc_e500(env, fsl_e6500);
+}
+
+POWERPC_FAMILY(e6500)(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+
+    dc->desc = "e6500 core";
+    pcc->init_proc = init_proc_e6500;
+    pcc->check_pow = check_pow_none;
+    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_MFTB |
+                       PPC_WRTEE | PPC_RFDI | PPC_RFMCI |
+                       PPC_CACHE | PPC_CACHE_LOCK | PPC_CACHE_ICBI |
+                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
+                       PPC_FLOAT | PPC_FLOAT_FRES |
+                       PPC_FLOAT_FRSQRTE | PPC_FLOAT_FSEL |
+                       PPC_FLOAT_STFIWX | PPC_WAIT |
+                       PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
+                       PPC_64B | PPC_POPCNTB | PPC_POPCNTWD | PPC_ALTIVEC;
+    pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 | \
+                        PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206;
+    pcc->msr_mask = (1ull << MSR_CM) |
+                    (1ull << MSR_GS) |
+                    (1ull << MSR_UCLE) |
+                    (1ull << MSR_CE) |
+                    (1ull << MSR_EE) |
+                    (1ull << MSR_PR) |
+                    (1ull << MSR_FP) |
+                    (1ull << MSR_ME) |
+                    (1ull << MSR_FE0) |
+                    (1ull << MSR_DE) |
+                    (1ull << MSR_FE1) |
+                    (1ull << MSR_IS) |
+                    (1ull << MSR_DS) |
+                    (1ull << MSR_PX) |
+                    (1ull << MSR_RI) |
+                    (1ull << MSR_VR);
+    pcc->mmu_model = POWERPC_MMU_BOOKE206;
+    pcc->excp_model = POWERPC_EXCP_BOOKE;
+    pcc->bus_model = PPC_FLAGS_INPUT_BookE;
+    pcc->bfd_mach = bfd_mach_ppc_e500;
+    pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
+                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_VRE;
+}
+
 #endif
 
 /* Non-embedded PowerPC                                                      */
-- 
1.8.3.1
