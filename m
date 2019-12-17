Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A18C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C4E20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QD2a6ZnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C4E20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Ye-0001LX-Mo
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4k6-0002Lr-1N
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jz-0007y6-Hq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:53 -0500
Received: from ozlabs.org ([203.11.71.1]:42423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jw-0007Nq-8X; Mon, 16 Dec 2019 23:45:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWf6p3Tz9sTY; Tue, 17 Dec 2019 15:43:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557822;
 bh=rlTeDJpdg4rEEZiWHjdxU1vrmoe+ccL1RPnnRbfaP8k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QD2a6ZnSOJcp9DeE+4ltVwVwrURg0r6ErUnZqaJ70KpROXRXYTbKVHMG+sN/HuUhE
 E6//WjHkbTOMDJXzc6cxPIXSx++7Fos7i9Cwv2j9PuB2UWveUjg1ayPIyAJ9ZBPHrs
 /NHbR1SrEtC6JWK94vsr8Geec5Brei7gbW8jby2M=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 61/88] target/ppc: Add POWER10 DD1.0 model information
Date: Tue, 17 Dec 2019 15:42:55 +1100
Message-Id: <20191217044322.351838-62-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This includes in QEMU a new CPU model for the POWER10 processor with
the same capabilities of a POWER9 process. The model will be extended
when support is completed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191205184454.10722-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/compat.c             |  21 +++-
 target/ppc/cpu-models.c         |   3 +
 target/ppc/cpu-models.h         |   3 +
 target/ppc/cpu.h                |   1 +
 target/ppc/translate_init.inc.c | 215 ++++++++++++++++++++++++++++++++
 5 files changed, 237 insertions(+), 6 deletions(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 7de4bf3122..f48df25944 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -51,36 +51,38 @@ static const CompatInfo compat_table[] =3D {
     { /* POWER6, ISA2.05 */
         .name =3D "power6",
         .pvr =3D CPU_POWERPC_LOGICAL_2_05,
-        .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
-               PCR_COMPAT_2_05 | PCR_TM_DIS | PCR_VSX_DIS,
+        .pcr =3D PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
+               PCR_COMPAT_2_06 | PCR_COMPAT_2_05 | PCR_TM_DIS | PCR_VSX_=
DIS,
         .pcr_level =3D PCR_COMPAT_2_05,
         .max_vthreads =3D 2,
     },
     { /* POWER7, ISA2.06 */
         .name =3D "power7",
         .pvr =3D CPU_POWERPC_LOGICAL_2_06,
-        .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | P=
CR_TM_DIS,
+        .pcr =3D PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
+               PCR_COMPAT_2_06 | PCR_TM_DIS,
         .pcr_level =3D PCR_COMPAT_2_06,
         .max_vthreads =3D 4,
     },
     {
         .name =3D "power7+",
         .pvr =3D CPU_POWERPC_LOGICAL_2_06_PLUS,
-        .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | P=
CR_TM_DIS,
+        .pcr =3D PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
+               PCR_COMPAT_2_06 | PCR_TM_DIS,
         .pcr_level =3D PCR_COMPAT_2_06,
         .max_vthreads =3D 4,
     },
     { /* POWER8, ISA2.07 */
         .name =3D "power8",
         .pvr =3D CPU_POWERPC_LOGICAL_2_07,
-        .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07,
+        .pcr =3D PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07,
         .pcr_level =3D PCR_COMPAT_2_07,
         .max_vthreads =3D 8,
     },
     { /* POWER9, ISA3.00 */
         .name =3D "power9",
         .pvr =3D CPU_POWERPC_LOGICAL_3_00,
-        .pcr =3D PCR_COMPAT_3_00,
+        .pcr =3D PCR_COMPAT_3_10 | PCR_COMPAT_3_00,
         .pcr_level =3D PCR_COMPAT_3_00,
         /*
          * POWER9 hardware only supports 4 threads / core, but this
@@ -91,6 +93,13 @@ static const CompatInfo compat_table[] =3D {
          */
         .max_vthreads =3D 8,
     },
+    { /* POWER10, ISA3.10 */
+        .name =3D "power10",
+        .pvr =3D CPU_POWERPC_LOGICAL_3_10,
+        .pcr =3D PCR_COMPAT_3_10,
+        .pcr_level =3D PCR_COMPAT_3_10,
+        .max_vthreads =3D 8,
+    },
 };
=20
 static const CompatInfo *compat_by_pvr(uint32_t pvr)
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 086548e9b9..4ad16863c0 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -774,6 +774,8 @@
                 "POWER9 v1.0")
     POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POW=
ER9,
                 "POWER9 v2.0")
+    POWERPC_DEF("power10_v1.0",  CPU_POWERPC_POWER10_DD1,            POW=
ER10,
+                "POWER10 v1.0")
 #endif /* defined (TARGET_PPC64) */
=20
 /***********************************************************************=
****/
@@ -950,6 +952,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] =3D {
     { "power8", "power8_v2.0" },
     { "power8nvl", "power8nvl_v1.0" },
     { "power9", "power9_v2.0" },
+    { "power10", "power10_v1.0" },
 #endif
=20
     /* Generic PowerPCs */
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 4fdb73034d..ce750b2d55 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -373,6 +373,8 @@ enum {
     CPU_POWERPC_POWER9_BASE        =3D 0x004E0000,
     CPU_POWERPC_POWER9_DD1         =3D 0x004E0100,
     CPU_POWERPC_POWER9_DD20        =3D 0x004E1200,
+    CPU_POWERPC_POWER10_BASE       =3D 0x00800000,
+    CPU_POWERPC_POWER10_DD1        =3D 0x00800100,
     CPU_POWERPC_970_v22            =3D 0x00390202,
     CPU_POWERPC_970FX_v10          =3D 0x00391100,
     CPU_POWERPC_970FX_v20          =3D 0x003C0200,
@@ -409,6 +411,7 @@ enum {
     CPU_POWERPC_LOGICAL_2_06_PLUS  =3D 0x0F100003,
     CPU_POWERPC_LOGICAL_2_07       =3D 0x0F000004,
     CPU_POWERPC_LOGICAL_3_00       =3D 0x0F000005,
+    CPU_POWERPC_LOGICAL_3_10       =3D 0x0F000006,
 };
=20
 /* System version register (used on MPC 8xxx)                           =
     */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 60cf030ce6..fbec1b0cd5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2364,6 +2364,7 @@ enum {
     PCR_COMPAT_2_06     =3D PPC_BIT(61),
     PCR_COMPAT_2_07     =3D PPC_BIT(60),
     PCR_COMPAT_3_00     =3D PPC_BIT(59),
+    PCR_COMPAT_3_10     =3D PPC_BIT(58),
     PCR_VEC_DIS         =3D PPC_BIT(0), /* Vec. disable (bit NA since PO=
WER8) */
     PCR_VSX_DIS         =3D PPC_BIT(1), /* VSX disable (bit NA since POW=
ER8) */
     PCR_TM_DIS          =3D PPC_BIT(2), /* Trans. memory disable (POWER8=
) */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 64a838095c..7364d36b07 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -3354,6 +3354,11 @@ static void init_excp_POWER9(CPUPPCState *env)
 #endif
 }
=20
+static void init_excp_POWER10(CPUPPCState *env)
+{
+    init_excp_POWER9(env);
+}
+
 #endif
=20
 /***********************************************************************=
******/
@@ -8996,6 +9001,216 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *dat=
a)
     pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
 }
=20
+#ifdef CONFIG_SOFTMMU
+/*
+ * Radix pg sizes and AP encodings for dt node ibm,processor-radix-AP-en=
codings
+ * Encoded as array of int_32s in the form:
+ *  0bxxxyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
+ *  x -> AP encoding
+ *  y -> radix mode supported page size (encoded as a shift)
+ */
+static struct ppc_radix_page_info POWER10_radix_page_info =3D {
+    .count =3D 4,
+    .entries =3D {
+        0x0000000c, /*  4K - enc: 0x0 */
+        0xa0000010, /* 64K - enc: 0x5 */
+        0x20000015, /*  2M - enc: 0x1 */
+        0x4000001e  /*  1G - enc: 0x2 */
+    }
+};
+#endif /* CONFIG_SOFTMMU */
+
+static void init_proc_POWER10(CPUPPCState *env)
+{
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
+    gen_spr_power9_mmu(env);
+
+    /* POWER9 Specific registers */
+    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
+                     spr_read_generic, spr_write_generic,
+                     KVM_REG_PPC_TIDR, 0);
+
+    /* FIXME: Filter fields properly based on privilege level */
+    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
+                        spr_read_generic, spr_write_generic,
+                        KVM_REG_PPC_PSSCR, 0);
+
+    /* env variables */
+    env->dcache_line_size =3D 128;
+    env->icache_line_size =3D 128;
+
+    /* Allocate hardware IRQ controller */
+    init_excp_POWER10(env);
+    ppcPOWER9_irq_init(env_archcpu(env));
+}
+
+static bool ppc_pvr_match_power10(PowerPCCPUClass *pcc, uint32_t pvr)
+{
+    if ((pvr & CPU_POWERPC_POWER_SERVER_MASK) =3D=3D CPU_POWERPC_POWER10=
_BASE) {
+        return true;
+    }
+    return false;
+}
+
+static bool cpu_has_work_POWER10(CPUState *cs)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    CPUPPCState *env =3D &cpu->env;
+
+    if (cs->halted) {
+        uint64_t psscr =3D env->spr[SPR_PSSCR];
+
+        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+            return false;
+        }
+
+        /* If EC is clear, just return true on any pending interrupt */
+        if (!(psscr & PSSCR_EC)) {
+            return true;
+        }
+        /* External Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
+            (env->spr[SPR_LPCR] & LPCR_EEE)) {
+            bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+            if (heic =3D=3D 0 || !msr_hv || msr_pr) {
+                return true;
+            }
+        }
+        /* Decrementer Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
+            (env->spr[SPR_LPCR] & LPCR_DEE)) {
+            return true;
+        }
+        /* Machine Check or Hypervisor Maintenance Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK |
+            1u << PPC_INTERRUPT_HMI)) && (env->spr[SPR_LPCR] & LPCR_OEE)=
) {
+            return true;
+        }
+        /* Privileged Doorbell Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DOORBELL)) &=
&
+            (env->spr[SPR_LPCR] & LPCR_PDEE)) {
+            return true;
+        }
+        /* Hypervisor Doorbell Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_HDOORBELL)) =
&&
+            (env->spr[SPR_LPCR] & LPCR_HDEE)) {
+            return true;
+        }
+        /* Hypervisor virtualization exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_HVIRT)) &&
+            (env->spr[SPR_LPCR] & LPCR_HVEE)) {
+            return true;
+        }
+        if (env->pending_interrupts & (1u << PPC_INTERRUPT_RESET)) {
+            return true;
+        }
+        return false;
+    } else {
+        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+    }
+}
+
+POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
+    CPUClass *cc =3D CPU_CLASS(oc);
+
+    dc->fw_name =3D "PowerPC,POWER10";
+    dc->desc =3D "POWER10";
+    dc->props =3D powerpc_servercpu_properties;
+    pcc->pvr_match =3D ppc_pvr_match_power10;
+    pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_0=
7 |
+                    PCR_COMPAT_3_00;
+    pcc->pcr_supported =3D PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPA=
T_2_07 |
+                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
+    pcc->init_proc =3D init_proc_POWER10;
+    pcc->check_pow =3D check_pow_nocheck;
+    cc->has_work =3D cpu_has_work_POWER10;
+    pcc->insns_flags =3D PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MF=
TB |
+                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
+                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
+                       PPC_FLOAT_FRSQRTES |
+                       PPC_FLOAT_STFIWX |
+                       PPC_FLOAT_EXT |
+                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
+                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
+                       PPC_MEM_TLBSYNC |
+                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
+                       PPC_SEGMENT_64B | PPC_SLBI |
+                       PPC_POPCNTB | PPC_POPCNTWD |
+                       PPC_CILDST;
+    pcc->insns_flags2 =3D PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX =
|
+                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
+                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
+                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
+                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
+                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
+                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
+    pcc->msr_mask =3D (1ull << MSR_SF) |
+                    (1ull << MSR_SHV) |
+                    (1ull << MSR_TM) |
+                    (1ull << MSR_VR) |
+                    (1ull << MSR_VSX) |
+                    (1ull << MSR_EE) |
+                    (1ull << MSR_PR) |
+                    (1ull << MSR_FP) |
+                    (1ull << MSR_ME) |
+                    (1ull << MSR_FE0) |
+                    (1ull << MSR_SE) |
+                    (1ull << MSR_DE) |
+                    (1ull << MSR_FE1) |
+                    (1ull << MSR_IR) |
+                    (1ull << MSR_DR) |
+                    (1ull << MSR_PMM) |
+                    (1ull << MSR_RI) |
+                    (1ull << MSR_LE);
+    pcc->mmu_model =3D POWERPC_MMU_3_00;
+#if defined(CONFIG_SOFTMMU)
+    pcc->handle_mmu_fault =3D ppc64_v3_handle_mmu_fault;
+    /* segment page size remain the same */
+    pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
+    pcc->radix_page_info =3D &POWER10_radix_page_info;
+    pcc->lrg_decr_bits =3D 56;
+#endif
+    pcc->excp_model =3D POWERPC_EXCP_POWER9;
+    pcc->bus_model =3D PPC_FLAGS_INPUT_POWER9;
+    pcc->bfd_mach =3D bfd_mach_ppc64;
+    pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
+                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
+                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM;
+    pcc->l1_dcache_size =3D 0x8000;
+    pcc->l1_icache_size =3D 0x8000;
+    pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
+    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
--=20
2.23.0


