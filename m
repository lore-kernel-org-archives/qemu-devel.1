Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26738C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED00A21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED00A21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahDR-0000dU-2Y
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iah8j-0006d8-Tv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iah8g-00076I-QN
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:20:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23306
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iah8g-0006zg-J2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:20:54 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xATEI4hD126626
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 09:20:52 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wjxaydy6v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 09:20:52 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 14:20:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 14:20:47 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xATEKj4b66322668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 14:20:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0A9BA4040;
 Fri, 29 Nov 2019 14:20:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1BD6A4057;
 Fri, 29 Nov 2019 14:20:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 14:20:43 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] s390x: Properly fetch and test the short psw on diag308
 subc 0/1
Date: Fri, 29 Nov 2019 09:20:23 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129142025.21453-1-frankja@linux.ibm.com>
References: <20191129142025.21453-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112914-0008-0000-0000-00000339F00A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112914-0009-0000-0000-00004A590058
Message-Id: <20191129142025.21453-2-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_04:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=1 impostorscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290124
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to actually fetch the cpu mask and set it. As we invert the
short psw indication in the mask, SIE will report a specification
exception, if it wasn't present in the reset psw.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 12 ++++++++++--
 target/s390x/cpu.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index bd39cb54b7..829ce6ad54 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -76,8 +76,16 @@ static bool s390_cpu_has_work(CPUState *cs)
 static void s390_cpu_load_normal(CPUState *s)
 {
     S390CPU *cpu = S390_CPU(s);
-    cpu->env.psw.addr = ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
-    cpu->env.psw.mask = PSW_MASK_32 | PSW_MASK_64;
+    uint64_t spsw = ldq_phys(s->as, 0);
+
+    cpu->env.psw.mask = spsw & 0xffffffff80000000ULL;
+    /*
+     * Invert short psw indication, so SIE will report a specification
+     * exception if it was not set.
+     */
+    cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
+    cpu->env.psw.addr = spsw & 0x7fffffffULL;
+
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d2af13b345..d5e18b096e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -265,6 +265,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_MASK_EXT            0x0100000000000000ULL
 #define PSW_MASK_KEY            0x00F0000000000000ULL
 #define PSW_SHIFT_KEY           52
+#define PSW_MASK_SHORTPSW       0x0008000000000000ULL
 #define PSW_MASK_MCHECK         0x0004000000000000ULL
 #define PSW_MASK_WAIT           0x0002000000000000ULL
 #define PSW_MASK_PSTATE         0x0001000000000000ULL
-- 
2.20.1


