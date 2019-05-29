Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD992C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993BE208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="h52aEk43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993BE208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48891 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVswX-0002Zb-Ni
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:24:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQV-0000P3-6U
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQT-0002tx-2I
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:07 -0400
Received: from ozlabs.org ([203.11.71.1]:56121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQS-0002fk-Gd; Wed, 29 May 2019 02:51:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv63Ws0z9sPW; Wed, 29 May 2019 16:50:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112626;
	bh=7aMwEc/K7U7fFcyDgJ7x3XIzmXqCoehQFLdOQob6q2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h52aEk43QQZAvMn7AOiVsYzfXCWXmtBlDbaSMBL65VWdXRUC5HJ9F+FFtBZSUIXMn
	lJAEEI2zo5qky8GZ7SYCDTtn8aA5P6zHXBwFYzvbQQ7HMRiU6JaTLiHK0lMDFZUJZh
	Q5nPbNgdZGyxM63h0iiHaqYrnZcvNRjLDbS9iGd0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:50:00 +1000
Message-Id: <20190529065017.15149-28-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 27/44] spapr/xive: add hcall support when under
 KVM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

XIVE hcalls are all redirected to QEMU as none are on a fast path.
When necessary, QEMU invokes KVM through specific ioctls to perform
host operations. QEMU should have done the necessary checks before
calling KVM and, in case of failure, H_HARDWARE is simply returned.

H_INT_ESB is a special case that could have been handled under KVM
but the impact on performance was low when under QEMU. Here are some
figures :

    kernel irqchip      OFF          ON
    H_INT_ESB                    KVM   QEMU

    rtl8139 (LSI )      1.19     1.24  1.23  Gbits/sec
    virtio             31.80    42.30   --   Gbits/sec

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190513084245.25755-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        |  90 ++++++++++++++--
 hw/intc/spapr_xive_kvm.c    | 197 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_xive.h |  15 +++
 3 files changed, 294 insertions(+), 8 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 27632683e6..03f92c3e65 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -86,6 +86,22 @@ static int spapr_xive_target_to_nvt(uint32_t target,
  * sPAPR END indexing uses a simple mapping of the CPU vcpu_id, 8
  * priorities per CPU
  */
+int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
+                             uint32_t *out_server, uint8_t *out_prio)
+{
+
+    assert(end_blk =3D=3D SPAPR_XIVE_BLOCK_ID);
+
+    if (out_server) {
+        *out_server =3D end_idx >> 3;
+    }
+
+    if (out_prio) {
+        *out_prio =3D end_idx & 0x7;
+    }
+    return 0;
+}
+
 static void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
                                   uint8_t *out_end_blk, uint32_t *out_en=
d_idx)
 {
@@ -792,6 +808,16 @@ static target_ulong h_int_set_source_config(PowerPCC=
PU *cpu,
         new_eas.w =3D xive_set_field64(EAS_END_DATA, new_eas.w, eisn);
     }
=20
+    if (kvm_irqchip_in_kernel()) {
+        Error *local_err =3D NULL;
+
+        kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return H_HARDWARE;
+        }
+    }
+
 out:
     xive->eat[lisn] =3D new_eas;
     return H_SUCCESS;
@@ -1103,6 +1129,16 @@ static target_ulong h_int_set_queue_config(PowerPC=
CPU *cpu,
      */
=20
 out:
+    if (kvm_irqchip_in_kernel()) {
+        Error *local_err =3D NULL;
+
+        kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &loca=
l_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return H_HARDWARE;
+        }
+    }
+
     /* Update END */
     memcpy(&xive->endt[end_idx], &end, sizeof(XiveEND));
     return H_SUCCESS;
@@ -1194,6 +1230,16 @@ static target_ulong h_int_get_queue_config(PowerPC=
CPU *cpu,
         args[2] =3D 0;
     }
=20
+    if (kvm_irqchip_in_kernel()) {
+        Error *local_err =3D NULL;
+
+        kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &local=
_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return H_HARDWARE;
+        }
+    }
+
     /* TODO: do we need any locking on the END ? */
     if (flags & SPAPR_XIVE_END_DEBUG) {
         /* Load the event queue generation number into the return flags =
*/
@@ -1346,15 +1392,20 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
         return H_P3;
     }
=20
-    mmio_addr =3D xive->vc_base + xive_source_esb_mgmt(xsrc, lisn) + off=
set;
+    if (kvm_irqchip_in_kernel()) {
+        args[0] =3D kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
+                                     flags & SPAPR_XIVE_ESB_STORE);
+    } else {
+        mmio_addr =3D xive->vc_base + xive_source_esb_mgmt(xsrc, lisn) +=
 offset;
=20
-    if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
-                      (flags & SPAPR_XIVE_ESB_STORE))) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @0x%"
-                      HWADDR_PRIx "\n", mmio_addr);
-        return H_HARDWARE;
+        if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
+                          (flags & SPAPR_XIVE_ESB_STORE))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @=
0x%"
+                          HWADDR_PRIx "\n", mmio_addr);
+            return H_HARDWARE;
+        }
+        args[0] =3D (flags & SPAPR_XIVE_ESB_STORE) ? -1 : data;
     }
-    args[0] =3D (flags & SPAPR_XIVE_ESB_STORE) ? -1 : data;
     return H_SUCCESS;
 }
=20
@@ -1411,7 +1462,20 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
      * This is not needed when running the emulation under QEMU
      */
=20
-    /* This is not real hardware. Nothing to be done */
+    /*
+     * This is not real hardware. Nothing to be done unless when
+     * under KVM
+     */
+
+    if (kvm_irqchip_in_kernel()) {
+        Error *local_err =3D NULL;
+
+        kvmppc_xive_sync_source(xive, lisn, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return H_HARDWARE;
+        }
+    }
     return H_SUCCESS;
 }
=20
@@ -1446,6 +1510,16 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
     }
=20
     device_reset(DEVICE(xive));
+
+    if (kvm_irqchip_in_kernel()) {
+        Error *local_err =3D NULL;
+
+        kvmppc_xive_reset(xive, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return H_HARDWARE;
+        }
+    }
     return H_SUCCESS;
 }
=20
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 7d9e771e8a..964bad0c23 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -89,6 +89,50 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **e=
rrp)
  * XIVE Interrupt Source (KVM)
  */
=20
+void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveE=
AS *eas,
+                                   Error **errp)
+{
+    uint32_t end_idx;
+    uint32_t end_blk;
+    uint8_t priority;
+    uint32_t server;
+    bool masked;
+    uint32_t eisn;
+    uint64_t kvm_src;
+    Error *local_err =3D NULL;
+
+    assert(xive_eas_is_valid(eas));
+
+    end_idx =3D xive_get_field64(EAS_END_INDEX, eas->w);
+    end_blk =3D xive_get_field64(EAS_END_BLOCK, eas->w);
+    eisn =3D xive_get_field64(EAS_END_DATA, eas->w);
+    masked =3D xive_eas_is_masked(eas);
+
+    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
+
+    kvm_src =3D priority << KVM_XIVE_SOURCE_PRIORITY_SHIFT &
+        KVM_XIVE_SOURCE_PRIORITY_MASK;
+    kvm_src |=3D server << KVM_XIVE_SOURCE_SERVER_SHIFT &
+        KVM_XIVE_SOURCE_SERVER_MASK;
+    kvm_src |=3D ((uint64_t) masked << KVM_XIVE_SOURCE_MASKED_SHIFT) &
+        KVM_XIVE_SOURCE_MASKED_MASK;
+    kvm_src |=3D ((uint64_t)eisn << KVM_XIVE_SOURCE_EISN_SHIFT) &
+        KVM_XIVE_SOURCE_EISN_MASK;
+
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lisn,
+                      &kvm_src, true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **err=
p)
+{
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_SYNC, lisn,
+                      NULL, true, errp);
+}
+
 /*
  * At reset, the interrupt sources are simply created and MASKED. We
  * only need to inform the KVM XIVE device about their type: LSI or
@@ -125,6 +169,64 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, Erro=
r **errp)
     }
 }
=20
+/*
+ * This is used to perform the magic loads on the ESB pages, described
+ * in xive.h.
+ *
+ * Memory barriers should not be needed for loads (no store for now).
+ */
+static uint64_t xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset=
,
+                            uint64_t data, bool write)
+{
+    uint64_t *addr =3D xsrc->esb_mmap + xive_source_esb_mgmt(xsrc, srcno=
) +
+        offset;
+
+    if (write) {
+        *addr =3D cpu_to_be64(data);
+        return -1;
+    } else {
+        /* Prevent the compiler from optimizing away the load */
+        volatile uint64_t value =3D be64_to_cpu(*addr);
+        return value;
+    }
+}
+
+static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t offse=
t)
+{
+    return xive_esb_rw(xsrc, srcno, offset, 0, 0) & 0x3;
+}
+
+static void xive_esb_trigger(XiveSource *xsrc, int srcno)
+{
+    uint64_t *addr =3D xsrc->esb_mmap + xive_source_esb_page(xsrc, srcno=
);
+
+    *addr =3D 0x0;
+}
+
+uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset=
,
+                            uint64_t data, bool write)
+{
+    if (write) {
+        return xive_esb_rw(xsrc, srcno, offset, data, 1);
+    }
+
+    /*
+     * Special Load EOI handling for LSI sources. Q bit is never set
+     * and the interrupt should be re-triggered if the level is still
+     * asserted.
+     */
+    if (xive_source_irq_is_lsi(xsrc, srcno) &&
+        offset =3D=3D XIVE_ESB_LOAD_EOI) {
+        xive_esb_read(xsrc, srcno, XIVE_ESB_SET_PQ_00);
+        if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
+            xive_esb_trigger(xsrc, srcno);
+        }
+        return 0;
+    } else {
+        return xive_esb_rw(xsrc, srcno, offset, 0, 0);
+    }
+}
+
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
 {
     XiveSource *xsrc =3D opaque;
@@ -155,6 +257,101 @@ void kvmppc_xive_source_set_irq(void *opaque, int s=
rcno, int val)
 /*
  * sPAPR XIVE interrupt controller (KVM)
  */
+void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
+                                  uint32_t end_idx, XiveEND *end,
+                                  Error **errp)
+{
+    struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
+    uint64_t kvm_eq_idx;
+    uint8_t priority;
+    uint32_t server;
+    Error *local_err =3D NULL;
+
+    assert(xive_end_is_valid(end));
+
+    /* Encode the tuple (server, prio) as a KVM EQ index */
+    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
+
+    kvm_eq_idx =3D priority << KVM_XIVE_EQ_PRIORITY_SHIFT &
+            KVM_XIVE_EQ_PRIORITY_MASK;
+    kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
+        KVM_XIVE_EQ_SERVER_MASK;
+
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
+                      &kvm_eq, false, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /*
+     * The EQ index and toggle bit are updated by HW. These are the
+     * only fields from KVM we want to update QEMU with. The other END
+     * fields should already be in the QEMU END table.
+     */
+    end->w1 =3D xive_set_field32(END_W1_GENERATION, 0ul, kvm_eq.qtoggle)=
 |
+        xive_set_field32(END_W1_PAGE_OFF, 0ul, kvm_eq.qindex);
+}
+
+void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
+                                  uint32_t end_idx, XiveEND *end,
+                                  Error **errp)
+{
+    struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
+    uint64_t kvm_eq_idx;
+    uint8_t priority;
+    uint32_t server;
+    Error *local_err =3D NULL;
+
+    /*
+     * Build the KVM state from the local END structure.
+     */
+
+    kvm_eq.flags =3D 0;
+    if (xive_get_field32(END_W0_UCOND_NOTIFY, end->w0)) {
+        kvm_eq.flags |=3D KVM_XIVE_EQ_ALWAYS_NOTIFY;
+    }
+
+    /*
+     * If the hcall is disabling the EQ, set the size and page address
+     * to zero. When migrating, only valid ENDs are taken into
+     * account.
+     */
+    if (xive_end_is_valid(end)) {
+        kvm_eq.qshift =3D xive_get_field32(END_W0_QSIZE, end->w0) + 12;
+        kvm_eq.qaddr  =3D xive_end_qaddr(end);
+        /*
+         * The EQ toggle bit and index should only be relevant when
+         * restoring the EQ state
+         */
+        kvm_eq.qtoggle =3D xive_get_field32(END_W1_GENERATION, end->w1);
+        kvm_eq.qindex  =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
+    } else {
+        kvm_eq.qshift =3D 0;
+        kvm_eq.qaddr  =3D 0;
+    }
+
+    /* Encode the tuple (server, prio) as a KVM EQ index */
+    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
+
+    kvm_eq_idx =3D priority << KVM_XIVE_EQ_PRIORITY_SHIFT &
+            KVM_XIVE_EQ_PRIORITY_MASK;
+    kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
+        KVM_XIVE_EQ_SERVER_MASK;
+
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
+                      &kvm_eq, true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+void kvmppc_xive_reset(SpaprXive *xive, Error **errp)
+{
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL, KVM_DEV_XIVE_RESE=
T,
+                      NULL, true, errp);
+}
=20
 static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
                               Error **errp)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 0edcc762de..03685910e7 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -55,9 +55,24 @@ void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
 void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
 void spapr_xive_map_mmio(SpaprXive *xive);
=20
+int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
+                             uint32_t *out_server, uint8_t *out_prio);
+
 /*
  * KVM XIVE device helpers
  */
 void kvmppc_xive_connect(SpaprXive *xive, Error **errp);
+void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
+void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveE=
AS *eas,
+                                   Error **errp);
+void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **err=
p);
+uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset=
,
+                            uint64_t data, bool write);
+void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
+                                 uint32_t end_idx, XiveEND *end,
+                                 Error **errp);
+void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
+                                 uint32_t end_idx, XiveEND *end,
+                                 Error **errp);
=20
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.21.0


