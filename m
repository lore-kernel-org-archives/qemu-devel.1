Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF2C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A909D217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aiqtfJUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A909D217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD18D-0002KH-M7
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13k-0008Hv-7y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13i-0003V5-Mu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:56 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD13i-0003SQ-7e; Wed, 25 Sep 2019 02:45:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dT8n4yV2z9sPf; Wed, 25 Sep 2019 16:45:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569393945;
 bh=FXv4yeGIF2b8djYs7hDdY6FUu4HojCrn6XMfRuQihUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aiqtfJUqafubqf65iUVUu7Lg9geT1dGRTMRIqPJYY1azQV/kauefQOUEbf5wa1Das
 Ro4JtS8rii99NT60IZ2qUflJHf48OxKi3OzMb8zrJRwvDRgCClXCKFMRimlc2W6AGd
 JiZDRk+J+AcaZiGsX0rdzfwOppucJJrqOn8rwQEQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/20] spapr: Fold spapr_phb_lsi_qirq() into its single caller
Date: Wed, 25 Sep 2019 16:45:21 +1000
Message-Id: <20190925064534.19155-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925064534.19155-1-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No point having a two-line helper that's used exactly once, and not likel=
y
to be used anywhere else in future.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c          | 3 ++-
 include/hw/pci-host/spapr.h | 7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7b71ad7c74..6934d506a7 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -721,9 +721,10 @@ static void pci_spapr_set_irq(void *opaque, int irq_=
num, int level)
      * corresponding qemu_irq.
      */
     SpaprPhbState *phb =3D opaque;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
     trace_spapr_pci_lsi_set(phb->dtbusname, irq_num, phb->lsi_table[irq_=
num].irq);
-    qemu_set_irq(spapr_phb_lsi_qirq(phb, irq_num), level);
+    qemu_set_irq(spapr_qirq(spapr, phb->lsi_table[irq_num].irq), level);
 }
=20
 static PCIINTxRoute spapr_route_intx_pin_to_irq(void *opaque, int pin)
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index abd87605b2..23506f05d9 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -128,13 +128,6 @@ struct SpaprPhbState {
 #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * =
\
                                       64 * KiB)
=20
-static inline qemu_irq spapr_phb_lsi_qirq(struct SpaprPhbState *phb, int=
 pin)
-{
-    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
-
-    return spapr_qirq(spapr, phb->lsi_table[pin].irq);
-}
-
 int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
                  uint32_t nr_msis, int *node_offset);
=20
--=20
2.21.0


