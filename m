Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A7EC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813AF2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813AF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9u1-0004q9-KK
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iD9pV-0007cZ-ED
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iD9pU-0007io-Cs
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:07:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38788
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iD9pU-0007iQ-7w
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:07:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8PG7X3X132472
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 12:07:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v8asb9v2u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 12:07:46 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 25 Sep 2019 17:07:44 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 25 Sep 2019 17:07:41 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8PG7eEY23396438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Sep 2019 16:07:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFB3DA404D;
 Wed, 25 Sep 2019 16:07:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 796D1A4051;
 Wed, 25 Sep 2019 16:07:40 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.186.179])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 25 Sep 2019 16:07:40 +0000 (GMT)
Subject: [PATCH] spapr/irq: Fix migration of older machine types with XIVE
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Wed, 25 Sep 2019 18:07:40 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19092516-0016-0000-0000-000002B08883
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092516-0017-0000-0000-000033115191
Message-Id: <156942766014.1274533.10792048853177121231.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-25_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=809 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250147
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
Cc: qemu-ppc@nongnu.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent patch "spapr/irq: Only claim VALID interrupts at the KVM level"
broke migration of older machine types started with ic-mode=xive:

qemu-system-ppc64: KVM_SET_DEVICE_ATTR failed: Group 3 attr 0x0000000000001300: Invalid argument
qemu-system-ppc64: error while loading state for instance 0x0 of device 'spapr'
qemu-system-ppc64: load of migration failed: Operation not permitted

This is because we should set the interrupt source in KVM at post load,
since we no longer do it unconditionaly at reset time for all interrupts.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

David,

I guess you should probably fold this fix directly into Cedric's
patch (currently SHA1 966d526cdfd9 in ppc-for-4.2) to avoid
bisection breakage.
---
 hw/intc/spapr_xive_kvm.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 71b88d7797bc..2006f96aece1 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -678,6 +678,17 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
             continue;
         }
 
+        /*
+         * We can only restore the source config if the source has been
+         * previously set in KVM. Since we don't do that for all interrupts
+         * at reset time anymore, let's do it now.
+         */
+        kvmppc_xive_source_reset_one(&xive->source, i, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+
         kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_err);
         if (local_err) {
             error_report_err(local_err);


