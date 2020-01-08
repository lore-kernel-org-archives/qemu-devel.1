Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6537C33C9B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FFE20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="npF+cXpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FFE20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3se-0001ZI-Ac
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oa-0003r3-8m
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oY-0002gx-QE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:32 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56133 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oY-0002de-Ez; Wed, 08 Jan 2020 00:23:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMC1LTHz9sST; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460999;
 bh=xuXCUv7AbtgO81cRSWzQUqJbuB77DWavVOto6WrS4/U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=npF+cXpbIbKNA8MYsN+2VjGfTfBrrPfWIwpum8DVkMiSVAn8FwLAD8ri63kiYB1Oy
 dFLxwgisNzTyctVh4sc/SORXPRx+n3Apzn0evJMQR1IBXbITaEDPzaYaHvsRuJkcAi
 QCci/T0J2Aqv3XAOj2NXs5+qnl5ArIreSqCx/f0Q=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 18/26] ppc/pnv: Add an "nr-threads" property to the base chip
 class
Date: Wed,  8 Jan 2020 16:23:04 +1100
Message-Id: <20200108052312.238710-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Set it at chip creation and forward it to the cores. This allows to drop
a call to qdev_get_machine().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200106145645.4539-7-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 8 +++++---
 include/hw/ppc/pnv.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ead92d52b2..6a0aa78d53 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -802,6 +802,8 @@ static void pnv_init(MachineState *machine)
                                 &error_fatal);
         object_property_set_int(chip, machine->smp.cores,
                                 "nr-cores", &error_fatal);
+        object_property_set_int(chip, machine->smp.threads,
+                                "nr-threads", &error_fatal);
         /*
          * The POWER8 machine use the XICS interrupt interface.
          * Propagate the XICS fabric to the chip and its controllers.
@@ -1526,7 +1528,6 @@ static void pnv_chip_core_sanitize(PnvChip *chip, E=
rror **errp)
=20
 static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
 {
-    MachineState *ms =3D MACHINE(qdev_get_machine());
     Error *error =3D NULL;
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
     const char *typename =3D pnv_chip_core_typename(chip);
@@ -1562,8 +1563,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
         object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_co=
re),
                                   &error_abort);
         chip->cores[i] =3D pnv_core;
-        object_property_set_int(OBJECT(pnv_core), ms->smp.threads, "nr-t=
hreads",
-                                &error_fatal);
+        object_property_set_int(OBJECT(pnv_core), chip->nr_threads,
+                                "nr-threads", &error_fatal);
         object_property_set_int(OBJECT(pnv_core), core_hwid,
                                 CPU_CORE_PROP_CORE_ID, &error_fatal);
         object_property_set_int(OBJECT(pnv_core),
@@ -1602,6 +1603,7 @@ static Property pnv_chip_properties[] =3D {
     DEFINE_PROP_UINT64("ram-size", PnvChip, ram_size, 0),
     DEFINE_PROP_UINT32("nr-cores", PnvChip, nr_cores, 1),
     DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
+    DEFINE_PROP_UINT32("nr-threads", PnvChip, nr_threads, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 56277862dd..4b9012f994 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -48,6 +48,7 @@ typedef struct PnvChip {
     uint64_t     ram_size;
=20
     uint32_t     nr_cores;
+    uint32_t     nr_threads;
     uint64_t     cores_mask;
     PnvCore      **cores;
=20
--=20
2.24.1


