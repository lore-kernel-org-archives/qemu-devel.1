Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA05DC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A363C20700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A363C20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzsY-0005Sl-GN
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFzoC-0000Z7-6d
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFzo6-0008M8-U5
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:02:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFzo3-0008FF-05
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:02:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x93BvBZr138378
 for <qemu-devel@nongnu.org>; Thu, 3 Oct 2019 08:01:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vd1gye6ym-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 08:01:59 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 3 Oct 2019 13:01:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 3 Oct 2019 13:01:54 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x93C1rYu51052772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2019 12:01:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0026A4068;
 Thu,  3 Oct 2019 12:01:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DE3DA4060;
 Thu,  3 Oct 2019 12:01:53 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Oct 2019 12:01:53 +0000 (GMT)
Subject: [PATCH 6/7] spapr/xive: Configure number of servers in KVM
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Thu, 03 Oct 2019 14:01:53 +0200
In-Reply-To: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-0016-0000-0000-000002B3A9F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-0017-0000-0000-00003314B3CB
Message-Id: <157010411139.246126.16419749660388287086.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-03_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=787 adultscore=0 classifier=spam adjust=0 reason=mlx
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

The XIVE KVM devices now has an attribute to configure the number of
interrupt servers. This allows to greatly optimize the usage of the VP
space in the XIVE HW, and thus to start a lot more VMs.

Only set this attribute if available in order to support older POWER9
KVM.

The XIVE KVM device now reports the exhaustion of VPs upon the
connection of the first VCPU. Check that in order to have a chance
to provide an hint to the user.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 51b334b676a1..2a3a9ef22b6f 100644
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
 
@@ -171,8 +172,15 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
     ret = kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive->fd,
                               vcpu_id, 0);
     if (ret < 0) {
-        error_setg(errp, "XIVE: unable to connect CPU%ld to KVM device: %s",
+        Error *err = NULL;
+
+        error_setg(&err, "XIVE: unable to connect CPU%ld to KVM device: %s",
                    vcpu_id, strerror(errno));
+        if (errno == ENOSPC) {
+            error_append_hint(&local_err, "Try -smp maxcpus=N with N < %u\n",
+                              ms->smp.max_cpus);
+        }
+        error_propagate(errp, err);
         return;
     }
 
@@ -768,6 +776,16 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
         return;
     }
 
+    /* Tell KVM about the # of VCPUs we may have */
+    if (kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                              KVM_DEV_XIVE_NR_SERVERS)) {
+        if (kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                              KVM_DEV_XIVE_NR_SERVERS, &xive->nr_servers, true,
+                              &local_err)) {
+            goto fail;
+        }
+    }
+
     /*
      * 1. Source ESB pages - KVM mapping
      */


