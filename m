Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9513DC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AF520705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bVsPWdop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AF520705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3tP-0002nk-Mm
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oc-0003t5-CA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oa-0002lU-VY
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:34 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37385 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oa-0002ht-K4; Wed, 08 Jan 2020 00:23:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMC6WDfz9sSY; Wed,  8 Jan 2020 16:23:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460999;
 bh=kGaZI5Lnwcj97tGSIjPD6mGjpb+lCMs2T2ZbPDSKe04=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bVsPWdopg+WJF2wYvKkxHm2aAg/D+w5phEjkJAM+/4UCZacOe8uIanPYICagBrBQQ
 Lrb6vUgH1aDevyX/kqqEKnlj7CwOe3HV3nZu/KsmkCSE8iThl80e3eAXD2XoLXaAIk
 tIIgweDaKUCqqvnHWL8So4SYpJfx7qNYOi6zgdJU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 22/26] pnv/xive: Deduce the PnvXive pointer from XiveTCTX::xptr
Date: Wed,  8 Jan 2020 16:23:08 +1100
Message-Id: <20200108052312.238710-23-david@gibson.dropbear.id.au>
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

And use it instead of reaching out to the machine. This allows to get
rid of pnv_get_chip().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200106145645.4539-11-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c   |  8 ++------
 hw/ppc/pnv.c         | 14 --------------
 include/hw/ppc/pnv.h |  2 --
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 6412cf222e..715fca61ae 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -472,12 +472,8 @@ static uint8_t pnv_xive_get_block_id(XiveRouter *xrt=
r)
 static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
 {
     int pir =3D ppc_cpu_pir(cpu);
-    PnvChip *chip;
-    PnvXive *xive;
-
-    chip =3D pnv_get_chip(PNV9_PIR2CHIP(pir));
-    assert(chip);
-    xive =3D &PNV9_CHIP(chip)->xive;
+    XivePresenter *xptr =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc)->xptr;
+    PnvXive *xive =3D PNV_XIVE(xptr);
=20
     if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
         xive_error(xive, "IC: CPU %x is not enabled", pir);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 19fc5d4ddb..e2735bb8dd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1717,20 +1717,6 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t =
format,
     return total_count;
 }
=20
-PnvChip *pnv_get_chip(uint32_t chip_id)
-{
-    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
-    int i;
-
-    for (i =3D 0; i < pnv->num_chips; i++) {
-        PnvChip *chip =3D pnv->chips[i];
-        if (chip->chip_id =3D=3D chip_id) {
-            return chip;
-        }
-    }
-    return NULL;
-}
-
 static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 2504d8cd4f..d65dd32036 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -219,8 +219,6 @@ struct PnvMachineState {
     PnvPnor      *pnor;
 };
=20
-PnvChip *pnv_get_chip(uint32_t chip_id);
-
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
=20
--=20
2.24.1


