Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CADC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9549E2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9549E2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZe1u-0000GP-GB
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 11:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iZdz3-0006R4-Ja
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iZdz2-0006cZ-Cy
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8702
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iZdz2-0006cB-83
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:36 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAQGJ6lf045547
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:46:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wh4yr8rvb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:46:34 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 26 Nov 2019 16:46:33 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 26 Nov 2019 16:46:29 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAQGkSvx48169174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 16:46:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFAA6AE045;
 Tue, 26 Nov 2019 16:46:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7879AE04D;
 Tue, 26 Nov 2019 16:46:28 +0000 (GMT)
Received: from bahia.tlslab.ibm.com (unknown [9.101.4.41])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 26 Nov 2019 16:46:28 +0000 (GMT)
Subject: [for-5.0 PATCH v2 3/4] spapr/xics: Configure number of servers in KVM
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Nov 2019 17:46:28 +0100
In-Reply-To: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
References: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112616-0008-0000-0000-000003389031
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112616-0009-0000-0000-00004A579545
Message-Id: <157478678846.67101.9660531022460517710.stgit@bahia.tlslab.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_04:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=707 impostorscore=0 clxscore=1034
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260139
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XICS-on-XIVE KVM devices now has an attribute to configure the number
of interrupt servers. This allows to greatly optimize the usage of the VP
space in the XIVE HW, and thus to start a lot more VMs.

Only set this attribute if available in order to support older POWER9 KVM
and pre-POWER9 XICS KVM devices.

The XICS-on-XIVE KVM device now reports the exhaustion of VPs upon the
connection of the first VCPU. Check that in order to have a chance to
provide a hint to the user.
`
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index a1f1b7b0d37c..8d6156578fbc 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -165,8 +165,15 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
 
     ret = kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd, vcpu_id);
     if (ret < 0) {
-        error_setg(errp, "Unable to connect CPU%ld to kernel XICS: %s", vcpu_id,
-                   strerror(errno));
+        Error *local_err = NULL;
+
+        error_setg(&local_err, "Unable to connect CPU%ld to kernel XICS: %s",
+                   vcpu_id, strerror(errno));
+        if (errno == ENOSPC) {
+            error_append_hint(&local_err, "Try -smp maxcpus=N with N < %u\n",
+                              MACHINE(qdev_get_machine())->smp.max_cpus);
+        }
+        error_propagate(errp, local_err);
         return;
     }
     enabled_icp = g_malloc(sizeof(*enabled_icp));
@@ -399,6 +406,16 @@ int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers,
         goto fail;
     }
 
+    /* Tell KVM about the # of VCPUs we may have (POWER9 and newer only) */
+    if (kvm_device_check_attr(rc, KVM_DEV_XICS_GRP_CTRL,
+                              KVM_DEV_XICS_NR_SERVERS)) {
+        if (kvm_device_access(rc, KVM_DEV_XICS_GRP_CTRL,
+                              KVM_DEV_XICS_NR_SERVERS, &nr_servers, true,
+                              &local_err)) {
+            goto fail;
+        }
+    }
+
     kernel_xics_fd = rc;
     kvm_kernel_irqchip = true;
     kvm_msi_via_irqfd_allowed = true;


