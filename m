Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33FBC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8780D20674
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8780D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaN1-0001d6-QL
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBaJi-0004zb-CF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBaJg-0004M1-Ok
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBaJg-0004Ig-Cp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02A8OcCw136540
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:32:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8k8jyht-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:32:42 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 08:32:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 08:32:38 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02A8WbS857344212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 08:32:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92B744C04A;
 Tue, 10 Mar 2020 08:32:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23D454C040;
 Tue, 10 Mar 2020 08:32:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2020 08:32:35 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 1/2] s390x: ipl: Consolidate iplb validity check into one
 function
Date: Tue, 10 Mar 2020 04:32:31 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b608f7d8-81ac-1e5b-011d-bd576f77aade@redhat.com>
References: <b608f7d8-81ac-1e5b-011d-bd576f77aade@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031008-0012-0000-0000-0000038EE7C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031008-0013-0000-0000-000021CBB21B
Message-Id: <20200310083232.29805-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_04:2020-03-09,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=1 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100057
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's nicer to just call one function than calling a function for each
possible iplb type.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/ipl.h      | 20 +++++++++++---------
 target/s390x/diag.c |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d4813105db..211ce2dbeb 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -173,16 +173,18 @@ static inline bool iplb_valid_len(IplParameterBlock *iplb)
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
+        return (be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN &&
+                iplb->pbt == S390_IPL_TYPE_FCP);
+    case S390_IPL_TYPE_CCW:
+        return (be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN &&
+                iplb->pbt == S390_IPL_TYPE_CCW);
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


