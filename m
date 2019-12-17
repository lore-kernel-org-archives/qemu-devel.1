Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C71C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6332B2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Igf5mJnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6332B2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5PU-0004ex-7X
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jC-0001Pa-NG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jB-0006oe-GF
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:58 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46239 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jB-0006HZ-5C; Mon, 16 Dec 2019 23:44:57 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWZ2TyWz9sT6; Tue, 17 Dec 2019 15:43:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557818;
 bh=nZ5yfF0vhIxWHx0QMLrYt8s8F6FlZSGETDaImhofivo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Igf5mJnKDxNQHKNjNPSNijPO5KkMWeNjozivLTfe4g18CVhEdG6hUqbfuXUle5HMC
 OMVzaJG1l7ozQyKcAGOqDsPkiuRaS5ev8X8J5L1LN5bmdqOuJnP6/JkNnITXScjuNY
 LNX7IoGevHXkEjsk1kMEMmsmJZNv62GWXE8g9K68=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 45/88] ppc/xive: Remove the get_tctx() XiveRouter handler
Date: Tue, 17 Dec 2019 15:42:39 +1100
Message-Id: <20191217044322.351838-46-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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

It is now unused.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-16-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c    | 13 -------------
 hw/intc/spapr_xive.c  |  8 --------
 hw/intc/xive.c        |  7 -------
 include/hw/ppc/xive.h |  2 --
 4 files changed, 30 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index c14a2d1869..216ebc150a 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -460,18 +460,6 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu=
)
     return xive;
 }
=20
-static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
-
-    if (!xive) {
-        return NULL;
-    }
-
-    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-}
-
 /*
  * The internal sources (IPIs) of the interrupt controller have no
  * knowledge of the XIVE chip on which they reside. Encode the block
@@ -1900,7 +1888,6 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D pnv_xive_write_end;
     xrc->get_nvt =3D pnv_xive_get_nvt;
     xrc->write_nvt =3D pnv_xive_write_nvt;
-    xrc->get_tctx =3D pnv_xive_get_tctx;
=20
     xnc->notify =3D pnv_xive_notify;
     xpc->match_nvt  =3D pnv_xive_match_nvt;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 40891543e0..b785066da5 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -427,13 +427,6 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, ui=
nt8_t nvt_blk,
     g_assert_not_reached();
 }
=20
-static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-
-    return spapr_cpu_state(cpu)->tctx;
-}
-
 static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
                                 bool cam_ignore, uint8_t priority,
@@ -773,7 +766,6 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D spapr_xive_write_end;
     xrc->get_nvt =3D spapr_xive_get_nvt;
     xrc->write_nvt =3D spapr_xive_write_nvt;
-    xrc->get_tctx =3D spapr_xive_get_tctx;
=20
     sicc->activate =3D spapr_xive_activate;
     sicc->deactivate =3D spapr_xive_deactivate;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 0ca7099f4e..4bff3abdc3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1317,13 +1317,6 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_=
t nvt_blk, uint32_t nvt_idx,
    return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
 }
=20
-XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
-
-    return xrc->get_tctx(xrtr, cs);
-}
-
 /*
  * Encode the HW CAM line in the block group mode format :
  *
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index dcf8974515..24315480e7 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -351,7 +351,6 @@ typedef struct XiveRouterClass {
                    XiveNVT *nvt);
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
                      XiveNVT *nvt, uint8_t word_number);
-    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
 } XiveRouterClass;
=20
 int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
@@ -364,7 +363,6 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
                         XiveNVT *nvt);
 int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
                           XiveNVT *nvt, uint8_t word_number);
-XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
=20
 /*
--=20
2.23.0


