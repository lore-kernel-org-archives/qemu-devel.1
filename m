Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8ACC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 03:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF33206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 03:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EMwtf4F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF33206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE2iW-0004Vs-Rd
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 23:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2hR-0002Kj-Et; Thu, 03 Sep 2020 23:47:41 -0400
Received: from ozlabs.org ([203.11.71.1]:53289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2hN-0004sK-Jt; Thu, 03 Sep 2020 23:47:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjNsn4xBzz9sV7; Fri,  4 Sep 2020 13:47:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599191245;
 bh=Ly+A7bmRWGNf8fZ+NruNygvD6RuKDnSvOp12wEpcHVI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EMwtf4F+3xTRqzqIxOKMFuSMuLzTNP7BmiJL/v2tN/TEkNDOX5sBHqOF+1Fmjrlyp
 po2ZEmPKy1SmTV3vHuTlO6reZlFo27BvFitD1KPFSZgrqEyWmt2E0ZH+y36c+JVrUC
 so3qdtYYxTlnemlAvqXcCrV/v/Q+5WWcK6ckfUFI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/30] spapr/xive: Add a 'hv-prio' property to represent the
 KVM escalation priority
Date: Fri,  4 Sep 2020 13:46:53 +1000
Message-Id: <20200904034719.673626-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904034719.673626-1-david@gibson.dropbear.id.au>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 23:47:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 bauerman@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

On POWER9, the KVM XIVE device uses priority 7 for the escalation
interrupts. On POWER10, the host can use a reduced set of priorities
and KVM will configure the escalation priority to a lower number. In
any case, the guest is allowed to use priorities in a single range :

    [ 0 .. (maxprio - 1) ].

Introduce a 'hv-prio' property to represent the escalation priority
number and use it to compute the "ibm,plat-res-int-priorities"
property defining the priority ranges reserved by the hypervisor.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200819130843.2230799-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 33 ++++++++++++++-------------------
 include/hw/ppc/spapr_xive.h |  2 ++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 4bd0d606ba..1fa09f287a 100644
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
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index a1c8540ab4..26c8d90d71 100644
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
-- 
2.26.2


