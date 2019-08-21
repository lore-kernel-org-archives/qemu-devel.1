Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A96CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CB722D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PVlliHW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CB722D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LaS-0008Em-Ng
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0q-0005Bb-2B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0o-0008Ri-6n
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:31 -0400
Received: from ozlabs.org ([203.11.71.1]:41709)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0m-00086k-NU; Wed, 21 Aug 2019 03:26:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjD4w7Dz9sR3; Wed, 21 Aug 2019 17:25:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372352;
 bh=c+EmIbgga9qhHKchaVJfp3Gud/L+/Rf9uswnPZgRVJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PVlliHW65k94TdXB0EF/obHFSaqP21jdpnA3IknQifzlTzVnrLc09o5D43wVxzozF
 OL3bggLPfZJ+ucqNRY69dgApRPLHnut/0jj9SizewS6eQKUuHPjSbfEtkf0laUVse/
 tQT2+OAp/Vf+UN0uLnxJIYtXzdA9wRXsv/Vru+U8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:35 +1000
Message-Id: <20190821072542.23090-36-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 35/42] spapr/irq: Drop spapr_irq_msi_reset()
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

PHBs already take care of clearing the MSIs from the bitmap during reset
or unplug. No need to do this globally from the machine code. Rather add
an assert to ensure that PHBs have acted as expected.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156415228966.1064338.190189424190233355.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
[dwg: Fix crash in qtest case where spapr->irq_map can be NULL at the
 new assert()]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             | 4 ----
 hw/ppc/spapr_irq.c         | 7 ++-----
 include/hw/ppc/spapr_irq.h | 1 -
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 51e1cb0d46..64fc2255cc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1755,10 +1755,6 @@ static void spapr_machine_reset(MachineState *mach=
ine)
         ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fata=
l);
     }
=20
-    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        spapr_irq_msi_reset(spapr);
-    }
-
     /*
      * This is fixing some of the default configuration of the XIVE
      * devices. To be called after the reset of the machine devices.
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 2f87fe08f3..06fe2432ba 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -59,11 +59,6 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int =
irq, uint32_t num)
     bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
 }
=20
-void spapr_irq_msi_reset(SpaprMachineState *spapr)
-{
-    bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
-}
-
 static void spapr_irq_init_kvm(SpaprMachineState *spapr,
                                   SpaprIrq *irq, Error **errp)
 {
@@ -731,6 +726,8 @@ int spapr_irq_post_load(SpaprMachineState *spapr, int=
 version_id)
=20
 void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
 {
+    assert(!spapr->irq_map || bitmap_empty(spapr->irq_map, spapr->irq_ma=
p_nr));
+
     if (spapr->irq->reset) {
         spapr->irq->reset(spapr, errp);
     }
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 8132e00366..5db305165c 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -30,7 +30,6 @@ void spapr_irq_msi_init(SpaprMachineState *spapr, uint3=
2_t nr_msis);
 int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool ali=
gn,
                         Error **errp);
 void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)=
;
-void spapr_irq_msi_reset(SpaprMachineState *spapr);
=20
 typedef struct SpaprIrq {
     uint32_t    nr_irqs;
--=20
2.21.0


