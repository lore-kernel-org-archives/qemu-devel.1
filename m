Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8724C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842872067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m0D2XHtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842872067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip41k-0005dK-6Q
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ow-0004Q3-Qj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ov-0003HE-Fu
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:54 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35301 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3ov-0002iS-4I; Wed, 08 Jan 2020 00:23:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMD4hKfz9sSj; Wed,  8 Jan 2020 16:23:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578461000;
 bh=tuKlphejUmyjcFGyLZpn0cp3VEzjtRJnKXWMwh6ccwU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m0D2XHtCQFePWJQ8wOTYznZnep+NB9upD3GIld/HU7Je7hn150MOQBQMkzttBFb9O
 2LW5O976c4A5H/1IOKzhlcxkBmTpUOPqiLxnMyKtV5wOh9D3+p0uuzpaiNob6kISov
 93wmwBQuwLn/ZTWruGn1Cmsj3n1zlQZu7zil02Qk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 20/26] xive: Add a "presenter" link property to the TCTX object
Date: Wed,  8 Jan 2020 16:23:06 +1100
Message-Id: <20200108052312.238710-21-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This will be used in subsequent patches to access the XIVE associated to
a TCTX without reaching out to the machine through qdev_get_machine().

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
[ groug: - split patch
         - write subject and changelog ]
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200106145645.4539-9-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c  | 2 +-
 hw/intc/xive.c        | 6 +++++-
 hw/ppc/pnv.c          | 3 ++-
 include/hw/ppc/xive.h | 8 +++++---
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 32322470a8..7663123878 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -601,7 +601,7 @@ static int spapr_xive_cpu_intc_create(SpaprInterruptC=
ontroller *intc,
     Object *obj;
     SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
-    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), errp);
+    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(xive), errp);
     if (!obj) {
         return -1;
     }
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 12a362b681..bc8019c4c9 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -654,6 +654,7 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
     Error *local_err =3D NULL;
=20
     assert(tctx->cs);
+    assert(tctx->xptr);
=20
     cpu =3D POWERPC_CPU(tctx->cs);
     env =3D &cpu->env;
@@ -727,6 +728,8 @@ static const VMStateDescription vmstate_xive_tctx =3D=
 {
=20
 static Property xive_tctx_properties[] =3D {
     DEFINE_PROP_LINK("cpu", XiveTCTX, cs, TYPE_CPU, CPUState *),
+    DEFINE_PROP_LINK("presenter", XiveTCTX, xptr, TYPE_XIVE_PRESENTER,
+                     XivePresenter *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -752,7 +755,7 @@ static const TypeInfo xive_tctx_info =3D {
     .class_init    =3D xive_tctx_class_init,
 };
=20
-Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
+Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)
 {
     Error *local_err =3D NULL;
     Object *obj;
@@ -761,6 +764,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
     object_property_set_link(obj, cpu, "cpu", &error_abort);
+    object_property_set_link(obj, OBJECT(xptr), "presenter", &error_abor=
t);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0b8f3ad26..19fc5d4ddb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -925,7 +925,8 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
      * controller object is initialized afterwards. Hopefully, it's
      * only used at runtime.
      */
-    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), &lo=
cal_err);
+    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(&chip9->xive),
+                           &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 1ded82b1cd..705cf48176 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -311,6 +311,8 @@ void xive_source_set_irq(void *opaque, int srcno, int=
 val);
 #define XIVE_TM_RING_COUNT      4
 #define XIVE_TM_RING_SIZE       0x10
=20
+typedef struct XivePresenter XivePresenter;
+
 typedef struct XiveTCTX {
     DeviceState parent_obj;
=20
@@ -319,6 +321,8 @@ typedef struct XiveTCTX {
     qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
+
+    XivePresenter *xptr;
 } XiveTCTX;
=20
 /*
@@ -378,8 +382,6 @@ typedef struct XiveTCTXMatch {
     uint8_t ring;
 } XiveTCTXMatch;
=20
-typedef struct XivePresenter XivePresenter;
-
 #define TYPE_XIVE_PRESENTER "xive-presenter"
 #define XIVE_PRESENTER(obj)                                     \
     INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
@@ -467,7 +469,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveT=
CTX *tctx, hwaddr offset,
                            unsigned size);
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
-Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
+Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)=
;
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
--=20
2.24.1


