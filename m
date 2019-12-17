Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC1BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6873F20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PipfyywD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6873F20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4y7-0005cN-FU
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ib-0000NZ-Es
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ia-0005xE-CK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:21 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47239 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ia-0005aQ-1G; Mon, 16 Dec 2019 23:44:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWV6T2Mz9sSv; Tue, 17 Dec 2019 15:43:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557814;
 bh=ey4PkgIVy1Dh/wZ3ywzkhTE9eyeU/5i9x3xN5XfNKH4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PipfyywDpH4HMBUg0w+fH764+JCgVoE5K1H6A3nCe8kPLTqLq7gj++jG7Z0mtnOMY
 yMy3gdryG169YyxW4TK3v2kPqgdFwrOoKSCmGPeR98amu9W0RY61BGmSHWAwRaLOL3
 TaQaygHnnNfr1aIV2e2kOVxSuZ8v6ha74PTQvIqk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 35/88] ppc/pnv: Implement the XiveFabric interface
Date: Tue, 17 Dec 2019 15:42:29 +1100
Message-Id: <20191217044322.351838-36-david@gibson.dropbear.id.au>
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

The CAM line matching on the PowerNV machine now scans all chips of
the system and all CPUs of a chip to find a dispatched NVT in the
thread contexts.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-10-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8f688f4efc..5b8b07f6ae 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1443,6 +1443,35 @@ static void pnv_pic_print_info(InterruptStatsProvi=
der *obj,
     }
 }
=20
+static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
+                         uint8_t nvt_blk, uint32_t nvt_idx,
+                         bool cam_ignore, uint8_t priority,
+                         uint32_t logic_serv,
+                         XiveTCTXMatch *match)
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
@@ -1506,9 +1535,11 @@ static void pnv_machine_power8_class_init(ObjectCl=
ass *oc, void *data)
 static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
+    xfc->match_nvt =3D pnv_match_nvt;
=20
     mc->alias =3D "powernv";
 }
@@ -1555,6 +1586,10 @@ static const TypeInfo types[] =3D {
         .name          =3D MACHINE_TYPE_NAME("powernv9"),
         .parent        =3D TYPE_PNV_MACHINE,
         .class_init    =3D pnv_machine_power9_class_init,
+        .interfaces =3D (InterfaceInfo[]) {
+            { TYPE_XIVE_FABRIC },
+            { },
+        },
     },
     {
         .name          =3D MACHINE_TYPE_NAME("powernv8"),
--=20
2.23.0


