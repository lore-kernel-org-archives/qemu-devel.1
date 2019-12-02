Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0911BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08AC20718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08AC20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibmKM-0002ia-0w
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 09:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1ibmHA-0007PL-Om
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1ibmH9-0005D4-GF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:02:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1ibmH9-0005Bb-8Y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:02:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB2Dv8fU083809
 for <qemu-devel@nongnu.org>; Mon, 2 Dec 2019 09:02:06 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wknu9v6dv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 09:02:06 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 2 Dec 2019 14:02:04 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 2 Dec 2019 14:02:00 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB2E1wOp61210794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Dec 2019 14:01:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E8314C059;
 Mon,  2 Dec 2019 14:01:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AB9F4C044;
 Mon,  2 Dec 2019 14:01:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.35.210])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  2 Dec 2019 14:01:57 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] s390x: Fix cpu normal reset ri clearing
Date: Mon,  2 Dec 2019 09:01:46 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191202140146.3910-1-frankja@linux.ibm.com>
References: <20191202140146.3910-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120214-0028-0000-0000-000003C36D10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120214-0029-0000-0000-0000248682CC
Message-Id: <20191202140146.3910-4-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=1 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020127
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it turns out we need to clear the ri controls and PSW enablement
bit to be architecture compliant.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/cpu.c | 5 +++++
 target/s390x/cpu.h | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 906285888e..c192e6b3b9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -131,6 +131,11 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
                                   &env->fpu_status);
        /* fall through */
     case S390_CPU_RESET_NORMAL:
+        env->psw.mask &= ~PSW_MASK_RI;
+        memset(&env->start_normal_reset_fields, 0,
+               offsetof(CPUS390XState, end_reset_fields) -
+               offsetof(CPUS390XState, start_normal_reset_fields));
+
         env->pfault_token = -1UL;
         env->bpbc = false;
         break;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d5e18b096e..7f5fa1d35b 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -58,7 +58,6 @@ struct CPUS390XState {
      */
     uint64_t vregs[32][2] QEMU_ALIGNED(16);  /* vector registers */
     uint32_t aregs[16];    /* access registers */
-    uint8_t riccb[64];     /* runtime instrumentation control */
     uint64_t gscb[4];      /* guarded storage control */
     uint64_t etoken;       /* etoken */
     uint64_t etoken_extension; /* etoken extension */
@@ -114,6 +113,10 @@ struct CPUS390XState {
     uint64_t gbea;
     uint64_t pp;
 
+    /* Fields up to this point are not cleared by normal CPU reset */
+    struct {} start_normal_reset_fields;
+    uint8_t riccb[64];     /* runtime instrumentation control */
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
@@ -252,6 +255,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #undef PSW_SHIFT_ASC
 #undef PSW_MASK_CC
 #undef PSW_MASK_PM
+#undef PSW_MASK_RI
 #undef PSW_SHIFT_MASK_PM
 #undef PSW_MASK_64
 #undef PSW_MASK_32
@@ -274,6 +278,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_MASK_CC             0x0000300000000000ULL
 #define PSW_MASK_PM             0x00000F0000000000ULL
 #define PSW_SHIFT_MASK_PM       40
+#define PSW_MASK_RI             0x0000008000000000ULL
 #define PSW_MASK_64             0x0000000100000000ULL
 #define PSW_MASK_32             0x0000000080000000ULL
 #define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
-- 
2.20.1


