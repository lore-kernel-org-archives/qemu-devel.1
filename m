Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C268C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EA320674
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EA320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaw3-0002NR-3h
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBav2-0001cd-9X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBav1-0008Px-9Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:11:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23222
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBav1-0008NF-4S
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:11:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02A9BImA059362
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:11:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8g4aku7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:11:18 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 09:09:56 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 09:09:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02A99rx341943224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 09:09:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B58D4204D;
 Tue, 10 Mar 2020 09:09:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 619764204F;
 Tue, 10 Mar 2020 09:09:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2020 09:09:52 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8] s390x: ipl: Consolidate iplb validity check into one
 function
Date: Tue, 10 Mar 2020 05:09:50 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c9fda605-7911-6c53-26d4-c18942b03773@de.ibm.com>
References: <c9fda605-7911-6c53-26d4-c18942b03773@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031009-0008-0000-0000-0000035B13AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031009-0009-0000-0000-00004A7C5607
Message-Id: <20200310090950.61172-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_04:2020-03-09,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 suspectscore=1 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100063
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's nicer to just call one function than calling a function for each
possible iplb type.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/ipl.h      | 18 +++++++++---------
 target/s390x/diag.c |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d4813105db..3e44abe1c6 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -173,16 +173,16 @@ static inline bool iplb_valid_len(IplParameterBlock *iplb)
     return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
 }
 
-static inline bool iplb_valid_ccw(IplParameterBlock *iplb)
+static inline bool iplb_valid(IplParameterBlock *iplb)
 {
-    return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN &&
-           iplb->pbt == S390_IPL_TYPE_CCW;
-}
-
-static inline bool iplb_valid_fcp(IplParameterBlock *iplb)
-{
-    return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN &&
-           iplb->pbt == S390_IPL_TYPE_FCP;
+    switch (iplb->pbt) {
+    case S390_IPL_TYPE_FCP:
+        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
+    case S390_IPL_TYPE_CCW:
+        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
+    default:
+        return false;
+    }
 }
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index b5aec06d6b..54e5670b3f 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -117,7 +117,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
 
-        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
+        if (!iplb_valid(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
-- 
2.20.1


