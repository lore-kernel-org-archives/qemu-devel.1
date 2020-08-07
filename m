Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3BF2177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3BF2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40cm-0006FM-Go
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k40bn-0004Zi-RA
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:32:23 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:54499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k40bm-0000xS-2O
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:32:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-K91spigQPsy-KtddlxJ8JQ-1; Fri, 07 Aug 2020 07:32:17 -0400
X-MC-Unique: K91spigQPsy-KtddlxJ8JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734F6107BEF8;
 Fri,  7 Aug 2020 11:32:16 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA7D65C7F;
 Fri,  7 Aug 2020 11:32:15 +0000 (UTC)
Subject: [PATCH v3 for-5.2 2/3] ppc/xive: Introduce dedicated
 kvm_irqchip_in_kernel() wrappers
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 07 Aug 2020 13:32:14 +0200
Message-ID: <159679993438.876294.7285654331498605426.stgit@bahia.lan>
In-Reply-To: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
References: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 07:32:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calls to the KVM XIVE device are guarded by kvm_irqchip_in_kernel(). This
ensures that QEMU won't try to use the device if KVM is disabled or if
an in-kernel irqchip isn't required.

When using ic-mode=3Ddual with the pseries machine, we have two possible
interrupt controllers: XIVE and XICS. The kvm_irqchip_in_kernel() helper
will return true as soon as any of the KVM device is created. It might
lure QEMU to think that the other one is also around, while it is not.
This is exactly what happens with ic-mode=3Ddual at machine init when
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
---
v3: Method for XiveNotifierClass no longer needed

v2: Introduce in_kernel() abstract methods in the base XIVE classes
---
 hw/intc/spapr_xive.c  |   45 +++++++++++++++++++++++++++++++--------------
 hw/intc/xive.c        |   25 +++++++++++++++++++------
 include/hw/ppc/xive.h |    1 +
 3 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 89c8cd96670b..3c84f64dc464 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -148,12 +148,19 @@ static void spapr_xive_end_pic_print_info(SpaprXive *=
xive, XiveEND *end,
     xive_end_queue_pic_print_info(end, 6, mon);
 }
=20
+/*
+ * kvm_irqchip_in_kernel() will cause the compiler to turn this
+ * info a nop if CONFIG_KVM isn't defined.
+ */
+#define spapr_xive_in_kernel(xive) \
+    (kvm_irqchip_in_kernel() && (xive)->fd !=3D -1)
+
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
 {
     XiveSource *xsrc =3D &xive->source;
     int i;
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_synchronize_state(xive, &local_err);
@@ -507,8 +514,10 @@ static const VMStateDescription vmstate_spapr_xive_eas=
 =3D {
=20
 static int vmstate_spapr_xive_pre_save(void *opaque)
 {
-    if (kvm_irqchip_in_kernel()) {
-        return kvmppc_xive_pre_save(SPAPR_XIVE(opaque));
+    SpaprXive *xive =3D SPAPR_XIVE(opaque);
+
+    if (spapr_xive_in_kernel(xive)) {
+        return kvmppc_xive_pre_save(xive);
     }
=20
     return 0;
@@ -520,8 +529,10 @@ static int vmstate_spapr_xive_pre_save(void *opaque)
  */
 static int spapr_xive_post_load(SpaprInterruptController *intc, int versio=
n_id)
 {
-    if (kvm_irqchip_in_kernel()) {
-        return kvmppc_xive_post_load(SPAPR_XIVE(intc), version_id);
+    SpaprXive *xive =3D SPAPR_XIVE(intc);
+
+    if (spapr_xive_in_kernel(xive)) {
+        return kvmppc_xive_post_load(xive, version_id);
     }
=20
     return 0;
@@ -564,7 +575,7 @@ static int spapr_xive_claim_irq(SpaprInterruptControlle=
r *intc, int lisn,
         xive_source_irq_set_lsi(xsrc, lisn);
     }
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
     }
=20
@@ -641,7 +652,7 @@ static void spapr_xive_set_irq(SpaprInterruptController=
 *intc, int irq, int val)
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         kvmppc_xive_source_set_irq(&xive->source, irq, val);
     } else {
         xive_source_set_irq(&xive->source, irq, val);
@@ -749,11 +760,16 @@ static void spapr_xive_deactivate(SpaprInterruptContr=
oller *intc)
=20
     spapr_xive_mmio_set_enabled(xive, false);
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         kvmppc_xive_disconnect(intc);
     }
 }
=20
+static bool spapr_xive_in_kernel_xptr(const XivePresenter *xptr)
+{
+    return spapr_xive_in_kernel(SPAPR_XIVE(xptr));
+}
+
 static void spapr_xive_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -788,6 +804,7 @@ static void spapr_xive_class_init(ObjectClass *klass, v=
oid *data)
     sicc->post_load =3D spapr_xive_post_load;
=20
     xpc->match_nvt  =3D spapr_xive_match_nvt;
+    xpc->in_kernel  =3D spapr_xive_in_kernel_xptr;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
@@ -1058,7 +1075,7 @@ static target_ulong h_int_set_source_config(PowerPCCP=
U *cpu,
         new_eas.w =3D xive_set_field64(EAS_END_DATA, new_eas.w, eisn);
     }
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_err);
@@ -1379,7 +1396,7 @@ static target_ulong h_int_set_queue_config(PowerPCCPU=
 *cpu,
      */
=20
 out:
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &local_=
err);
@@ -1480,7 +1497,7 @@ static target_ulong h_int_get_queue_config(PowerPCCPU=
 *cpu,
         args[2] =3D 0;
     }
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &local_e=
rr);
@@ -1642,7 +1659,7 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
         return H_P3;
     }
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         args[0] =3D kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
                                      flags & SPAPR_XIVE_ESB_STORE);
     } else {
@@ -1717,7 +1734,7 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
      * under KVM
      */
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_sync_source(xive, lisn, &local_err);
@@ -1761,7 +1778,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
=20
     device_legacy_reset(DEVICE(xive));
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (spapr_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_reset(xive, &local_err);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 561d746cd1da..a453e8f4dcbe 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -592,6 +592,17 @@ static const char * const xive_tctx_ring_names[] =3D {
     "USER", "OS", "POOL", "PHYS",
 };
=20
+/*
+ * kvm_irqchip_in_kernel() will cause the compiler to turn this
+ * info a nop if CONFIG_KVM isn't defined.
+ */
+#define xive_in_kernel(xptr)                                            \
+    (kvm_irqchip_in_kernel() &&                                         \
+     ({                                                                 \
+         XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);      =
\
+         xpc->in_kernel ? xpc->in_kernel(xptr) : false;                 \
+     }))
+
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
 {
     int cpu_index;
@@ -606,7 +617,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *=
mon)
=20
     cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (xive_in_kernel(tctx->xptr)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
@@ -671,7 +682,7 @@ static void xive_tctx_realize(DeviceState *dev, Error *=
*errp)
     }
=20
     /* Connect the presenter to the VCPU (required for CPU hotplug) */
-    if (kvm_irqchip_in_kernel()) {
+    if (xive_in_kernel(tctx->xptr)) {
         kvmppc_xive_cpu_connect(tctx, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -682,10 +693,11 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
=20
 static int vmstate_xive_tctx_pre_save(void *opaque)
 {
+    XiveTCTX *tctx =3D XIVE_TCTX(opaque);
     Error *local_err =3D NULL;
=20
-    if (kvm_irqchip_in_kernel()) {
-        kvmppc_xive_cpu_get_state(XIVE_TCTX(opaque), &local_err);
+    if (xive_in_kernel(tctx->xptr)) {
+        kvmppc_xive_cpu_get_state(tctx, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -1;
@@ -697,14 +709,15 @@ static int vmstate_xive_tctx_pre_save(void *opaque)
=20
 static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
 {
+    XiveTCTX *tctx =3D XIVE_TCTX(opaque);
     Error *local_err =3D NULL;
=20
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
index 82a61eaca74f..2f3c5af810bb 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -402,6 +402,7 @@ typedef struct XivePresenterClass {
                      uint8_t nvt_blk, uint32_t nvt_idx,
                      bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
+    bool (*in_kernel)(const XivePresenter *xptr);
 } XivePresenterClass;
=20
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,



