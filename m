Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4385EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153B320842
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153B320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9SaN-000650-8D
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SRW-0007Ya-RR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SRV-00085p-S2
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:44:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9SRV-00080P-L0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:44:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024BhmDU088022
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2020 06:43:50 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhrydg0qp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 06:43:50 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Mar 2020 11:43:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Mar 2020 11:43:23 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 024BhNRt54526020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 11:43:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F33B342041;
 Wed,  4 Mar 2020 11:43:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C83D4203F;
 Wed,  4 Mar 2020 11:43:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.55])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 11:43:22 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/18] s390x: protvirt: Handle SIGP store status correctly
Date: Wed,  4 Mar 2020 06:42:28 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304114231.23493-1-frankja@linux.ibm.com>
References: <20200304114231.23493-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030411-0016-0000-0000-000002ED13AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030411-0017-0000-0000-00003350608A
Message-Id: <20200304114231.23493-16-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_03:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=682 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040090
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

Status storing is not done by QEMU anymore, but is handled by SIE.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.c | 4 ++++
 target/s390x/sigp.c   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index ed72684911..8b91ed68f0 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -246,6 +246,10 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
     hwaddr len = sizeof(*sa);
     int i;
 
+    if (cpu->env.pv) {
+        return 0;
+    }
+
     sa = cpu_physical_memory_map(addr, &len, true);
     if (!sa) {
         return -EFAULT;
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index c604f17710..e1c8071464 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -497,6 +497,7 @@ void do_stop_interrupt(CPUS390XState *env)
     if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) == 0) {
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
+    /* Storing will occur on next SIE entry for protected VMs */
     if (cpu->env.sigp_order == SIGP_STOP_STORE_STATUS) {
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
     }
-- 
2.20.1


