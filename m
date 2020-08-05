Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2042922D37
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2042922D37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3NMb-00024F-Bj
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 13:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3NKO-0006wX-2y
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 13:35:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54357
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3NKL-0001VT-UL
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 13:35:47 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-vK98yMR0Mi6TNdccR9la9w-1; Wed, 05 Aug 2020 13:35:40 -0400
X-MC-Unique: vK98yMR0Mi6TNdccR9la9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B2E80183C;
 Wed,  5 Aug 2020 17:35:39 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E41C69500;
 Wed,  5 Aug 2020 17:35:38 +0000 (UTC)
Subject: [PATCH for-5.2 3/5] ppc/xive: Introduce dedicated
 kvm_irqchip_in_kernel() wrappers
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 05 Aug 2020 19:35:37 +0200
Message-ID: <159664893734.638781.14358602267403682394.stgit@bahia.lan>
In-Reply-To: <159664891296.638781.18417631893299150932.stgit@bahia.lan>
References: <159664891296.638781.18417631893299150932.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
KVM XIVE specific code. Introduce helpers to access the underlying
fd for various XIVE types and call them with a kvm_irqchip_in_kernel()
guard : this allows the compiler to optimize the kvmppc_xive_* calls
out if CONFIG_KVM isn't defined, thus avoiding the need for stubs.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |   39 +++++++++++++++++++++++++--------------
 hw/intc/spapr_xive_kvm.c    |   15 +++++++++++++++
 hw/intc/xive.c              |   30 +++++++++++++++++++++++-------
 include/hw/ppc/spapr_xive.h |    1 +
 include/hw/ppc/xive.h       |    2 ++
 5 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 89c8cd96670b..98e6489fb16d 100644
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
+#define kvmppc_xive_in_kernel(xive) \
+    (kvm_irqchip_in_kernel() && kvmppc_xive_kernel_irqchip(xive))
+
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
 {
     XiveSource *xsrc =3D &xive->source;
     int i;
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
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
+    if (kvmppc_xive_in_kernel(xive)) {
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
+    if (kvmppc_xive_in_kernel(xive)) {
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
+    if (kvmppc_xive_in_kernel(xive)) {
         return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
     }
=20
@@ -641,7 +652,7 @@ static void spapr_xive_set_irq(SpaprInterruptController=
 *intc, int irq, int val)
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
         kvmppc_xive_source_set_irq(&xive->source, irq, val);
     } else {
         xive_source_set_irq(&xive->source, irq, val);
@@ -749,7 +760,7 @@ static void spapr_xive_deactivate(SpaprInterruptControl=
ler *intc)
=20
     spapr_xive_mmio_set_enabled(xive, false);
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
         kvmppc_xive_disconnect(intc);
     }
 }
@@ -1058,7 +1069,7 @@ static target_ulong h_int_set_source_config(PowerPCCP=
U *cpu,
         new_eas.w =3D xive_set_field64(EAS_END_DATA, new_eas.w, eisn);
     }
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_err);
@@ -1379,7 +1390,7 @@ static target_ulong h_int_set_queue_config(PowerPCCPU=
 *cpu,
      */
=20
 out:
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &local_=
err);
@@ -1480,7 +1491,7 @@ static target_ulong h_int_get_queue_config(PowerPCCPU=
 *cpu,
         args[2] =3D 0;
     }
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &local_e=
rr);
@@ -1642,7 +1653,7 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
         return H_P3;
     }
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
         args[0] =3D kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
                                      flags & SPAPR_XIVE_ESB_STORE);
     } else {
@@ -1717,7 +1728,7 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
      * under KVM
      */
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_sync_source(xive, lisn, &local_err);
@@ -1761,7 +1772,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
=20
     device_legacy_reset(DEVICE(xive));
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel(xive)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_reset(xive, &local_err);
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 893a1ee77e70..a9657e2b0cda 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -889,3 +889,18 @@ void kvmppc_xive_disconnect(SpaprInterruptController *=
intc)
         xive->change =3D NULL;
     }
 }
+
+bool kvmppc_xive_kernel_irqchip(SpaprXive *xive)
+{
+    return xive->fd !=3D -1;
+}
+
+bool kvmppc_xive_kernel_irqchip_tctx(XiveTCTX *tctx)
+{
+    return kvmppc_xive_kernel_irqchip(SPAPR_XIVE(tctx->xptr));
+}
+
+bool kvmppc_xive_kernel_irqchip_xsrc(XiveSource *xsrc)
+{
+    return kvmppc_xive_kernel_irqchip(SPAPR_XIVE(xsrc->xive));
+}
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9b55e0356c62..2e1af4530dc5 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -592,6 +592,13 @@ static const char * const xive_tctx_ring_names[] =3D {
     "USER", "OS", "POOL", "PHYS",
 };
=20
+/*
+ * kvm_irqchip_in_kernel() will cause the compiler to turn this
+ * info a nop if CONFIG_KVM isn't defined.
+ */
+#define kvmppc_xive_in_kernel_tctx(tctx) \
+    (kvm_irqchip_in_kernel() && kvmppc_xive_kernel_irqchip_tctx(tctx))
+
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
 {
     int cpu_index;
@@ -606,7 +613,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *=
mon)
=20
     cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel_tctx(tctx)) {
         Error *local_err =3D NULL;
=20
         kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
@@ -671,7 +678,7 @@ static void xive_tctx_realize(DeviceState *dev, Error *=
*errp)
     }
=20
     /* Connect the presenter to the VCPU (required for CPU hotplug) */
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel_tctx(tctx)) {
         kvmppc_xive_cpu_connect(tctx, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -682,10 +689,11 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
=20
 static int vmstate_xive_tctx_pre_save(void *opaque)
 {
+    XiveTCTX *tctx =3D XIVE_TCTX(opaque);
     Error *local_err =3D NULL;
=20
-    if (kvm_irqchip_in_kernel()) {
-        kvmppc_xive_cpu_get_state(XIVE_TCTX(opaque), &local_err);
+    if (kvmppc_xive_in_kernel_tctx(tctx)) {
+        kvmppc_xive_cpu_get_state(tctx, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -1;
@@ -697,14 +705,15 @@ static int vmstate_xive_tctx_pre_save(void *opaque)
=20
 static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
 {
+    XiveTCTX *tctx =3D XIVE_TCTX(opaque);
     Error *local_err =3D NULL;
=20
-    if (kvm_irqchip_in_kernel()) {
+    if (kvmppc_xive_in_kernel_tctx(tctx)) {
         /*
          * Required for hotplugged CPU, for which the state comes
          * after all states of the machine.
          */
-        kvmppc_xive_cpu_set_state(XIVE_TCTX(opaque), &local_err);
+        kvmppc_xive_cpu_set_state(tctx, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -1;
@@ -1125,6 +1134,13 @@ static void xive_source_reset(void *dev)
     memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
 }
=20
+/*
+ * kvm_irqchip_in_kernel() will cause the compiler to turn this
+ * info a nop if CONFIG_KVM isn't defined.
+ */
+#define kvmppc_xive_in_kernel_xsrc(xsrc) \
+    (kvm_irqchip_in_kernel() && kvmppc_xive_kernel_irqchip_xsrc(xsrc))
+
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(dev);
@@ -1147,7 +1163,7 @@ static void xive_source_realize(DeviceState *dev, Err=
or **errp)
     xsrc->status =3D g_malloc0(xsrc->nr_irqs);
     xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
=20
-    if (!kvm_irqchip_in_kernel()) {
+    if (!kvmppc_xive_in_kernel_xsrc(xsrc)) {
         memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
                               &xive_source_esb_ops, xsrc, "xive.esb",
                               (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 93d09d68deb7..9fd00378ac1f 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -94,5 +94,6 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_=
t end_blk,
 void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp);
 int kvmppc_xive_pre_save(SpaprXive *xive);
 int kvmppc_xive_post_load(SpaprXive *xive, int version_id);
+bool kvmppc_xive_kernel_irqchip(SpaprXive *xive);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 705cf48176fc..ea66e9ea9c7b 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -484,5 +484,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **er=
rp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
+bool kvmppc_xive_kernel_irqchip_tctx(XiveTCTX *tctx);
+bool kvmppc_xive_kernel_irqchip_xsrc(XiveSource *xsrc);
=20
 #endif /* PPC_XIVE_H */



