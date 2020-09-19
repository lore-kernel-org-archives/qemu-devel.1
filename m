Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADF3C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880A020866
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U1ymod9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880A020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJeyG-0004uZ-Lw
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kJet3-0007b6-Fv; Sat, 19 Sep 2020 11:34:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kJet1-0003oj-FL; Sat, 19 Sep 2020 11:34:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08JFW6N7041908; Sat, 19 Sep 2020 11:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=kQJ7phx7IPDRsUIQYnPyKtoU9miSSA3NGZKF6VkgNr0=;
 b=U1ymod9WX+D0SnQHyG0PuBDTR6lnHcV8lB8Aaq2tcL4dd+OvhtcfdFmBFWZgKBnkRHzE
 W9htEV3pFy1i6260I9S5PKLaAY/7baofKxFKHEevmst37EaEngXYXHOV0P1BY5v0/jao
 xKfxsJpL9q2mbdHVl8VGt95c2mU3Xil85L/BloNlmkJtVBvNxKO1FOGII70rmmsbLG2+
 tVSDY4G8MWfw8qxFiLXrV0l3Gcx+m+9BUsNdri24CFaUwtQOekAB+c6uazGDvKRwIksA
 zmZ7jbPzafL9b17VD9/nn4ZjG73X4gEanqHkMYgSv0/PPEzeleFADB4byiGHaBJzbhzq +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33nmku04er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 11:34:49 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08JFWMs4043912;
 Sat, 19 Sep 2020 11:34:49 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33nmku04eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 11:34:49 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08JFQkrw017400;
 Sat, 19 Sep 2020 15:34:48 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 33n9m8c20x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 15:34:48 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08JFYhjL20644294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Sep 2020 15:34:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5EBE7805C;
 Sat, 19 Sep 2020 15:34:46 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AC317805F;
 Sat, 19 Sep 2020 15:34:45 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.74.107])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 19 Sep 2020 15:34:45 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com, thuth@redhat.com
Subject: [PATCH 6/7] s390x/pci: use a PCI Function structure
Date: Sat, 19 Sep 2020 11:34:31 -0400
Message-Id: <1600529672-10243-7-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-19_05:2020-09-16,
 2020-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=962 clxscore=1015 priorityscore=1501 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009190131
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:34:45
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
 mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net
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
---
 hw/s390x/s390-pci-bus.c  | 22 +++++++++++++++++-----
 hw/s390x/s390-pci-bus.h  |  1 +
 hw/s390x/s390-pci-inst.c |  8 ++------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index d6666c2..d5255ba 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -777,6 +777,17 @@ static void s390_pci_init_default_group(void)
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
+    pbdev->pci_grp = s390_grp_find(ZPCI_DEFAULT_FN_GRP);
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -994,17 +1005,18 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             }
         }
 
+        pbdev->pdev = pdev;
+        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
+        pbdev->iommu->pbdev = pbdev;
+        pbdev->state = ZPCI_FS_DISABLED;
+        set_pbdev_info(pbdev);
+
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             pbdev->fh |= FH_SHM_VFIO;
         } else {
             pbdev->fh |= FH_SHM_EMUL;
         }
 
-        pbdev->pdev = pdev;
-        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
-        pbdev->iommu->pbdev = pbdev;
-        pbdev->state = ZPCI_FS_DISABLED;
-
         if (s390_pci_msix_init(pbdev)) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 2399376..7821856 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -342,6 +342,7 @@ struct S390PCIBusDevice {
     uint16_t maxstbl;
     uint8_t sum;
     S390PCIGroup *pci_grp;
+    ClpRspQueryPci zpci_fn;
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 946de25..22a0884 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -267,6 +267,8 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             goto out;
         }
 
+        memcpy(resquery, &pbdev->zpci_fn, sizeof(*resquery));
+
         for (i = 0; i < PCI_BAR_COUNT; i++) {
             uint32_t data = pci_get_long(pbdev->pdev->config +
                 PCI_BASE_ADDRESS_0 + (i * 4));
@@ -280,12 +282,6 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
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
-- 
1.8.3.1


