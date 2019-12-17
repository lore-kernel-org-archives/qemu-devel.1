Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8ECC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE702072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ra8bUvVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE702072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35835 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5PM-0004Sx-Kv
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jb-00022v-Cr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jZ-0007OH-VL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:23 -0500
Received: from ozlabs.org ([203.11.71.1]:49633)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jZ-0006st-JX; Mon, 16 Dec 2019 23:45:21 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWc4gK7z9sTM; Tue, 17 Dec 2019 15:43:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557820;
 bh=5Qx9JZq/b4z8NuNNEqJb3p8l2efckqMTcq8O5CEPJfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ra8bUvVLF4bOicbS5uN224pSu12v4D6O9Ebdb9fmpZNBcIyoWiw1vB3WVZuoK8STb
 bHIgKeBa76w3+HDmbWnbIAQGe2WZ0xqWmouk1QKBePJqQFtaylKZjGxLD54/q3R1A+
 ochV9tmXMZkkCc9FS/H+wYV95CCSuvRztrKQtT6E=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 49/88] ppc/pnv: Extend XiveRouter with a get_block_id() handler
Date: Tue, 17 Dec 2019 15:42:43 +1100
Message-Id: <20191217044322.351838-50-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When doing CAM line compares, fetch the block id from the interrupt
controller which can have set the PC_TCTXT_CHIPID field.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-20-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c    |  6 ++++++
 hw/intc/spapr_xive.c  |  6 ++++++
 hw/intc/xive.c        | 21 ++++++++++++++++-----
 include/hw/ppc/xive.h |  2 +-
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 23e73641f2..43c760efd1 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -459,6 +459,11 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, u=
int8_t format,
     return count;
 }
=20
+static uint8_t pnv_xive_get_block_id(XiveRouter *xrtr)
+{
+    return pnv_xive_block_id(PNV_XIVE(xrtr));
+}
+
 /*
  * The TIMA MMIO space is shared among the chips and to identify the
  * chip from which the access is being done, we extract the chip id
@@ -1890,6 +1895,7 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D pnv_xive_write_end;
     xrc->get_nvt =3D pnv_xive_get_nvt;
     xrc->write_nvt =3D pnv_xive_write_nvt;
+    xrc->get_block_id =3D pnv_xive_get_block_id;
=20
     xnc->notify =3D pnv_xive_notify;
     xpc->match_nvt  =3D pnv_xive_match_nvt;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index b785066da5..57305c56d7 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -473,6 +473,11 @@ static int spapr_xive_match_nvt(XivePresenter *xptr,=
 uint8_t format,
     return count;
 }
=20
+static uint8_t spapr_xive_get_block_id(XiveRouter *xrtr)
+{
+    return SPAPR_XIVE_BLOCK_ID;
+}
+
 static const VMStateDescription vmstate_spapr_xive_end =3D {
     .name =3D TYPE_SPAPR_XIVE "/end",
     .version_id =3D 1,
@@ -766,6 +771,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D spapr_xive_write_end;
     xrc->get_nvt =3D spapr_xive_get_nvt;
     xrc->write_nvt =3D spapr_xive_write_nvt;
+    xrc->get_block_id =3D spapr_xive_get_block_id;
=20
     sicc->activate =3D spapr_xive_activate;
     sicc->deactivate =3D spapr_xive_deactivate;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index e022bb7afd..d4c6e21703 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1371,17 +1371,25 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8=
_t nvt_blk, uint32_t nvt_idx,
    return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
 }
=20
+static int xive_router_get_block_id(XiveRouter *xrtr)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_block_id(xrtr);
+}
+
 /*
  * Encode the HW CAM line in the block group mode format :
  *
  *   chip << 19 | 0000000 0 0001 thread (7Bit)
  */
-static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx)
+static uint32_t xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tct=
x)
 {
     CPUPPCState *env =3D &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
+    uint8_t blk =3D xive_router_get_block_id(XIVE_ROUTER(xptr));
=20
-    return xive_nvt_cam_line((pir >> 8) & 0xf, 1 << 7 | (pir & 0x7f));
+    return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
 }
=20
 /*
@@ -1418,7 +1426,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, =
XiveTCTX *tctx,
=20
         /* PHYS ring */
         if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
-            cam =3D=3D xive_tctx_hw_cam_line(tctx)) {
+            cam =3D=3D xive_tctx_hw_cam_line(xptr, tctx)) {
             return TM_QW3_HV_PHYS;
         }
=20
@@ -1755,7 +1763,11 @@ static uint64_t xive_end_source_read(void *opaque,=
 hwaddr addr, unsigned size)
     uint8_t pq;
     uint64_t ret =3D -1;
=20
-    end_blk =3D xsrc->block_id;
+    /*
+     * The block id should be deduced from the load address on the END
+     * ESB MMIO but our model only supports a single block per XIVE chip=
.
+     */
+    end_blk =3D xive_router_get_block_id(xsrc->xrtr);
     end_idx =3D addr >> (xsrc->esb_shift + 1);
=20
     if (xive_router_get_end(xsrc->xrtr, end_blk, end_idx, &end)) {
@@ -1855,7 +1867,6 @@ static void xive_end_source_realize(DeviceState *de=
v, Error **errp)
 }
=20
 static Property xive_end_source_properties[] =3D {
-    DEFINE_PROP_UINT8("block-id", XiveENDSource, block_id, 0),
     DEFINE_PROP_UINT32("nr-ends", XiveENDSource, nr_ends, 0),
     DEFINE_PROP_UINT32("shift", XiveENDSource, esb_shift, XIVE_ESB_64K),
     DEFINE_PROP_LINK("xive", XiveENDSource, xrtr, TYPE_XIVE_ROUTER,
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 9c0bf2c301..1b7b89098f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -351,6 +351,7 @@ typedef struct XiveRouterClass {
                    XiveNVT *nvt);
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
                      XiveNVT *nvt, uint8_t word_number);
+    uint8_t (*get_block_id)(XiveRouter *xrtr);
 } XiveRouterClass;
=20
 int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
@@ -431,7 +432,6 @@ typedef struct XiveENDSource {
     DeviceState parent;
=20
     uint32_t        nr_ends;
-    uint8_t         block_id;
=20
     /* ESB memory region */
     uint32_t        esb_shift;
--=20
2.23.0


