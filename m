Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7FAC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F8022CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cisTeu91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F8022CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LBg-0000gW-3X
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0V-0004hj-Sf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0T-00089j-EI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:11 -0400
Received: from ozlabs.org ([203.11.71.1]:38131)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0S-00086j-NU; Wed, 21 Aug 2019 03:26:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjD2fBwz9sRG; Wed, 21 Aug 2019 17:25:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372352;
 bh=4T/RugTmxVtT8zm+dzl4xl8xrPpUGZdfYGoB7p6Qn5k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cisTeu91uUN7vgJCvXsFnF/zz9vlGXHA+LIInCy16KEtWYqgHSGZVADkOyH6keycu
 EqrXmcrXei1JwHXHF33yGLUywBh2FUx7x+WkfO5GwFXKCe8Jqtrn3dcNVABVfEhiSJ
 EY+AkqZ4P67+3nnjrsSnDdmeE6zfRMCoIQHsdGdI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:33 +1000
Message-Id: <20190821072542.23090-34-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 33/42] spapr/pci: Consolidate de-allocation of
 MSIs
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
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

When freeing MSIs, we need to:
- remove them from the machine's MSI bitmap
- remove them from the IC backend
- remove them from the PHB's MSI cache

This is currently open coded in two places in rtas_ibm_change_msi(),
and we're about to need this in spapr_phb_reset() as well. Instead of
duplicating this code again, make it a destroy function for the PHB's
MSI cache. Removing an MSI device from the cache will call the destroy
function internally.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156415227855.1064338.5657793835271464648.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 4c5420c465..6e6b4d0f60 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -338,10 +338,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
             return;
         }
=20
-        if (!smc->legacy_irq_allocation) {
-            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
-        }
-        spapr_irq_free(spapr, msi->first_irq, msi->num);
         if (msi_present(pdev)) {
             spapr_msi_setmsg(pdev, 0, false, 0, 0);
         }
@@ -411,10 +407,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
=20
     /* Release previous MSIs */
     if (msi) {
-        if (!smc->legacy_irq_allocation) {
-            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
-        }
-        spapr_irq_free(spapr, msi->first_irq, msi->num);
         g_hash_table_remove(phb->msi, &config_addr);
     }
=20
@@ -1808,6 +1800,19 @@ static void spapr_phb_unrealize(DeviceState *dev, =
Error **errp)
     memory_region_del_subregion(get_system_memory(), &sphb->mem32window)=
;
 }
=20
+static void spapr_phb_destroy_msi(gpointer opaque)
+{
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    spapr_pci_msi *msi =3D opaque;
+
+    if (!smc->legacy_irq_allocation) {
+        spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
+    }
+    spapr_irq_free(spapr, msi->first_irq, msi->num);
+    g_free(msi);
+}
+
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
@@ -2019,7 +2024,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
                                     spapr_tce_get_iommu(tcet));
     }
=20
-    sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_free,=
 g_free);
+    sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_free,
+                                      spapr_phb_destroy_msi);
     return;
=20
 unrealize:
--=20
2.21.0


