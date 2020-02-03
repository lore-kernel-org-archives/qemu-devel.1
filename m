Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7B9C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D15C20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IKukQ0R2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D15C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVBh-0005qe-Gk
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxo-0003Yy-0q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxm-0003Oy-6g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:03 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50389 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxl-0002db-RX; Mon, 03 Feb 2020 01:12:02 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBr2F2mz9sSx; Mon,  3 Feb 2020 17:11:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710292;
 bh=b+jEKCcOsZP9lpCTW7dR8B27vCgt7Ad6CoaXidvsZDI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IKukQ0R27n+cB3GxdDIYR9wzDrRQxFtZu/cjS/r7npzp2QpMYXgFZVUXYEYHS/955
 skyZbOpY9TG2H/jO4r7a9pDQ+Mi2QK20wEGA+iyb96F9hic8ety/LWgLVsRrfym8n+
 BkWAmRNEFrbAp+EzPJD4pOS6LNuZrPKLeYd2y+kQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 21/35] ppc/pnv: change the PowerNV machine devices to be non
 user creatable
Date: Mon,  3 Feb 2020 17:11:09 +1100
Message-Id: <20200203061123.59150-22-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The PowerNV machine emulates an OpenPOWER system and the PowerNV chip
devices are models of the internal logic of the POWER processor. They
can not be instantiated by the user on the QEMU command line.

The PHB3/PHB4 devices could be an exception in the future after some
rework on how the device tree is built. For the moment, exclude them
also.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200129113720.7404-1-clg@kaod.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/pnv_phb3.c      | 2 ++
 hw/pci-host/pnv_phb3_pbcq.c | 1 +
 hw/pci-host/pnv_phb4.c      | 3 ++-
 hw/pci-host/pnv_phb4_pec.c  | 2 ++
 hw/ppc/pnv_core.c           | 2 ++
 hw/ppc/pnv_homer.c          | 1 +
 hw/ppc/pnv_lpc.c            | 1 +
 hw/ppc/pnv_occ.c            | 1 +
 8 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index f03399c406..74618fadf0 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1115,6 +1115,7 @@ static void pnv_phb3_class_init(ObjectClass *klass,=
 void *data)
     dc->realize =3D pnv_phb3_realize;
     device_class_set_props(dc, pnv_phb3_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pnv_phb3_type_info =3D {
@@ -1168,6 +1169,7 @@ static void pnv_phb3_root_port_class_init(ObjectCla=
ss *klass, void *data)
=20
     device_class_set_parent_realize(dc, pnv_phb3_root_port_realize,
                                     &rpc->parent_realize);
+    dc->user_creatable =3D false;
=20
     k->vendor_id =3D PCI_VENDOR_ID_IBM;
     k->device_id =3D 0x03dc;
diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
index 6f0c05be68..f232228b0e 100644
--- a/hw/pci-host/pnv_phb3_pbcq.c
+++ b/hw/pci-host/pnv_phb3_pbcq.c
@@ -335,6 +335,7 @@ static void pnv_pbcq_class_init(ObjectClass *klass, v=
oid *data)
     xdc->dt_xscom =3D pnv_pbcq_dt_xscom;
=20
     dc->realize =3D pnv_pbcq_realize;
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pnv_pbcq_type_info =3D {
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 61235d13a6..23cf093928 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1290,7 +1290,7 @@ static void pnv_phb4_class_init(ObjectClass *klass,=
 void *data)
     dc->realize         =3D pnv_phb4_realize;
     device_class_set_props(dc, pnv_phb4_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->user_creatable  =3D true;
+    dc->user_creatable  =3D false;
     dc->reset           =3D pnv_phb4_reset;
=20
     xfc->notify         =3D pnv_phb4_xive_notify;
@@ -1368,6 +1368,7 @@ static void pnv_phb4_root_port_class_init(ObjectCla=
ss *klass, void *data)
     PCIERootPortClass *rpc =3D PCIE_ROOT_PORT_CLASS(klass);
=20
     dc->desc     =3D "IBM PHB4 PCIE Root Port";
+    dc->user_creatable =3D false;
=20
     device_class_set_parent_realize(dc, pnv_phb4_root_port_realize,
                                     &rpc->parent_realize);
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index fd92041d69..68e1db3eac 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -490,6 +490,7 @@ static void pnv_pec_class_init(ObjectClass *klass, vo=
id *data)
=20
     dc->realize =3D pnv_pec_realize;
     device_class_set_props(dc, pnv_pec_properties);
+    dc->user_creatable =3D false;
=20
     pecc->xscom_nest_base =3D pnv_pec_xscom_nest_base;
     pecc->xscom_pci_base  =3D pnv_pec_xscom_pci_base;
@@ -568,6 +569,7 @@ static void pnv_pec_stk_class_init(ObjectClass *klass=
, void *data)
=20
     device_class_set_props(dc, pnv_pec_stk_properties);
     dc->realize =3D pnv_pec_stk_realize;
+    dc->user_creatable =3D false;
=20
     /* TODO: reset regs ? */
 }
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index f7247222bc..234562040d 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -325,6 +325,7 @@ static void pnv_core_class_init(ObjectClass *oc, void=
 *data)
     dc->realize =3D pnv_core_realize;
     dc->unrealize =3D pnv_core_unrealize;
     device_class_set_props(dc, pnv_core_properties);
+    dc->user_creatable =3D false;
 }
=20
 #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
@@ -423,6 +424,7 @@ static void pnv_quad_class_init(ObjectClass *oc, void=
 *data)
=20
     dc->realize =3D pnv_quad_realize;
     device_class_set_props(dc, pnv_quad_properties);
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pnv_quad_info =3D {
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 93ae42f7e4..9a262629b7 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -360,6 +360,7 @@ static void pnv_homer_class_init(ObjectClass *klass, =
void *data)
     dc->realize =3D pnv_homer_realize;
     dc->desc =3D "PowerNV HOMER Memory";
     device_class_set_props(dc, pnv_homer_properties);
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pnv_homer_type_info =3D {
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d1de98f04c..5989d723c5 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -762,6 +762,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, vo=
id *data)
     dc->realize =3D pnv_lpc_realize;
     dc->desc =3D "PowerNV LPC Controller";
     device_class_set_props(dc, pnv_lpc_properties);
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pnv_lpc_info =3D {
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 2173fac0e7..5a716c256e 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -280,6 +280,7 @@ static void pnv_occ_class_init(ObjectClass *klass, vo=
id *data)
     dc->realize =3D pnv_occ_realize;
     dc->desc =3D "PowerNV OCC Controller";
     device_class_set_props(dc, pnv_occ_properties);
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pnv_occ_type_info =3D {
--=20
2.24.1


