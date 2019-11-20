Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7245C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0CF22310
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0CF22310
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOVa-00018m-Fm
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOOu-00036G-22
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOOs-000360-1F
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:43:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61810
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXOOq-000306-2N
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:43:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKBg5PO174165
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:43:55 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf35wd3e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:43:54 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 20 Nov 2019 11:43:53 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 11:43:51 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAKBhBGH38601048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 11:43:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EF074C046;
 Wed, 20 Nov 2019 11:43:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F45C4C044;
 Wed, 20 Nov 2019 11:43:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.205])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 11:43:48 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/15] s390x: Beautify diag308 handling
Date: Wed, 20 Nov 2019 06:43:21 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120114334.2287-1-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112011-0016-0000-0000-000002C9CC52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112011-0017-0000-0000-0000332B8B7E
Message-Id: <20191120114334.2287-3-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=3 mlxlogscore=999 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200107
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's improve readability by:
* Using constants for the subcodes
* Moving parameter checking into a function
* Removing subcode > 6 check as the default case catches that

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/diag.c | 54 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 53c2f81f2a..067c667ba7 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -53,6 +53,29 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 #define DIAG_308_RC_NO_CONF         0x0102
 #define DIAG_308_RC_INVALID         0x0402
 
+#define DIAG308_RES_MOD_CLR		0
+#define DIAG308_RES_LOAD_NORM		1
+#define DIAG308_LOAD_CLEAR		3
+#define DIAG308_LOAD_NORMAL_DUMP	4
+#define DIAG308_SET			5
+#define DIAG308_STORE			6
+
+static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
+                              uintptr_t ra, bool write)
+{
+    if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return -EINVAL;
+    }
+    if (!address_space_access_valid(&address_space_memory, addr,
+                                    sizeof(IplParameterBlock), write,
+                                    MEMTXATTRS_UNSPECIFIED)) {
+        s390_program_interrupt(env, PGM_ADDRESSING, ra);
+        return -EINVAL;
+    }
+    return 0;
+}
+
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
@@ -65,30 +88,24 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         return;
     }
 
-    if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
+    if (subcode & ~0x0ffffULL) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
 
     switch (subcode) {
-    case 0:
+    case DIAG308_RES_MOD_CLR:
         s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
         break;
-    case 1:
+    case DIAG308_RES_LOAD_NORM:
         s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
         break;
-    case 3:
+    case DIAG308_LOAD_CLEAR:
+        /* Well we still lack the clearing bit... */
         s390_ipl_reset_request(cs, S390_RESET_REIPL);
         break;
-    case 5:
-        if ((r1 & 1) || (addr & 0x0fffULL)) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-            return;
-        }
-        if (!address_space_access_valid(&address_space_memory, addr,
-                                        sizeof(IplParameterBlock), false,
-                                        MEMTXATTRS_UNSPECIFIED)) {
-            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+    case DIAG308_SET:
+        if (diag308_parm_check(env, r1, addr, ra, false)) {
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
@@ -110,15 +127,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 out:
         g_free(iplb);
         return;
-    case 6:
-        if ((r1 & 1) || (addr & 0x0fffULL)) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-            return;
-        }
-        if (!address_space_access_valid(&address_space_memory, addr,
-                                        sizeof(IplParameterBlock), true,
-                                        MEMTXATTRS_UNSPECIFIED)) {
-            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+    case DIAG308_STORE:
+        if (diag308_parm_check(env, r1, addr, ra, true)) {
             return;
         }
         iplb = s390_ipl_get_iplb();
-- 
2.20.1


