Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206D4C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9D520863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bIVDwz5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9D520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjTb-0003Ly-F3
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9V-0006qC-BR
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9T-00053Z-2x
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:49 -0400
Received: from ozlabs.org ([203.11.71.1]:56149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9S-00050y-JF; Fri, 27 Sep 2019 01:50:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrF5KM8z9sRM; Fri, 27 Sep 2019 15:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563437;
 bh=ee/8yKrlNbFwZNPVHGyE6SXgmXBlNjtSwzic6mqlvAE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bIVDwz5AhMrtUqEQn8mvo/p4rkvc4AW2WAV2NerHYfXbPIULF4hhBVFkhj9qc0kIb
 mOVY/rH7diCl54pxCZB1v266WTCwr5IxbpvSw6jS7JnPezXZNtAqUEabx6VXaU6ZGT
 7TCF/6koi00/UZtxQcWTmy/+PVDJ38aNdbXZ8Y9s=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 18/33] spapr: Use less cryptic representation of which irq
 backends are supported
Date: Fri, 27 Sep 2019 15:50:13 +1000
Message-Id: <20190927055028.11493-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
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

SpaprIrq::ov5 stores the value for a particular byte in PAPR option vecto=
r
5 which indicates whether XICS, XIVE or both interrupt controllers are
available.  As usual for PAPR, the encoding is kind of overly complicated
and confusing (though to be fair there are some backwards compat things i=
t
has to handle).

But to make our internal code clearer, have SpaprIrq encode more directly
which backends are available as two booleans, and derive the OV5 value fr=
om
that at the point we need it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c             | 15 ++++++++++++---
 hw/ppc/spapr_hcall.c       |  6 +++---
 hw/ppc/spapr_irq.c         | 12 ++++++++----
 include/hw/ppc/spapr_irq.h |  3 ++-
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3742a8cf06..795f6ab505 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1136,19 +1136,28 @@ static void spapr_dt_ov5_platform_support(SpaprMa=
chineState *spapr, void *fdt,
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
=20
     char val[2 * 4] =3D {
-        23, spapr->irq->ov5, /* Xive mode. */
+        23, 0x00, /* XICS / XIVE mode */
         24, 0x00, /* Hash/Radix, filled in below. */
         25, 0x00, /* Hash options: Segment Tables =3D=3D no, GTSE =3D=3D=
 no. */
         26, 0x40, /* Radix options: GTSE =3D=3D yes. */
     };
=20
+    if (spapr->irq->xics && spapr->irq->xive) {
+        val[1] =3D SPAPR_OV5_XIVE_BOTH;
+    } else if (spapr->irq->xive) {
+        val[1] =3D SPAPR_OV5_XIVE_EXPLOIT;
+    } else {
+        assert(spapr->irq->xics);
+        val[1] =3D SPAPR_OV5_XIVE_LEGACY;
+    }
+
     if (!ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
                           first_ppc_cpu->compat_pvr)) {
         /*
          * If we're in a pre POWER9 compat mode then the guest should
          * do hash and use the legacy interrupt mode
          */
-        val[1] =3D 0x00; /* XICS */
+        val[1] =3D SPAPR_OV5_XIVE_LEGACY; /* XICS */
         val[3] =3D 0x00; /* Hash */
     } else if (kvm_enabled()) {
         if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) =
{
@@ -2837,7 +2846,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
=20
     /* advertise XIVE on POWER9 machines */
-    if (spapr->irq->ov5 & (SPAPR_OV5_XIVE_EXPLOIT | SPAPR_OV5_XIVE_BOTH)=
) {
+    if (spapr->irq->xive) {
         spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
     }
=20
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 3d3a67149a..140f05c1c6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1784,13 +1784,13 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
      * terminate the boot.
      */
     if (guest_xive) {
-        if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_LEGACY) {
+        if (!spapr->irq->xive) {
             error_report(
 "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=3Dxi=
ve or ic-mode=3Ddual machine property");
             exit(EXIT_FAILURE);
         }
     } else {
-        if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
+        if (!spapr->irq->xics) {
             error_report(
 "Guest requested unavailable interrupt mode (XICS), either don't set the=
 ic-mode machine property or try ic-mode=3Dxics or ic-mode=3Ddual");
             exit(EXIT_FAILURE);
@@ -1804,7 +1804,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
      */
     if (!spapr->cas_reboot) {
         spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT)
-            && spapr->irq->ov5 & SPAPR_OV5_XIVE_BOTH;
+            && spapr->irq->xics && spapr->irq->xive;
     }
=20
     spapr_ovec_cleanup(ov5_updates);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 4951329959..0aec5b0f0e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -210,7 +210,8 @@ static void spapr_irq_init_kvm_xics(SpaprMachineState=
 *spapr, Error **errp)
 SpaprIrq spapr_irq_xics =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .nr_msis     =3D SPAPR_NR_MSIS,
-    .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
+    .xics        =3D true,
+    .xive        =3D false,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
@@ -353,7 +354,8 @@ static void spapr_irq_init_kvm_xive(SpaprMachineState=
 *spapr, Error **errp)
 SpaprIrq spapr_irq_xive =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .nr_msis     =3D SPAPR_NR_MSIS,
-    .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
+    .xics        =3D false,
+    .xive        =3D true,
=20
     .init        =3D spapr_irq_init_xive,
     .claim       =3D spapr_irq_claim_xive,
@@ -514,7 +516,8 @@ static void spapr_irq_set_irq_dual(void *opaque, int =
irq, int val)
 SpaprIrq spapr_irq_dual =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .nr_msis     =3D SPAPR_NR_MSIS,
-    .ov5         =3D SPAPR_OV5_XIVE_BOTH,
+    .xics        =3D true,
+    .xive        =3D true,
=20
     .init        =3D spapr_irq_init_dual,
     .claim       =3D spapr_irq_claim_dual,
@@ -757,7 +760,8 @@ int spapr_irq_find(SpaprMachineState *spapr, int num,=
 bool align, Error **errp)
 SpaprIrq spapr_irq_xics_legacy =3D {
     .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
     .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
-    .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
+    .xics        =3D true,
+    .xive        =3D false,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ed88b4599a..d3f3b85eb9 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -39,7 +39,8 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int i=
rq, uint32_t num);
 typedef struct SpaprIrq {
     uint32_t    nr_xirqs;
     uint32_t    nr_msis;
-    uint8_t     ov5;
+    bool        xics;
+    bool        xive;
=20
     void (*init)(SpaprMachineState *spapr, Error **errp);
     int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
--=20
2.21.0


