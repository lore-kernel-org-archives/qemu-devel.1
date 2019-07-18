Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D61AC76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6604621019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6604621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho529-00042u-MG
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59082)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho50Q-0006WG-T6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho50P-00027d-Mo
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:26 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:49060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho50P-00026j-HB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:25 -0400
Received: from player778.ha.ovh.net (unknown [10.108.42.176])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 242621FE191
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:55:24 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 58C42801F490;
 Thu, 18 Jul 2019 11:55:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:12 +0200
Message-Id: <20190718115420.19919-10-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6785798742523874278
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.98.131
Subject: [Qemu-devel] [PATCH v2 09/17] ppc/xive: Extend XiveTCTX with a
 XiveRouter pointer
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is to perform lookups in the NVT table when a vCPU is dispatched
and possibily resend interrupts.

Future XIVE chip will use a different class for the model of the
interrupt controller and we might need to change the type of
'XiveRouter *' to 'Object *'

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 2 ++
 hw/intc/xive.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 4851ff87e795..206b23ecfab3 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -320,6 +320,8 @@ typedef struct XiveTCTX {
     qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
+
+    struct XiveRouter  *xrtr;
 } XiveTCTX;
=20
 /*
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 88f2e560db0f..1b0eccb6df40 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -573,6 +573,14 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
     Object *obj;
     Error *local_err =3D NULL;
=20
+    obj =3D object_property_get_link(OBJECT(dev), "xrtr", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'xrtr' not found: ");
+        return;
+    }
+    tctx->xrtr =3D XIVE_ROUTER(obj);
+
     obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
     if (!obj) {
         error_propagate(errp, local_err);
@@ -666,6 +674,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
     object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_add_const_link(obj, "xrtr", OBJECT(xrtr), &error_abo=
rt);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
--=20
2.21.0


