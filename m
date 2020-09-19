Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C3C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C37520866
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sXzWdsQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C37520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJezX-0005vk-BC
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kJet0-0007R9-HQ; Sat, 19 Sep 2020 11:34:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kJesy-0003o8-Ct; Sat, 19 Sep 2020 11:34:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08JF2YwX189514; Sat, 19 Sep 2020 11:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=e9hh0x892plEkeJgIZM0H6mIPFt2AdXnm6DL4lzjtLQ=;
 b=sXzWdsQHbECBlpM9EQUixUAAr57bWOZ6vemJo2MgY8xmENV2Pj0DNMnLTXzoHFWC0gUa
 rYQSUwwDxcrcpRZP3+ug80hbGhRgGAIlTk14sK4ixtW6hLJVL+7Nr2B7+A+fC4ZWxVZX
 uHYGksBKVSAUHxi4BmAWO9EF+ulhpEBCINBQufFNoqaE9mbzZOU+d3S095mGnuQyGgMW
 y0m0tuosq09d/D2lxChFpW2g0KCUnhuA/fHaAdZ6P5GUB0q5mXKtheHna9LKavHHDAxs
 pTNE/DFX0lESRlzN9fohmxIwJE/JdxgS4MMTh1xN9/kDw2V3GzZAkWYjQ3839etCdsMi QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33nkqdh402-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 11:34:46 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08JFYkv8069430;
 Sat, 19 Sep 2020 11:34:46 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33nkqdh3ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 11:34:46 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08JFRPZT010064;
 Sat, 19 Sep 2020 15:34:45 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 33n9m841rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 15:34:45 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08JFYh4K44892514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Sep 2020 15:34:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5DDF78064;
 Sat, 19 Sep 2020 15:34:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 588497805E;
 Sat, 19 Sep 2020 15:34:42 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.74.107])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 19 Sep 2020 15:34:42 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com, thuth@redhat.com
Subject: [PATCH 4/7] s390x/pci: use a PCI Group structure
Date: Sat, 19 Sep 2020 11:34:29 -0400
Message-Id: <1600529672-10243-5-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-19_05:2020-09-16,
 2020-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 suspectscore=2
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

We use a S390PCIGroup structure to hold the information related to a
zPCI Function group.

This allows us to be ready to support multiple groups and to retrieve
the group information from the host.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-bus.h  | 10 ++++++++++
 hw/s390x/s390-pci-inst.c | 22 +++++++++++++---------
 3 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 92146a2..3015d86 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -737,6 +737,46 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     object_unref(OBJECT(iommu));
 }
 
+static S390PCIGroup *s390_grp_create(int ug)
+{
+    S390PCIGroup *grp;
+    S390pciState *s = s390_get_phb();
+
+    grp = g_new0(S390PCIGroup, 1);
+    grp->ug = ug;
+    QTAILQ_INSERT_TAIL(&s->zpci_grps, grp, link);
+    return grp;
+}
+
+S390PCIGroup *s390_grp_find(int ug)
+{
+    S390PCIGroup *grp;
+    S390pciState *s = s390_get_phb();
+
+    QTAILQ_FOREACH(grp, &s->zpci_grps, link) {
+        if ((grp->ug & CLP_REQ_QPCIG_MASK_PFGID) == ug) {
+            return grp;
+        }
+    }
+    return NULL;
+}
+
+static void s390_pci_init_default_group(void)
+{
+    S390PCIGroup *grp;
+    ClpRspQueryPciGrp *resgrp;
+
+    grp = s390_grp_create(ZPCI_DEFAULT_FN_GRP);
+    resgrp = &grp->zpci_grp;
+    resgrp->fr = 1;
+    stq_p(&resgrp->dasm, 0);
+    stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
+    stw_p(&resgrp->mui, DEFAULT_MUI);
+    stw_p(&resgrp->i, 128);
+    stw_p(&resgrp->maxstbl, 128);
+    resgrp->version = 0;
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -764,7 +804,9 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s->bus_no = 0;
     QTAILQ_INIT(&s->pending_sei);
     QTAILQ_INIT(&s->zpci_devs);
+    QTAILQ_INIT(&s->zpci_grps);
 
+    s390_pci_init_default_group();
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
 }
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index da416cb..2399376 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -316,6 +316,14 @@ typedef struct ZpciFmb {
 } ZpciFmb;
 QEMU_BUILD_BUG_MSG(offsetof(ZpciFmb, fmt0) != 48, "padding in ZpciFmb");
 
+#define ZPCI_DEFAULT_FN_GRP 0x20
+typedef struct S390PCIGroup {
+    ClpRspQueryPciGrp zpci_grp;
+    int ug;
+    QTAILQ_ENTRY(S390PCIGroup) link;
+} S390PCIGroup;
+S390PCIGroup *s390_grp_find(int ug);
+
 struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
@@ -333,6 +341,7 @@ struct S390PCIBusDevice {
     uint16_t noi;
     uint16_t maxstbl;
     uint8_t sum;
+    S390PCIGroup *pci_grp;
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
@@ -357,6 +366,7 @@ struct S390pciState {
     GHashTable *zpci_table;
     QTAILQ_HEAD(, SeiContainer) pending_sei;
     QTAILQ_HEAD(, S390PCIBusDevice) zpci_devs;
+    QTAILQ_HEAD(, S390PCIGroup) zpci_grps;
 };
 
 S390pciState *s390_get_phb(void);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 2f7a7d7..946de25 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -284,21 +284,25 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         stq_p(&resquery->edma, ZPCI_EDMA_ADDR);
         stl_p(&resquery->fid, pbdev->fid);
         stw_p(&resquery->pchid, 0);
-        stw_p(&resquery->ug, 1);
+        stw_p(&resquery->ug, ZPCI_DEFAULT_FN_GRP);
         stl_p(&resquery->uid, pbdev->uid);
         stw_p(&resquery->hdr.rsp, CLP_RC_OK);
         break;
     }
     case CLP_QUERY_PCI_FNGRP: {
         ClpRspQueryPciGrp *resgrp = (ClpRspQueryPciGrp *)resh;
-        resgrp->fr = 1;
-        stq_p(&resgrp->dasm, 0);
-        stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
-        stw_p(&resgrp->mui, DEFAULT_MUI);
-        stw_p(&resgrp->i, 128);
-        stw_p(&resgrp->maxstbl, 128);
-        resgrp->version = 0;
 
+        ClpReqQueryPciGrp *reqgrp = (ClpReqQueryPciGrp *)reqh;
+        S390PCIGroup *grp;
+
+        grp = s390_grp_find(reqgrp->g);
+        if (!grp) {
+            /* We do not allow access to unknown groups */
+            /* The group must have been obtained with a vfio device */
+            stw_p(&resgrp->hdr.rsp, CLP_RC_QUERYPCIFG_PFGID);
+            goto out;
+        }
+        memcpy(resgrp, &grp->zpci_grp, sizeof(ClpRspQueryPciGrp));
         stw_p(&resgrp->hdr.rsp, CLP_RC_OK);
         break;
     }
@@ -754,7 +758,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
     /* Length must be greater than 8, a multiple of 8 */
     /* and not greater than maxstbl */
-    if ((len <= 8) || (len % 8) || (len > pbdev->maxstbl)) {
+    if ((len <= 8) || (len % 8) || (len > pbdev->pci_grp->zpci_grp.maxstbl)) {
         goto specification_error;
     }
     /* Do not cross a 4K-byte boundary */
-- 
1.8.3.1


