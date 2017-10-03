Received: from eggs.gnu.org ([2001:4830:134:3::10]:37993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzKDN-0007Ja-8o
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzKDI-0003Nm-QY
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:14:13 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  3 Oct 2017 12:14:04 +0200
Message-Id: <1507025644-5972-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/ppc: Remove unused PPC 460 and 460F
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

We don't have any 460 or 460F CPUs in QEMU, so the init functions
are just dead code. Let's simply remove them (translate_init.c
is already big enough without them).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/translate_init.c | 217 --------------------------------------------
 1 file changed, 217 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c6399a3..0d6379f 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -4176,223 +4176,6 @@ POWERPC_FAMILY(440x5wDFPU)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_460 (CPUPPCState *env)
-{
-    /* Time base */
-    gen_tbl(env);
-    gen_spr_BookE(env, 0x000000000000FFFFULL);
-    gen_spr_440(env);
-    gen_spr_usprgh(env);
-    /* Processor identification */
-    spr_register(env, SPR_BOOKE_PIR, "PIR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_pir,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_IAC3, "IAC3",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_IAC4, "IAC4",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_DVC1, "DVC1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_DVC2, "DVC2",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_MCSR, "MCSR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_BOOKE_MCSRR0, "MCSRR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_BOOKE_MCSRR1, "MCSRR1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_440_CCR1, "CCR1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_DCRIPR, "SPR_DCRIPR",
-                 &spr_read_generic, &spr_write_generic,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->id_tlbs = 0;
-    env->tlb_type = TLB_EMB;
-#endif
-    init_excp_BookE(env);
-    env->dcache_line_size = 32;
-    env->icache_line_size = 32;
-    /* XXX: TODO: allocate internal IRQ controller */
-
-    SET_FIT_PERIOD(12, 16, 20, 24);
-    SET_WDT_PERIOD(20, 24, 28, 32);
-}
-
-POWERPC_FAMILY(460)(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-
-    dc->desc = "PowerPC 460 (guessed)";
-    pcc->init_proc = init_proc_460;
-    pcc->check_pow = check_pow_nocheck;
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
-                       PPC_DCR | PPC_DCRX  | PPC_DCRUX |
-                       PPC_WRTEE | PPC_MFAPIDI | PPC_MFTB |
-                       PPC_CACHE | PPC_CACHE_ICBI |
-                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
-                       PPC_MEM_TLBSYNC | PPC_TLBIVA |
-                       PPC_BOOKE | PPC_4xx_COMMON | PPC_405_MAC |
-                       PPC_440_SPEC;
-    pcc->msr_mask = (1ull << MSR_POW) |
-                    (1ull << MSR_CE) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_DWE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_FE1) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR);
-    pcc->mmu_model = POWERPC_MMU_BOOKE;
-    pcc->excp_model = POWERPC_EXCP_BOOKE;
-    pcc->bus_model = PPC_FLAGS_INPUT_BookE;
-    pcc->bfd_mach = bfd_mach_ppc_403;
-    pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DWE |
-                 POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
-}
-
-static void init_proc_460F(CPUPPCState *env)
-{
-    /* Time base */
-    gen_tbl(env);
-    gen_spr_BookE(env, 0x000000000000FFFFULL);
-    gen_spr_440(env);
-    gen_spr_usprgh(env);
-    /* Processor identification */
-    spr_register(env, SPR_BOOKE_PIR, "PIR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_pir,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_IAC3, "IAC3",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_IAC4, "IAC4",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_DVC1, "DVC1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_DVC2, "DVC2",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_BOOKE_MCSR, "MCSR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_BOOKE_MCSRR0, "MCSRR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_BOOKE_MCSRR1, "MCSRR1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_440_CCR1, "CCR1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* XXX : not implemented */
-    spr_register(env, SPR_DCRIPR, "SPR_DCRIPR",
-                 &spr_read_generic, &spr_write_generic,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->id_tlbs = 0;
-    env->tlb_type = TLB_EMB;
-#endif
-    init_excp_BookE(env);
-    env->dcache_line_size = 32;
-    env->icache_line_size = 32;
-    /* XXX: TODO: allocate internal IRQ controller */
-
-    SET_FIT_PERIOD(12, 16, 20, 24);
-    SET_WDT_PERIOD(20, 24, 28, 32);
-}
-
-POWERPC_FAMILY(460F)(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-
-    dc->desc = "PowerPC 460F (guessed)";
-    pcc->init_proc = init_proc_460F;
-    pcc->check_pow = check_pow_nocheck;
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
-                       PPC_FLOAT | PPC_FLOAT_FRES | PPC_FLOAT_FSEL |
-                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
-                       PPC_FLOAT_STFIWX | PPC_MFTB |
-                       PPC_DCR | PPC_DCRX | PPC_DCRUX |
-                       PPC_WRTEE | PPC_MFAPIDI |
-                       PPC_CACHE | PPC_CACHE_ICBI |
-                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
-                       PPC_MEM_TLBSYNC | PPC_TLBIVA |
-                       PPC_BOOKE | PPC_4xx_COMMON | PPC_405_MAC |
-                       PPC_440_SPEC;
-    pcc->msr_mask = (1ull << MSR_POW) |
-                    (1ull << MSR_CE) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_DWE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_FE1) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR);
-    pcc->mmu_model = POWERPC_MMU_BOOKE;
-    pcc->excp_model = POWERPC_EXCP_BOOKE;
-    pcc->bus_model = PPC_FLAGS_INPUT_BookE;
-    pcc->bfd_mach = bfd_mach_ppc_403;
-    pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DWE |
-                 POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
-}
-
 static void init_proc_MPC5xx(CPUPPCState *env)
 {
     /* Time base */
-- 
1.8.3.1
