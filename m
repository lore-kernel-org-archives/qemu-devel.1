Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48AAC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0142322400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hKwD8cwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0142322400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4cy-0005x0-47
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kX4X2-0006Kp-Pz; Mon, 26 Oct 2020 11:35:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39832
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kX4Wx-0000zB-9e; Mon, 26 Oct 2020 11:35:35 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09QFXna0054608; Mon, 26 Oct 2020 11:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=ypvHD84FdsYofhc2A1y40REINK7Jr4BzI0AH7kAAG+A=;
 b=hKwD8cwvNBvIIPRqI1i5RVLXkkUKBSVR52MjpiE0GXzCa01J432mAzVpsMfg2SpRVV1x
 05RDWsvZ/CcSkVWBYgToMeGHULg+6ATFgYUlrahRptXSGWReVmd9hVJl2ze1SblIKjIS
 V4AtDo0A82zeMcLUwgbtBE/B/W0qP/Hf3bVbN66cwrHUkrkzfaqK5dxlpX72GTL2/Fxz
 DtPrnkTQ9G35TFGa828d6jh4ZDPuW7t0Kz4PP21Oi1u5LdORGw7YfrRln0KxeaWM+Zp8
 CX2DVpJb5fS30nlDXzF11eXQmpOWKxGIt/LkXiEjQftjVMT2rAWRZCHtnapKjFKQuzQv MA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34dhc0qu25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 11:35:28 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09QFYWeB059391;
 Mon, 26 Oct 2020 11:35:28 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34dhc0qu1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 11:35:28 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QFIHdH023418;
 Mon, 26 Oct 2020 15:35:27 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03dal.us.ibm.com with ESMTP id 34cbw8vt4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2020 15:35:27 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09QFZQK540436172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 15:35:26 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E5D9112062;
 Mon, 26 Oct 2020 15:35:26 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFCD0112061;
 Mon, 26 Oct 2020 15:35:23 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.49.29])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2020 15:35:23 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com, thuth@redhat.com
Subject: [PATCH 11/13] s390x/pci: use a PCI Function structure
Date: Mon, 26 Oct 2020 11:34:39 -0400
Message-Id: <1603726481-31824-12-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603726481-31824-1-git-send-email-mjrosato@linux.ibm.com>
References: <1603726481-31824-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-26_08:2020-10-26,
 2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=962 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260107
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 11:03:39
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kvm@vger.kernel.org, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pierre Morel <pmorel@linux.ibm.com>

We use a ClpRspQueryPci structure to hold the information related to a
zPCI Function.

This allows us to be ready to support different zPCI functions and to
retrieve the zPCI function information from the host.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c         | 12 ++++++++++++
 hw/s390x/s390-pci-inst.c        |  8 ++------
 include/hw/s390x/s390-pci-bus.h |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 036cf46..072b56e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -778,6 +778,17 @@ static void s390_pci_init_default_group(void)
     resgrp->version = 0;
 }
 
+static void set_pbdev_info(S390PCIBusDevice *pbdev)
+{
+    pbdev->zpci_fn.sdma = ZPCI_SDMA_ADDR;
+    pbdev->zpci_fn.edma = ZPCI_EDMA_ADDR;
+    pbdev->zpci_fn.pchid = 0;
+    pbdev->zpci_fn.ug = ZPCI_DEFAULT_FN_GRP;
+    pbdev->zpci_fn.fid = pbdev->fid;
+    pbdev->zpci_fn.uid = pbdev->uid;
+    pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -1000,6 +1011,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
+        set_pbdev_info(pbdev);
 
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             pbdev->fh |= FH_SHM_VFIO;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index c25b2a6..58cd041 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -281,6 +281,8 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             goto out;
         }
 
+        memcpy(resquery, &pbdev->zpci_fn, sizeof(*resquery));
+
         for (i = 0; i < PCI_BAR_COUNT; i++) {
             uint32_t data = pci_get_long(pbdev->pdev->config +
                 PCI_BASE_ADDRESS_0 + (i * 4));
@@ -294,12 +296,6 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
                     resquery->bar_size[i]);
         }
 
-        stq_p(&resquery->sdma, ZPCI_SDMA_ADDR);
-        stq_p(&resquery->edma, ZPCI_EDMA_ADDR);
-        stl_p(&resquery->fid, pbdev->fid);
-        stw_p(&resquery->pchid, 0);
-        stw_p(&resquery->ug, ZPCI_DEFAULT_FN_GRP);
-        stl_p(&resquery->uid, pbdev->uid);
         stw_p(&resquery->hdr.rsp, CLP_RC_OK);
         break;
     }
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 869c0f2..fe36f16 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -342,6 +342,7 @@ struct S390PCIBusDevice {
     uint16_t maxstbl;
     uint8_t sum;
     S390PCIGroup *pci_group;
+    ClpRspQueryPci zpci_fn;
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
-- 
1.8.3.1


