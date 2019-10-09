Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304B6C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F364821848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ciTqY4tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F364821848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFBI-0006j7-Is
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59H-0001Y3-7o
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59E-0006Zo-Gk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41177 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI59C-0006Ur-V0; Wed, 09 Oct 2019 02:08:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p3gF0llQz9sR3; Wed,  9 Oct 2019 17:08:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570601305;
 bh=14lr9JEGz77/t8EG1ZaezP7gMjFaSymG2CgVirQ0kyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ciTqY4tGEu4CTAWRkuQI9NWB5o/pVMUPlvz/S+Y9gmgrcg8cSjAHbyfuAoCmTvZoN
 jejeN0Ks6iQ7ausXDxloH3kzTcaUHtaes52ZbKnsPspSbh+Ya/y2XWJn58XFAnFats
 OckVhiGQFGJx5Wj0R0vZNEbJRbNHtdpqyCsWeHXk=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v4 11/19] spapr, xics,
 xive: Match signatures for XICS and XIVE KVM connect routines
Date: Wed,  9 Oct 2019 17:08:10 +1100
Message-Id: <20191009060818.29719-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both XICS and XIVE have routines to connect and disconnect KVM with
similar but not identical signatures.  This adjusts them to match
exactly, which will be useful for further cleanups later.

While we're there, we add an explicit return value to the connect path
to streamline error reporting in the callers.  We remove error
reporting the disconnect path.  In the XICS case this wasn't used at
all.  In the XIVE case the only error case was if the KVM device was
set up, but KVM didn't have the capability to do so which is pretty
obviously impossible.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c    | 22 ++++++++++------------
 hw/intc/xics_kvm.c          |  9 +++++----
 hw/ppc/spapr_irq.c          | 22 +++++-----------------
 include/hw/ppc/spapr_xive.h |  4 ++--
 include/hw/ppc/xics_spapr.h |  4 ++--
 5 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 51b334b676..08012ac7cd 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -740,8 +740,9 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int pg=
off, size_t len,
  * All the XIVE memory regions are now backed by mappings from the KVM
  * XIVE device.
  */
-void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
+int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp)
 {
+    SpaprXive *xive =3D SPAPR_XIVE(intc);
     XiveSource *xsrc =3D &xive->source;
     Error *local_err =3D NULL;
     size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
@@ -753,19 +754,19 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **e=
rrp)
      * rebooting under the XIVE-only interrupt mode.
      */
     if (xive->fd !=3D -1) {
-        return;
+        return 0;
     }
=20
     if (!kvmppc_has_cap_xive()) {
         error_setg(errp, "IRQ_XIVE capability must be present for KVM");
-        return;
+        return -1;
     }
=20
     /* First, create the KVM XIVE device */
     xive->fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
     if (xive->fd < 0) {
         error_setg_errno(errp, -xive->fd, "XIVE: error creating KVM devi=
ce");
-        return;
+        return -1;
     }
=20
     /*
@@ -821,15 +822,17 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **e=
rrp)
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
-    return;
+    return 0;
=20
 fail:
     error_propagate(errp, local_err);
-    kvmppc_xive_disconnect(xive, NULL);
+    kvmppc_xive_disconnect(intc);
+    return -1;
 }
=20
-void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
+void kvmppc_xive_disconnect(SpaprInterruptController *intc)
 {
+    SpaprXive *xive =3D SPAPR_XIVE(intc);
     XiveSource *xsrc;
     size_t esb_len;
=20
@@ -838,11 +841,6 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error *=
*errp)
         return;
     }
=20
-    if (!kvmppc_has_cap_xive()) {
-        error_setg(errp, "IRQ_XIVE capability must be present for KVM");
-        return;
-    }
-
     /* Clear the KVM mapping */
     xsrc =3D &xive->source;
     esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index ba90d6dc96..954c424b36 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -342,8 +342,9 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int va=
l)
     }
 }
=20
-int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
+int xics_kvm_connect(SpaprInterruptController *intc, Error **errp)
 {
+    ICSState *ics =3D ICS_SPAPR(intc);
     int rc;
     CPUState *cs;
     Error *local_err =3D NULL;
@@ -413,7 +414,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error =
**errp)
     }
=20
     /* Update the KVM sources */
-    ics_set_kvm_state(spapr->ics, &local_err);
+    ics_set_kvm_state(ics, &local_err);
     if (local_err) {
         goto fail;
     }
@@ -431,11 +432,11 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
=20
 fail:
     error_propagate(errp, local_err);
-    xics_kvm_disconnect(spapr, NULL);
+    xics_kvm_disconnect(intc);
     return -1;
 }
=20
-void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
+void xics_kvm_disconnect(SpaprInterruptController *intc)
 {
     /*
      * Only on P9 using the XICS-on XIVE KVM device:
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a8005072e6..5c8ffb27da 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -124,7 +124,7 @@ static void spapr_irq_reset_xics(SpaprMachineState *s=
papr, Error **errp)
 static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
-        xics_kvm_connect(spapr, errp);
+        xics_kvm_connect(SPAPR_INTC(spapr->ics), errp);
     }
 }
=20
@@ -173,7 +173,7 @@ static void spapr_irq_reset_xive(SpaprMachineState *s=
papr, Error **errp)
 static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
-        kvmppc_xive_connect(spapr->xive, errp);
+        kvmppc_xive_connect(SPAPR_INTC(spapr->xive), errp);
     }
 }
=20
@@ -215,7 +215,7 @@ static int spapr_irq_post_load_dual(SpaprMachineState=
 *spapr, int version_id)
      */
     if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
         if (kvm_irqchip_in_kernel()) {
-            xics_kvm_disconnect(spapr, &error_fatal);
+            xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
         }
         spapr_irq_xive.reset(spapr, &error_fatal);
     }
@@ -225,8 +225,6 @@ static int spapr_irq_post_load_dual(SpaprMachineState=
 *spapr, int version_id)
=20
 static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
 {
-    Error *local_err =3D NULL;
-
     /*
      * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
      * if selected.
@@ -235,18 +233,8 @@ static void spapr_irq_reset_dual(SpaprMachineState *=
spapr, Error **errp)
=20
     /* Destroy all KVM devices */
     if (kvm_irqchip_in_kernel()) {
-        xics_kvm_disconnect(spapr, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            error_prepend(errp, "KVM XICS disconnect failed: ");
-            return;
-        }
-        kvmppc_xive_disconnect(spapr->xive, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            error_prepend(errp, "KVM XIVE disconnect failed: ");
-            return;
-        }
+        xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
+        kvmppc_xive_disconnect(SPAPR_INTC(spapr->xive));
     }
=20
     spapr_irq_current(spapr)->reset(spapr, errp);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index ebe156eb30..64972754f9 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -68,8 +68,8 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t =
end_idx,
 /*
  * KVM XIVE device helpers
  */
-void kvmppc_xive_connect(SpaprXive *xive, Error **errp);
-void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp);
+int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp);
+void kvmppc_xive_disconnect(SpaprInterruptController *intc);
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
 void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveE=
AS *eas,
                                    Error **errp);
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 8e4fb6adce..28b87038c8 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -32,8 +32,8 @@
 #define TYPE_ICS_SPAPR "ics-spapr"
 #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
=20
-int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
-void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
+int xics_kvm_connect(SpaprInterruptController *intc, Error **errp);
+void xics_kvm_disconnect(SpaprInterruptController *intc);
 bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
=20
 #endif /* XICS_SPAPR_H */
--=20
2.21.0


