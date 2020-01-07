Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C035EC33CA1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991872073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991872073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosNZ-0001Zy-QA
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iormh-0001OZ-Vd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iormg-0006Wi-LN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:32:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6048
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iormg-0006W8-FQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:32:46 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 007GRqlq094053
 for <qemu-devel@nongnu.org>; Tue, 7 Jan 2020 11:32:45 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xb8n21t8e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 11:32:45 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 7 Jan 2020 16:32:44 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 7 Jan 2020 16:32:42 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 007GVsBl35127626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2020 16:31:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74534A405C;
 Tue,  7 Jan 2020 16:32:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C85D2A405B;
 Tue,  7 Jan 2020 16:32:40 +0000 (GMT)
Received: from bahia.tlslab.ibm.com (unknown [9.101.4.41])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2020 16:32:40 +0000 (GMT)
Subject: [PATCH 1/2] pnv/psi: Add device reset hook
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Tue, 07 Jan 2020 17:32:40 +0100
In-Reply-To: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
x-cbid: 20010716-0012-0000-0000-0000037B3E76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010716-0013-0000-0000-000021B75ADE
Message-Id: <157841476035.66386.17838417527621752518.stgit@bahia.tlslab.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-07_05:2020-01-07,
 2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=965 bulkscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1034 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070135
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 007GRqlq094053
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And call it from a QEMU reset handler. This allows each PNV child class t=
o
override the reset hook if needed, eg. POWER8 doesn't but POWER9 does.
The proper way to do that would be to use device_class_set_parent_reset()=
,
but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_reset
pointer adds a fair amount of code. Calling pnv_psi_reset() explicitely i=
s
fine for now.

A subsequent patch will consolidate the call to qemu_register_reset() in
a single place.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_psi.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 75e20d9da08b..6c94781e377d 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -455,7 +455,7 @@ static const MemoryRegionOps pnv_psi_xscom_ops =3D {
     }
 };
=20
-static void pnv_psi_reset(void *dev)
+static void pnv_psi_reset(DeviceState *dev)
 {
     PnvPsi *psi =3D PNV_PSI(dev);
=20
@@ -464,6 +464,11 @@ static void pnv_psi_reset(void *dev)
     psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
 }
=20
+static void pnv_psi_reset_handler(void *dev)
+{
+    device_reset(DEVICE(dev));
+}
+
 static void pnv_psi_power8_instance_init(Object *obj)
 {
     Pnv8Psi *psi8 =3D PNV8_PSI(obj);
@@ -533,7 +538,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
             ((uint64_t) i << PSIHB_XIVR_SRC_SH);
     }
=20
-    qemu_register_reset(pnv_psi_reset, dev);
+    qemu_register_reset(pnv_psi_reset_handler, dev);
 }
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
@@ -816,7 +821,7 @@ static void pnv_psi_power9_irq_set(PnvPsi *psi, int i=
rq, bool state)
     qemu_set_irq(psi->qirqs[irq], state);
 }
=20
-static void pnv_psi_power9_reset(void *dev)
+static void pnv_psi_power9_reset(DeviceState *dev)
 {
     Pnv9Psi *psi =3D PNV9_PSI(dev);
=20
@@ -870,7 +875,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
=20
     pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
=20
-    qemu_register_reset(pnv_psi_power9_reset, dev);
+    qemu_register_reset(pnv_psi_reset_handler, dev);
 }
=20
 static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
@@ -882,6 +887,7 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
=20
     dc->desc    =3D "PowerNV PSI Controller POWER9";
     dc->realize =3D pnv_psi_power9_realize;
+    dc->reset   =3D pnv_psi_power9_reset;
=20
     ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
     ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
@@ -934,6 +940,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
=20
     dc->desc =3D "PowerNV PSI Controller";
     dc->props =3D pnv_psi_properties;
+    dc->reset =3D pnv_psi_reset;
 }
=20
 static const TypeInfo pnv_psi_info =3D {


