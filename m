Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C74C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE5F2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE5F2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZe4Z-00031U-FM
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 11:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iZdz8-0006Z4-W9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iZdz7-0006gh-KU
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iZdz7-0006gF-CY
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:41 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAQGIXMS055310
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:46:40 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wh2pnf01s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:46:40 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 26 Nov 2019 16:46:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 26 Nov 2019 16:46:35 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAQGkY2Z48955554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 16:46:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AFBE4C044;
 Tue, 26 Nov 2019 16:46:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33E3D4C040;
 Tue, 26 Nov 2019 16:46:34 +0000 (GMT)
Received: from bahia.tlslab.ibm.com (unknown [9.101.4.41])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 26 Nov 2019 16:46:34 +0000 (GMT)
Subject: [for-5.0 PATCH v2 4/4] spapr/xive: Configure number of servers in KVM
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Nov 2019 17:46:33 +0100
In-Reply-To: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
References: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112616-4275-0000-0000-00000386AD8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112616-4276-0000-0000-0000389A3929
Message-Id: <157478679392.67101.7843580591407950866.stgit@bahia.tlslab.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_04:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 mlxlogscore=698 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1034 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260139
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XIVE KVM devices now has an attribute to configure the number of
interrupt servers. This allows to greatly optimize the usage of the VP
space in the XIVE HW, and thus to start a lot more VMs.

Only set this attribute if available in order to support older POWER9
KVM.

The XIVE KVM device now reports the exhaustion of VPs upon the
connection of the first VCPU. Check that in order to have a chance
to provide a hint to the user.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 46c7609bd8d0..32b2809210a0 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -152,7 +152,8 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
 
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 {
-    SpaprXive *xive = SPAPR_MACHINE(qdev_get_machine())->xive;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    SpaprXive *xive = SPAPR_MACHINE(ms)->xive;
     unsigned long vcpu_id;
     int ret;
 
@@ -171,8 +172,16 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
     ret = kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive->fd,
                               vcpu_id, 0);
     if (ret < 0) {
-        error_setg(errp, "XIVE: unable to connect CPU%ld to KVM device: %s",
+        Error *local_err = NULL;
+
+        error_setg(&local_err,
+                   "XIVE: unable to connect CPU%ld to KVM device: %s",
                    vcpu_id, strerror(errno));
+        if (errno == ENOSPC) {
+            error_append_hint(&local_err, "Try -smp maxcpus=N with N < %u\n",
+                              ms->smp.max_cpus);
+        }
+        error_propagate(errp, local_err);
         return;
     }
 
@@ -758,6 +767,16 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
         return -1;
     }
 
+    /* Tell KVM about the # of VCPUs we may have */
+    if (kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                              KVM_DEV_XIVE_NR_SERVERS)) {
+        if (kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                              KVM_DEV_XIVE_NR_SERVERS, &nr_servers, true,
+                              &local_err)) {
+            goto fail;
+        }
+    }
+
     /*
      * 1. Source ESB pages - KVM mapping
      */


