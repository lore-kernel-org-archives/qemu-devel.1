Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECCC54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5739F207DD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5739F207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4IG-0000LV-Gm
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jY4HG-0007ye-5G
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:59:10 -0400
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:47108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jY4HA-0003o2-H8
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:59:09 -0400
Received: from player779.ha.ovh.net (unknown [10.110.208.43])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1F23D1B9C61
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 10:58:49 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 7101E123098AA;
 Mon, 11 May 2020 08:58:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] ppc/pnv: Add definitions for interrupts occurring in
 power-saving mode
Date: Mon, 11 May 2020 10:58:22 +0200
Message-Id: <20200511085822.65319-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1425670759773277158
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrledtgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieekkeelffetgeelveevjeehteduvdeivdeljeevvdeuvedtgfeiudeiveeiudfgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.45.107; envelope-from=clg@kaod.org;
 helo=5.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 04:58:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If an interrupt occurred when the thread was in power-saving mode,
bits [42:45] of SRR1 indicate the exception that caused exit from
power-saving mode.

bits [46:47] of SRR1 indicate the power-saving mode in which the
thread was when the interrupt occured.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h         | 21 +++++++++++++++++++++
 hw/ppc/pnv.c             |  8 ++++----
 target/ppc/excp_helper.c | 16 ++++++++--------
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index df5c30160da8..9648623677d2 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1b4748ce6dc3..182b62565022 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1986,15 +1986,15 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 
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
@@ -2004,7 +2004,7 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 	 * another CPU requesting a NMI IPI) system reset exception should be
 	 * 0b0010 (PPC_BIT(44)).
          */
-        env->spr[SPR_SRR1] |= PPC_BIT(44);
+        env->spr[SPR_SRR1] |= SRR1_WAKESCOM;
     }
 }
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 14d39029825a..a988ba15f4f7 100644
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
2.25.4


