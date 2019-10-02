Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6412C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763AA2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j5i90ZHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763AA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFUnq-0004Hf-2N
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkj-0001aW-BR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkh-0002oG-RI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:33 -0400
Received: from ozlabs.org ([203.11.71.1]:36381)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFUkh-0002mU-C5; Tue, 01 Oct 2019 22:52:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jgf72BZ5z9sQw; Wed,  2 Oct 2019 12:52:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569984735;
 bh=94tk8hMC8mG/3jJCPrWVw2Ex0NCpGjmPmqMYz3vP9bY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j5i90ZHmghtgDE0pjJwOXCaTLgf1BvrTuMdEWKI80DPVVwd1t3gF7tNpJ9OEhkACA
 sJ44R9bvVbucweyPxzCFs4qWQGroTtf7nLQTSbFsVLgMxVkn6pRkyyuD6YzZgjMw3f
 eTG2hl3La9sdYjFec7SA4uYffJIESDNMXGf/K9BY=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 07/34] spapr: Fold spapr_phb_lsi_qirq() into its single
 caller
Date: Wed,  2 Oct 2019 12:51:41 +1000
Message-Id: <20191002025208.3487-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002025208.3487-1-david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
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
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No point having a two-line helper that's used exactly once, and not likel=
y
to be used anywhere else in future.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr_pci.c          | 3 ++-
 include/hw/pci-host/spapr.h | 7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c1c9634755..01ff41d4c4 100644
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


