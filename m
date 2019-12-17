Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10B6C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD4820733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TNbGcFFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD4820733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4sz-0006CU-7u
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hv-0007yn-9j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ht-0005JL-UT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:39 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45905 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ht-0005D5-K9; Mon, 16 Dec 2019 23:43:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWP6L6zz9sSQ; Tue, 17 Dec 2019 15:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557809;
 bh=0Y4e9z7qnnI/ns1o/F7tXL36eNCsL0ItzSihF6vlJW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TNbGcFFpLxa5zPgG11H1BiE4UQ9HJmwxZI9C7HNJNwQtKjwP+SfXc8VtVpyT67ykz
 bDc/ncs6AnzLTWBstENEOB+oCoWvtlkxu3xOdBGfLnfbjOkysA6SvrJ9eJH9t1K+Au
 +ytVoTryJM2iWt1ScssVCn+O/3OR+dJwbiGfh1kc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 10/88] ppc/pnv: Link "chip" property to PnvCore::chip pointer
Date: Tue, 17 Dec 2019 15:42:04 +1100
Message-Id: <20191217044322.351838-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The core object has both a pointer and a "chip" property pointing to the
chip object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157383336007.165747.1524120147081367440.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c      |  4 ++--
 hw/ppc/pnv_core.c | 10 ++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3fa24a2d60..2bf8a3b23b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1327,8 +1327,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
         object_property_set_int(OBJECT(pnv_core),
                                 pcc->core_pir(chip, core_hwid),
                                 "pir", &error_fatal);
-        object_property_add_const_link(OBJECT(pnv_core), "chip",
-                                       OBJECT(chip), &error_fatal);
+        object_property_set_link(OBJECT(pnv_core), OBJECT(chip), "chip",
+                                 &error_abort);
         object_property_set_bool(OBJECT(pnv_core), true, "realized",
                                  &error_fatal);
=20
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 61b3d3ce22..5ab75bde6c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -217,15 +217,8 @@ static void pnv_core_realize(DeviceState *dev, Error=
 **errp)
     void *obj;
     int i, j;
     char name[32];
-    Object *chip;
=20
-    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
-    if (!chip) {
-        error_propagate_prepend(errp, local_err,
-                                "required link 'chip' not found: ");
-        return;
-    }
-    pc->chip =3D PNV_CHIP(chip);
+    assert(pc->chip);
=20
     pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
@@ -297,6 +290,7 @@ static void pnv_core_unrealize(DeviceState *dev, Erro=
r **errp)
=20
 static Property pnv_core_properties[] =3D {
     DEFINE_PROP_UINT32("pir", PnvCore, pir, 0),
+    DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.23.0


