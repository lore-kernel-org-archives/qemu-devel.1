Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD21C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C4EC20700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4EC20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzuG-0007m7-HD
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFznv-0000Rc-Og
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFznt-00088S-1M
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFzns-00087k-MH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x93Bvnk0056582
 for <qemu-devel@nongnu.org>; Thu, 3 Oct 2019 08:01:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vde6emyn3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 08:01:51 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 3 Oct 2019 13:01:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 3 Oct 2019 13:01:47 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x93C1kvY17826012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2019 12:01:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F68BAE059;
 Thu,  3 Oct 2019 12:01:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F259AE061;
 Thu,  3 Oct 2019 12:01:46 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Oct 2019 12:01:46 +0000 (GMT)
Subject: [PATCH 5/7] spapr/xics: Configure number of servers in KVM
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Thu, 03 Oct 2019 14:01:45 +0200
In-Reply-To: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-0020-0000-0000-00000374A8D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-0021-0000-0000-000021CAB26D
Message-Id: <157010410405.246126.5846482955650460662.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-03_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=794 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030113
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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

The XICS-on-XIVE KVM devices now has an attribute to configure the number
of interrupt servers. This allows to greatly optimize the usage of the VP
space in the XIVE HW, and thus to start a lot more VMs.

Only set this attribute if available in order to support older POWER9 KVM
and pre-POWER9 XICS KVM devices.

The XICS-on-XIVE KVM device now reports the exhaustion of VPs upon the
connection of the first VCPU. Check that in order to have a chance to
provide an hint to the user.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index ba90d6dc966c..12d9524cc432 100644
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
@@ -344,6 +351,7 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
 
 int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
 {
+    ICSState *ics = spapr->ics;
     int rc;
     CPUState *cs;
     Error *local_err = NULL;
@@ -397,6 +405,18 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
         goto fail;
     }
 
+    /* Tell KVM about the # of VCPUs we may have (POWER9 and newer only) */
+    if (kvm_device_check_attr(rc, KVM_DEV_XICS_GRP_CTRL,
+                              KVM_DEV_XICS_NR_SERVERS)) {
+        uint32_t nr_servers = xics_nr_servers(ics->xics);
+
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


