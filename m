Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ABEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A809521774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A809521774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacay-000645-Sp
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iacQ5-0000JG-Av
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iacPy-0002oo-05
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:18:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29580
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iacPu-0002jr-Mo
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:18:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAT9ICPW118514
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:18:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wjttrsw11-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:18:16 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 09:17:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 09:17:21 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAT9HJCM55312428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 09:17:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A525B4C04A;
 Fri, 29 Nov 2019 09:17:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0F904C044;
 Fri, 29 Nov 2019 09:17:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 09:17:17 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5] s390x: kvm: Make kvm_sclp_service_call void
Date: Fri, 29 Nov 2019 04:17:13 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129100155.331ae2f0.cohuck@redhat.com>
References: <20191129100155.331ae2f0.cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112909-0016-0000-0000-000002CDD12E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112909-0017-0000-0000-0000332FBADF
Message-Id: <20191129091713.4582-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_02:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 suspectscore=1 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290081
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

It defaults to returning 0 anyway and that return value is not
necessary, as 0 is also the default rc that the caller would return.

While doing that we can simplify the logic a bit and return early if
we inject a PGM exception.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0c9d14b4b1..ad6e38c876 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1159,13 +1159,13 @@ void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code)
     kvm_s390_vcpu_interrupt(cpu, &irq);
 }
 
-static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
+static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
                                  uint16_t ipbh0)
 {
     CPUS390XState *env = &cpu->env;
     uint64_t sccb;
     uint32_t code;
-    int r = 0;
+    int r;
 
     sccb = env->regs[ipbh0 & 0xf];
     code = env->regs[(ipbh0 & 0xf0) >> 4];
@@ -1173,11 +1173,9 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
     r = sclp_service_call(env, sccb, code);
     if (r < 0) {
         kvm_s390_program_interrupt(cpu, -r);
-    } else {
-        setcc(cpu, r);
+        return;
     }
-
-    return 0;
+    setcc(cpu, r);
 }
 
 static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
@@ -1240,7 +1238,7 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
         setcc(cpu, 3);
         break;
     case PRIV_B2_SCLP_CALL:
-        rc = kvm_sclp_service_call(cpu, run, ipbh0);
+        kvm_sclp_service_call(cpu, run, ipbh0);
         break;
     default:
         rc = -1;
-- 
2.20.1


