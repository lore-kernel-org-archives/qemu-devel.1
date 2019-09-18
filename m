Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC2BC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5302320665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5302320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdS8-0004hz-5u
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcUO-0003Ty-8a
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcUN-0002se-3V
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:32 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:41824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcUM-0002rX-Td
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:31 -0400
Received: from player799.ha.ovh.net (unknown [10.109.159.62])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 51E7214130A
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:07:29 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id BACB29F0E535;
 Wed, 18 Sep 2019 16:07:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:26 +0200
Message-Id: <20190918160645.25126-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6215248964917955558
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.149
Subject: [Qemu-devel] [PATCH v4 06/25] ppc/pnv: Implement the XiveFabric
 interface
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CAM line matching on the PowerNV machine now scans all chips of
the system and all CPUs of a chip to find a dispatched NVT in the
thread contexts.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 77a86c6a2301..ca24dd62df23 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1378,6 +1378,35 @@ static void pnv_pic_print_info(InterruptStatsProvi=
der *obj,
     }
 }
=20
+static int pnv_xive_match_nvt(XiveFabric *xfb, uint8_t format,
+                               uint8_t nvt_blk, uint32_t nvt_idx,
+                               bool cam_ignore, uint8_t priority,
+                               uint32_t logic_serv,
+                               XiveTCTXMatch *match)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(xfb);
+    int total_count =3D 0;
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
+        XivePresenter *xptr =3D XIVE_PRESENTER(&chip9->xive);
+        XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
+        int count;
+
+        count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ign=
ore,
+                               priority, logic_serv, match);
+
+        if (count < 0) {
+            return count;
+        }
+
+        total_count +=3D count;
+    }
+
+    return total_count;
+}
+
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -1441,9 +1470,11 @@ static void pnv_machine_power8_class_init(ObjectCl=
ass *oc, void *data)
 static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
+    xfc->match_nvt =3D pnv_xive_match_nvt;
=20
     mc->alias =3D "powernv";
 }
@@ -1495,6 +1526,7 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
         .interfaces =3D (InterfaceInfo[]) {               \
             { TYPE_XICS_FABRIC },                       \
             { TYPE_INTERRUPT_STATS_PROVIDER },          \
+            { TYPE_XIVE_FABRIC },                       \
             { },                                        \
         },                                              \
     }
--=20
2.21.0


