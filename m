Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7281BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18782076B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ppaXn1gB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18782076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEru-0000u6-QV
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kQEk0-0007ub-RC; Wed, 07 Oct 2020 15:04:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57340
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kQEjx-0004ct-O5; Wed, 07 Oct 2020 15:04:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 097J2VW9155947; Wed, 7 Oct 2020 15:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=mPRqIry+1htThAWT37oYyw8XVX4dUwbBHMUdDjTjQWY=;
 b=ppaXn1gBc73BzCAXxUDtT6KyAZZUO5B/pISdf4faOH81SP61CLEiAVoQ+w2XRpGo/jag
 HkX16Cug4g8UckgQP1i5Wj0+VDnDTbhrP3MGx3BltLi3PleKAeGz7fzC6c6DdBY3enuQ
 Gp/CLuzXzA1Puy29sXGg5wkQC2gTKDM4MDH/XSKpGbd9c9mjycEdPNn+fR6+Ehbi5Vs4
 TteCM4dhZElNeiuZZoNUZyid0yaQIvhvEoFtDrhpTcdZpjMLC1kLnACvZh060QdH6tK9
 6UhuTHVeFa0fV88q6fBFNztE2s6BhJ2puG56mC+fVPY8bGExCd8pWXkpS8Y5kltdkTDL Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 341j4yjmpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 15:04:40 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 097J2ekd156546;
 Wed, 7 Oct 2020 15:04:40 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 341j4yjmpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 15:04:40 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097IlUre003045;
 Wed, 7 Oct 2020 19:04:39 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03dal.us.ibm.com with ESMTP id 33xgx9spb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 19:04:39 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 097J4cNC30015976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Oct 2020 19:04:38 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7481BAC05F;
 Wed,  7 Oct 2020 19:04:38 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BA7EAC05E;
 Wed,  7 Oct 2020 19:04:36 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.60.106])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  7 Oct 2020 19:04:35 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com, thuth@redhat.com
Subject: [PATCH v3 07/10] s390x/pci: clean up s390 PCI groups
Date: Wed,  7 Oct 2020 15:04:12 -0400
Message-Id: <1602097455-15658-8-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602097455-15658-1-git-send-email-mjrosato@linux.ibm.com>
References: <1602097455-15658-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-07_10:2020-10-07,
 2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070118
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:04:22
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
index c99f2f0..c34f14a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -811,6 +811,17 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
                              S390_ADAPTER_SUPPRESSIBLE, errp);
 }
 
+static void s390_pcihost_unrealize(DeviceState *dev)
+{
+    S390PCIGroup *group;
+    S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
+
+    while (!QTAILQ_EMPTY(&s->zpci_groups)) {
+        group = QTAILQ_FIRST(&s->zpci_groups);
+        QTAILQ_REMOVE(&s->zpci_groups, group, link);
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


