Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AD7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497012073F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497012073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8Yk-0008Mz-5g
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1ic8EI-000623-Ri
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1ic8EF-0001EV-Hj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:28:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1ic8EE-0001BF-KQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:28:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB3DMxkR025130
 for <qemu-devel@nongnu.org>; Tue, 3 Dec 2019 08:28:32 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6spbwv4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 08:28:32 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 3 Dec 2019 13:28:30 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 3 Dec 2019 13:28:27 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xB3DSPxT45023634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Dec 2019 13:28:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7ED3A4057;
 Tue,  3 Dec 2019 13:28:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EA71A4051;
 Tue,  3 Dec 2019 13:28:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.18.156])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  3 Dec 2019 13:28:24 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] pc-bios/s390x: Fix reset psw mask
Date: Tue,  3 Dec 2019 08:28:13 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203132813.2734-1-frankja@linux.ibm.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120313-0020-0000-0000-00000393164E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120313-0021-0000-0000-000021EA3794
Message-Id: <20191203132813.2734-5-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_03:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 suspectscore=1 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030105
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to set the short psw indication bit in the reset psw, as it is
a short psw.

fixes: 9629823290 ("pc-bios/s390-ccw: do a subsystem reset before running the guest")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/jump2ipl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 266f1502b9..da13c43cc0 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -12,11 +12,11 @@
 #define KERN_IMAGE_START 0x010000UL
 #define PSW_MASK_64 0x0000000100000000ULL
 #define PSW_MASK_32 0x0000000080000000ULL
-#define IPL_PSW_MASK (PSW_MASK_32 | PSW_MASK_64)
+#define PSW_MASK_SHORTPSW 0x0008000000000000ULL
+#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_32 | PSW_MASK_64)
 
 typedef struct ResetInfo {
-    uint32_t ipl_mask;
-    uint32_t ipl_addr;
+    uint64_t ipl_psw;
     uint32_t ipl_continue;
 } ResetInfo;
 
@@ -50,7 +50,9 @@ void jump_to_IPL_code(uint64_t address)
     ResetInfo *current = 0;
 
     save = *current;
-    current->ipl_addr = (uint32_t) (uint64_t) &jump_to_IPL_2;
+
+    current->ipl_psw = (uint64_t) &jump_to_IPL_2;
+    current->ipl_psw |= RESET_PSW_MASK;
     current->ipl_continue = address & 0x7fffffff;
 
     debug_print_int("set IPL addr to", current->ipl_continue);
@@ -82,7 +84,7 @@ void jump_to_low_kernel(void)
     }
 
     /* Trying to get PSW at zero address */
-    if (*((uint64_t *)0) & IPL_PSW_MASK) {
+    if (*((uint64_t *)0) & RESET_PSW_MASK) {
         jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
     }
 
-- 
2.20.1


