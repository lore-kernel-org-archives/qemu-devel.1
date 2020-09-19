Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB111C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355992098B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xobu2NC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355992098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJex5-0003D0-C3
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kJet1-0007Uj-Eq; Sat, 19 Sep 2020 11:34:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kJesz-0003oU-I5; Sat, 19 Sep 2020 11:34:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08JFX8LR120344; Sat, 19 Sep 2020 11:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=uG/e4wcSiERmLCLc9M/ERnAMQnnWWI/AOe8fCtyrPiM=;
 b=Xobu2NC2geI/J3VS4yM3xtE67RRwlYOgExQGEmGXKKayph8c4yLyUKNebD2mRwX10n/3
 6yfTwhzOW9fBOJX+pnp/D6Ch8kKZ68nUE47DASjMuyJoQQuOACaeDlnPuvt4sLTbMwDg
 vZXsiHLrmgI+4KcebAuZ4zdl5PQVLFC33jKc52rNZykjFjbkGSH9aODSjenPD8PByzB0
 MgPZo0NNg+wYoSov8+CRuVIjlO+gu+SyScnEhSdADhf3Edx/nKXguYxGWVUbAzZVhhnA
 lAiKcw9DJWbIiz5AFXJqnYxMvkc0zztWjwiicSTkTepBYEB5oMjh8XKixMJQtdNS5auo Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33nmqvr13f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 11:34:48 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08JFXMFN120670;
 Sat, 19 Sep 2020 11:34:47 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33nmqvr139-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 11:34:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08JFSRiR000698;
 Sat, 19 Sep 2020 15:34:47 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01dal.us.ibm.com with ESMTP id 33n9m8m0ye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 15:34:47 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08JFYdbZ36766070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Sep 2020 15:34:39 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 674FD7805C;
 Sat, 19 Sep 2020 15:34:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E98287805E;
 Sat, 19 Sep 2020 15:34:43 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.74.107])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 19 Sep 2020 15:34:43 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com, thuth@redhat.com
Subject: [PATCH 5/7] s390x/pci: clean up s390 PCI groups
Date: Sat, 19 Sep 2020 11:34:30 -0400
Message-Id: <1600529672-10243-6-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-19_05:2020-09-16,
 2020-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009190133
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:34:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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

Add a step to remove all stashed PCI groups to avoid stale data between
machine resets.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3015d86..d6666c2 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -811,6 +811,17 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
                              S390_ADAPTER_SUPPRESSIBLE, errp);
 }
 
+static void s390_pcihost_unrealize(DeviceState *dev)
+{
+    S390PCIGroup *grp;
+    S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
+
+    while (!QTAILQ_EMPTY(&s->zpci_grps)) {
+        grp = QTAILQ_FIRST(&s->zpci_grps);
+        QTAILQ_REMOVE(&s->zpci_grps, grp, link);
+    }
+}
+
 static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
 {
     char *name;
@@ -1165,6 +1176,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
 
     dc->reset = s390_pcihost_reset;
     dc->realize = s390_pcihost_realize;
+    dc->unrealize = s390_pcihost_unrealize;
     hc->pre_plug = s390_pcihost_pre_plug;
     hc->plug = s390_pcihost_plug;
     hc->unplug_request = s390_pcihost_unplug_request;
-- 
1.8.3.1


