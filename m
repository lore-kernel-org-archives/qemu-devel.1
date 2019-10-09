Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B80C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1A620B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oAYFrAjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1A620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIElC-00046J-Qs
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59H-0001Y2-7E
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59E-0006Z9-8N
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:34 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59717 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI59C-0006Uh-Qj; Wed, 09 Oct 2019 02:08:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p3gD5Xq7z9sPw; Wed,  9 Oct 2019 17:08:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570601304;
 bh=XUPxcRcTe2kkMQz3PgmYd462tBPoK4iFHjEdYV6FO8s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oAYFrAjcRgaoJpkPMk/l2hzdCn/7PKSwStpGpUHvjYfPST1BN1Xd8FLFM+KJKFcJZ
 qaLR+pkCZHn9oHEPceW78MenqYhxfErHFyq+2ZDDlNOgc9+4/INI52IAYr7qdNgjVY
 +fIfDPmxwi4nS2zqwP0H5Nfcfw4tdEq/gg0HHGZE=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v4 07/19] spapr: Formalize notion of active interrupt
 controller
Date: Wed,  9 Oct 2019 17:08:06 +1100
Message-Id: <20191009060818.29719-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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

spapr now has the mechanism of constructing both XICS and XIVE instances =
of
the SpaprInterruptController interface.  However, only one of the interru=
pt
controllers will actually be active at any given time, depending on featu=
re
negotiation with the guest.  This is handled in the current code via
spapr_irq_current() which checks the OV5 vector from feature negotiation =
to
determine the current backend.

Determining the active controller at the point we need it like this
can be pretty confusing, because it makes it very non obvious at what
points the active controller can change.  This can make it difficult
to reason about the code and where a change of active controller could
appear in sequence with other events.

Make this mechanism more explicit by adding an 'active_intc' pointer
and an explicit spapr_irq_update_active_intc() function to update it
from the CAS state.  We also add hooks on the intc backend which will
get called when it is activated or deactivated.

For now we just introduce the switch and hooks, later patches will
actually start using them.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_irq.c         | 51 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h     |  5 ++--
 include/hw/ppc/spapr_irq.h |  5 ++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 83882cfad3..249a2688ac 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -586,6 +586,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq=
)
=20
 int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
 {
+    spapr_irq_update_active_intc(spapr);
     return spapr->irq->post_load(spapr, version_id);
 }
=20
@@ -593,6 +594,8 @@ void spapr_irq_reset(SpaprMachineState *spapr, Error =
**errp)
 {
     assert(!spapr->irq_map || bitmap_empty(spapr->irq_map, spapr->irq_ma=
p_nr));
=20
+    spapr_irq_update_active_intc(spapr);
+
     if (spapr->irq->reset) {
         spapr->irq->reset(spapr, errp);
     }
@@ -619,6 +622,54 @@ int spapr_irq_get_phandle(SpaprMachineState *spapr, =
void *fdt, Error **errp)
     return phandle;
 }
=20
+static void set_active_intc(SpaprMachineState *spapr,
+                            SpaprInterruptController *new_intc)
+{
+    SpaprInterruptControllerClass *sicc;
+
+    assert(new_intc);
+
+    if (new_intc =3D=3D spapr->active_intc) {
+        /* Nothing to do */
+        return;
+    }
+
+    if (spapr->active_intc) {
+        sicc =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
+        if (sicc->deactivate) {
+            sicc->deactivate(spapr->active_intc);
+        }
+    }
+
+    sicc =3D SPAPR_INTC_GET_CLASS(new_intc);
+    if (sicc->activate) {
+        sicc->activate(new_intc, &error_fatal);
+    }
+
+    spapr->active_intc =3D new_intc;
+}
+
+void spapr_irq_update_active_intc(SpaprMachineState *spapr)
+{
+    SpaprInterruptController *new_intc;
+
+    if (!spapr->ics) {
+        /*
+         * XXX before we run CAS, ov5_cas is initialized empty, which
+         * indicates XICS, even if we have ic-mode=3Dxive.  TODO: clean
+         * up the CAS path so that we have a clearer way of handling
+         * this.
+         */
+        new_intc =3D SPAPR_INTC(spapr->xive);
+    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        new_intc =3D SPAPR_INTC(spapr->xive);
+    } else {
+        new_intc =3D SPAPR_INTC(spapr->ics);
+    }
+
+    set_active_intc(spapr, new_intc);
+}
+
 /*
  * XICS legacy routines - to deprecate one day
  */
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index cbd1a4c9f3..763da757f0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,7 +143,6 @@ struct SpaprMachineState {
     struct SpaprVioBus *vio_bus;
     QLIST_HEAD(, SpaprPhbState) phbs;
     struct SpaprNvram *nvram;
-    ICSState *ics;
     SpaprRtcState rtc;
=20
     SpaprResizeHpt resize_hpt;
@@ -195,9 +194,11 @@ struct SpaprMachineState {
=20
     int32_t irq_map_nr;
     unsigned long *irq_map;
-    SpaprXive  *xive;
     SpaprIrq *irq;
     qemu_irq *qirqs;
+    SpaprInterruptController *active_intc;
+    ICSState *ics;
+    SpaprXive *xive;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     SpaprCapabilities def, eff, mig;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index adfef0fcbe..593059eff5 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -44,6 +44,9 @@ typedef struct SpaprInterruptController SpaprInterruptC=
ontroller;
 typedef struct SpaprInterruptControllerClass {
     InterfaceClass parent;
=20
+    int (*activate)(SpaprInterruptController *intc, Error **errp);
+    void (*deactivate)(SpaprInterruptController *intc);
+
     /*
      * These methods will typically be called on all intcs, active and
      * inactive
@@ -55,6 +58,8 @@ typedef struct SpaprInterruptControllerClass {
     void (*free_irq)(SpaprInterruptController *intc, int irq);
 } SpaprInterruptControllerClass;
=20
+void spapr_irq_update_active_intc(SpaprMachineState *spapr);
+
 int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
=20
--=20
2.21.0


