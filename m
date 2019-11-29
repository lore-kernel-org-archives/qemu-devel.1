Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5944CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EB72086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EB72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadOF-0000UH-5L
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iactn-0003Hg-8A
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iacti-0005Ln-7u
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iactf-0004hf-Cs
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:08 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAT9mXtQ109227
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:48:55 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjaehhr8e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:48:54 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 09:48:52 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 09:48:49 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAT9mmuc63242396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 09:48:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05DDFA4040;
 Fri, 29 Nov 2019 09:48:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27E21A4057;
 Fri, 29 Nov 2019 09:48:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 09:48:45 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/13] s390x: protvirt: Handle SIGP store status correctly
Date: Fri, 29 Nov 2019 04:48:09 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129094809.26684-1-frankja@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112909-0008-0000-0000-00000339D0EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112909-0009-0000-0000-00004A58E040
Message-Id: <20191129094809.26684-14-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_02:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=1
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=615 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290086
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Status storing is obviously not done by qemu anymore.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/helper.c | 4 ++++
 target/s390x/sigp.c   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a3a49164e4..3800c4b395 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -246,6 +246,10 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
     hwaddr len = sizeof(*sa);
     int i;
 
+    if (cpu->env.pv) {
+        return 0;
+    }
+
     sa = cpu_physical_memory_map(addr, &len, 1);
     if (!sa) {
         return -EFAULT;
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 727875bb4a..2007946299 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -497,6 +497,7 @@ void do_stop_interrupt(CPUS390XState *env)
     if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) == 0) {
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
+    /* Storing will occur on next SIE entry for fmt 4 */
     if (cpu->env.sigp_order == SIGP_STOP_STORE_STATUS) {
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
     }
-- 
2.20.1


