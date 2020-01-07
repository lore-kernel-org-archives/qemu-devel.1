Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC6C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8765C2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8765C2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios5T-0005RG-El
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iormt-0001Tk-MW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iormr-0006dy-MV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:32:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iormp-0006ca-SW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:32:56 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 007GRi6N112170
 for <qemu-devel@nongnu.org>; Tue, 7 Jan 2020 11:32:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xapd6j3kt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 11:32:54 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 7 Jan 2020 16:32:50 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 7 Jan 2020 16:32:48 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 007GVxCd49480182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2020 16:31:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 136E15204E;
 Tue,  7 Jan 2020 16:32:47 +0000 (GMT)
Received: from bahia.tlslab.ibm.com (unknown [9.101.4.41])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D4DD452054;
 Tue,  7 Jan 2020 16:32:46 +0000 (GMT)
Subject: [PATCH 2/2] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Tue, 07 Jan 2020 17:32:46 +0100
In-Reply-To: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
x-cbid: 20010716-0008-0000-0000-0000034740CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010716-0009-0000-0000-00004A6782AD
Message-Id: <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-07_05:2020-01-07,
 2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 clxscore=1034 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=750 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070135
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 007GRi6N112170
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

The proper way to do that would be to use device_class_set_parent_realize=
(),
but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_realiz=
e
pointer adds a fair amount of code. Calling pnv_psi_realize() explicitely
is fine for now.

This should probably be achieved with a device realize hook in the
PSI base class and device_class_set_parent_realize() in the children
classes.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_psi.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 6c94781e377d..546232106756 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -469,6 +469,16 @@ static void pnv_psi_reset_handler(void *dev)
     device_reset(DEVICE(dev));
 }
=20
+static void pnv_psi_realize(DeviceState *dev, Error **errp)
+{
+    PnvPsi *psi =3D PNV_PSI(dev);
+
+    /* Default BAR for MMIO region */
+    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
+
+    qemu_register_reset(pnv_psi_reset_handler, dev);
+}
+
 static void pnv_psi_power8_instance_init(Object *obj)
 {
     Pnv8Psi *psi8 =3D PNV8_PSI(obj);
@@ -528,9 +538,6 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
     memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, psi=
,
                           "psihb", PNV_PSIHB_SIZE);
=20
-    /* Default BAR for MMIO region */
-    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
-
     /* Default sources in XIVR */
     for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
         uint8_t xivr =3D irq_to_xivr[i];
@@ -538,7 +545,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
             ((uint64_t) i << PSIHB_XIVR_SRC_SH);
     }
=20
-    qemu_register_reset(pnv_psi_reset_handler, dev);
+    pnv_psi_realize(dev, errp);
 }
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
@@ -873,9 +880,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
     memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mmio_o=
ps, psi,
                           "psihb", PNV9_PSIHB_SIZE);
=20
-    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
-
-    qemu_register_reset(pnv_psi_reset_handler, dev);
+    pnv_psi_realize(dev, errp);
 }
=20
 static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)


