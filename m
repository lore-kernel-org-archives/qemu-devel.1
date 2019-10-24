Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3510ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0910120663
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0910120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfWg-0002HZ-3w
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNe5X-0003MV-KB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNe5V-0004ns-KA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNe5V-0004mC-CR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9OEOcKX056201
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:27:39 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vucuytmmf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:27:39 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 24 Oct 2019 15:27:36 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 24 Oct 2019 15:27:34 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9OERXq153870660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 14:27:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD12A11C052;
 Thu, 24 Oct 2019 14:27:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B56411C04A;
 Thu, 24 Oct 2019 14:27:33 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2019 14:27:33 +0000 (GMT)
Subject: [PATCH 3/3] ppc: Skip partially initialized vCPUs in 'info pic'
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 24 Oct 2019 16:27:33 +0200
In-Reply-To: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
References: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102414-0008-0000-0000-00000326DF3E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102414-0009-0000-0000-00004A46131F
Message-Id: <157192725327.3146912.12047076483178652551.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-24_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=760 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240135
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

CPU_FOREACH() can race with vCPU hotplug/unplug on sPAPR machines, ie.
we may try to print out info about a vCPU with a NULL presenter pointer.

Check that in order to prevent QEMU from crashing.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c |   11 ++++++++++-
 hw/intc/xive.c |   11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 5f746079be46..e7ac9ba618fa 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -44,7 +44,16 @@
 
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
-    int cpu_index = icp->cs ? icp->cs->cpu_index : -1;
+    int cpu_index;
+
+    /* Skip partially initialized vCPUs. This can happen on sPAPR when vCPUs
+     * are hot plugged or unplugged.
+     */
+    if (!icp) {
+        return;
+    }
+
+    cpu_index = icp->cs ? icp->cs->cpu_index : -1;
 
     if (!icp->output) {
         return;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 952a461d5329..75dce82fb205 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -523,9 +523,18 @@ static const char * const xive_tctx_ring_names[] = {
 
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
 {
-    int cpu_index = tctx->cs ? tctx->cs->cpu_index : -1;
+    int cpu_index;
     int i;
 
+    /* Skip partially initialized vCPUs. This can happen on sPAPR when vCPUs
+     * are hot plugged or unplugged.
+     */
+    if (!tctx) {
+        return;
+    }
+
+    cpu_index = tctx->cs ? tctx->cs->cpu_index : -1;
+
     if (kvm_irqchip_in_kernel()) {
         Error *local_err = NULL;
 


