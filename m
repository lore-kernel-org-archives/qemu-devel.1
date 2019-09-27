Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3FBC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D412054F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Wb8MR9PX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D412054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjcf-0002sC-7r
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9W-0006sB-Li
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9T-000541-9g
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:50 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54719)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9S-000511-LJ; Fri, 27 Sep 2019 01:50:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrF4Jppz9sRC; Fri, 27 Sep 2019 15:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563437;
 bh=KifldnMf+iU4qAAl4SsphkPZHyxo9Nnm8xbbr1lvEjo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wb8MR9PXkQWy4H9xlCLKy3p43lpEWevxubyguyUtx2Esdg3LPSPEt5uk5thFPkllN
 g5EgeD5qp1PEUB3TI9+ErnSm1ZF04xe/TVcIk3o0oQO52riixJIwogG7RsXQKbdhXV
 +gxoMimC9UYNm/UoIVm7NDyQ526Z5GRfDzPc0qK0=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 17/33] xive: Improve irq claim/free path
Date: Fri, 27 Sep 2019 15:50:12 +1000
Message-Id: <20190927055028.11493-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

spapr_xive_irq_claim() returns a bool to indicate if it succeeded.
But most of the callers and one callee use int return values and/or an
Error * with more information instead.  In any case, ints are a more
common idiom for success/failure states than bools (one never knows
what sense they'll be in).

So instead change to an int return value to indicate presence of error
+ an Error * to describe the details through that call chain.

It also didn't actually check if the irq was already claimed, which is
one of the primary purposes of the claim path, so do that.

spapr_xive_irq_free() also returned a bool... which no callers checked
and was always true, so just drop it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 20 +++++++++-----------
 hw/intc/spapr_xive_kvm.c    |  8 ++++----
 hw/ppc/spapr_irq.c          | 14 ++++++++------
 include/hw/ppc/spapr_xive.h |  4 ++--
 include/hw/ppc/xive.h       |  2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 47b5ec0b56..04879abf2e 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -528,12 +528,17 @@ static void spapr_xive_register_types(void)
=20
 type_init(spapr_xive_register_types)
=20
-bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi)
+int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **er=
rp)
 {
     XiveSource *xsrc =3D &xive->source;
=20
     assert(lisn < xive->nr_irqs);
=20
+    if (xive_eas_is_valid(&xive->eat[lisn])) {
+        error_setg(errp, "IRQ %d is not free", lisn);
+        return -EBUSY;
+    }
+
     /*
      * Set default values when allocating an IRQ number
      */
@@ -543,24 +548,17 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t=
 lisn, bool lsi)
     }
=20
     if (kvm_irqchip_in_kernel()) {
-        Error *local_err =3D NULL;
-
-        kvmppc_xive_source_reset_one(xsrc, lisn, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return false;
-        }
+        return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
     }
=20
-    return true;
+    return 0;
 }
=20
-bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
+void spapr_xive_irq_free(SpaprXive *xive, int lisn)
 {
     assert(lisn < xive->nr_irqs);
=20
     xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
-    return true;
 }
=20
 /*
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 2006f96aec..51b334b676 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -232,14 +232,14 @@ void kvmppc_xive_sync_source(SpaprXive *xive, uint3=
2_t lisn, Error **errp)
  * only need to inform the KVM XIVE device about their type: LSI or
  * MSI.
  */
-void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **e=
rrp)
+int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **er=
rp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
     uint64_t state =3D 0;
=20
     /* The KVM XIVE device is not in use */
     if (xive->fd =3D=3D -1) {
-        return;
+        return -ENODEV;
     }
=20
     if (xive_source_irq_is_lsi(xsrc, srcno)) {
@@ -249,8 +249,8 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc, i=
nt srcno, Error **errp)
         }
     }
=20
-    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, srcno, &state,
-                      true, errp);
+    return kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, srcno, &=
state,
+                             true, errp);
 }
=20
 static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index da9e80b24e..4951329959 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -246,7 +246,13 @@ static void spapr_irq_init_xive(SpaprMachineState *s=
papr, Error **errp)
=20
     /* Enable the CPU IPIs */
     for (i =3D 0; i < nr_servers; ++i) {
-        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false);
+        Error *local_err =3D NULL;
+
+        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, &loc=
al_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
=20
     spapr_xive_hcall_init(spapr);
@@ -255,11 +261,7 @@ static void spapr_irq_init_xive(SpaprMachineState *s=
papr, Error **errp)
 static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool =
lsi,
                                 Error **errp)
 {
-    if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
-        error_setg(errp, "IRQ %d is invalid", irq);
-        return -1;
-    }
-    return 0;
+    return spapr_xive_irq_claim(spapr->xive, irq, lsi, errp);
 }
=20
 static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index bfd40f01d8..0df20a6590 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -54,8 +54,8 @@ typedef struct SpaprXive {
  */
 #define SPAPR_XIVE_BLOCK_ID 0x0
=20
-bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi);
-bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn);
+int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **er=
rp);
+void spapr_xive_irq_free(SpaprXive *xive, int lisn);
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
 int spapr_xive_post_load(SpaprXive *xive, int version_id);
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 6d38755f84..fd3319bd32 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -425,7 +425,7 @@ static inline uint32_t xive_nvt_cam_line(uint8_t nvt_=
blk, uint32_t nvt_idx)
  * KVM XIVE device helpers
  */
=20
-void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **e=
rrp);
+int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **er=
rp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
--=20
2.21.0


