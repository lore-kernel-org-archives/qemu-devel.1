Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35820C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15D1207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="V5WwOPuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15D1207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGK8P-0003Ai-1N
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2H-0004sV-PJ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2F-00053o-Ey
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:05 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34791)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2F-0004zt-0t; Fri, 04 Oct 2019 05:38:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YG4K3fz9sR6; Fri,  4 Oct 2019 19:37:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181874;
 bh=OirAMtv4UlayQDyT8sYysuEo+ORX8REYSURSmh6PVJc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V5WwOPuUGpdl8AhRKkhv+Zml06KPhXgAOURjvyyGmVBU25BVJUdwFGWXYpl9KKAXB
 ukH0zhtqMJ5AIiTbG+gu74H0KOIdI3xr+o11uuOzwOu/ujgXDap4S0lPgnjmhVUO4T
 4v82yA29XZScvIGLATC1aok85sPu6SfLXdl2Lmz4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 10/53] spapr/irq: Only claim VALID interrupts at the KVM level
Date: Fri,  4 Oct 2019 19:37:04 +1000
Message-Id: <20191004093747.31350-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

A typical pseries VM with 16 vCPUs, one disk, one network adapater
uses less than 100 interrupts but the whole IRQ number space of the
QEMU machine is allocated at reset time and it is 8K wide. This is
wasting a considerable amount of interrupt numbers in the global IRQ
space which has 1M interrupts per socket on a POWER9.

To optimise the HW resources, only request at the KVM level interrupts
which have been claimed by the guest. This will help to increase the
maximum number of VMs per system and also help supporting nested guests
using the XIVE interrupt mode.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190911133937.2716-3-clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156942766014.1274533.10792048853177121231.stgit@bahia.lan>
[dwg: Folded in fix up from Greg Kurz]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 40 +++++++++++++++++++++++++++++++++++++---
 hw/intc/xics_kvm.c       |  8 ++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 17af4d19f5..2006f96aec 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -255,11 +255,16 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc,=
 int srcno, Error **errp)
=20
 static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
 {
+    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
     int i;
=20
     for (i =3D 0; i < xsrc->nr_irqs; i++) {
         Error *local_err =3D NULL;
=20
+        if (!xive_eas_is_valid(&xive->eat[i])) {
+            continue;
+        }
+
         kvmppc_xive_source_reset_one(xsrc, i, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -328,11 +333,18 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int s=
rcno, uint32_t offset,
=20
 static void kvmppc_xive_source_get_state(XiveSource *xsrc)
 {
+    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
     int i;
=20
     for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq;
+
+        if (!xive_eas_is_valid(&xive->eat[i])) {
+            continue;
+        }
+
         /* Perform a load without side effect to retrieve the PQ bits */
-        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
+        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
=20
         /* and save PQ locally */
         xive_source_esb_set(xsrc, i, pq);
@@ -521,9 +533,14 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
      */
     if (running) {
         for (i =3D 0; i < xsrc->nr_irqs; i++) {
-            uint8_t pq =3D xive_source_esb_get(xsrc, i);
+            uint8_t pq;
             uint8_t old_pq;
=20
+            if (!xive_eas_is_valid(&xive->eat[i])) {
+                continue;
+            }
+
+            pq =3D xive_source_esb_get(xsrc, i);
             old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq <=
< 8));
=20
             /*
@@ -545,7 +562,13 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
      * migration is in progress.
      */
     for (i =3D 0; i < xsrc->nr_irqs; i++) {
-        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
+        uint8_t pq;
+
+        if (!xive_eas_is_valid(&xive->eat[i])) {
+            continue;
+        }
+
+        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
=20
         /*
          * PQ is set to PENDING to possibly catch a triggered
@@ -655,6 +678,17 @@ int kvmppc_xive_post_load(SpaprXive *xive, int versi=
on_id)
             continue;
         }
=20
+        /*
+         * We can only restore the source config if the source has been
+         * previously set in KVM. Since we don't do that for all interru=
pts
+         * at reset time anymore, let's do it now.
+         */
+        kvmppc_xive_source_reset_one(&xive->source, i, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+
         kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_err=
);
         if (local_err) {
             error_report_err(local_err);
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index a4d2e876cc..ba90d6dc96 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -190,6 +190,10 @@ void ics_get_kvm_state(ICSState *ics)
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
=20
+        if (ics_irq_free(ics, i)) {
+            continue;
+        }
+
         kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
                           i + ics->offset, &state, false, &error_fatal);
=20
@@ -301,6 +305,10 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
         Error *local_err =3D NULL;
         int ret;
=20
+        if (ics_irq_free(ics, i)) {
+            continue;
+        }
+
         ret =3D ics_set_kvm_state_one(ics, i, &local_err);
         if (ret < 0) {
             error_propagate(errp, local_err);
--=20
2.21.0


