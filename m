Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117AAC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 04:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514D7221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 04:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kKlBqycm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514D7221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGajh-00057A-BF
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 00:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@linux.ibm.com>)
 id 1kGaiw-0004Yf-MM; Fri, 11 Sep 2020 00:31:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@linux.ibm.com>)
 id 1kGaiu-0004Jm-Ka; Fri, 11 Sep 2020 00:31:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08B43icu099068; Fri, 11 Sep 2020 00:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ObIs7ZUzOhX1e8VGE1/CqWxJuEbn2p2ZqVQ81nH+X/w=;
 b=kKlBqycmsY7A6pL2TLFcSeFPEBkaKUI9G5AtHgHO/WbMPzIhfXddOO7x6loU4aukVjuH
 O+pxaADnQ4Cl3G7eeeg/9VdEOc+j/nZm2fXgalf3GhX5IY7ht6MO9svpeSKSQQldKula
 JJ83Jte2di/QLPRoKp+7LbMxlQU0nb1P78PmXRtGr5I6wT4O5cAq3OunzU7Mprwt2NNI
 G1qdPIcbgNBtHuyPd/RLR8VuadX6WSma16ylThp/SqTIzg8QIZzDbradSGxFZ5NvQ5+x
 cX/ft8Iu7U9+E9cPUl6d11P32OHD5DphWVtCJ27w2WezVCjAfYtOWz49oDblv/iH2Lts Zw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33g1vqgjte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 00:31:37 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08B4SFXW008634;
 Fri, 11 Sep 2020 04:31:36 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma04dal.us.ibm.com with ESMTP id 33c2aa0fc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 04:31:36 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08B4VZhv44892614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2020 04:31:35 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DA32C605A;
 Fri, 11 Sep 2020 04:31:35 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C8F3C6057;
 Fri, 11 Sep 2020 04:31:34 +0000 (GMT)
Received: from farosas.linux.ibm.com.com (unknown [9.80.219.36])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2020 04:31:34 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] spapr: Handle HPT allocation failure in nested guest
Date: Fri, 11 Sep 2020 01:31:23 -0300
Message-Id: <20200911043123.204162-1-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-11_01:2020-09-10,
 2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=3
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110026
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farosas@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 00:31:42
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The nested KVM code does not yet support HPT guests. Calling the
KVM_CAP_PPC_ALLOC_HTAB ioctl currently leads to KVM setting the guest
as HPT and erroneously executing code in L1 that should only run in
hypervisor mode, leading to an exception in the L1 vcpu thread when it
enters the nested guest.

This can be reproduced with -machine max-cpu-compat=power8 in the L2
guest command line.

The KVM code has since been modified to fail the ioctl when running in
a nested environment so QEMU needs to be able to handle that. This
patch provides an error message informing the user about the lack of
support for HPT in nested guests.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9bce1892b5..ea2c755310 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1483,6 +1483,12 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
     spapr_free_hpt(spapr);
 
     rc = kvmppc_reset_htab(shift);
+
+    if (rc == -EOPNOTSUPP) {
+        error_setg(errp, "HPT not supported in nested guests");
+        return;
+    }
+
     if (rc < 0) {
         /* kernel-side HPT needed, but couldn't allocate one */
         error_setg_errno(errp, errno,
-- 
2.25.4


