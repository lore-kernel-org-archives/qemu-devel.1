Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1288C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E2E24654
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E2E24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lTb-0006Se-NJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j4lOm-00067J-5F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j4lOl-0006X5-2P
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j4lOk-0006Wj-QS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01KCsWW8129610
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:57:46 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ueefsg3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:57:45 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 20 Feb 2020 12:57:43 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Feb 2020 12:57:41 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01KCveoV27328654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 12:57:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A043CAE045;
 Thu, 20 Feb 2020 12:57:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 728F4AE04D;
 Thu, 20 Feb 2020 12:57:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.185.143])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2020 12:57:39 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/16] s390x: protvirt: Move STSI data over SIDAD
Date: Thu, 20 Feb 2020 07:56:30 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220125638.7241-1-frankja@linux.ibm.com>
References: <20200220125638.7241-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022012-0016-0000-0000-000002E8979D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022012-0017-0000-0000-0000334BB3EC
Message-Id: <20200220125638.7241-9-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-20_03:2020-02-19,
 2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=937 suspectscore=1 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200097
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For protected guests, we need to put the STSI emulation results into
the SIDA, so SIE will write them into the guest at the next entry.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/kvm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f222836df5..3a5a5146e3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1795,11 +1795,16 @@ static int handle_tsch(S390CPU *cpu)
 
 static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
 {
+    CPUS390XState *env = &cpu->env;
     SysIB_322 sysib;
     int del;
 
-    if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib))) {
-        return;
+    if (env->pv) {
+        s390_cpu_pv_mem_read(cpu, 0, &sysib, sizeof(sysib));
+    } else {
+        if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib))) {
+            return;
+        }
     }
     /* Shift the stack of Extended Names to prepare for our own data */
     memmove(&sysib.ext_names[1], &sysib.ext_names[0],
@@ -1838,7 +1843,11 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
     /* Insert UUID */
     memcpy(sysib.vm[0].uuid, &qemu_uuid, sizeof(sysib.vm[0].uuid));
 
-    s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, sizeof(sysib));
+    if (env->pv) {
+        s390_cpu_pv_mem_write(cpu, 0, &sysib, sizeof(sysib));
+    } else {
+        s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, sizeof(sysib));
+    }
 }
 
 static int handle_stsi(S390CPU *cpu)
-- 
2.20.1


