Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A973C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693602078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LLFkuxTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693602078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdomk-0002jI-KH
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdoli-00014v-LS; Wed, 27 May 2020 01:38:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50969 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolh-0001bo-D4; Wed, 27 May 2020 01:38:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03q4nq8z9sSn; Wed, 27 May 2020 15:38:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557895;
 bh=tM/dD/Q1dq5YeZuMnvtetIYBE7QDpqKX/IQGQsvb7Zk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LLFkuxTJzu5nyn9C9OjYLtrXI+iwBoYEr59MkmHQFRyiPd390C7q/aIJudm7ABI/b
 bpEA/RkknOY3krR+4ITyCGWKj9MLSuQwZ1WzGZLtV5qJ+8PkMvclIGqibBxfjlOYhN
 j0X/gLlIi0+vD+6j05B+uP1prsDuCa6yzl8X5Bs8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/15] ppc/spapr: Add hotremovable flag on DIMM LMBs on drmem_v2
Date: Wed, 27 May 2020 15:37:59 +1000
Message-Id: <20200527053809.356168-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:38:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: lvivier@redhat.com, Leonardo Bras <leobras.c@gmail.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 Leonardo Bras <leonardo@linux.ibm.com>, Bharata B Rao <bharata@linux.ibm.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Leonardo Bras <leonardo@linux.ibm.com>

On reboot, all memory that was previously added using object_add and
device_add is placed in this DIMM area.

The new SPAPR_LMB_FLAGS_HOTREMOVABLE flag helps Linux to put this memory in
the correct memory zone, so no unmovable allocations are made there,
allowing the object to be easily hot-removed by device_del and
object_del.

This new flag was accepted in Power Architecture documentation.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>
Message-Id: <20200511200201.58537-1-leobras.c@gmail.com>
[dwg: Fixed syntax error spotted by Cédric Le Goater]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c             |  8 ++++----
 hw/ppc/spapr.c           |  3 ++-
 include/hw/ppc/spapr.h   |  1 +
 target/ppc/cpu.h         | 21 +++++++++++++++++++++
 target/ppc/excp_helper.c | 16 ++++++++--------
 5 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f48a61d6d1..806a5d9a8d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1984,15 +1984,15 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 
     cpu_synchronize_state(cs);
     ppc_cpu_do_system_reset(cs);
-    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
+    if (env->spr[SPR_SRR1] & SRR1_WAKESTATE) {
         /*
          * Power-save wakeups, as indicated by non-zero SRR1[46:47] put the
          * wakeup reason in SRR1[42:45], system reset is indicated with 0b0100
          * (PPC_BIT(43)).
          */
-        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
+        if (!(env->spr[SPR_SRR1] & SRR1_WAKERESET)) {
             warn_report("ppc_cpu_do_system_reset does not set system reset wakeup reason");
-            env->spr[SPR_SRR1] |= PPC_BIT(43);
+            env->spr[SPR_SRR1] |= SRR1_WAKERESET;
         }
     } else {
         /*
@@ -2002,7 +2002,7 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
          * another CPU requesting a NMI IPI) system reset exception should be
          * 0b0010 (PPC_BIT(44)).
          */
-        env->spr[SPR_SRR1] |= PPC_BIT(44);
+        env->spr[SPR_SRR1] |= SRR1_WAKESCOM;
     }
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9b358fcc60..3b1a5ed865 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -445,7 +445,8 @@ static int spapr_dt_dynamic_memory_v2(SpaprMachineState *spapr, void *fdt,
         g_assert(drc);
         elem = spapr_get_drconf_cell(size / lmb_size, addr,
                                      spapr_drc_index(drc), node,
-                                     SPAPR_LMB_FLAGS_ASSIGNED);
+                                     (SPAPR_LMB_FLAGS_ASSIGNED |
+                                      SPAPR_LMB_FLAGS_HOTREMOVABLE));
         QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
         nr_entries++;
         cur_addr = addr + size;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d2533e7264..c421410e3f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -886,6 +886,7 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 #define SPAPR_LMB_FLAGS_ASSIGNED 0x00000008
 #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
 #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
+#define SPAPR_LMB_FLAGS_HOTREMOVABLE 0x00000100
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c1005b04a0..1988b436cb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -476,6 +476,27 @@ typedef struct ppc_v3_pate_t {
 #define SRR1_PROTFAULT           DSISR_PROTFAULT
 #define SRR1_IAMR                DSISR_AMR
 
+/* SRR1[42:45] wakeup fields for System Reset Interrupt */
+
+#define SRR1_WAKEMASK           0x003c0000 /* reason for wakeup */
+
+#define SRR1_WAKEHMI            0x00280000 /* Hypervisor maintenance */
+#define SRR1_WAKEHVI            0x00240000 /* Hypervisor Virt. Interrupt (P9) */
+#define SRR1_WAKEEE             0x00200000 /* External interrupt */
+#define SRR1_WAKEDEC            0x00180000 /* Decrementer interrupt */
+#define SRR1_WAKEDBELL          0x00140000 /* Privileged doorbell */
+#define SRR1_WAKERESET          0x00100000 /* System reset */
+#define SRR1_WAKEHDBELL         0x000c0000 /* Hypervisor doorbell */
+#define SRR1_WAKESCOM           0x00080000 /* SCOM not in power-saving mode */
+
+/* SRR1[46:47] power-saving exit mode */
+
+#define SRR1_WAKESTATE          0x00030000 /* Powersave exit mask */
+
+#define SRR1_WS_HVLOSS          0x00030000 /* HV resources not maintained */
+#define SRR1_WS_GPRLOSS         0x00020000 /* GPRs not maintained */
+#define SRR1_WS_NOLOSS          0x00010000 /* All resources maintained */
+
 /* Facility Status and Control (FSCR) bits */
 #define FSCR_EBB        (63 - 56) /* Event-Based Branch Facility */
 #define FSCR_TAR        (63 - 55) /* Target Address Register */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 14d3902982..a988ba15f4 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -101,7 +101,7 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
     env->resume_as_sreset = false;
 
     /* Pretend to be returning from doze always as we don't lose state */
-    *msr |= (0x1ull << (63 - 47));
+    *msr |= SRR1_WS_NOLOSS;
 
     /* Machine checks are sent normally */
     if (excp == POWERPC_EXCP_MCHECK) {
@@ -109,25 +109,25 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
     }
     switch (excp) {
     case POWERPC_EXCP_RESET:
-        *msr |= 0x4ull << (63 - 45);
+        *msr |= SRR1_WAKERESET;
         break;
     case POWERPC_EXCP_EXTERNAL:
-        *msr |= 0x8ull << (63 - 45);
+        *msr |= SRR1_WAKEEE;
         break;
     case POWERPC_EXCP_DECR:
-        *msr |= 0x6ull << (63 - 45);
+        *msr |= SRR1_WAKEDEC;
         break;
     case POWERPC_EXCP_SDOOR:
-        *msr |= 0x5ull << (63 - 45);
+        *msr |= SRR1_WAKEDBELL;
         break;
     case POWERPC_EXCP_SDOOR_HV:
-        *msr |= 0x3ull << (63 - 45);
+        *msr |= SRR1_WAKEHDBELL;
         break;
     case POWERPC_EXCP_HV_MAINT:
-        *msr |= 0xaull << (63 - 45);
+        *msr |= SRR1_WAKEHMI;
         break;
     case POWERPC_EXCP_HVIRT:
-        *msr |= 0x9ull << (63 - 45);
+        *msr |= SRR1_WAKEHVI;
         break;
     default:
         cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
-- 
2.26.2


