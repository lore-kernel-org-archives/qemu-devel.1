Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19043C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B5B206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="L4YUi8yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B5B206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tHD-0002RS-F9
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6H-0007kV-2c; Tue, 18 Aug 2020 00:19:53 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6E-0006OJ-Sz; Tue, 18 Aug 2020 00:19:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNd4865z9sVg; Tue, 18 Aug 2020 14:19:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724369;
 bh=GD4OipZ8hOU2+/gyQ5TK/Laf6IOlG9KPRJDCNf+Gid0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L4YUi8yhsc/bFajsFSbUfqS9mvFyBgwvWanmJ5eflxH053sYETvHrdERWLc71yQcF
 HYv12So9mjvWvJRbIx6q/EIgXdtanSpB2OW5qE2TQ4gIBfdcObGJxZfbeGp6nd9cDQ
 +inRq/1N6ODssnvlGpAjIa6B41gos/ar5VRLgiRo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 23/40] ppc/xive: Introduce dedicated kvm_irqchip_in_kernel()
 wrappers
Date: Tue, 18 Aug 2020 14:19:05 +1000
Message-Id: <20200818041922.251708-24-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Calls to the KVM XIVE device are guarded by kvm_irqchip_in_kernel(). This
ensures that QEMU won't try to use the device if KVM is disabled or if
an in-kernel irqchip isn't required.

When using ic-mode=dual with the pseries machine, we have two possible
interrupt controllers: XIVE and XICS. The kvm_irqchip_in_kernel() helper
will return true as soon as any of the KVM device is created. It might
lure QEMU to think that the other one is also around, while it is not.
This is exactly what happens with ic-mode=dual at machine init when
claiming IRQ numbers, which must be done on all possible IRQ backends,
eg. RTAS event sources or the PHB0 LSI table : only the KVM XICS device
is active but we end up calling kvmppc_xive_source_reset_one() anyway,
which fails. This doesn't cause any trouble because of another bug :
kvmppc_xive_source_reset_one() lacks an error_setg() and callers don't
see the failure.

Most of the other kvmppc_xive_* functions have similar xive->fd
checks to filter out the case when KVM XIVE isn't active. It
might look safer to have idempotent functions but it doesn't
really help to understand what's going on when debugging.

Since we already have all the kvm_irqchip_in_kernel() in place,
also have the callers to check xive->fd as well before calling
KVM XIVE specific code. This is straight-forward for the spapr
specific XIVE code. Some more care is needed for the platform
agnostic XIVE code since it cannot access xive->fd directly.
Introduce new in_kernel() methods in some base XIVE classes
for this purpose and implement them only in spapr.

In all cases, we still need to call kvm_irqchip_in_kernel() so that
compilers can optimize the kvmppc_xive_* calls away when CONFIG_KVM
isn't defined, thus avoiding the need for stubs.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159679993438.876294.7285654331498605426.stgit@bahia.lan>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c  | 45 +++++++++++++++++++++++++++++--------------
 hw/intc/xive.c        | 25 ++++++++++++++++++------
 include/hw/ppc/xive.h |  1 +
 3 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 89c8cd9667..3c84f64dc4 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -148,12 +148,19 @@ static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
     xive_end_queue_pic_print_info(end, 6, mon);
 }
 
+/*
+ * kvm_irqchip_in_kernel() will cause the compiler to turn this
+ * info a nop if CONFIG_KVM isn't defined.
+ */
+#define spapr_xive_in_kernel(xive) \
+    (kvm_irqchip_in_kernel() && (xive)->fd != -1)
+
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
 {
     XiveSource *xsrc = &xive->source;
     int i;
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err = NULL;
 
         kvmppc_xive_synchronize_state(xive, &local_err);
@@ -507,8 +514,10 @@ static const VMStateDescription vmstate_spapr_xive_eas = {
 
 static int vmstate_spapr_xive_pre_save(void *opaque)
 {
-    if (kvm_irqchip_in_kernel()) {
-        return kvmppc_xive_pre_save(SPAPR_XIVE(opaque));
+    SpaprXive *xive = SPAPR_XIVE(opaque);
+
+    if (spapr_xive_in_kernel(xive)) {
+        return kvmppc_xive_pre_save(xive);
     }
 
     return 0;
@@ -520,8 +529,10 @@ static int vmstate_spapr_xive_pre_save(void *opaque)
  */
 static int spapr_xive_post_load(SpaprInterruptController *intc, int version_id)
 {
-    if (kvm_irqchip_in_kernel()) {
-        return kvmppc_xive_post_load(SPAPR_XIVE(intc), version_id);
+    SpaprXive *xive = SPAPR_XIVE(intc);
+
+    if (spapr_xive_in_kernel(xive)) {
+        return kvmppc_xive_post_load(xive, version_id);
     }
 
     return 0;
@@ -564,7 +575,7 @@ static int spapr_xive_claim_irq(SpaprInterruptController *intc, int lisn,
         xive_source_irq_set_lsi(xsrc, lisn);
     }
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
     }
 
@@ -641,7 +652,7 @@ static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, int val)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         kvmppc_xive_source_set_irq(&xive->source, irq, val);
     } else {
         xive_source_set_irq(&xive->source, irq, val);
@@ -749,11 +760,16 @@ static void spapr_xive_deactivate(SpaprInterruptController *intc)
 
     spapr_xive_mmio_set_enabled(xive, false);
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         kvmppc_xive_disconnect(intc);
     }
 }
 
+static bool spapr_xive_in_kernel_xptr(const XivePresenter *xptr)
+{
+    return spapr_xive_in_kernel(SPAPR_XIVE(xptr));
+}
+
 static void spapr_xive_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -788,6 +804,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
     sicc->post_load = spapr_xive_post_load;
 
     xpc->match_nvt  = spapr_xive_match_nvt;
+    xpc->in_kernel  = spapr_xive_in_kernel_xptr;
 }
 
 static const TypeInfo spapr_xive_info = {
@@ -1058,7 +1075,7 @@ static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
         new_eas.w = xive_set_field64(EAS_END_DATA, new_eas.w, eisn);
     }
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err = NULL;
 
         kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_err);
@@ -1379,7 +1396,7 @@ static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
      */
 
 out:
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err = NULL;
 
         kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &local_err);
@@ -1480,7 +1497,7 @@ static target_ulong h_int_get_queue_config(PowerPCCPU *cpu,
         args[2] = 0;
     }
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err = NULL;
 
         kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &local_err);
@@ -1642,7 +1659,7 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
         return H_P3;
     }
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         args[0] = kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
                                      flags & SPAPR_XIVE_ESB_STORE);
     } else {
@@ -1717,7 +1734,7 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
      * under KVM
      */
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err = NULL;
 
         kvmppc_xive_sync_source(xive, lisn, &local_err);
@@ -1761,7 +1778,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
 
     device_legacy_reset(DEVICE(xive));
 
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err = NULL;
 
         kvmppc_xive_reset(xive, &local_err);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 561d746cd1..a453e8f4dc 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -592,6 +592,17 @@ static const char * const xive_tctx_ring_names[] = {
     "USER", "OS", "POOL", "PHYS",
 };
 
+/*
+ * kvm_irqchip_in_kernel() will cause the compiler to turn this
+ * info a nop if CONFIG_KVM isn't defined.
+ */
+#define xive_in_kernel(xptr)                                            \
+    (kvm_irqchip_in_kernel() &&                                         \
+     ({                                                                 \
+         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);      \
+         xpc->in_kernel ? xpc->in_kernel(xptr) : false;                 \
+     }))
+
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
 {
     int cpu_index;
@@ -606,7 +617,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
 
     cpu_index = tctx->cs ? tctx->cs->cpu_index : -1;
 
-    if (kvm_irqchip_in_kernel()) {
+    if (xive_in_kernel(tctx->xptr)) {
         Error *local_err = NULL;
 
         kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
@@ -671,7 +682,7 @@ static void xive_tctx_realize(DeviceState *dev, Error **errp)
     }
 
     /* Connect the presenter to the VCPU (required for CPU hotplug) */
-    if (kvm_irqchip_in_kernel()) {
+    if (xive_in_kernel(tctx->xptr)) {
         kvmppc_xive_cpu_connect(tctx, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -682,10 +693,11 @@ static void xive_tctx_realize(DeviceState *dev, Error **errp)
 
 static int vmstate_xive_tctx_pre_save(void *opaque)
 {
+    XiveTCTX *tctx = XIVE_TCTX(opaque);
     Error *local_err = NULL;
 
-    if (kvm_irqchip_in_kernel()) {
-        kvmppc_xive_cpu_get_state(XIVE_TCTX(opaque), &local_err);
+    if (xive_in_kernel(tctx->xptr)) {
+        kvmppc_xive_cpu_get_state(tctx, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -1;
@@ -697,14 +709,15 @@ static int vmstate_xive_tctx_pre_save(void *opaque)
 
 static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
 {
+    XiveTCTX *tctx = XIVE_TCTX(opaque);
     Error *local_err = NULL;
 
-    if (kvm_irqchip_in_kernel()) {
+    if (xive_in_kernel(tctx->xptr)) {
         /*
          * Required for hotplugged CPU, for which the state comes
          * after all states of the machine.
          */
-        kvmppc_xive_cpu_set_state(XIVE_TCTX(opaque), &local_err);
+        kvmppc_xive_cpu_set_state(tctx, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -1;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 82a61eaca7..2f3c5af810 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -402,6 +402,7 @@ typedef struct XivePresenterClass {
                      uint8_t nvt_blk, uint32_t nvt_idx,
                      bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
+    bool (*in_kernel)(const XivePresenter *xptr);
 } XivePresenterClass;
 
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.26.2


