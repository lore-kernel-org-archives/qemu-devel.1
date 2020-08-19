Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8410DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5841A206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5841A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8NqZ-0006Uf-J4
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npl-0004sb-Kd; Wed, 19 Aug 2020 09:08:53 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:56181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npj-0006LG-DW; Wed, 19 Aug 2020 09:08:53 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.48])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4C1DF51EFC69;
 Wed, 19 Aug 2020 15:08:48 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:08:47 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0025ea54756-2229-4e8c-9abe-a16a990f0f54,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/8] spapr/xive: Add a 'hv-prio' property to represent the KVM
 escalation priority
Date: Wed, 19 Aug 2020 15:08:36 +0200
Message-ID: <20200819130843.2230799-2-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819130843.2230799-1-clg@kaod.org>
References: <20200819130843.2230799-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 0e746071-b9c8-4da6-8e3b-cb7d7c648407
X-Ovh-Tracer-Id: 2621094985544862502
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 09:08:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On POWER9, the KVM XIVE device uses priority 7 for the escalation
interrupts. On POWER10, the host can use a reduced set of priorities
and KVM will configure the escalation priority to a lower number. In
any case, the guest is allowed to use priorities in a single range :

    [ 0 .. (maxprio - 1) ].

Introduce a 'hv-prio' property to represent the escalation priority
number and use it to compute the "ibm,plat-res-int-priorities"
property defining the priority ranges reserved by the hypervisor.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |  2 ++
 hw/intc/spapr_xive.c        | 33 ++++++++++++++-------------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 0ffbe0be0280..1dddcbcb9cdd 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -49,6 +49,8 @@ typedef struct SpaprXive {
     void          *tm_mmap;
     MemoryRegion  tm_mmio_kvm;
     VMChangeStateEntry *change;
+
+    uint8_t       hv_prio;
 } SpaprXive;
 
 typedef struct SpaprXiveClass {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 4bd0d606ba17..1fa09f287ac0 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -595,6 +595,7 @@ static Property spapr_xive_properties[] = {
     DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
     DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE),
     DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_BASE),
+    DEFINE_PROP_UINT8("hv-prio", SpaprXive, hv_prio, 7),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -692,12 +693,13 @@ static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_servers,
         cpu_to_be32(16), /* 64K */
     };
     /*
-     * The following array is in sync with the reserved priorities
-     * defined by the 'spapr_xive_priority_is_reserved' routine.
+     * QEMU/KVM only needs to define a single range to reserve the
+     * escalation priority. A priority bitmask would have been more
+     * appropriate.
      */
     uint32_t plat_res_int_priorities[] = {
-        cpu_to_be32(7),    /* start */
-        cpu_to_be32(0xf8), /* count */
+        cpu_to_be32(xive->hv_prio),    /* start */
+        cpu_to_be32(0xff - xive->hv_prio), /* count */
     };
 
     /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) */
@@ -844,19 +846,12 @@ type_init(spapr_xive_register_types)
  */
 
 /*
- * Linux hosts under OPAL reserve priority 7 for their own escalation
- * interrupts (DD2.X POWER9). So we only allow the guest to use
- * priorities [0..6].
+ * On POWER9, the KVM XIVE device uses priority 7 for the escalation
+ * interrupts. So we only allow the guest to use priorities [0..6].
  */
-static bool spapr_xive_priority_is_reserved(uint8_t priority)
+static bool spapr_xive_priority_is_reserved(SpaprXive *xive, uint8_t priority)
 {
-    switch (priority) {
-    case 0 ... 6:
-        return false;
-    case 7: /* OPAL escalation queue */
-    default:
-        return true;
-    }
+    return priority >= xive->hv_prio;
 }
 
 /*
@@ -1053,7 +1048,7 @@ static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
         new_eas.w = eas.w & cpu_to_be64(~EAS_MASKED);
     }
 
-    if (spapr_xive_priority_is_reserved(priority)) {
+    if (spapr_xive_priority_is_reserved(xive, priority)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
                       " is reserved\n", priority);
         return H_P4;
@@ -1212,7 +1207,7 @@ static target_ulong h_int_get_queue_info(PowerPCCPU *cpu,
      * This is not needed when running the emulation under QEMU
      */
 
-    if (spapr_xive_priority_is_reserved(priority)) {
+    if (spapr_xive_priority_is_reserved(xive, priority)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
                       " is reserved\n", priority);
         return H_P3;
@@ -1299,7 +1294,7 @@ static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
      * This is not needed when running the emulation under QEMU
      */
 
-    if (spapr_xive_priority_is_reserved(priority)) {
+    if (spapr_xive_priority_is_reserved(xive, priority)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
                       " is reserved\n", priority);
         return H_P3;
@@ -1466,7 +1461,7 @@ static target_ulong h_int_get_queue_config(PowerPCCPU *cpu,
      * This is not needed when running the emulation under QEMU
      */
 
-    if (spapr_xive_priority_is_reserved(priority)) {
+    if (spapr_xive_priority_is_reserved(xive, priority)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
                       " is reserved\n", priority);
         return H_P3;
-- 
2.25.4


