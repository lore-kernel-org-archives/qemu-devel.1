Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA46FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D0F20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YOp14rL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D0F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYuK-0004jg-Qk
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKw-0005ei-EP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKu-00062t-96
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:19:14 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47887 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKs-0005Ih-Fc; Thu, 24 Oct 2019 04:19:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrc2Mh1z9sSJ; Thu, 24 Oct 2019 19:18:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905120;
 bh=tzJ+7MOt2gZTDZOt/gkdmDHnADHessDKG06YzqJyGLQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YOp14rL+X7uTApnva66vvaTZ2/UKFKvzBAIste07UkMbyoTiM8YCi10ldkncFlYe0
 FguJNFIJUC7/2H6fYNWertG7zvXqFF0qe2FqY4abt/eDlbjz5cMf5O6sKCsGIHGkF6
 t+b1r2CBpuA8uvjKEoEKlGA6gIbGIzO4iWv0Zy9A=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 25/28] ppc/pnv: Add a PnvChip pointer to PnvCore
Date: Thu, 24 Oct 2019 19:18:10 +1100
Message-Id: <20191024081813.2115-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

We will use it to reset the interrupt presenter from the CPU reset
handler.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20191022163812.330-5-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c         | 3 ++-
 include/hw/ppc/pnv_core.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 9f981a4940..cc17bbfed8 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -222,6 +222,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
                                 "required link 'chip' not found: ");
         return;
     }
+    pc->chip =3D PNV_CHIP(chip);
=20
     pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
@@ -243,7 +244,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     }
=20
     for (j =3D 0; j < cc->nr_threads; j++) {
-        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err);
+        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
         if (local_err) {
             goto err;
         }
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index bfbd2ec42a..55eee95104 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -31,6 +31,8 @@
 #define PNV_CORE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
=20
+typedef struct PnvChip PnvChip;
+
 typedef struct PnvCore {
     /*< private >*/
     CPUCore parent_obj;
@@ -38,6 +40,7 @@ typedef struct PnvCore {
     /*< public >*/
     PowerPCCPU **threads;
     uint32_t pir;
+    PnvChip *chip;
=20
     MemoryRegion xscom_regs;
 } PnvCore;
--=20
2.21.0


